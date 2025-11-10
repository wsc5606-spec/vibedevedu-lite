const fs = require('fs');
const path = require('path');

console.log('SQL 파일 최종 수정 중...\n');

const filePath = path.join(__dirname, 'sql-challenges.sql');
let content = fs.readFileSync(filePath, 'utf8');

// 백업
fs.writeFileSync(filePath + '.broken', content, 'utf8');

let fixCount = 0;

console.log('1단계: INSERT 문 파싱 및 재구성...\n');

// 각 INSERT 문을 찾아서 VALUES 부분의 작은따옴표를 $$ 구분자로 변경
// 단, 'sql', 'challenge', 'syntax' 같은 키워드와 SQL 쿼리는 유지

const lines = content.split('\n');
const fixedLines = [];

for (let i = 0; i < lines.length; i++) {
    let line = lines[i];

    // INSERT나 주석이 아닌 일반 데이터 라인
    if (line.includes("('sql-") || line.trim().startsWith("('sql")) {
        // VALUES 행의 시작
        // 작은따옴표로 시작하는 값들을 찾되, 특정 키워드는 제외

        // 깨진 한글이 포함된 작은따옴표 문자열을 $$ 구분자로 변경
        const fixedLine = line.replace(/'([^']*[?�][^']*)'/g, (match, content) => {
            // 깨진 문자가 포함되어 있으면 $$ 구분자로 변경
            if (content.includes('?�')) {
                fixCount++;
                return `$$${content}$$`;
            }
            return match;
        });

        fixedLines.push(fixedLine);
    } else if (line.includes('?�') && line.includes("'")) {
        // 다른 라인에서도 깨진 문자가 있으면 처리
        const fixedLine = line.replace(/'([^']*[?�][^']*)'/g, (match, content) => {
            fixCount++;
            return `$$${content}$$`;
        });
        fixedLines.push(fixedLine);
    } else {
        fixedLines.push(line);
    }
}

const fixedContent = fixedLines.join('\n');

console.log(`${fixCount}개 라인 수정됨\n`);

// 저장
fs.writeFileSync(filePath, fixedContent, 'utf8');

console.log('✅ 완료!');
console.log(`수정된 파일: ${filePath}`);
console.log(`백업: ${filePath}.broken`);
console.log('\n이제 sql-challenges.sql을 업로드해보세요!');

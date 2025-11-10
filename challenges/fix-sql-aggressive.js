const fs = require('fs');
const path = require('path');

console.log('SQL 파일 전면 수정 중 (모든 작은따옴표 → $$ 변환)...\n');

const filePath = path.join(__dirname, 'sql-challenges.sql');
let content = fs.readFileSync(filePath, 'utf8');

// 백업
fs.writeFileSync(filePath + '.before-aggressive', content, 'utf8');

let fixCount = 0;

// 전략: INSERT VALUES 행에서 SQL 키워드가 아닌 모든 작은따옴표를 $$로 변경
// 유지해야 할 것: 'sql', 'syntax', 'basics', 'challenge', 'medium', 'hard'
// 유지해야 할 것: SQL 쿼리 ('SELECT ...', 'INSERT ...', etc)

const lines = content.split('\n');
const fixedLines = [];

const keepQuotes = ['sql', 'syntax', 'basics', 'challenge', 'advanced', 'medium', 'hard'];

for (let line of lines) {
    // INSERT 데이터 행인지 확인
    if (line.trim().startsWith("('sql-") || line.includes("('sql-")) {
        // 모든 작은따옴표 쌍을 찾음
        let newLine = line;
        const regex = /'([^']*)'/g;
        const matches = [...line.matchAll(regex)];

        // 뒤에서부터 교체 (인덱스가 변하지 않도록)
        for (let i = matches.length - 1; i >= 0; i--) {
            const match = matches[i];
            const content = match[1];
            const fullMatch = match[0];
            const index = match.index;

            // 보존해야 할 키워드인지 확인
            if (keepQuotes.includes(content)) {
                continue;
            }

            // SQL 쿼리인지 확인 (SELECT, INSERT, UPDATE, DELETE로 시작)
            if (content.trim().match(/^(SELECT|INSERT|UPDATE|DELETE|CREATE|DROP|ALTER)/i)) {
                continue;
            }

            // -- 주석으로 시작하는 것도 보존
            if (content.trim().startsWith('--')) {
                continue;
            }

            // 그 외 모든 것은 $$로 변경
            fixCount++;
            newLine = newLine.substring(0, index) + '$$' + content + '$$' + newLine.substring(index + fullMatch.length);
        }

        fixedLines.push(newLine);
    } else {
        fixedLines.push(line);
    }
}

const fixedContent = fixedLines.join('\n');

console.log(`${fixCount}개 작은따옴표 쌍을 $$ 구분자로 변경함\n`);

// 저장
fs.writeFileSync(filePath, fixedContent, 'utf8');

console.log('✅ 완료!');
console.log(`수정된 파일: ${filePath}`);
console.log(`백업: ${filePath}.before-aggressive`);
console.log('\n이제 sql-challenges.sql을 업로드해보세요!');

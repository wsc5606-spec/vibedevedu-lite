const fs = require('fs');
const path = require('path');

console.log('SQL 파일 인코딩 문제 해결 중...\n');

const part1Path = path.join(__dirname, 'sql-part1.sql');
const part2Path = path.join(__dirname, 'sql-part2.sql');

// 파일들을 다양한 인코딩으로 시도
const encodings = ['utf8', 'latin1', 'ascii'];

let part1Content = null;
let part2Content = null;

for (const encoding of encodings) {
    try {
        console.log(`${encoding} 인코딩으로 읽기 시도...`);
        part1Content = fs.readFileSync(part1Path, encoding);
        part2Content = fs.readFileSync(part2Path, encoding);

        // 한글이 제대로 읽혔는지 확인
        if (part1Content.includes('모든') || part1Content.includes('사용자')) {
            console.log(`✅ ${encoding}로 성공!\n`);
            break;
        }
    } catch (e) {
        console.log(`❌ ${encoding} 실패`);
    }
}

if (!part1Content || !part2Content) {
    console.log('ERROR: 파일을 읽을 수 없습니다.');
    process.exit(1);
}

console.log('작은따옴표를 달러 구분자로 변경 중...\n');

// 작은따옴표로 된 한국어/영어 텍스트를 찾아서 $$ 구분자로 변경
const fixQuotes = (content) => {
    // INSERT INTO ... VALUES 패턴에서 작은따옴표로 된 값들을 찾아 변경
    // 단, SQL 코드 부분('SELECT ...', 'INSERT ...')은 제외

    let fixed = content;
    let count = 0;

    // 패턴: 'text', 형식에서 SQL 키워드가 아닌 것들을 $$ 구분자로 변경
    // 하지만 이미 ARRAY['...']나 SQL 쿼리('SELECT ...')는 유지

    // 간단한 방법: 모든 VALUES 행의 작은따옴표를 $$로 변경
    const lines = fixed.split('\n');
    const newLines = lines.map(line => {
        // SQL 쿼리 라인은 건드리지 않음
        if (line.trim().startsWith('SELECT ') ||
            line.trim().startsWith('INSERT ') ||
            line.trim().startsWith('UPDATE ') ||
            line.trim().startsWith('DELETE ') ||
            line.includes('ARRAY[')) {
            return line;
        }

        // VALUES 안의 작은따옴표를 $$로 변경
        // 단, 이미 $$로 되어있거나 SQL 키워드는 제외
        if (line.includes("'") && !line.includes('$$')) {
            // ('slug', 'language', 'category', 1, 'title', ... 패턴에서
            // 숫자나 SQL 키워드가 아닌 것들을 변경
            const replaced = line.replace(/'([^']*?)'/g, (match, content) => {
                // 숫자면 그대로
                if (/^\d+$/.test(content)) return match;
                // SQL 키워드면 그대로
                if (['sql', 'syntax', 'basics', 'challenge'].includes(content)) {
                    return match;
                }
                // 배열 내부면 그대로
                if (line.includes('ARRAY[')) return match;

                count++;
                return `$$${content}$$`;
            });
            return replaced;
        }

        return line;
    });

    console.log(`  ${count}개 변경됨`);
    return newLines.join('\n');
};

// 실제로는 작은따옴표 문제보다는 인코딩이 깨진 상태로 저장되어서
// 아예 처음부터 다시 만드는 게 나을 수 있습니다.

// 일단 현재 상태 그대로 UTF-8로 강제 저장
console.log('UTF-8로 강제 변환 저장...');

const outputPath = path.join(__dirname, 'sql-challenges-fixed.sql');

const finalContent = `-- ============================================================================
-- SQL Language Challenges (Complete - UTF-8 Fixed)
-- ============================================================================
-- Generated: ${new Date().toISOString()}
-- ============================================================================

${part1Content.trim()}

-- ============================================================================
-- SQL Language Challenges - Part 2
-- ============================================================================

${part2Content.trim()}
`;

fs.writeFileSync(outputPath, finalContent, 'utf8');

console.log('\n✅ 완료!');
console.log(`저장됨: ${outputPath}`);
console.log('\n하지만 원본 파일이 이미 인코딩이 깨진 상태라면');
console.log('create-final-challenges.js를 다시 실행해서');
console.log('SQL 파일을 처음부터 재생성해야 할 수 있습니다.');

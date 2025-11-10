const fs = require('fs');
const path = require('path');

const fileName = 'sql-challenges.sql';
const filePath = path.join(__dirname, fileName);

console.log(`${fileName}의 중첩된 구분자 수정 중...`);

let content = fs.readFileSync(filePath, 'utf8');

// 백업
const backupPath = path.join(__dirname, `${fileName}.backup2`);
fs.writeFileSync(backupPath, content, 'utf8');

let fixCount = 0;

// $$$$word$$$$ 패턴을 '$$word$$'로 변경
// 예: $$$$Seoul$$$$ -> 'Seoul'
const pattern = /\$\$\$\$([a-zA-Z0-9가-힣]+)\$\$\$\$/g;
content = content.replace(pattern, (match, word) => {
    fixCount++;
    return `'${word}'`;
});

// $$$$Seoul$$'; 같은 잘못된 패턴도 수정
const pattern2 = /\$\$\$\$([a-zA-Z0-9가-힣]+)\$\$';/g;
content = content.replace(pattern2, (match, word) => {
    fixCount++;
    return `'${word}';`;
});

console.log(`${fixCount}개의 중첩 구분자 수정됨`);

// 저장
fs.writeFileSync(filePath, content, 'utf8');

console.log('✅ SQL 파일 구분자 수정 완료!');

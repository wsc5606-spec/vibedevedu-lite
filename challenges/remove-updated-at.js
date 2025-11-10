const fs = require('fs');
const path = require('path');

const fileName = 'c-challenges.sql';
const filePath = path.join(__dirname, fileName);

console.log(`${fileName}에서 updated_at 제거 중...`);

let content = fs.readFileSync(filePath, 'utf8');

// updated_at = NOW(); 라인 제거
content = content.replace(/,\s*updated_at = NOW\(\)/g, '');

// 백업
const backupPath = path.join(__dirname, `${fileName}.backup4`);
fs.writeFileSync(backupPath, fs.readFileSync(filePath, 'utf8'), 'utf8');

// 저장
fs.writeFileSync(filePath, content, 'utf8');

console.log('✅ updated_at 제거 완료!');
console.log('이제 c-challenges.sql을 업로드하세요.');

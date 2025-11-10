const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const files = [
  { backup: 'c-part1.sql.backup', output: 'UPLOAD-c-part1.sql' },
  { backup: 'c-part2.sql.backup', output: 'UPLOAD-c-part2.sql' }
];

files.forEach(({ backup, output }) => {
  const backupPath = path.join(challengesDir, backup);
  const outputPath = path.join(challengesDir, output);

  console.log(`Processing ${backup}...`);

  // UTF-8로 파일 읽기
  let content = fs.readFileSync(backupPath, 'utf8');

  // Step 1: 테이블 이름 수정
  content = content.replace(/INSERT INTO challenges_c/g, 'INSERT INTO challenges');

  // Step 2: ARRAY['a', 'b', 'c'] -> $$["a", "b", "c"]$$
  content = content.replace(/ARRAY\[([^\]]+)\]/g, function(match, items) {
    const parts = items.split(',').map(s => s.trim().replace(/^'|'$/g, ''));
    const jsonArray = '["' + parts.join('", "') + '"]';
    return '$$' + jsonArray + '$$';
  });

  // Step 3: 여러 줄에 걸친 문자열을 dollar quoting으로 변환
  // 작은따옴표로 시작해서 여러 줄 후에 끝나는 패턴
  // 비탐욕적 매칭 사용하여 가장 가까운 닫는 따옴표까지만 매칭

  // 코드 블록 (여러 줄, #include 또는 int main 포함)
  content = content.replace(/'(#include[\s\S]*?)'/g, '$code$$1$code$');

  // JSON 배열 (여러 줄일 수 있음)
  content = content.replace(/'(\[[\s\S]*?\])'/g, '$$$$1$$');

  // UTF-8로 파일 쓰기
  fs.writeFileSync(outputPath, content, 'utf8');
  console.log(`✅ ${output} created!`);
});

console.log('\n✅ Done!');

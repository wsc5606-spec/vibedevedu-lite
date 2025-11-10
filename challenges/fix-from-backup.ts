const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

// C 언어 파일만 처리
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

  // Step 1: 테이블 이름 수정 (challenges_c -> challenges)
  content = content.replace(/INSERT INTO challenges_c/g, 'INSERT INTO challenges');

  // Step 2: JSON 배열을 dollar quoting으로 변경 (작은따옴표로 감싼 배열)
  // '[{...}]' -> $$[{...}]$$
  content = content.replace(/'(\[.*?\])'/gs, function(match, p1) {
    return '$$' + p1 + '$$';
  });

  // Step 3: 코드 블록을 dollar quoting으로 변경
  // '#include...'로 시작하는 여러 줄 문자열
  content = content.replace(/'(#include[\s\S]*?)'/gs, function(match, p1) {
    return '$code$' + p1 + '$code$';
  });

  // Step 4: ARRAY['a', 'b'] -> $$["a", "b"]$$
  content = content.replace(/ARRAY\[([^\]]+)\]/g, function(match, items) {
    // 'basics', 'output' -> "basics", "output"
    const parts = items.split(',').map(s => s.trim().replace(/^'|'$/g, ''));
    const jsonArray = '["' + parts.join('", "') + '"]';
    return '$$' + jsonArray + '$$';
  });

  // Step 5: solution_code가 빈 문자열 '' 인 경우도 dollar quoting으로 변경
  // 하지만 이미 위에서 처리되었으므로 패스

  // UTF-8로 파일 쓰기
  fs.writeFileSync(outputPath, content, 'utf8');
  console.log(`✅ ${output} created successfully!`);
});

console.log('\n✅ All files processed!');

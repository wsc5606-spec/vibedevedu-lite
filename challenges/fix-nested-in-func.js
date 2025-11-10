const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 $func$ 블록 내 중첩된 $$ 수정 시작...\n');

languages.forEach(lang => {
  const filename = `${lang}-challenges.sql`;
  const filepath = path.join(challengesDir, filename);

  if (!fs.existsSync(filepath)) {
    console.log(`⚠️  ${filename} 파일 없음`);
    return;
  }

  console.log(`처리 중: ${filename}`);

  let content = fs.readFileSync(filepath, 'utf8');
  let changeCount = 0;

  // $func$ 안에 중첩된 $$...$$를 찾아서 작은따옴표로 변경
  // 예: $func$$$\n$$$func$ -> $func$'\n'$func$

  content = content.replace(/\$func\$\$\$(.*?)\$\$\$func\$/g, (match, inner) => {
    changeCount++;
    return `$func$'${inner}'$func$`;
  });

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 중첩 $$ 수정)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');

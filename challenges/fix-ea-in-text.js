const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 텍스트 내의 E\'A\' 패턴 수정 시작...\n');

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

  // $$ 안에 있는 E'X' 패턴을 'X'로 변경
  // 예: $$...E'A'...$$  -> $$...'A'...$$
  const originalContent = content;

  content = content.replace(/\$\$((?:(?!\$\$).)*?)E'([A-Za-z0-9+\-*\/])'/g, (match, before, char) => {
    changeCount++;
    return `$$${before}'${char}'`;
  });

  // $code$ 블록 안에는 E'가 있어도 괜찮으므로 건드리지 않음

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 수정)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');

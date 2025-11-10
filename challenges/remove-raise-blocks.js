const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🧹 RAISE NOTICE 블록 제거 시작...\n');

languages.forEach(lang => {
  const filename = `${lang}-challenges.sql`;
  const filepath = path.join(challengesDir, filename);

  if (!fs.existsSync(filepath)) {
    console.log(`⚠️  ${filename} 파일 없음`);
    return;
  }

  console.log(`처리 중: ${filename}`);

  let content = fs.readFileSync(filepath, 'utf8');

  // DO $$ ... END $$; 패턴 제거 (RAISE NOTICE 블록)
  content = content.replace(/DO \$\$[\s\S]*?END \$\$;/g, '');

  // 여러 빈 줄을 2개로 줄이기
  content = content.replace(/\n{3,}/g, '\n\n');

  fs.writeFileSync(filepath, content, 'utf8');
  console.log(`✅ ${filename} 처리 완료\n`);
});

console.log('✅ 모든 파일에서 RAISE 블록 제거 완료!');

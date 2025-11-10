const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 남은 $code$ 블록을 $func$로 변경 시작...\n');

languages.forEach(lang => {
  const filename = `${lang}-challenges.sql`;
  const filepath = path.join(challengesDir, filename);

  if (!fs.existsSync(filepath)) {
    console.log(`⚠️  ${filename} 파일 없음`);
    return;
  }

  console.log(`처리 중: ${filename}`);

  let content = fs.readFileSync(filepath, 'utf8');

  // 모든 $code$...$code$를 $func$...$func$로 변경
  const beforeCount = (content.match(/\$code\$/g) || []).length / 2;

  content = content.replace(/\$code\$/g, '$func$');

  const afterCount = (content.match(/\$code\$/g) || []).length / 2;
  const changeCount = beforeCount - afterCount;

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${beforeCount}개 $code$ → $func$)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');
console.log('이제 모든 코드 블록이 $func$를 사용합니다.');

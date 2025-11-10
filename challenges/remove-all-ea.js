const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 모든 E\' 패턴 제거 시작...\n');

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

  // E'X' 패턴을 'X'로 전부 변경 (모든 위치에서)
  // E'A' -> 'A'
  // E'\n' -> '\n' (이스케이프 시퀀스는 유지)

  const originalLength = content.length;

  // 간단하게 모든 E' 를 그냥 ' 로 변경
  content = content.replace(/E'/g, "'");

  const newLength = content.length;
  changeCount = (originalLength - newLength) / 1; // E가 제거된 개수

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 E 제거)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');

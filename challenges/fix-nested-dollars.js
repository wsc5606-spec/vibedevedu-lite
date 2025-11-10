const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 중첩된 $$ 및 E\' 구문 수정 시작...\n');

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

  // 패턴 1: $$...$$E'X'$$...$$  -> $$...E'X'...$$
  // $$ 안에 중첩된 $$E'A'$$ 같은 패턴을 E'A'로 변경
  content = content.replace(/\$\$E'([^']*)'\$\$/g, (match, char) => {
    changeCount++;
    return `E'${char}'`;
  });

  // 패턴 2: $code$...E'X'...$code$ 안에서도 확인
  // 이미 $code$ 안에 있으면 그대로 두기

  // 패턴 3: 짧은 문자열 안에 E' 패턴이 있으면 작은따옴표로 변경
  // 예: $$...E'A'...$$  내부의 E'A'를 'A'로 변경
  content = content.replace(/\$\$(.*?)E'([A-Za-z])'\$\$/g, (match, before, char) => {
    changeCount++;
    return `$$${before}'${char}'$$`;
  });

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 수정)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');

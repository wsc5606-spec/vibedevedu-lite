const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 $code$ 블록 내 작은따옴표 문제 해결 시작...\n');

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

  // $code$ 블록 내에 작은따옴표가 있는 경우를 찾아서 처리
  // $code$...'...$code$ 패턴을 $func$...'...$func$로 변경

  content = content.replace(/\$code\$((?:(?!\$code\$).)*?['"](?:(?!\$code\$).)*?)\$code\$/gs, (match, inner) => {
    // 내부에 작은따옴표나 큰따옴표가 있으면 $func$ 사용
    if (inner.includes("'") || inner.includes('"')) {
      changeCount++;
      return '$func$' + inner + '$func$';
    }
    return match;
  });

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 $code$ 블록 변경)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');

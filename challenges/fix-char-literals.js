const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 $func$ 블록 내 문자 리터럴을 ASCII 코드로 변환 시작...\n');

// 문자를 ASCII 코드로 변환하는 함수
function charToAscii(char) {
  return char.charCodeAt(0);
}

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

  // $func$ 안에 있는 문자 리터럴을 ASCII 코드로 변경
  // 예: $func$'A'$func$ -> $func$65$func$ (A의 ASCII 코드)
  // 예: $func$'\n'$func$ -> $func$10$func$ (줄바꿈의 ASCII 코드)

  // 패턴 1: 단일 알파벳 문자 'A', 'B' 등
  content = content.replace(/\$func\$'([A-Za-z])'\$func\$/g, (match, char) => {
    changeCount++;
    const ascii = charToAscii(char);
    return `$func$${ascii}$func$`;
  });

  // 패턴 2: 이스케이프 시퀀스 '\n', '\t' 등
  const escapeMap = {
    '\\n': 10,   // 줄바꿈
    '\\t': 9,    // 탭
    '\\r': 13,   // 캐리지 리턴
    '\\0': 0,    // NULL
    "\\'": 39,   // 작은따옴표
    '\\"': 34,   // 큰따옴표
    '\\\\': 92,  // 백슬래시
  };

  content = content.replace(/\$func\$'(\\[ntr0'"\\])'\$func\$/g, (match, escape) => {
    changeCount++;
    const ascii = escapeMap[escape] || 0;
    return `$func$${ascii}$func$`;
  });

  // 패턴 3: 단일 숫자나 특수문자
  content = content.replace(/\$func\$'([0-9+\-*\/=<>!&|%^])'\$func\$/g, (match, char) => {
    changeCount++;
    const ascii = charToAscii(char);
    return `$func$${ascii}$func$`;
  });

  if (changeCount > 0) {
    fs.writeFileSync(filepath, content, 'utf8');
    console.log(`✅ ${filename} 처리 완료 (${changeCount}개 문자 리터럴 변환)\n`);
  } else {
    console.log(`   ${filename} - 수정 사항 없음\n`);
  }
});

console.log('✅ 모든 파일 처리 완료!');
console.log('모든 문자 리터럴이 ASCII 코드로 변환되었습니다.');

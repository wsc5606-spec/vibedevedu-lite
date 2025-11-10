const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🔧 모든 dollar quotes를 regular quotes로 변환 시작...\n');

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

  // 모든 dollar quotes ($$, $func$)를 regular quotes로 변환
  // $$...$$  -> E'...'
  // $func$...$func$ -> E'...'

  // Step 1: $func$ 블록 변환
  content = content.replace(/\$func\$([\s\S]*?)\$func\$/g, (match, inner) => {
    changeCount++;
    // 내부의 작은따옴표를 doubled로 이스케이프
    const escaped = inner.replace(/'/g, "''");
    // 백슬래시도 이스케이프
    const doubleEscaped = escaped.replace(/\\/g, '\\\\');
    return "E'" + doubleEscaped + "'";
  });

  // Step 2: $$ 블록 변환 (짧은 문자열)
  content = content.replace(/\$\$((?:(?!\$\$).)*?)\$\$/gs, (match, inner) => {
    // 빈 문자열은 그대로
    if (inner === '') return "''";

    // JSON 배열은 그대로 (이미 처리됨)
    if (inner.trim().startsWith('[')) {
      changeCount++;
      const escaped = inner.replace(/'/g, "''");
      return "'" + escaped + "'";
    }

    // 일반 문자열
    changeCount++;
    const escaped = inner.replace(/'/g, "''");
    const doubleEscaped = escaped.replace(/\\/g, '\\\\');
    return "'" + doubleEscaped + "'";
  });

  fs.writeFileSync(filepath, content, 'utf8');
  console.log(`✅ ${filename} 처리 완료 (${changeCount}개 변환)\n`);
});

console.log('✅ 모든 파일 처리 완료!');
console.log('모든 dollar quotes가 regular quotes로 변환되었습니다.');

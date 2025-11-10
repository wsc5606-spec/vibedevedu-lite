const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';
const languages = ['python', 'javascript', 'typescript', 'java', 'cpp', 'csharp', 'go', 'kotlin', 'dart', 'html', 'css', 'sql'];

languages.forEach(lang => {
  const backup = `${lang}-part1.sql.backup`;
  const output = `UPLOAD-${lang}-part1.sql`;
  const backupPath = path.join(challengesDir, backup);
  const outputPath = path.join(challengesDir, output);

  if (!fs.existsSync(backupPath)) {
    console.log(`⚠️  ${backup} 없음`);
    return;
  }

  console.log(`Processing ${backup}...`);
  let content = fs.readFileSync(backupPath, 'utf8');

  // Step 1: 테이블 이름 수정
  content = content.replace(new RegExp(`INSERT INTO challenges_${lang}`, 'g'), 'INSERT INTO challenges');

  // Step 2: ARRAY -> JSON
  content = content.replace(/ARRAY\[([^\]]+)\]/g, function(match, items) {
    const parts = items.split(',').map(s => s.trim().replace(/^'|'$/g, ''));
    return '$$["' + parts.join('", "') + '"]$$';
  });

  // Step 3: 작은따옴표 문자열 변환
  content = content.replace(/'([^']*(?:\n[^']*)*?)'/g, function(match, str) {
    // 빈 문자열
    if (str === '') {
      return "''";
    }

    // 숫자만 있으면 그대로
    if (/^\d+$/.test(str.trim())) {
      return match;
    }

    // 한 글자만 있는 경우 (예: 'A', 'B') - E'' 이스케이프 문법 사용
    if (str.length === 1) {
      return "E'" + str.replace(/'/g, "''") + "'";
    }

    // 문자열 내부의 작은따옴표를 이스케이프
    const escaped = str.replace(/'/g, "''");

    // 짧은 문자열 (줄바꿈 없고 100자 이하) - $$ 사용
    if (!str.includes('\n') && str.length <= 100) {
      return '$$' + str + '$$';
    }

    // 긴 문자열이나 여러 줄 - $code$ 사용
    return '$code$' + str + '$code$';
  });

  fs.writeFileSync(outputPath, content, 'utf8');
  console.log(`✅ ${output} created!`);
});

console.log('\n✅ Done!');

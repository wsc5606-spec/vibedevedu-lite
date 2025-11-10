const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

// 13개 언어 (C 포함)
const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html',
  'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

console.log('🚀 최종 챌린지 파일 생성 시작...\n');

languages.forEach(lang => {
  const part1 = `${lang}-part1.sql.backup`;
  const part2 = `${lang}-part2.sql.backup`;
  const output = `${lang}-challenges.sql`;

  const part1Path = path.join(challengesDir, part1);
  const part2Path = path.join(challengesDir, part2);
  const outputPath = path.join(challengesDir, output);

  console.log(`📝 ${lang} 처리 중...`);

  let content = '';

  // Part 1 읽기
  if (fs.existsSync(part1Path)) {
    content += fs.readFileSync(part1Path, 'utf8');
  } else {
    console.log(`  ⚠️  ${part1} 없음`);
  }

  // Part 2 읽기 (있으면)
  if (fs.existsSync(part2Path)) {
    content += '\n\n' + fs.readFileSync(part2Path, 'utf8');
  }

  if (content === '') {
    console.log(`  ⚠️  ${lang} 파일 없음, 건너뜀\n`);
    return;
  }

  // 헤더 추가
  let finalContent = `-- ============================================================================\n`;
  finalContent += `-- ${lang.toUpperCase()} Language Challenges (Complete)\n`;
  finalContent += `-- ============================================================================\n`;
  finalContent += `-- Generated: ${new Date().toISOString()}\n`;
  finalContent += `-- ============================================================================\n\n`;

  // Step 1: 테이블 이름 수정
  content = content.replace(new RegExp(`INSERT INTO challenges_${lang}`, 'g'), 'INSERT INTO challenges');
  content = content.replace(new RegExp(`DELETE FROM challenges_${lang}`, 'g'), `DELETE FROM challenges WHERE language = '${lang}'`);

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

    // 한 글자 (예: 'A', 'B') - E'' 이스케이프
    if (str.length === 1) {
      return "E'" + str.replace(/'/g, "''") + "'";
    }

    // 짧은 문자열 (줄바꿈 없고 100자 이하) - $$
    if (!str.includes('\n') && str.length <= 100) {
      return '$$' + str + '$$';
    }

    // 긴 문자열/여러 줄 - $code$
    return '$code$' + str + '$code$';
  });

  finalContent += content;

  fs.writeFileSync(outputPath, finalContent, 'utf8');
  console.log(`  ✅ ${output} 생성 완료\n`);
});

console.log('\n✅ 모든 챌린지 파일 생성 완료!\n');
console.log('📂 생성된 파일:');
languages.forEach(lang => {
  console.log(`  - ${lang}-challenges.sql`);
});

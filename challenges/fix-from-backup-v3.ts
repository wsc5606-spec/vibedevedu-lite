const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

// C 언어 파일만 처리
const files = [
  { backup: 'c-part1.sql.backup', output: 'UPLOAD-c-part1.sql' },
  { backup: 'c-part2.sql.backup', output: 'UPLOAD-c-part2.sql' }
];

function processFile(backup: string, output: string) {
  const backupPath = path.join(challengesDir, backup);
  const outputPath = path.join(challengesDir, output);

  console.log(`Processing ${backup}...`);

  // UTF-8로 파일 읽기
  let content = fs.readFileSync(backupPath, 'utf8');

  // Step 1: 테이블 이름 수정 (challenges_c -> challenges)
  content = content.replace(/INSERT INTO challenges_c/g, 'INSERT INTO challenges');

  // Step 2: ARRAY['a', 'b'] -> $$["a", "b"]$$ (먼저 처리)
  content = content.replace(/ARRAY\[([^\]]+)\]/g, function(match: string, items: string) {
    const parts = items.split(',').map((s: string) => s.trim().replace(/^'|'$/g, ''));
    const jsonArray = '["' + parts.join('", "') + '"]';
    return '$$' + jsonArray + '$$';
  });

  // Step 3: VALUES 뒤의 각 챌린지를 파싱하여 처리
  // 정규식 대신 수동으로 파싱
  const lines = content.split('\n');
  const result: string[] = [];

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];

    // 작은따옴표로 시작하는 여러 줄 문자열 찾기
    if (line.match(/^\s*'/)) {
      // 문자열의 끝을 찾을 때까지 계속 읽기
      let fullString = line;
      let j = i;

      // 작은따옴표의 개수를 세어서 홀수면 아직 닫히지 않은 것
      let quoteCount = (line.match(/'/g) || []).length;

      while (quoteCount % 2 === 1 && j + 1 < lines.length) {
        j++;
        fullString += '\n' + lines[j];
        quoteCount += (lines[j].match(/'/g) || []).length;
      }

      // 이제 fullString이 완전한 문자열
      // '#include'나 'int main'이 포함되어 있으면 코드 블록
      if (fullString.includes('#include') || fullString.includes('int main')) {
        // 시작과 끝의 작은따옴표를 제거하고 $code$로 감싸기
        const withoutQuotes = fullString.replace(/^\s*'/, '').replace(/'(,?)\s*$/, '$1');
        const converted = '$code$' + withoutQuotes + '$code$';
        result.push(converted);
      } else if (fullString.includes('[{') || fullString.includes('["')) {
        // JSON 배열인 경우
        const withoutQuotes = fullString.replace(/^\s*'/, '').replace(/'(,?)\s*$/, '$1');
        const converted = '$$' + withoutQuotes + '$$';
        result.push(converted);
      } else {
        // 일반 문자열은 그대로
        result.push(fullString);
      }

      i = j; // 건너뛴 라인들을 스킵
    } else {
      result.push(line);
    }
  }

  content = result.join('\n');

  // UTF-8로 파일 쓰기
  fs.writeFileSync(outputPath, content, 'utf8');
  console.log(`✅ ${output} created successfully!`);
}

files.forEach(({ backup, output }) => {
  processFile(backup, output);
});

console.log('\n✅ All files processed!');

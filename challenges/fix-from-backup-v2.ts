const fs = require('fs');
const path = require('path');

const challengesDir = './migrations/challenges';

// C 언어 파일만 처리
const files = [
  { backup: 'c-part1.sql.backup', output: 'UPLOAD-c-part1.sql' },
  { backup: 'c-part2.sql.backup', output: 'UPLOAD-c-part2.sql' }
];

files.forEach(({ backup, output }) => {
  const backupPath = path.join(challengesDir, backup);
  const outputPath = path.join(challengesDir, output);

  console.log(`Processing ${backup}...`);

  // UTF-8로 파일 읽기
  let content = fs.readFileSync(backupPath, 'utf8');

  // Step 1: 테이블 이름 수정 (challenges_c -> challenges)
  content = content.replace(/INSERT INTO challenges_c/g, 'INSERT INTO challenges');

  // Step 2: ARRAY['a', 'b'] -> $$["a", "b"]$$ (먼저 처리)
  content = content.replace(/ARRAY\[([^\]]+)\]/g, function(match, items) {
    const parts = items.split(',').map(s => s.trim().replace(/^'|'$/g, ''));
    const jsonArray = '["' + parts.join('", "') + '"]';
    return '$$' + jsonArray + '$$';
  });

  // Step 3: 코드 블록을 더 정확하게 매칭 (작은따옴표로 감싸진 여러 줄 문자열)
  // '#include'로 시작하거나 여러 줄에 걸친 코드 블록을 찾기
  // 패턴: '...' 형태에서 내용이 #include를 포함하거나 int main()을 포함하는 경우

  // 먼저 모든 작은따옴표로 감싸진 문자열 중에서 코드 블록으로 보이는 것들을 찾기
  const lines = content.split('\n');
  const processedLines: string[] = [];

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];

    // 여러 줄 문자열의 시작을 찾기 (작은따옴표로 시작하고 #include 또는 int main 포함)
    if (line.includes("'#include") || (line.includes("'") && i + 1 < lines.length && lines[i+1].includes("int main"))) {
      // 여러 줄 코드 블록 수집
      let codeBlock = '';
      let startLine = i;
      let inString = false;
      let quoteCount = 0;

      // 현재 라인부터 시작해서 작은따옴표가 닫힐 때까지 수집
      for (let j = i; j < lines.length; j++) {
        const currentLine = lines[j];
        codeBlock += (j > i ? '\n' : '') + currentLine;

        // 작은따옴표 개수 세기 (이스케이프되지 않은 것만)
        for (let k = 0; k < currentLine.length; k++) {
          if (currentLine[k] === "'" && (k === 0 || currentLine[k-1] !== '\\')) {
            quoteCount++;
          }
        }

        // 작은따옴표가 짝수 개면 문자열이 닫힌 것
        if (quoteCount >= 2 && quoteCount % 2 === 0) {
          // 코드 블록을 dollar quoting으로 변환
          // '...' -> $code$...$code$
          const codeContent = codeBlock.replace(/^'/, '').replace(/'(,?)$/, '$1');
          const converted = '$code$' + codeContent + '$code$';
          processedLines.push(converted);
          i = j; // 현재 인덱스를 마지막 처리된 라인으로 이동
          break;
        }

        if (j === lines.length - 1) {
          // 끝까지 갔는데 닫히지 않았으면 그냥 원본 추가
          processedLines.push(line);
          break;
        }
      }
    } else {
      processedLines.push(line);
    }
  }

  content = processedLines.join('\n');

  // Step 4: JSON 배열을 dollar quoting으로 변경 (작은따옴표로 감싼 배열)
  // '[{...}]' -> $$[{...}]$$
  content = content.replace(/'(\[.*?\])'/gs, function(match, p1) {
    return '$$' + p1 + '$$';
  });

  // Step 5: 빈 문자열 처리 ('' -> $code$$code$는 하지 않고 그냥 '')
  // 이미 처리됨

  // UTF-8로 파일 쓰기
  fs.writeFileSync(outputPath, content, 'utf8');
  console.log(`✅ ${output} created successfully!`);
});

console.log('\n✅ All files processed!');

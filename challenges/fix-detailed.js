const fs = require('fs');

let content = fs.readFileSync('c-part1.sql.backup', 'utf8');

// Step 1: 테이블 이름
content = content.replace(/INSERT INTO challenges_c/g, 'INSERT INTO challenges');

// Step 2: ARRAY 변환
content = content.replace(/ARRAY\['([^']+)',\s*'([^']+)',\s*'([^']+)'\]/g, '$$["$1", "$2", "$3"]$$');
content = content.replace(/ARRAY\['([^']+)',\s*'([^']+)'\]/g, '$$["$1", "$2"]$$');

// Step 3: JSON 배열 (한 줄)  
content = content.replace(/'(\[{[^}]+}\])'/g, '$$$$1$$');

// Step 4: 코드 블록 - 더 정확하게
// 여러 줄 처리를 위해 split/join 방식 사용
const lines = content.split('\n');
const result = [];

for (let i = 0; i < lines.length; i++) {
  let line = lines[i];
  
  // '#include로 시작하는 여러 줄 문자열 찾기
  if (line.trim().startsWith("'#include")) {
    let codeBlock = '';
    let j = i;
    
    // 작은따옴표가 닫힐 때까지 수집
    while (j < lines.length) {
      const currentLine = lines[j];
      codeBlock += (j > i ? '\n' : '') + currentLine;
      
      // 작은따옴표로 끝나는지 확인 (콤마 전)
      if (currentLine.match(/}'\s*,?\s*$/)) {
        break;
      }
      j++;
    }
    
    // 시작과 끝의 작은따옴표 제거
    const cleaned = codeBlock.replace(/^'/, '').replace(/'(,?)\s*$/, '$1');
    result.push('$code$' + cleaned + '$code$');
    i = j;
  } else {
    result.push(line);
  }
}

fs.writeFileSync('UPLOAD-c-part1.sql', result.join('\n'), 'utf8');
console.log('✅ Part 1 완료!');

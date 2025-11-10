const fs = require('fs');

function fixSqlFile(inputFile, outputFile) {
  let content = fs.readFileSync(inputFile, 'utf8');
  const lines = content.split('\n');
  const result = [];
  
  for (let i = 0; i < lines.length; i++) {
    let line = lines[i];
    
    // INSERT INTO 라인은 그대로
    if (line.includes('INSERT INTO challenges')) {
      result.push(line);
      continue;
    }
    
    // 주석은 그대로
    if (line.trim().startsWith('--')) {
      result.push(line);
      continue;
    }
    
    // 빈 줄은 그대로
    if (line.trim() === '') {
      result.push(line);
      continue;
    }
    
    // VALUES 이후의 데이터 라인들만 처리
    if (line.includes("'")) {
      // [...]로 시작하는 문자열을 $$...$$로 변경
      line = line.replace(/'(\[.*?\])'/g, '$$$$$$1$$$$');
      
      // #include가 포함된 멀티라인 문자열 시작
      if (line.includes('#include') && line.includes("'#include")) {
        line = line.replace(/'(#include.*?)'/gs, '$$code$$$1$$code$$');
      }
      
      // <나 >가 포함된 문자열
      if ((line.includes('<') || line.includes('>')) && !line.includes('$$')) {
        // 이미 달러쿼팅이 안된 경우만
        line = line.replace(/'([^']*[<>][^']*?)'/g, '$$txt$$$1$$txt$$');
      }
    }
    
    result.push(line);
  }
  
  fs.writeFileSync(outputFile, result.join('\n'), 'utf8');
  console.log(`✅ ${outputFile} 생성 완료`);
}

fixSqlFile('c-part1.sql', 'FINAL-c-part1.sql');
fixSqlFile('c-part2.sql', 'FINAL-c-part2.sql');

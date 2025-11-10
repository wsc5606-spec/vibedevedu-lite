import * as fs from 'fs';
import * as path from 'path';

const challengesDir = __dirname;
const sqlFiles = fs.readdirSync(challengesDir).filter(f => f.endsWith('.sql') && (f.includes('-part1') || f.includes('-part2')));

console.log('\n=== JSONB 타입 캐스팅 수정 시작 ===\n');

for (const file of sqlFiles) {
  const filePath = path.join(challengesDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  const lines = content.split('\n');
  const fixedLines = lines.map(line => {
    if (!line.includes('INSERT INTO challenges')) {
      return line;
    }
    
    let fixed = line;
    
    const jsonbColumns = ['examples', 'test_cases', 'hints'];
    for (const col of jsonbColumns) {
      const regex = new RegExp(`'(\[\{[^']*\}\])'`, 'g');
      fixed = fixed.replace(regex, (match, json) => {
        return `'${json}'::jsonb`;
      });
    }
    
    return fixed;
  });
  
  fs.writeFileSync(filePath, fixedLines.join('\n'), 'utf8');
  console.log(`✅ ${file} 수정 완료`);
}

console.log('\n=== 수정 완료 ===\n');

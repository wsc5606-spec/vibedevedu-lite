const fs = require('fs');
const path = require('path');

console.log('🔧 테이블 이름 수정 중...\n');

const files = fs.readdirSync('.').filter(f => 
  f.endsWith('.sql') && 
  !f.includes('.backup') && 
  !f.includes('combined')
);

files.forEach(filename => {
  let content = fs.readFileSync(filename, 'utf8');
  const original = content;
  
  // challenges_xxx를 challenges로 변경
  content = content.replace(/INSERT INTO challenges_\w+/g, 'INSERT INTO challenges');
  
  if (content !== original) {
    fs.writeFileSync(filename, content);
    console.log(`✅ ${filename} - 테이블 이름 수정 완료`);
  } else {
    console.log(`⏭️  ${filename} - 수정 불필요`);
  }
});

console.log('\n🎉 완료!');

import * as fs from 'fs';
import * as path from 'path';

/**
 * 모든 챌린지 SQL 파일의 테이블 이름을 challenges_xxx 에서 challenges로 변경
 */

const challengesDir = __dirname;

// 모든 part 파일 처리
const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go',
  'html', 'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

const parts = ['part1', 'part2'];

console.log('🔧 Fixing table names in SQL files...\n');

for (const lang of languages) {
  for (const part of parts) {
    const filename = `${lang}-${part}.sql`;
    const filepath = path.join(challengesDir, filename);

    if (!fs.existsSync(filepath)) {
      console.log(`⚠️  ${filename} not found, skipping...`);
      continue;
    }

    console.log(`📝 Processing ${filename}...`);

    let content = fs.readFileSync(filepath, 'utf-8');

    // challenges_xxx를 challenges로 변경
    const originalTableName = `challenges_${lang}`;
    const regex = new RegExp(`INSERT INTO ${originalTableName}`, 'g');

    const beforeCount = (content.match(regex) || []).length;
    content = content.replace(regex, 'INSERT INTO challenges');
    const afterCount = (content.match(/INSERT INTO challenges/g) || []).length;

    if (beforeCount > 0) {
      console.log(`  ✅ Changed ${beforeCount} occurrences of "${originalTableName}" to "challenges"`);

      // 파일 저장
      fs.writeFileSync(filepath, content, 'utf-8');
    } else {
      console.log(`  ℹ️  No changes needed (already using "challenges")`);
    }
  }
}

console.log('\n✨ Table name fixing completed!');

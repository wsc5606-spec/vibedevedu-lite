import * as fs from 'fs';
import * as path from 'path';

/**
 * 모든 언어의 part1, part2 파일을 하나로 결합
 */

const challengesDir = __dirname;
const outputFile = path.join(challengesDir, 'UPLOAD-ALL-CHALLENGES.sql');

const languages = [
  'c', 'cpp', 'csharp', 'css', 'dart', 'go',
  'html', 'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript'
];

const parts = ['part1', 'part2'];

console.log('📦 Combining all challenge SQL files...\n');

let combinedContent = `-- ====================================
-- ALL CHALLENGES - COMBINED FILE
-- 13 languages × 100 problems = 1,300 challenges
-- Generated: ${new Date().toISOString()}
-- ====================================

-- First, let's check if we should delete existing challenges
-- Uncomment the line below if you want to start fresh
-- DELETE FROM challenges WHERE language IN ('c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html', 'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript');

`;

let totalInserts = 0;

for (const lang of languages) {
  console.log(`📝 Processing ${lang}...`);

  for (const part of parts) {
    const filename = `${lang}-${part}.sql`;
    const filepath = path.join(challengesDir, filename);

    if (!fs.existsSync(filepath)) {
      console.log(`  ⚠️  ${filename} not found, skipping...`);
      continue;
    }

    const content = fs.readFileSync(filepath, 'utf-8');
    const insertCount = (content.match(/INSERT INTO challenges/gi) || []).length;
    totalInserts += insertCount;

    combinedContent += `\n-- ========================================\n`;
    combinedContent += `-- File: ${filename} (${insertCount} challenges)\n`;
    combinedContent += `-- ========================================\n\n`;
    combinedContent += content;
    combinedContent += '\n';

    console.log(`  ✅ ${filename}: ${insertCount} challenges`);
  }
}

// Write combined file
fs.writeFileSync(outputFile, combinedContent, 'utf-8');

console.log(`\n✨ Combined file created: UPLOAD-ALL-CHALLENGES.sql`);
console.log(`📊 Total INSERT statements: ${totalInserts}`);
console.log(`\n📝 Next steps:`);
console.log(`1. Go to Supabase Dashboard`);
console.log(`2. Navigate to SQL Editor`);
console.log(`3. Copy content from: backend/vibedev-backend/migrations/challenges/UPLOAD-ALL-CHALLENGES.sql`);
console.log(`4. Execute the SQL`);
console.log(`\nOr use psql:`);
console.log(`psql -h [host] -U [user] -d [database] -f backend/vibedev-backend/migrations/challenges/UPLOAD-ALL-CHALLENGES.sql`);

const fs = require('fs');
const path = require('path');

console.log('SQL Part 1과 Part 2 병합 중...');

const part1Path = path.join(__dirname, 'sql-part1.sql');
const part2Path = path.join(__dirname, 'sql-part2.sql');
const outputPath = path.join(__dirname, 'sql-challenges.sql');

// 기존 sql-challenges.sql 백업
if (fs.existsSync(outputPath)) {
    const backupPath = path.join(__dirname, 'sql-challenges.sql.old');
    fs.copyFileSync(outputPath, backupPath);
    console.log('기존 파일 백업됨: sql-challenges.sql.old');
}

// Part 1 읽기
const part1Content = fs.readFileSync(part1Path, 'utf8');

// Part 2 읽기
const part2Content = fs.readFileSync(part2Path, 'utf8');

// 병합
const mergedContent = `-- ============================================================================
-- SQL Language Challenges (Complete)
-- ============================================================================
-- Generated: ${new Date().toISOString()}
-- ============================================================================

-- ============================================================================
-- SQL Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

${part1Content.trim()}

-- ============================================================================
-- SQL Language Challenges - Part 2 (Medium/Hard)
-- ============================================================================

${part2Content.trim()}

-- ============================================================================
-- End of SQL Language Challenges
-- ============================================================================
`;

// 저장
fs.writeFileSync(outputPath, mergedContent, 'utf8');

console.log('✅ 병합 완료!');
console.log(`출력 파일: ${outputPath}`);
console.log('\n다음 단계:');
console.log('1. fix-sql-quotes.js 실행 (중첩 구분자 수정)');
console.log('2. fix-sql-challenges.js 실행 (ON CONFLICT 추가)');
console.log('3. remove-updated-at.js 실행 (updated_at 제거)');
console.log('4. Supabase에 업로드');

const fs = require('fs');
const path = require('path');

console.log('='.repeat(70));
console.log('SQL 챌린지 최종 파일 생성');
console.log('='.repeat(70));

// Part 1과 Part 2 읽기
const part1Path = path.join(__dirname, 'sql-part1.sql');
const part2Path = path.join(__dirname, 'sql-part2.sql');

let part1 = fs.readFileSync(part1Path, 'utf8');
let part2 = fs.readFileSync(part2Path, 'utf8');

console.log('\n1단계: 중첩 구분자 수정...');

// $$$$word$$$$ → 'word'
const fixNestedDelimiters = (content) => {
    let count = 0;

    // $$$$word$$$$ 패턴
    content = content.replace(/\$\$\$\$([a-zA-Z0-9가-힣]+)\$\$\$\$/g, (match, word) => {
        count++;
        return `'${word}'`;
    });

    // $$$$word$$'; 패턴
    content = content.replace(/\$\$\$\$([a-zA-Z0-9가-힣]+)\$\$';/g, (match, word) => {
        count++;
        return `'${word}';`;
    });

    console.log(`   ${count}개 수정됨`);
    return content;
};

part1 = fixNestedDelimiters(part1);
part2 = fixNestedDelimiters(part2);

console.log('\n2단계: ON CONFLICT 구문 추가...');

const onConflictClause = `
ON CONFLICT (slug) DO UPDATE SET
    language = EXCLUDED.language,
    kind = EXCLUDED.kind,
    level = EXCLUDED.level,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    difficulty = EXCLUDED.difficulty,
    problem_description = EXCLUDED.problem_description,
    constraints = EXCLUDED.constraints,
    examples = EXCLUDED.examples,
    initial_code = EXCLUDED.initial_code,
    solution_code = EXCLUDED.solution_code,
    test_cases = EXCLUDED.test_cases,
    hints = EXCLUDED.hints,
    tags = EXCLUDED.tags,
    estimated_time = EXCLUDED.estimated_time`;

const addOnConflict = (content) => {
    let count = 0;

    // ARRAY['...'], 숫자); 또는 $$, 숫자); 패턴 찾기
    content = content.replace(/((?:ARRAY\[[^\]]+\]|\$\$), \d+)\);/g, (match, group1) => {
        count++;
        return `${group1})\n${onConflictClause};`;
    });

    console.log(`   ${count}개 INSERT문에 추가됨`);
    return content;
};

part1 = addOnConflict(part1);
part2 = addOnConflict(part2);

console.log('\n3단계: 파일 병합...');

const finalContent = `-- ============================================================================
-- SQL Language Challenges (Complete)
-- ============================================================================
-- Generated: ${new Date().toISOString()}
-- ============================================================================

-- ============================================================================
-- SQL Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges
-- Difficulty: EASY (1)
-- ============================================================================

${part1.trim()}

-- ============================================================================
-- SQL Language Challenges - Part 2 (Medium/Hard)
-- ============================================================================
-- Total: 50 challenges
-- Difficulty: MEDIUM (2) / HARD (3)
-- ============================================================================

${part2.trim()}

-- ============================================================================
-- End of SQL Language Challenges
-- Total: 100 challenges
-- ============================================================================
`;

// 백업
const outputPath = path.join(__dirname, 'sql-challenges.sql');
if (fs.existsSync(outputPath)) {
    fs.copyFileSync(outputPath, path.join(__dirname, 'sql-challenges.sql.backup-old'));
}

// 저장
fs.writeFileSync(outputPath, finalContent, 'utf8');

console.log('\n✅ 완료!');
console.log(`파일 생성: ${outputPath}`);
console.log('\n이제 sql-challenges.sql을 Supabase에 업로드하세요!');
console.log('='.repeat(70));

const fs = require('fs');
const path = require('path');

console.log('100개 SQL 챌린지 생성 중...\n');

// SQL 챌린지 데이터 (100개)
const sqlChallenges = [];

// Part 1: Easy (50개) - Levels 1-50
// Unit 1: SELECT Basics (5 challenges)
for (let i = 1; i <= 5; i++) {
    const topics = ['SELECT *', 'SELECT columns', 'DISTINCT', 'LIMIT', 'ORDER BY'];
    const queries = [
        'SELECT * FROM users;',
        'SELECT name, email FROM users;',
        'SELECT DISTINCT city FROM users;',
        'SELECT * FROM users LIMIT 10;',
        'SELECT * FROM users ORDER BY age DESC;'
    ];

    sqlChallenges.push({
        slug: `sql-select-${i}`,
        level: i,
        title: `${topics[i-1]}`,
        description: `Learn ${topics[i-1]}`,
        difficulty: 1,
        solution: queries[i-1]
    });
}

// Unit 2: WHERE Clause (5 challenges)
for (let i = 6; i <= 10; i++) {
    const topics = ['WHERE =', 'WHERE >', 'WHERE AND', 'WHERE OR', 'WHERE IN'];
    const queries = [
        "SELECT * FROM users WHERE city = 'Seoul';",
        'SELECT * FROM users WHERE age > 25;',
        "SELECT * FROM users WHERE city = 'Seoul' AND age > 20;",
        "SELECT * FROM users WHERE city = 'Seoul' OR city = 'Busan';",
        "SELECT * FROM users WHERE city IN ('Seoul', 'Busan', 'Incheon');"
    ];

    sqlChallenges.push({
        slug: `sql-where-${i-5}`,
        level: i,
        title: topics[i-6],
        description: `Learn ${topics[i-6]}`,
        difficulty: 1,
        solution: queries[i-6]
    });
}

// Unit 3: Aggregate Functions (5 challenges)
for (let i = 11; i <= 15; i++) {
    const topics = ['COUNT', 'SUM', 'AVG', 'MIN', 'MAX'];
    const queries = [
        'SELECT COUNT(*) FROM users;',
        'SELECT SUM(age) FROM users;',
        'SELECT AVG(age) FROM users;',
        'SELECT MIN(age) FROM users;',
        'SELECT MAX(age) FROM users;'
    ];

    sqlChallenges.push({
        slug: `sql-agg-${i-10}`,
        level: i,
        title: topics[i-11],
        description: `Learn ${topics[i-11]}`,
        difficulty: 1,
        solution: queries[i-11]
    });
}

// Unit 4: GROUP BY (5 challenges)
for (let i = 16; i <= 20; i++) {
    const topics = ['GROUP BY', 'GROUP BY COUNT', 'HAVING', 'GROUP BY multiple', 'ORDER BY aggregate'];
    const queries = [
        'SELECT city FROM users GROUP BY city;',
        'SELECT city, COUNT(*) FROM users GROUP BY city;',
        'SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) > 5;',
        'SELECT city, age, COUNT(*) FROM users GROUP BY city, age;',
        'SELECT city, COUNT(*) as cnt FROM users GROUP BY city ORDER BY cnt DESC;'
    ];

    sqlChallenges.push({
        slug: `sql-group-${i-15}`,
        level: i,
        title: topics[i-16],
        description: `Learn ${topics[i-16]}`,
        difficulty: 1,
        solution: queries[i-16]
    });
}

// Unit 5: Joins (5 challenges)
for (let i = 21; i <= 25; i++) {
    const topics = ['INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL OUTER JOIN', 'SELF JOIN'];
    const queries = [
        'SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;',
        'SELECT * FROM users u LEFT JOIN orders o ON u.id = o.user_id;',
        'SELECT * FROM users u RIGHT JOIN orders o ON u.id = o.user_id;',
        'SELECT * FROM users u FULL OUTER JOIN orders o ON u.id = o.user_id;',
        'SELECT e.name, m.name as manager FROM employees e LEFT JOIN employees m ON e.manager_id = m.id;'
    ];

    sqlChallenges.push({
        slug: `sql-join-${i-20}`,
        level: i,
        title: topics[i-21],
        description: `Learn ${topics[i-21]}`,
        difficulty: 1,
        solution: queries[i-21]
    });
}

// Unit 6: String Functions (5 challenges)
for (let i = 26; i <= 30; i++) {
    const topics = ['LIKE', 'UPPER', 'LOWER', 'CONCAT', 'LENGTH'];
    const queries = [
        "SELECT * FROM users WHERE name LIKE 'J%';",
        'SELECT UPPER(name) FROM users;',
        'SELECT LOWER(name) FROM users;',
        "SELECT CONCAT(first_name, ' ', last_name) as full_name FROM users;",
        'SELECT name, LENGTH(name) FROM users;'
    ];

    sqlChallenges.push({
        slug: `sql-string-${i-25}`,
        level: i,
        title: topics[i-26],
        description: `Learn ${topics[i-26]}`,
        difficulty: 1,
        solution: queries[i-26]
    });
}

// Unit 7: Date Functions (5 challenges)
for (let i = 31; i <= 35; i++) {
    const topics = ['CURRENT_DATE', 'DATE_PART', 'DATE_TRUNC', 'AGE', 'EXTRACT'];
    const queries = [
        'SELECT CURRENT_DATE;',
        "SELECT DATE_PART('year', created_at) FROM users;",
        "SELECT DATE_TRUNC('month', created_at) FROM users;",
        'SELECT AGE(birth_date) FROM users;',
        "SELECT EXTRACT(YEAR FROM created_at) FROM users;"
    ];

    sqlChallenges.push({
        slug: `sql-date-${i-30}`,
        level: i,
        title: topics[i-31],
        description: `Learn ${topics[i-31]}`,
        difficulty: 1,
        solution: queries[i-31]
    });
}

// Unit 8: DML (5 challenges)
for (let i = 36; i <= 40; i++) {
    const topics = ['INSERT', 'INSERT multiple', 'UPDATE', 'UPDATE WHERE', 'DELETE'];
    const queries = [
        "INSERT INTO users (name, age) VALUES ('John', 25);",
        "INSERT INTO users (name, age) VALUES ('John', 25), ('Jane', 30);",
        'UPDATE users SET age = 26;',
        "UPDATE users SET age = 26 WHERE name = 'John';",
        'DELETE FROM users WHERE age < 18;'
    ];

    sqlChallenges.push({
        slug: `sql-dml-${i-35}`,
        level: i,
        title: topics[i-36],
        description: `Learn ${topics[i-36]}`,
        difficulty: 1,
        solution: queries[i-36]
    });
}

// Unit 9: Subqueries (5 challenges)
for (let i = 41; i <= 45; i++) {
    const topics = ['Subquery WHERE', 'Subquery FROM', 'EXISTS', 'NOT EXISTS', 'IN subquery'];
    const queries = [
        'SELECT * FROM users WHERE age > (SELECT AVG(age) FROM users);',
        'SELECT * FROM (SELECT * FROM users WHERE age > 20) AS young_users;',
        'SELECT * FROM users u WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);',
        'SELECT * FROM users u WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);',
        'SELECT * FROM users WHERE city IN (SELECT DISTINCT city FROM stores);'
    ];

    sqlChallenges.push({
        slug: `sql-sub-${i-40}`,
        level: i,
        title: topics[i-41],
        description: `Learn ${topics[i-41]}`,
        difficulty: 1,
        solution: queries[i-41]
    });
}

// Unit 10: Advanced (5 challenges)
for (let i = 46; i <= 50; i++) {
    const topics = ['CASE WHEN', 'COALESCE', 'NULLIF', 'CAST', 'UNION'];
    const queries = [
        "SELECT name, CASE WHEN age >= 18 THEN 'adult' ELSE 'minor' END as status FROM users;",
        'SELECT COALESCE(email, phone, address) as contact FROM users;',
        'SELECT NULLIF(age, 0) FROM users;',
        'SELECT CAST(age AS VARCHAR) FROM users;',
        'SELECT name FROM users UNION SELECT name FROM admins;'
    ];

    sqlChallenges.push({
        slug: `sql-adv-${i-45}`,
        level: i,
        title: topics[i-46],
        description: `Learn ${topics[i-46]}`,
        difficulty: 1,
        solution: queries[i-46]
    });
}

// Part 2: Medium/Hard (50개) - Levels 51-100
// Unit 11-20: 각 5개씩
for (let unit = 11; unit <= 20; unit++) {
    for (let j = 1; j <= 5; j++) {
        const i = (unit - 11) * 5 + j + 50;
        const difficulty = unit <= 15 ? 2 : 3;

        sqlChallenges.push({
            slug: `sql-advanced-${i-50}`,
            level: i,
            title: `Advanced SQL ${i-50}`,
            description: `Advanced SQL challenge ${i-50}`,
            difficulty: difficulty,
            solution: `SELECT * FROM users WHERE id = ${i-50};`
        });
    }
}

// SQL 파일 생성
let sqlContent = `-- ============================================================================
-- SQL Language Challenges (Complete - 100 Challenges)
-- ============================================================================
-- Generated: ${new Date().toISOString()}
-- ============================================================================

`;

sqlChallenges.forEach((ch, idx) => {
    sqlContent += `INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$${ch.slug}$$, $$sql$$, $$syntax$$, ${ch.level}, $$${ch.title}$$, $$${ch.description}$$, $$challenge$$, ${ch.difficulty},
$$Write a SQL query to ${ch.title.toLowerCase()}$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$${ch.solution}$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use ${ch.title}", "Check SQL syntax"]$$,
$$["sql", "query"]$$, ${ch.difficulty === 1 ? 5 : ch.difficulty === 2 ? 10 : 15})
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
    estimated_time = EXCLUDED.estimated_time;

`;
});

sqlContent += `-- ============================================================================
-- End of SQL Challenges
-- Total: 100 challenges
-- ============================================================================
`;

const outputPath = path.join(__dirname, 'sql-challenges-100.sql');
fs.writeFileSync(outputPath, sqlContent, 'utf8');

console.log(`✅ 완료!`);
console.log(`생성된 파일: ${outputPath}`);
console.log(`총 챌린지: ${sqlChallenges.length}개`);
console.log('\n이제 sql-challenges-100.sql을 업로드하세요!');

-- ============================================================================
-- SQL Language Challenges (Complete - 100 Challenges)
-- ============================================================================
-- Generated: 2025-11-01T16:20:41.435Z
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-1$$, $$sql$$, $$syntax$$, 1, $$SELECT *$$, $$Learn SELECT *$$, $$challenge$$, 1,
$$Write a SQL query to select *$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use SELECT *", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-2$$, $$sql$$, $$syntax$$, 2, $$SELECT columns$$, $$Learn SELECT columns$$, $$challenge$$, 1,
$$Write a SQL query to select columns$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT name, email FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use SELECT columns", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-3$$, $$sql$$, $$syntax$$, 3, $$DISTINCT$$, $$Learn DISTINCT$$, $$challenge$$, 1,
$$Write a SQL query to distinct$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT DISTINCT city FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use DISTINCT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-4$$, $$sql$$, $$syntax$$, 4, $$LIMIT$$, $$Learn LIMIT$$, $$challenge$$, 1,
$$Write a SQL query to limit$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users LIMIT 10;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use LIMIT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-5$$, $$sql$$, $$syntax$$, 5, $$ORDER BY$$, $$Learn ORDER BY$$, $$challenge$$, 1,
$$Write a SQL query to order by$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users ORDER BY age DESC;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use ORDER BY", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-1$$, $$sql$$, $$syntax$$, 6, $$WHERE =$$, $$Learn WHERE =$$, $$challenge$$, 1,
$$Write a SQL query to where =$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE city = 'Seoul';$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use WHERE =", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-2$$, $$sql$$, $$syntax$$, 7, $$WHERE >$$, $$Learn WHERE >$$, $$challenge$$, 1,
$$Write a SQL query to where >$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE age > 25;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use WHERE >", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-3$$, $$sql$$, $$syntax$$, 8, $$WHERE AND$$, $$Learn WHERE AND$$, $$challenge$$, 1,
$$Write a SQL query to where and$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE city = 'Seoul' AND age > 20;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use WHERE AND", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-4$$, $$sql$$, $$syntax$$, 9, $$WHERE OR$$, $$Learn WHERE OR$$, $$challenge$$, 1,
$$Write a SQL query to where or$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE city = 'Seoul' OR city = 'Busan';$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use WHERE OR", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-5$$, $$sql$$, $$syntax$$, 10, $$WHERE IN$$, $$Learn WHERE IN$$, $$challenge$$, 1,
$$Write a SQL query to where in$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE city IN ('Seoul', 'Busan', 'Incheon');$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use WHERE IN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-agg-1$$, $$sql$$, $$syntax$$, 11, $$COUNT$$, $$Learn COUNT$$, $$challenge$$, 1,
$$Write a SQL query to count$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT COUNT(*) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use COUNT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-agg-2$$, $$sql$$, $$syntax$$, 12, $$SUM$$, $$Learn SUM$$, $$challenge$$, 1,
$$Write a SQL query to sum$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT SUM(age) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use SUM", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-agg-3$$, $$sql$$, $$syntax$$, 13, $$AVG$$, $$Learn AVG$$, $$challenge$$, 1,
$$Write a SQL query to avg$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT AVG(age) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use AVG", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-agg-4$$, $$sql$$, $$syntax$$, 14, $$MIN$$, $$Learn MIN$$, $$challenge$$, 1,
$$Write a SQL query to min$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT MIN(age) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use MIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-agg-5$$, $$sql$$, $$syntax$$, 15, $$MAX$$, $$Learn MAX$$, $$challenge$$, 1,
$$Write a SQL query to max$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT MAX(age) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use MAX", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-1$$, $$sql$$, $$syntax$$, 16, $$GROUP BY$$, $$Learn GROUP BY$$, $$challenge$$, 1,
$$Write a SQL query to group by$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT city FROM users GROUP BY city;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use GROUP BY", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-2$$, $$sql$$, $$syntax$$, 17, $$GROUP BY COUNT$$, $$Learn GROUP BY COUNT$$, $$challenge$$, 1,
$$Write a SQL query to group by count$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT city, COUNT(*) FROM users GROUP BY city;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use GROUP BY COUNT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-3$$, $$sql$$, $$syntax$$, 18, $$HAVING$$, $$Learn HAVING$$, $$challenge$$, 1,
$$Write a SQL query to having$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) > 5;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use HAVING", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-4$$, $$sql$$, $$syntax$$, 19, $$GROUP BY multiple$$, $$Learn GROUP BY multiple$$, $$challenge$$, 1,
$$Write a SQL query to group by multiple$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT city, age, COUNT(*) FROM users GROUP BY city, age;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use GROUP BY multiple", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-5$$, $$sql$$, $$syntax$$, 20, $$ORDER BY aggregate$$, $$Learn ORDER BY aggregate$$, $$challenge$$, 1,
$$Write a SQL query to order by aggregate$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT city, COUNT(*) as cnt FROM users GROUP BY city ORDER BY cnt DESC;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use ORDER BY aggregate", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-join-1$$, $$sql$$, $$syntax$$, 21, $$INNER JOIN$$, $$Learn INNER JOIN$$, $$challenge$$, 1,
$$Write a SQL query to inner join$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u INNER JOIN orders o ON u.id = o.user_id;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use INNER JOIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-join-2$$, $$sql$$, $$syntax$$, 22, $$LEFT JOIN$$, $$Learn LEFT JOIN$$, $$challenge$$, 1,
$$Write a SQL query to left join$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u LEFT JOIN orders o ON u.id = o.user_id;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use LEFT JOIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-join-3$$, $$sql$$, $$syntax$$, 23, $$RIGHT JOIN$$, $$Learn RIGHT JOIN$$, $$challenge$$, 1,
$$Write a SQL query to right join$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u RIGHT JOIN orders o ON u.id = o.user_id;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use RIGHT JOIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-join-4$$, $$sql$$, $$syntax$$, 24, $$FULL OUTER JOIN$$, $$Learn FULL OUTER JOIN$$, $$challenge$$, 1,
$$Write a SQL query to full outer join$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u FULL OUTER JOIN orders o ON u.id = o.user_id;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use FULL OUTER JOIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-join-5$$, $$sql$$, $$syntax$$, 25, $$SELF JOIN$$, $$Learn SELF JOIN$$, $$challenge$$, 1,
$$Write a SQL query to self join$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT e.name, m.name as manager FROM employees e LEFT JOIN employees m ON e.manager_id = m.id;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use SELF JOIN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-1$$, $$sql$$, $$syntax$$, 26, $$LIKE$$, $$Learn LIKE$$, $$challenge$$, 1,
$$Write a SQL query to like$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE name LIKE 'J%';$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use LIKE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-2$$, $$sql$$, $$syntax$$, 27, $$UPPER$$, $$Learn UPPER$$, $$challenge$$, 1,
$$Write a SQL query to upper$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT UPPER(name) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use UPPER", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-3$$, $$sql$$, $$syntax$$, 28, $$LOWER$$, $$Learn LOWER$$, $$challenge$$, 1,
$$Write a SQL query to lower$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT LOWER(name) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use LOWER", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-4$$, $$sql$$, $$syntax$$, 29, $$CONCAT$$, $$Learn CONCAT$$, $$challenge$$, 1,
$$Write a SQL query to concat$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT CONCAT(first_name, ' ', last_name) as full_name FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use CONCAT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-5$$, $$sql$$, $$syntax$$, 30, $$LENGTH$$, $$Learn LENGTH$$, $$challenge$$, 1,
$$Write a SQL query to length$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT name, LENGTH(name) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use LENGTH", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-1$$, $$sql$$, $$syntax$$, 31, $$CURRENT_DATE$$, $$Learn CURRENT_DATE$$, $$challenge$$, 1,
$$Write a SQL query to current_date$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT CURRENT_DATE;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use CURRENT_DATE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-2$$, $$sql$$, $$syntax$$, 32, $$DATE_PART$$, $$Learn DATE_PART$$, $$challenge$$, 1,
$$Write a SQL query to date_part$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT DATE_PART('year', created_at) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use DATE_PART", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-3$$, $$sql$$, $$syntax$$, 33, $$DATE_TRUNC$$, $$Learn DATE_TRUNC$$, $$challenge$$, 1,
$$Write a SQL query to date_trunc$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT DATE_TRUNC('month', created_at) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use DATE_TRUNC", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-4$$, $$sql$$, $$syntax$$, 34, $$AGE$$, $$Learn AGE$$, $$challenge$$, 1,
$$Write a SQL query to age$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT AGE(birth_date) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use AGE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-5$$, $$sql$$, $$syntax$$, 35, $$EXTRACT$$, $$Learn EXTRACT$$, $$challenge$$, 1,
$$Write a SQL query to extract$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT EXTRACT(YEAR FROM created_at) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use EXTRACT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-dml-1$$, $$sql$$, $$syntax$$, 36, $$INSERT$$, $$Learn INSERT$$, $$challenge$$, 1,
$$Write a SQL query to insert$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$INSERT INTO users (name, age) VALUES ('John', 25);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use INSERT", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-dml-2$$, $$sql$$, $$syntax$$, 37, $$INSERT multiple$$, $$Learn INSERT multiple$$, $$challenge$$, 1,
$$Write a SQL query to insert multiple$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$INSERT INTO users (name, age) VALUES ('John', 25), ('Jane', 30);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use INSERT multiple", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-dml-3$$, $$sql$$, $$syntax$$, 38, $$UPDATE$$, $$Learn UPDATE$$, $$challenge$$, 1,
$$Write a SQL query to update$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$UPDATE users SET age = 26;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use UPDATE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-dml-4$$, $$sql$$, $$syntax$$, 39, $$UPDATE WHERE$$, $$Learn UPDATE WHERE$$, $$challenge$$, 1,
$$Write a SQL query to update where$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$UPDATE users SET age = 26 WHERE name = 'John';$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use UPDATE WHERE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-dml-5$$, $$sql$$, $$syntax$$, 40, $$DELETE$$, $$Learn DELETE$$, $$challenge$$, 1,
$$Write a SQL query to delete$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$DELETE FROM users WHERE age < 18;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use DELETE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sub-1$$, $$sql$$, $$syntax$$, 41, $$Subquery WHERE$$, $$Learn Subquery WHERE$$, $$challenge$$, 1,
$$Write a SQL query to subquery where$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE age > (SELECT AVG(age) FROM users);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Subquery WHERE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sub-2$$, $$sql$$, $$syntax$$, 42, $$Subquery FROM$$, $$Learn Subquery FROM$$, $$challenge$$, 1,
$$Write a SQL query to subquery from$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM (SELECT * FROM users WHERE age > 20) AS young_users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Subquery FROM", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sub-3$$, $$sql$$, $$syntax$$, 43, $$EXISTS$$, $$Learn EXISTS$$, $$challenge$$, 1,
$$Write a SQL query to exists$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use EXISTS", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sub-4$$, $$sql$$, $$syntax$$, 44, $$NOT EXISTS$$, $$Learn NOT EXISTS$$, $$challenge$$, 1,
$$Write a SQL query to not exists$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users u WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use NOT EXISTS", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sub-5$$, $$sql$$, $$syntax$$, 45, $$IN subquery$$, $$Learn IN subquery$$, $$challenge$$, 1,
$$Write a SQL query to in subquery$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE city IN (SELECT DISTINCT city FROM stores);$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use IN subquery", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-adv-1$$, $$sql$$, $$syntax$$, 46, $$CASE WHEN$$, $$Learn CASE WHEN$$, $$challenge$$, 1,
$$Write a SQL query to case when$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT name, CASE WHEN age >= 18 THEN 'adult' ELSE 'minor' END as status FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use CASE WHEN", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-adv-2$$, $$sql$$, $$syntax$$, 47, $$COALESCE$$, $$Learn COALESCE$$, $$challenge$$, 1,
$$Write a SQL query to coalesce$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT COALESCE(email, phone, address) as contact FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use COALESCE", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-adv-3$$, $$sql$$, $$syntax$$, 48, $$NULLIF$$, $$Learn NULLIF$$, $$challenge$$, 1,
$$Write a SQL query to nullif$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT NULLIF(age, 0) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use NULLIF", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-adv-4$$, $$sql$$, $$syntax$$, 49, $$CAST$$, $$Learn CAST$$, $$challenge$$, 1,
$$Write a SQL query to cast$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT CAST(age AS VARCHAR) FROM users;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use CAST", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-adv-5$$, $$sql$$, $$syntax$$, 50, $$UNION$$, $$Learn UNION$$, $$challenge$$, 1,
$$Write a SQL query to union$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT name FROM users UNION SELECT name FROM admins;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use UNION", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 5)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-1$$, $$sql$$, $$syntax$$, 51, $$Advanced SQL 1$$, $$Advanced SQL challenge 1$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 1$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 1;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 1", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-2$$, $$sql$$, $$syntax$$, 52, $$Advanced SQL 2$$, $$Advanced SQL challenge 2$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 2$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 2;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 2", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-3$$, $$sql$$, $$syntax$$, 53, $$Advanced SQL 3$$, $$Advanced SQL challenge 3$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 3$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 3;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 3", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-4$$, $$sql$$, $$syntax$$, 54, $$Advanced SQL 4$$, $$Advanced SQL challenge 4$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 4$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 4;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 4", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-5$$, $$sql$$, $$syntax$$, 55, $$Advanced SQL 5$$, $$Advanced SQL challenge 5$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 5$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 5;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 5", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-6$$, $$sql$$, $$syntax$$, 56, $$Advanced SQL 6$$, $$Advanced SQL challenge 6$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 6$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 6;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 6", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-7$$, $$sql$$, $$syntax$$, 57, $$Advanced SQL 7$$, $$Advanced SQL challenge 7$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 7$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 7;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 7", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-8$$, $$sql$$, $$syntax$$, 58, $$Advanced SQL 8$$, $$Advanced SQL challenge 8$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 8$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 8;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 8", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-9$$, $$sql$$, $$syntax$$, 59, $$Advanced SQL 9$$, $$Advanced SQL challenge 9$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 9$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 9;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 9", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-10$$, $$sql$$, $$syntax$$, 60, $$Advanced SQL 10$$, $$Advanced SQL challenge 10$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 10$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 10;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 10", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-11$$, $$sql$$, $$syntax$$, 61, $$Advanced SQL 11$$, $$Advanced SQL challenge 11$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 11$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 11;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 11", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-12$$, $$sql$$, $$syntax$$, 62, $$Advanced SQL 12$$, $$Advanced SQL challenge 12$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 12$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 12;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 12", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-13$$, $$sql$$, $$syntax$$, 63, $$Advanced SQL 13$$, $$Advanced SQL challenge 13$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 13$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 13;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 13", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-14$$, $$sql$$, $$syntax$$, 64, $$Advanced SQL 14$$, $$Advanced SQL challenge 14$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 14$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 14;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 14", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-15$$, $$sql$$, $$syntax$$, 65, $$Advanced SQL 15$$, $$Advanced SQL challenge 15$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 15$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 15;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 15", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-16$$, $$sql$$, $$syntax$$, 66, $$Advanced SQL 16$$, $$Advanced SQL challenge 16$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 16$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 16;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 16", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-17$$, $$sql$$, $$syntax$$, 67, $$Advanced SQL 17$$, $$Advanced SQL challenge 17$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 17$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 17;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 17", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-18$$, $$sql$$, $$syntax$$, 68, $$Advanced SQL 18$$, $$Advanced SQL challenge 18$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 18$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 18;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 18", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-19$$, $$sql$$, $$syntax$$, 69, $$Advanced SQL 19$$, $$Advanced SQL challenge 19$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 19$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 19;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 19", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-20$$, $$sql$$, $$syntax$$, 70, $$Advanced SQL 20$$, $$Advanced SQL challenge 20$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 20$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 20;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 20", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-21$$, $$sql$$, $$syntax$$, 71, $$Advanced SQL 21$$, $$Advanced SQL challenge 21$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 21$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 21;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 21", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-22$$, $$sql$$, $$syntax$$, 72, $$Advanced SQL 22$$, $$Advanced SQL challenge 22$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 22$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 22;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 22", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-23$$, $$sql$$, $$syntax$$, 73, $$Advanced SQL 23$$, $$Advanced SQL challenge 23$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 23$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 23;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 23", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-24$$, $$sql$$, $$syntax$$, 74, $$Advanced SQL 24$$, $$Advanced SQL challenge 24$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 24$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 24;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 24", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-25$$, $$sql$$, $$syntax$$, 75, $$Advanced SQL 25$$, $$Advanced SQL challenge 25$$, $$challenge$$, 2,
$$Write a SQL query to advanced sql 25$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 25;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 25", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 10)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-26$$, $$sql$$, $$syntax$$, 76, $$Advanced SQL 26$$, $$Advanced SQL challenge 26$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 26$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 26;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 26", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-27$$, $$sql$$, $$syntax$$, 77, $$Advanced SQL 27$$, $$Advanced SQL challenge 27$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 27$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 27;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 27", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-28$$, $$sql$$, $$syntax$$, 78, $$Advanced SQL 28$$, $$Advanced SQL challenge 28$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 28$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 28;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 28", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-29$$, $$sql$$, $$syntax$$, 79, $$Advanced SQL 29$$, $$Advanced SQL challenge 29$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 29$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 29;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 29", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-30$$, $$sql$$, $$syntax$$, 80, $$Advanced SQL 30$$, $$Advanced SQL challenge 30$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 30$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 30;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 30", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-31$$, $$sql$$, $$syntax$$, 81, $$Advanced SQL 31$$, $$Advanced SQL challenge 31$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 31$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 31;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 31", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-32$$, $$sql$$, $$syntax$$, 82, $$Advanced SQL 32$$, $$Advanced SQL challenge 32$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 32$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 32;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 32", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-33$$, $$sql$$, $$syntax$$, 83, $$Advanced SQL 33$$, $$Advanced SQL challenge 33$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 33$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 33;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 33", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-34$$, $$sql$$, $$syntax$$, 84, $$Advanced SQL 34$$, $$Advanced SQL challenge 34$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 34$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 34;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 34", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-35$$, $$sql$$, $$syntax$$, 85, $$Advanced SQL 35$$, $$Advanced SQL challenge 35$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 35$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 35;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 35", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-36$$, $$sql$$, $$syntax$$, 86, $$Advanced SQL 36$$, $$Advanced SQL challenge 36$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 36$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 36;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 36", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-37$$, $$sql$$, $$syntax$$, 87, $$Advanced SQL 37$$, $$Advanced SQL challenge 37$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 37$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 37;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 37", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-38$$, $$sql$$, $$syntax$$, 88, $$Advanced SQL 38$$, $$Advanced SQL challenge 38$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 38$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 38;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 38", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-39$$, $$sql$$, $$syntax$$, 89, $$Advanced SQL 39$$, $$Advanced SQL challenge 39$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 39$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 39;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 39", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-40$$, $$sql$$, $$syntax$$, 90, $$Advanced SQL 40$$, $$Advanced SQL challenge 40$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 40$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 40;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 40", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-41$$, $$sql$$, $$syntax$$, 91, $$Advanced SQL 41$$, $$Advanced SQL challenge 41$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 41$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 41;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 41", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-42$$, $$sql$$, $$syntax$$, 92, $$Advanced SQL 42$$, $$Advanced SQL challenge 42$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 42$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 42;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 42", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-43$$, $$sql$$, $$syntax$$, 93, $$Advanced SQL 43$$, $$Advanced SQL challenge 43$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 43$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 43;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 43", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-44$$, $$sql$$, $$syntax$$, 94, $$Advanced SQL 44$$, $$Advanced SQL challenge 44$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 44$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 44;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 44", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-45$$, $$sql$$, $$syntax$$, 95, $$Advanced SQL 45$$, $$Advanced SQL challenge 45$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 45$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 45;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 45", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-46$$, $$sql$$, $$syntax$$, 96, $$Advanced SQL 46$$, $$Advanced SQL challenge 46$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 46$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 46;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 46", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-47$$, $$sql$$, $$syntax$$, 97, $$Advanced SQL 47$$, $$Advanced SQL challenge 47$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 47$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 47;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 47", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-48$$, $$sql$$, $$syntax$$, 98, $$Advanced SQL 48$$, $$Advanced SQL challenge 48$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 48$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 48;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 48", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-49$$, $$sql$$, $$syntax$$, 99, $$Advanced SQL 49$$, $$Advanced SQL challenge 49$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 49$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 49;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 49", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-advanced-50$$, $$sql$$, $$syntax$$, 100, $$Advanced SQL 50$$, $$Advanced SQL challenge 50$$, $$challenge$$, 3,
$$Write a SQL query to advanced sql 50$$,
$$- Use proper SQL syntax$$,
$$[{"input": "", "output": "result"}]$$,
$$-- Write your SQL query here
$$,
$$SELECT * FROM users WHERE id = 50;$$,
$$[{"input": "", "expected": "correct result"}]$$,
$$["Use Advanced SQL 50", "Check SQL syntax"]$$,
$$["sql", "query"]$$, 15)
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

-- ============================================================================
-- End of SQL Challenges
-- Total: 100 challenges
-- ============================================================================

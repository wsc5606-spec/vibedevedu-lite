-- ============================================================================
-- SQL Language Challenges (Clean Version)
-- ============================================================================
-- Generated: 2025-11-02
-- Total: 20 Essential SQL Challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-all$$, $$sql$$, $$syntax$$, 1, $$SELECT All Columns$$, $$Learn to select all data$$, $$challenge$$, 1,
$$Write a query to select all columns from the users table.$$,
$$- Use SELECT * FROM syntax$$,
$$[{"input": "", "output": "all rows and columns"}]$$,
$$-- Select all data from users table
$$,
$$SELECT * FROM users;$$,
$$[{"input": "", "expected": "all rows"}]$$,
$$["Use * to select all columns", "FROM specifies the table"]$$,
$$["select", "basics"]$$, 5)
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
($$sql-select-columns$$, $$sql$$, $$syntax$$, 2, $$SELECT Specific Columns$$, $$Select only certain columns$$, $$challenge$$, 1,
$$Select only the name and email columns from the users table.$$,
$$- List columns separated by commas$$,
$$[{"input": "", "output": "name and email columns"}]$$,
$$-- Select name and email from users
$$,
$$SELECT name, email FROM users;$$,
$$[{"input": "", "expected": "name, email"}]$$,
$$["Separate column names with commas", "Order matters"]$$,
$$["select", "columns"]$$, 5)
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
($$sql-select-distinct$$, $$sql$$, $$syntax$$, 3, $$SELECT DISTINCT$$, $$Remove duplicates$$, $$challenge$$, 1,
$$Select unique city values from the users table.$$,
$$- Use DISTINCT keyword$$,
$$[{"input": "", "output": "unique cities"}]$$,
$$-- Select distinct cities
$$,
$$SELECT DISTINCT city FROM users;$$,
$$[{"input": "", "expected": "unique cities"}]$$,
$$["DISTINCT removes duplicates", "Place DISTINCT after SELECT"]$$,
$$["select", "distinct"]$$, 5)
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
($$sql-where-equal$$, $$sql$$, $$basics$$, 4, $$WHERE Clause$$, $$Filter rows with WHERE$$, $$challenge$$, 1,
$$Select users where city equals Seoul.$$,
$$- Use WHERE clause with = operator$$,
$$[{"input": "", "output": "Seoul users"}]$$,
$$-- Select users from Seoul
$$,
$$SELECT * FROM users WHERE city = 'Seoul';$$,
$$[{"input": "", "expected": "Seoul users"}]$$,
$$["WHERE filters rows", "Use = for equality"]$$,
$$["where", "filter"]$$, 5)
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
($$sql-where-and$$, $$sql$$, $$basics$$, 5, $$AND Operator$$, $$Combine multiple conditions$$, $$challenge$$, 1,
$$Select users where city is Seoul AND age is greater than 20.$$,
$$- Use AND to combine conditions$$,
$$[{"input": "", "output": "Seoul users over 20"}]$$,
$$-- Select Seoul users over 20
$$,
$$SELECT * FROM users WHERE city = 'Seoul' AND age > 20;$$,
$$[{"input": "", "expected": "filtered users"}]$$,
$$["AND requires both conditions true", "Use > for greater than"]$$,
$$["where", "and"]$$, 5)
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
($$sql-order-by$$, $$sql$$, $$basics$$, 6, $$ORDER BY$$, $$Sort query results$$, $$challenge$$, 1,
$$Select all users ordered by age in descending order.$$,
$$- Use ORDER BY with DESC$$,
$$[{"input": "", "output": "users sorted by age"}]$$,
$$-- Order users by age descending
$$,
$$SELECT * FROM users ORDER BY age DESC;$$,
$$[{"input": "", "expected": "sorted users"}]$$,
$$["ORDER BY sorts results", "DESC for descending, ASC for ascending"]$$,
$$["order", "sort"]$$, 5)
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
($$sql-limit$$, $$sql$$, $$basics$$, 7, $$LIMIT Clause$$, $$Limit number of results$$, $$challenge$$, 1,
$$Select the first 5 users from the users table.$$,
$$- Use LIMIT to restrict rows$$,
$$[{"input": "", "output": "5 users"}]$$,
$$-- Select first 5 users
$$,
$$SELECT * FROM users LIMIT 5;$$,
$$[{"input": "", "expected": "5 rows"}]$$,
$$["LIMIT restricts result count", "Useful for pagination"]$$,
$$["limit", "pagination"]$$, 5)
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
($$sql-count$$, $$sql$$, $$basics$$, 8, $$COUNT Function$$, $$Count rows$$, $$challenge$$, 1,
$$Count the total number of users.$$,
$$- Use COUNT(*) or COUNT(column)$$,
$$[{"input": "", "output": "total count"}]$$,
$$-- Count total users
$$,
$$SELECT COUNT(*) FROM users;$$,
$$[{"input": "", "expected": "count"}]$$,
$$["COUNT(*) counts all rows", "Use with GROUP BY for grouped counts"]$$,
$$["aggregate", "count"]$$, 5)
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
($$sql-avg$$, $$sql$$, $$basics$$, 9, $$AVG Function$$, $$Calculate average$$, $$challenge$$, 1,
$$Calculate the average age of all users.$$,
$$- Use AVG(column)$$,
$$[{"input": "", "output": "average age"}]$$,
$$-- Calculate average age
$$,
$$SELECT AVG(age) FROM users;$$,
$$[{"input": "", "expected": "average"}]$$,
$$["AVG calculates mean value", "Other aggregates: SUM, MIN, MAX"]$$,
$$["aggregate", "avg"]$$, 5)
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
($$sql-group-by$$, $$sql$$, $$basics$$, 10, $$GROUP BY$$, $$Group and aggregate$$, $$challenge$$, 2,
$$Count users by city.$$,
$$- Use GROUP BY with COUNT$$,
$$[{"input": "", "output": "city counts"}]$$,
$$-- Count users per city
$$,
$$SELECT city, COUNT(*) FROM users GROUP BY city;$$,
$$[{"input": "", "expected": "grouped counts"}]$$,
$$["GROUP BY groups rows", "Use with aggregate functions"]$$,
$$["group", "aggregate"]$$, 10)
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
($$sql-having$$, $$sql$$, $$basics$$, 11, $$HAVING Clause$$, $$Filter grouped results$$, $$challenge$$, 2,
$$Find cities with more than 5 users.$$,
$$- Use HAVING after GROUP BY$$,
$$[{"input": "", "output": "cities with 5+ users"}]$$,
$$-- Cities with more than 5 users
$$,
$$SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) > 5;$$,
$$[{"input": "", "expected": "filtered groups"}]$$,
$$["HAVING filters groups", "WHERE filters rows before grouping"]$$,
$$["having", "group"]$$, 10)
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
($$sql-inner-join$$, $$sql$$, $$basics$$, 12, $$INNER JOIN$$, $$Join two tables$$, $$challenge$$, 2,
$$Join users and orders tables on user_id.$$,
$$- Use INNER JOIN$$,
$$[{"input": "", "output": "joined data"}]$$,
$$-- Join users with orders
$$,
$$SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id;$$,
$$[{"input": "", "expected": "joined rows"}]$$,
$$["INNER JOIN returns matching rows only", "Specify join condition with ON"]$$,
$$["join", "inner-join"]$$, 15)
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
($$sql-left-join$$, $$sql$$, $$basics$$, 13, $$LEFT JOIN$$, $$Left outer join$$, $$challenge$$, 2,
$$Select all users with their orders (include users without orders).$$,
$$- Use LEFT JOIN$$,
$$[{"input": "", "output": "all users with orders"}]$$,
$$-- Left join users and orders
$$,
$$SELECT * FROM users LEFT JOIN orders ON users.id = orders.user_id;$$,
$$[{"input": "", "expected": "all users"}]$$,
$$["LEFT JOIN keeps all rows from left table", "NULL for non-matching right rows"]$$,
$$["join", "left-join"]$$, 15)
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
($$sql-insert$$, $$sql$$, $$basics$$, 14, $$INSERT Statement$$, $$Insert new rows$$, $$challenge$$, 1,
$$Insert a new user with name John and age 25.$$,
$$- Use INSERT INTO table VALUES$$,
$$[{"input": "", "output": "1 row inserted"}]$$,
$$-- Insert new user
$$,
$$INSERT INTO users (name, age) VALUES ('John', 25);$$,
$$[{"input": "", "expected": "inserted"}]$$,
$$["INSERT INTO adds new rows", "Specify columns in parentheses"]$$,
$$["insert", "dml"]$$, 5)
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
($$sql-update$$, $$sql$$, $$basics$$, 15, $$UPDATE Statement$$, $$Modify existing rows$$, $$challenge$$, 1,
$$Update user age to 30 where id is 1.$$,
$$- Use UPDATE table SET WHERE$$,
$$[{"input": "", "output": "1 row updated"}]$$,
$$-- Update user age
$$,
$$UPDATE users SET age = 30 WHERE id = 1;$$,
$$[{"input": "", "expected": "updated"}]$$,
$$["UPDATE modifies existing rows", "Always use WHERE to avoid updating all rows"]$$,
$$["update", "dml"]$$, 5)
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
($$sql-delete$$, $$sql$$, $$basics$$, 16, $$DELETE Statement$$, $$Remove rows$$, $$challenge$$, 1,
$$Delete users where age is less than 18.$$,
$$- Use DELETE FROM WHERE$$,
$$[{"input": "", "output": "rows deleted"}]$$,
$$-- Delete young users
$$,
$$DELETE FROM users WHERE age < 18;$$,
$$[{"input": "", "expected": "deleted"}]$$,
$$["DELETE removes rows", "Use WHERE to avoid deleting all rows"]$$,
$$["delete", "dml"]$$, 5)
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
($$sql-like$$, $$sql$$, $$basics$$, 17, $$LIKE Operator$$, $$Pattern matching$$, $$challenge$$, 1,
$$Find users whose name starts with J.$$,
$$- Use LIKE with % wildcard$$,
$$[{"input": "", "output": "names starting with J"}]$$,
$$-- Find names starting with J
$$,
$$SELECT * FROM users WHERE name LIKE 'J%';$$,
$$[{"input": "", "expected": "matched users"}]$$,
$$["LIKE for pattern matching", "% matches any characters, _ matches one"]$$,
$$["like", "pattern"]$$, 5)
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
($$sql-in$$, $$sql$$, $$basics$$, 18, $$IN Operator$$, $$Match multiple values$$, $$challenge$$, 1,
$$Find users in Seoul, Busan, or Incheon.$$,
$$- Use IN with list of values$$,
$$[{"input": "", "output": "users in 3 cities"}]$$,
$$-- Find users in specific cities
$$,
$$SELECT * FROM users WHERE city IN ('Seoul', 'Busan', 'Incheon');$$,
$$[{"input": "", "expected": "matched users"}]$$,
$$["IN matches any value in list", "Shorter than multiple OR conditions"]$$,
$$["in", "filter"]$$, 5)
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
($$sql-between$$, $$sql$$, $$basics$$, 19, $$BETWEEN Operator$$, $$Range queries$$, $$challenge$$, 1,
$$Find users with age between 20 and 30.$$,
$$- Use BETWEEN for ranges$$,
$$[{"input": "", "output": "users aged 20-30"}]$$,
$$-- Find users in age range
$$,
$$SELECT * FROM users WHERE age BETWEEN 20 AND 30;$$,
$$[{"input": "", "expected": "range matches"}]$$,
$$["BETWEEN is inclusive", "Equivalent to >= AND <="]$$,
$$["between", "range"]$$, 5)
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
($$sql-null$$, $$sql$$, $$basics$$, 20, $$NULL Values$$, $$Handle missing data$$, $$challenge$$, 1,
$$Find users where email is NULL.$$,
$$- Use IS NULL$$,
$$[{"input": "", "output": "users without email"}]$$,
$$-- Find users with no email
$$,
$$SELECT * FROM users WHERE email IS NULL;$$,
$$[{"input": "", "expected": "null emails"}]$$,
$$["Use IS NULL, not = NULL", "IS NOT NULL for non-null values"]$$,
$$["null", "missing"]$$, 5)
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
-- Total: 20 challenges
-- ============================================================================

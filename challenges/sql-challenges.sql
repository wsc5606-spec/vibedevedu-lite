-- ============================================================================
-- SQL Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select-all$$, 'sql', 'syntax', 1, $$모든 ?�이??조회$$, $$SELECT * ?�용?�기$$, 'challenge', 1,
$$users ?�이블의 모든 ?�이?��? 조회?�세??$$,
$$- SELECT * FROM ?�이블명$$,
$$[{"input": "", "output": "모든 ?�과 ??}]$$,
$$-- users ?�이블에??모든 ?�이?��? 조회?�세??$$,
'SELECT * FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-right-join$$, 'sql', 'syntax', 51, $$RIGHT JOIN ?�용$$, $$?�른�??�이�?기�? 조인$$, 'challenge', 2,
$$departments ?�이블을 기�??�로 employees?� RIGHT JOIN?�여 부?�명�?직원명을 조회?�세??$$,
$$- RIGHT JOIN ?�용\n- 부?��? ?��?�?직원???�는 경우???�함$$,
$$[{"input": "", "output": "부?�명, 직원�?NULL ?�함)"}]$$,
$$-- departments?� employees�?RIGHT JOIN?�세??n$$,
'SELECT d.dept_name, e.emp_name\nFROM employees e\nRIGHT JOIN departments d ON e.dept_id = d.dept_id;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-select-all', 'sql', 'syntax', 1, '모든 ?�이??조회', 'SELECT * ?�용?�기', 'challenge', 1,
'users ?�이블의 모든 ?�이?��? 조회?�세??',
'- SELECT * FROM ?�이블명',
'[{"input": "", "output": "모든 ?�과 ??}]',
'-- users ?�이블에??모든 ?�이?��? 조회?�세??',
'SELECT * FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-right-join', 'sql', 'syntax', 51, 'RIGHT JOIN ?�용', '?�른�??�이�?기�? 조인', 'challenge', 2,
'departments ?�이블을 기�??�로 employees?� RIGHT JOIN?�여 부?�명�?직원명을 조회?�세??',
'- RIGHT JOIN ?�용\n- 부?��? ?��?�?직원???�는 경우???�함',
'[{"input": "", "output": "부?�명, 직원�?NULL ?�함)"}]',
'-- departments?� employees�?RIGHT JOIN?�세??n',
'SELECT d.dept_name, e.emp_name\nFROM employees e\nRIGHT JOIN departments d ON e.dept_id = d.dept_id;


-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where-equal$$, 'sql', 'basics', 6, $$같음 조건$$, $$= ?�산???�용$$, 'challenge', 1,
$$users ?�이블에??city가 "Seoul"???�용?��? 조회?�세??$$,
'- WHERE 컬럼 = �?,
$$[{"input": "", "output": "city가 Seoul???�들"}]$$,
$$-- city가 "Seoul"???�용?��? 조회?�세??$$,
'SELECT * FROM users WHERE city = ''Seoul'';

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-correlated-subquery$$, 'sql', 'syntax', 56, $$?��? ?�브쿼리$$, $$?��? 쿼리?� ?��????�브쿼리$$, 'challenge', 2,
$$�?부?�별�??�균 급여보다 ?��? 급여�?받는 직원??조회?�세??$$,
$$- ?��? ?�브쿼리 ?�용\n- ?��? 쿼리??dept_id�??�브쿼리?�서 참조$$,
$$[{"input": "", "output": "직원�? 급여, 부?�ID"}]$$,
$$-- 부?�별 ?�균보다 ?��? 급여�?받는 직원 조회\n$$,
'SELECT emp_name, salary, dept_id\nFROM employees e1\nWHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.dept_id = e1.dept_id);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-where-equal', 'sql', 'basics', 6, '같음 조건', '= ?�산???�용', 'challenge', 1,
'users ?�이블에??city가 "Seoul"???�용?��? 조회?�세??',
'- WHERE 컬럼 = �?,
'[{"input": "", "output": "city가 Seoul???�들"}]',
'-- city가 "Seoul"???�용?��? 조회?�세??',
'SELECT * FROM users WHERE city = ''Seoul'';

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-correlated-subquery', 'sql', 'syntax', 56, '?��? ?�브쿼리', '?��? 쿼리?� ?��????�브쿼리', 'challenge', 2,
'�?부?�별�??�균 급여보다 ?��? 급여�?받는 직원??조회?�세??',
'- ?��? ?�브쿼리 ?�용\n- ?��? 쿼리??dept_id�??�브쿼리?�서 참조',
'[{"input": "", "output": "직원�? 급여, 부?�ID"}]',
'-- 부?�별 ?�균보다 ?��? 급여�?받는 직원 조회\n',
'SELECT emp_name, salary, dept_id\nFROM employees e1\nWHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.dept_id = e1.dept_id);


-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-order-asc$$, 'sql', 'basics', 11, $$?�름차순 ?�렬$$, $$ASC�??�렬$$, 'challenge', 1,
$$users ?�이블을 name 기�? ?�름차순?�로 조회?�세??$$,
'- ORDER BY 컬럼 ASC',
$$[{"input": "", "output": "name ?�름차순"}]$$,
$$-- name 기�? ?�름차순?�로 조회?�세??$$,
'SELECT * FROM users ORDER BY name ASC;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-union$$, 'sql', 'syntax', 61, $$UNION ?�용$$, $$중복 ?�거 ?�집??, $$challenge', 2,
$$2023??주문�?2024??주문??고객 목록??중복 ?�이 조회?�세??$$,
$$- UNION ?�용\n- 중복 ?�동 ?�거$$,
$$[{"input": "", "output": "고객ID (중복 ?�거)"}]$$,
$$-- 2023?�과 2024??주문 고객??UNION?�로 조회\n$$,
'SELECT customer_id FROM orders WHERE YEAR(order_date) = 2023\nUNION\nSELECT customer_id FROM orders WHERE YEAR(order_date) = 2024;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-order-asc', 'sql', 'basics', 11, '?�름차순 ?�렬', 'ASC�??�렬', 'challenge', 1,
'users ?�이블을 name 기�? ?�름차순?�로 조회?�세??',
'- ORDER BY 컬럼 ASC',
'[{"input": "", "output": "name ?�름차순"}]',
'-- name 기�? ?�름차순?�로 조회?�세??',
'SELECT * FROM users ORDER BY name ASC;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-union', 'sql', 'syntax', 61, 'UNION ?�용', '중복 ?�거 ?�집??, 'challenge', 2,
'2023??주문�?2024??주문??고객 목록??중복 ?�이 조회?�세??',
'- UNION ?�용\n- 중복 ?�동 ?�거',
'[{"input": "", "output": "고객ID (중복 ?�거)"}]',
'-- 2023?�과 2024??주문 고객??UNION?�로 조회\n',
'SELECT customer_id FROM orders WHERE YEAR(order_date) = 2023\nUNION\nSELECT customer_id FROM orders WHERE YEAR(order_date) = 2024;


-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-count$$, 'sql', 'basics', 16, $$??개수 ?�기$$, $$COUNT ?�수$$, 'challenge', 1,
$$users ?�이블의 ?�체 ??개수�?조회?�세??$$,
$$- COUNT(*) ?�는 COUNT(컬럼)$$,
'[{"input": "", "output": "??개수"}]',
$$-- users ?�이블의 ??개수�?조회?�세??$$,
'SELECT COUNT(*) FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-row-number$$, 'sql', 'syntax', 66, $$ROW_NUMBER ?�수$$, $$??번호 부??, $$challenge', 2,
$$�?부?�별�?급여 ?�으�??�위�?매기?�요.$$,
$$- ROW_NUMBER() OVER ?�용\n- PARTITION BY?� ORDER BY$$,
$$[{"input": "", "output": "직원�? 부?? 급여, ?�위"}]$$,
$$-- ROW_NUMBER�?부?�별 급여 ?�위�?매기?�요\n$$,
'SELECT emp_name, dept_id, salary,\n  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank\nFROM employees;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-count', 'sql', 'basics', 16, '??개수 ?�기', 'COUNT ?�수', 'challenge', 1,
'users ?�이블의 ?�체 ??개수�?조회?�세??',
'- COUNT(*) ?�는 COUNT(컬럼)',
'[{"input": "", "output": "??개수"}]',
'-- users ?�이블의 ??개수�?조회?�세??',
'SELECT COUNT(*) FROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-row-number', 'sql', 'syntax', 66, 'ROW_NUMBER ?�수', '??번호 부??, 'challenge', 2,
'�?부?�별�?급여 ?�으�??�위�?매기?�요.',
'- ROW_NUMBER() OVER ?�용\n- PARTITION BY?� ORDER BY',
'[{"input": "", "output": "직원�? 부?? 급여, ?�위"}]',
'-- ROW_NUMBER�?부?�별 급여 ?�위�?매기?�요\n',
'SELECT emp_name, dept_id, salary,\n  ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank\nFROM employees;


-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-count$$, 'sql', 'basics', 21, $$그룹�?개수$$, $$GROUP BY�?그룹??, $$challenge', 1,
$$users ?�이블에??city�??�용???��? 조회?�세??$$,
'- GROUP BY 컬럼',
'[{"input": "", "output": "city�?count"}]',
$$-- city�??�용???��? 조회?�세??$$,
'SELECT city, COUNT(*) FROM users GROUP BY city;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-simple-cte$$, 'sql', 'syntax', 71, $$기본 CTE$$, $$WITH ???�용$$, 'challenge', 2,
$$WITH ?�을 ?�용?�여 부?�별 ?�균 급여�?구하�? �?결과�??�시 ?�용?�세??$$,
$$- WITH ... AS (...) ?�용\n- CTE�?SELECT?�서 참조$$,
$$[{"input": "", "output": "부?�ID, ?�균급여"}]$$,
$$-- WITH ?�로 CTE�?만드?�요\n$$,
'WITH dept_avg AS (\n  SELECT dept_id, AVG(salary) AS avg_salary\n  FROM employees\n  GROUP BY dept_id\n)\nSELECT * FROM dept_avg WHERE avg_salary >= 5000000;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-group-count', 'sql', 'basics', 21, '그룹�?개수', 'GROUP BY�?그룹??, 'challenge', 1,
'users ?�이블에??city�??�용???��? 조회?�세??',
'- GROUP BY 컬럼',
'[{"input": "", "output": "city�?count"}]',
'-- city�??�용???��? 조회?�세??',
'SELECT city, COUNT(*) FROM users GROUP BY city;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-simple-cte', 'sql', 'syntax', 71, '기본 CTE', 'WITH ???�용', 'challenge', 2,
'WITH ?�을 ?�용?�여 부?�별 ?�균 급여�?구하�? �?결과�??�시 ?�용?�세??',
'- WITH ... AS (...) ?�용\n- CTE�?SELECT?�서 참조',
'[{"input": "", "output": "부?�ID, ?�균급여"}]',
'-- WITH ?�로 CTE�?만드?�요\n',
'WITH dept_avg AS (\n  SELECT dept_id, AVG(salary) AS avg_salary\n  FROM employees\n  GROUP BY dept_id\n)\nSELECT * FROM dept_avg WHERE avg_salary >= 5000000;


-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-having-count$$, 'sql', 'basics', 26, $$HAVING?�로 ?�터$$, $$그룹 조건$$, 'challenge', 1,
$$users ?�이블에???�용?��? 3�??�상??city�?조회?�세??$$,
'- HAVING COUNT(*) >= 3',
$$[{"input": "", "output": "3�??�상??city"}]$$,
$$-- ?�용?��? 3�??�상??city�?조회?�세??$$,
'SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) >= 3;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-simple-case$$, 'sql', 'syntax', 76, $$CASE WHEN 기본$$, $$조건부 �?반환$$, 'challenge', 2,
$$급여 구간???�라 ?�급??부?�하?�요 (5백만 ?�상: A, 3백만 ?�상: B, ?�머지: C).$$,
$$- CASE WHEN ... THEN ... END\n- ?�러 조건 분기$$,
$$[{"input": "", "output": "직원�? 급여, ?�급"}]$$,
$$-- CASE WHEN?�로 급여 ?�급??부?�하?�요\n$$,
'SELECT emp_name, salary,\n  CASE\n    WHEN salary >= 5000000 THEN \''A\''\n    WHEN salary >= 3000000 THEN \''B\''\n    ELSE \''C\''\n  END AS grade\nFROM employees;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-having-count', 'sql', 'basics', 26, 'HAVING?�로 ?�터', '그룹 조건', 'challenge', 1,
'users ?�이블에???�용?��? 3�??�상??city�?조회?�세??',
'- HAVING COUNT(*) >= 3',
'[{"input": "", "output": "3�??�상??city"}]',
'-- ?�용?��? 3�??�상??city�?조회?�세??',
'SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) >= 3;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-simple-case', 'sql', 'syntax', 76, 'CASE WHEN 기본', '조건부 �?반환', 'challenge', 2,
'급여 구간???�라 ?�급??부?�하?�요 (5백만 ?�상: A, 3백만 ?�상: B, ?�머지: C).',
'- CASE WHEN ... THEN ... END\n- ?�러 조건 분기',
'[{"input": "", "output": "직원�? 급여, ?�급"}]',
'-- CASE WHEN?�로 급여 ?�급??부?�하?�요\n',
'SELECT emp_name, salary,\n  CASE\n    WHEN salary >= 5000000 THEN \''A\''\n    WHEN salary >= 3000000 THEN \''B\''\n    ELSE \''C\''\n  END AS grade\nFROM employees;


-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-inner-join$$, 'sql', 'basics', 31, $$INNER JOIN$$, $$?��? 조인$$, 'challenge', 1,
$$users?� orders�?user_id�?조인?�여 조회?�세??$$,
'- INNER JOIN ... ON',
'[{"input": "", "output": "조인??결과"}]',
$$-- users?� orders�?user_id�?조인?�세??$$,
'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-string-manipulation$$, 'sql', 'syntax', 81, $$문자??가�?, $$CONCAT, SUBSTRING ??, 'challenge', 3,
$$?�메??주소?�서 ?�메??부분만 추출?�고, ?�문자�?변?�하?�요.$$,
$$- SUBSTRING, POSITION, UPPER ?�용\n- @ ?�후 문자??추출$$,
$$[{"input": "", "output": "?�메?? ?�메??}]$$,
$$-- ?�메?�에???�메?�을 추출?�고 ?�문자�?변?�하?�요\n$$,
'SELECT email,\n  UPPER(SUBSTRING(email FROM POSITION(\''@\'' IN email) + 1)) AS domain\nFROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-inner-join', 'sql', 'basics', 31, 'INNER JOIN', '?��? 조인', 'challenge', 1,
'users?� orders�?user_id�?조인?�여 조회?�세??',
'- INNER JOIN ... ON',
'[{"input": "", "output": "조인??결과"}]',
'-- users?� orders�?user_id�?조인?�세??',
'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-string-manipulation', 'sql', 'syntax', 81, '문자??가�?, 'CONCAT, SUBSTRING ??, 'challenge', 3,
'?�메??주소?�서 ?�메??부분만 추출?�고, ?�문자�?변?�하?�요.',
'- SUBSTRING, POSITION, UPPER ?�용\n- @ ?�후 문자??추출',
'[{"input": "", "output": "?�메?? ?�메??}]',
'-- ?�메?�에???�메?�을 추출?�고 ?�문자�?변?�하?�요\n',
'SELECT email,\n  UPPER(SUBSTRING(email FROM POSITION(\''@\'' IN email) + 1)) AS domain\nFROM users;


-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-subquery-where$$, 'sql', 'basics', 36, $$WHERE ?�브쿼리$$, $$조건???�브쿼리$$, 'challenge', 1,
$$products?�서 ?�균 가격보??비싼 ?�품??조회?�세??$$,
'- WHERE 컬럼 > (SELECT ...)',
$$[{"input": "", "output": "?�균 ?�상 ?�품"}]$$,
$$-- ?�균 가격보??비싼 ?�품??조회?�세??$$,
'SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-date-calculation$$, 'sql', 'syntax', 86, $$?�짜 계산$$, $$?�짜 ?�산$$, 'challenge', 3,
$$�?주문?�로부??30?????�짜?� ?��? ?�수�?계산?�세??$$,
$$- DATE_ADD, DATEDIFF ?�용\n- CURRENT_DATE?� 비교$$,
$$[{"input": "", "output": "주문?? 만료?? ?��??�수"}]$$,
$$-- 주문?�로부??30???��? ?��? ?�수�?계산?�세??n$$,
'SELECT order_date,\n  order_date + INTERVAL \''30 days\'' AS expiry_date,\n  (order_date + INTERVAL \''30 days\'') - CURRENT_DATE AS days_left\nFROM orders;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-subquery-where', 'sql', 'basics', 36, 'WHERE ?�브쿼리', '조건???�브쿼리', 'challenge', 1,
'products?�서 ?�균 가격보??비싼 ?�품??조회?�세??',
'- WHERE 컬럼 > (SELECT ...)',
'[{"input": "", "output": "?�균 ?�상 ?�품"}]',
'-- ?�균 가격보??비싼 ?�품??조회?�세??',
'SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-date-calculation', 'sql', 'syntax', 86, '?�짜 계산', '?�짜 ?�산', 'challenge', 3,
'�?주문?�로부??30?????�짜?� ?��? ?�수�?계산?�세??',
'- DATE_ADD, DATEDIFF ?�용\n- CURRENT_DATE?� 비교',
'[{"input": "", "output": "주문?? 만료?? ?��??�수"}]',
'-- 주문?�로부??30???��? ?��? ?�수�?계산?�세??n',
'SELECT order_date,\n  order_date + INTERVAL \''30 days\'' AS expiry_date,\n  (order_date + INTERVAL \''30 days\'') - CURRENT_DATE AS days_left\nFROM orders;


-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-insert-basic$$, 'sql', 'basics', 41, $$?�이???�입$$, 'INSERT INTO', 'challenge', 1,
$$users ?�이블에 (name="John", age=25, city="Seoul") ?�이?��? ?�입?�세??$$,
'- INSERT INTO ... VALUES',
'[{"input": "", "output": "1 row inserted"}]',
$$-- users??John, 25, Seoul???�입?�세??$$,
'INSERT INTO users (name, age, city) VALUES (''John'', 25, ''Seoul'');

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-json-extract$$, 'sql', 'syntax', 91, $$JSON ?�이??추출$$, $$JSON ?�드 ?�근$$, 'challenge', 3,
$$JSON 컬럼?�서 ?�정 ?�의 값을 추출?�세??$$,
'- -> ?�는 ->> ?�산???�용\n- JSON 경로 지??,
$$[{"input": "", "output": "ID, ?�름(JSON?�서 추출)"}]$$,
$$-- JSON 컬럼?�서 name ?��? 추출?�세??n$$,
'SELECT id, data->>\''name\'' AS name\nFROM users;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-insert-basic', 'sql', 'basics', 41, '?�이???�입', 'INSERT INTO', 'challenge', 1,
'users ?�이블에 (name="John", age=25, city="Seoul") ?�이?��? ?�입?�세??',
'- INSERT INTO ... VALUES',
'[{"input": "", "output": "1 row inserted"}]',
'-- users??John, 25, Seoul???�입?�세??',
'INSERT INTO users (name, age, city) VALUES (''John'', 25, ''Seoul'');

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-json-extract', 'sql', 'syntax', 91, 'JSON ?�이??추출', 'JSON ?�드 ?�근', 'challenge', 3,
'JSON 컬럼?�서 ?�정 ?�의 값을 추출?�세??',
'- -> ?�는 ->> ?�산???�용\n- JSON 경로 지??,
'[{"input": "", "output": "ID, ?�름(JSON?�서 추출)"}]',
'-- JSON 컬럼?�서 name ?��? 추출?�세??n',
'SELECT id, data->>\''name\'' AS name\nFROM users;


-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-create-table$$, 'sql', 'basics', 46, $$?�이�??�성$$, 'CREATE TABLE', 'challenge', 1,
$$id(INT), name(VARCHAR), age(INT) 컬럼??가�?students ?�이블을 ?�성?�세??$$,
'- CREATE TABLE ... (...)',
'[{"input": "", "output": "table created"}]',
$$-- students ?�이블을 ?�성?�세??$$,
'CREATE TABLE students (id INT, name VARCHAR(100), age INT);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-upsert$$, 'sql', 'syntax', 96, $$UPSERT 구현$$, 'INSERT ON CONFLICT', 'challenge', 3,
$$존재?�면 UPDATE, ?�으�?INSERT?�는 UPSERT�?구현?�세??$$,
$$- INSERT ... ON CONFLICT ?�용\n- DO UPDATE SET$$,
'[{"input": "", "output": "처리????}]',
$$-- UPSERT�?구현?�세??n$$,
'INSERT INTO products (id, name, price)\nVALUES (1, \''Product A\'', 1000)\nON CONFLICT (id)\nDO UPDATE SET\n  name = EXCLUDED.name,\n  price = EXCLUDED.price;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-create-table', 'sql', 'basics', 46, '?�이�??�성', 'CREATE TABLE', 'challenge', 1,
'id(INT), name(VARCHAR), age(INT) 컬럼??가�?students ?�이블을 ?�성?�세??',
'- CREATE TABLE ... (...)',
'[{"input": "", "output": "table created"}]',
'-- students ?�이블을 ?�성?�세??',
'CREATE TABLE students (id INT, name VARCHAR(100), age INT);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-upsert', 'sql', 'syntax', 96, 'UPSERT 구현', 'INSERT ON CONFLICT', 'challenge', 3,
'존재?�면 UPDATE, ?�으�?INSERT?�는 UPSERT�?구현?�세??',
'- INSERT ... ON CONFLICT ?�용\n- DO UPDATE SET',
'[{"input": "", "output": "처리????}]',
'-- UPSERT�?구현?�세??n',
'INSERT INTO products (id, name, price)\nVALUES (1, \''Product A\'', 1000)\nON CONFLICT (id)\nDO UPDATE SET\n  name = EXCLUDED.name,\n  price = EXCLUDED.price;


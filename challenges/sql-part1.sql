-- ============================================================================
-- SQL Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

-- Unit 1: SELECT 기초 (SELECT Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-select-all', 'sql', 'syntax', 1, '모든 ?�이??조회', 'SELECT * ?�용?�기', 'challenge', 1,
'users ?�이블의 모든 ?�이?��? 조회?�세??',
'- SELECT * FROM ?�이블명',
'[{"input": "", "output": "모든 ?�과 ??}]',
'-- users ?�이블에??모든 ?�이?��? 조회?�세??',
'SELECT * FROM users;',
'[{"input": "", "expected": "all rows"}]',
'["*??모든 컬럼???��??�니??]',
ARRAY['select', 'basics'], 5),

('sql-select-columns', 'sql', 'syntax', 2, '?�정 컬럼 조회', '컬럼 지?�하??조회', 'challenge', 1,
'users ?�이블에??name�?email 컬럼�?조회?�세??',
'- SELECT 컬럼1, 컬럼2 FROM',
'[{"input": "", "output": "name, email 컬럼"}]',
'-- users ?�이블에??name�?email??조회?�세??',
'SELECT name, email FROM users;',
'[{"input": "", "expected": "name, email columns"}]',
'["컬럼명을 ?�표�?구분?�니??]',
ARRAY['select', 'columns'], 5),

('sql-select-distinct', 'sql', 'syntax', 3, '중복 ?�거', 'DISTINCT ?�용?�기', 'challenge', 1,
'users ?�이블에??중복???�거??city�?조회?�세??',
'- SELECT DISTINCT',
'[{"input": "", "output": "고유??city 값들"}]',
'-- users ?�이블에??중복 ?�는 city�?조회?�세??',
'SELECT DISTINCT city FROM users;',
'[{"input": "", "expected": "unique cities"}]',
'["DISTINCT??중복???�거?�니??]',
ARRAY['select', 'distinct'], 5),

('sql-select-limit', 'sql', 'syntax', 4, '결과 개수 ?�한', 'LIMIT ?�용?�기', 'challenge', 1,
'users ?�이블에???�위 5�??�만 조회?�세??',
'- LIMIT ?�자',
'[{"input": "", "output": "?�위 5�???}]',
'-- users ?�이블에???�위 5개만 조회?�세??',
'SELECT * FROM users LIMIT 5;',
'[{"input": "", "expected": "5 rows"}]',
'["LIMIT?�로 ??개수�??�한?�니??]',
ARRAY['select', 'limit'], 5),

('sql-select-alias', 'sql', 'syntax', 5, '별칭 ?�용', 'AS�?별칭 지??, 'challenge', 1,
'users ?�이블에??name??"?�용?�명"?�라??별칭?�로 조회?�세??',
'- AS 별칭',
'[{"input": "", "output": "name AS ?�용?�명"}]',
'-- name 컬럼??"?�용?�명"?�라??별칭?�로 조회?�세??',
'SELECT name AS ?�용?�명 FROM users;',
'[{"input": "", "expected": "name with alias"}]',
'["AS�?별칭??지?�합?�다"]',
ARRAY['select', 'alias'], 5);

-- Unit 2: WHERE 조건 (WHERE Clause) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-where-equal', 'sql', 'basics', 6, '같음 조건', '= ?�산???�용', 'challenge', 1,
'users ?�이블에??city가 "Seoul"???�용?��? 조회?�세??',
'- WHERE 컬럼 = �?,
'[{"input": "", "output": "city가 Seoul???�들"}]',
'-- city가 "Seoul"???�용?��? 조회?�세??',
'SELECT * FROM users WHERE city = ''Seoul'';',
'[{"input": "", "expected": "Seoul users"}]',
'["WHERE ?�로 조건??지?�합?�다"]',
ARRAY['where', 'equality'], 5),

('sql-where-greater', 'sql', 'basics', 7, '?�기 비교', '>, < ?�산??, 'challenge', 1,
'products ?�이블에??price가 10000 ?�상???�품??조회?�세??',
'- WHERE 컬럼 >= �?,
'[{"input": "", "output": "price >= 10000???�품"}]',
'-- price가 10000 ?�상???�품??조회?�세??',
'SELECT * FROM products WHERE price >= 10000;',
'[{"input": "", "expected": "products with price >= 10000"}]',
'[">=???�상, >??초과�??��??�니??]',
ARRAY['where', 'comparison'], 5),

('sql-where-and', 'sql', 'basics', 8, 'AND 조건', '?�러 조건 ?�시 만족', 'challenge', 1,
'users ?�이블에??city가 "Seoul"?�고 age가 20 ?�상???�용?��? 조회?�세??',
'- WHERE 조건1 AND 조건2',
'[{"input": "", "output": "Seoul?�고 age >= 20"}]',
'-- city가 Seoul?�고 age가 20 ?�상???�용?��? 조회?�세??',
'SELECT * FROM users WHERE city = ''Seoul'' AND age >= 20;',
'[{"input": "", "expected": "Seoul users aged 20+"}]',
'["AND??모든 조건??만족?�야 ?�니??]',
ARRAY['where', 'and'], 5),

('sql-where-or', 'sql', 'basics', 9, 'OR 조건', '조건 �??�나 만족', 'challenge', 1,
'users ?�이블에??city가 "Seoul" ?�는 "Busan"???�용?��? 조회?�세??',
'- WHERE 조건1 OR 조건2',
'[{"input": "", "output": "Seoul ?�는 Busan"}]',
'-- city가 Seoul ?�는 Busan???�용?��? 조회?�세??',
'SELECT * FROM users WHERE city = ''Seoul'' OR city = ''Busan'';',
'[{"input": "", "expected": "Seoul or Busan users"}]',
'["OR???�나?�도 만족?�면 ?�니??]',
ARRAY['where', 'or'], 5),

('sql-where-in', 'sql', 'basics', 10, 'IN 조건', '?�러 �?�??�나', 'challenge', 1,
'users ?�이블에??city가 "Seoul", "Busan", "Incheon" �??�나???�용?��? 조회?�세??',
'- WHERE 컬럼 IN (�?, �?, ...)',
'[{"input": "", "output": "3�??�시 �??�나"}]',
'-- city가 Seoul, Busan, Incheon �??�나???�용?��? 조회?�세??',
'SELECT * FROM users WHERE city IN (''Seoul'', ''Busan'', ''Incheon'');',
'[{"input": "", "expected": "users from 3 cities"}]',
'["IN?� ?�러 OR 조건??간결?�게 ?�현?�니??]',
ARRAY['where', 'in'], 5);

-- Unit 3: ORDER BY ?�렬 (Sorting) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-order-asc', 'sql', 'basics', 11, '?�름차순 ?�렬', 'ASC�??�렬', 'challenge', 1,
'users ?�이블을 name 기�? ?�름차순?�로 조회?�세??',
'- ORDER BY 컬럼 ASC',
'[{"input": "", "output": "name ?�름차순"}]',
'-- name 기�? ?�름차순?�로 조회?�세??',
'SELECT * FROM users ORDER BY name ASC;',
'[{"input": "", "expected": "ascending by name"}]',
'["ASC???�름차순(기본�??�니??]',
ARRAY['order-by', 'asc'], 5),

('sql-order-desc', 'sql', 'basics', 12, '?�림차순 ?�렬', 'DESC�??�렬', 'challenge', 1,
'products ?�이블을 price 기�? ?�림차순?�로 조회?�세??',
'- ORDER BY 컬럼 DESC',
'[{"input": "", "output": "price ?�림차순"}]',
'-- price 기�? ?�림차순?�로 조회?�세??',
'SELECT * FROM products ORDER BY price DESC;',
'[{"input": "", "expected": "descending by price"}]',
'["DESC???�림차순?�니??]',
ARRAY['order-by', 'desc'], 5),

('sql-order-multiple', 'sql', 'basics', 13, '?�중 ?�렬', '?�러 컬럼?�로 ?�렬', 'challenge', 1,
'users ?�이블을 city ?�름차순, age ?�림차순?�로 조회?�세??',
'- ORDER BY 컬럼1, 컬럼2 DESC',
'[{"input": "", "output": "city ASC, age DESC"}]',
'-- city ?�름차순, age ?�림차순?�로 조회?�세??',
'SELECT * FROM users ORDER BY city ASC, age DESC;',
'[{"input": "", "expected": "sorted by city then age"}]',
'["�?번째 컬럼?�로 먼�? ?�렬, 같으�???번째 컬럼?�로 ?�렬"]',
ARRAY['order-by', 'multiple'], 5),

('sql-order-limit', 'sql', 'basics', 14, '?�렬 ???�한', 'ORDER BY?� LIMIT 조합', 'challenge', 1,
'products ?�이블에??price가 가??비싼 ?�위 3개�? 조회?�세??',
'- ORDER BY ... DESC LIMIT',
'[{"input": "", "output": "가??비싼 3�?}]',
'-- 가??비싼 ?�위 3�??�품??조회?�세??',
'SELECT * FROM products ORDER BY price DESC LIMIT 3;',
'[{"input": "", "expected": "top 3 expensive products"}]',
'["?�림차순 ?�렬 ??LIMIT ?�용"]',
ARRAY['order-by', 'limit'], 5),

('sql-order-null', 'sql', 'basics', 15, 'NULL ?�렬', 'NULL �?처리', 'challenge', 1,
'users ?�이블을 email ?�름차순?�로 조회?�세??NULL ?�함).',
'- NULL?� ?�렬 ???�별 처리',
'[{"input": "", "output": "email ?�렬"}]',
'-- email 기�? ?�름차순?�로 조회?�세??',
'SELECT * FROM users ORDER BY email ASC;',
'[{"input": "", "expected": "sorted by email"}]',
'["NULL?� ?�름차순?�서 먼�? ?��??�니??]',
ARRAY['order-by', 'null'], 5);

-- Unit 4: 집계 ?�수 (Aggregate Functions) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-count', 'sql', 'basics', 16, '??개수 ?�기', 'COUNT ?�수', 'challenge', 1,
'users ?�이블의 ?�체 ??개수�?조회?�세??',
'- COUNT(*) ?�는 COUNT(컬럼)',
'[{"input": "", "output": "??개수"}]',
'-- users ?�이블의 ??개수�?조회?�세??',
'SELECT COUNT(*) FROM users;',
'[{"input": "", "expected": "total count"}]',
'["COUNT(*)??모든 ?�을 ?�니??]',
ARRAY['aggregate', 'count'], 5),

('sql-sum', 'sql', 'basics', 17, '?�계 구하�?, 'SUM ?�수', 'challenge', 1,
'orders ?�이블의 amount ?�계�?구하?�요.',
'- SUM(컬럼)',
'[{"input": "", "output": "amount ?�계"}]',
'-- amount???�계�?구하?�요
',
'SELECT SUM(amount) FROM orders;',
'[{"input": "", "expected": "total amount"}]',
'["SUM?� ?�자 컬럼???�계�?구합?�다"]',
ARRAY['aggregate', 'sum'], 5),

('sql-avg', 'sql', 'basics', 18, '?�균 구하�?, 'AVG ?�수', 'challenge', 1,
'products ?�이블의 price ?�균??구하?�요.',
'- AVG(컬럼)',
'[{"input": "", "output": "price ?�균"}]',
'-- price???�균??구하?�요
',
'SELECT AVG(price) FROM products;',
'[{"input": "", "expected": "average price"}]',
'["AVG???�균값을 구합?�다"]',
ARRAY['aggregate', 'avg'], 5),

('sql-max-min', 'sql', 'basics', 19, '최댓값과 최솟�?, 'MAX, MIN ?�수', 'challenge', 1,
'products ?�이블의 price 최댓값과 최솟값을 조회?�세??',
'- MAX(컬럼), MIN(컬럼)',
'[{"input": "", "output": "최댓�? 최솟�?}]',
'-- price??최댓값과 최솟값을 조회?�세??',
'SELECT MAX(price), MIN(price) FROM products;',
'[{"input": "", "expected": "max and min price"}]',
'["MAX??최댓�? MIN?� 최솟�?]',
ARRAY['aggregate', 'max', 'min'], 5),

('sql-count-distinct', 'sql', 'basics', 20, '고유 �?개수', 'COUNT(DISTINCT)', 'challenge', 1,
'users ?�이블의 고유??city 개수�??�세??',
'- COUNT(DISTINCT 컬럼)',
'[{"input": "", "output": "고유 city 개수"}]',
'-- 고유??city??개수�??�세??',
'SELECT COUNT(DISTINCT city) FROM users;',
'[{"input": "", "expected": "unique city count"}]',
'["COUNT(DISTINCT)??중복 ?�거 ??개수�??�니??]',
ARRAY['aggregate', 'count', 'distinct'], 5);

-- Unit 5: GROUP BY (Grouping) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-group-count', 'sql', 'basics', 21, '그룹�?개수', 'GROUP BY�?그룹??, 'challenge', 1,
'users ?�이블에??city�??�용???��? 조회?�세??',
'- GROUP BY 컬럼',
'[{"input": "", "output": "city�?count"}]',
'-- city�??�용???��? 조회?�세??',
'SELECT city, COUNT(*) FROM users GROUP BY city;',
'[{"input": "", "expected": "count by city"}]',
'["GROUP BY�?그룹???�누�?집계?�니??]',
ARRAY['group-by', 'count'], 5),

('sql-group-sum', 'sql', 'basics', 22, '그룹�??�계', 'GROUP BY?� SUM', 'challenge', 1,
'orders ?�이블에??user_id�?amount ?�계�?조회?�세??',
'- GROUP BY user_id',
'[{"input": "", "output": "user_id�?sum"}]',
'-- user_id�?amount ?�계�?조회?�세??',
'SELECT user_id, SUM(amount) FROM orders GROUP BY user_id;',
'[{"input": "", "expected": "sum by user"}]',
'["�?그룹별로 SUM??계산?�니??]',
ARRAY['group-by', 'sum'], 5),

('sql-group-avg', 'sql', 'basics', 23, '그룹�??�균', 'GROUP BY?� AVG', 'challenge', 1,
'products ?�이블에??category�?price ?�균??조회?�세??',
'- GROUP BY category',
'[{"input": "", "output": "category�?avg"}]',
'-- category�?price ?�균??조회?�세??',
'SELECT category, AVG(price) FROM products GROUP BY category;',
'[{"input": "", "expected": "average by category"}]',
'["그룹별로 ?�균??구합?�다"]',
ARRAY['group-by', 'avg'], 5),

('sql-group-multiple', 'sql', 'basics', 24, '?�중 그룹??, '?�러 컬럼?�로 그룹??, 'challenge', 1,
'orders ?�이블에??user_id, status�?개수�?조회?�세??',
'- GROUP BY 컬럼1, 컬럼2',
'[{"input": "", "output": "user_id, status�?count"}]',
'-- user_id, status�?개수�?조회?�세??',
'SELECT user_id, status, COUNT(*) FROM orders GROUP BY user_id, status;',
'[{"input": "", "expected": "count by user and status"}]',
'["?�러 컬럼?�로 그룹???�눌 ???�습?�다"]',
ARRAY['group-by', 'multiple'], 5),

('sql-group-order', 'sql', 'basics', 25, '그룹 ?�렬', 'GROUP BY?� ORDER BY', 'challenge', 1,
'users ?�이블에??city�??�용???��? 많�? ?�으�?조회?�세??',
'- GROUP BY ... ORDER BY COUNT(*) DESC',
'[{"input": "", "output": "count ?�림차순"}]',
'-- city�??�용???��? 많�? ?�으�?조회?�세??',
'SELECT city, COUNT(*) AS cnt FROM users GROUP BY city ORDER BY cnt DESC;',
'[{"input": "", "expected": "cities by user count desc"}]',
'["집계 결과�??�렬?????�습?�다"]',
ARRAY['group-by', 'order-by'], 5);

-- Unit 6: HAVING 조건 (HAVING Clause) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-having-count', 'sql', 'basics', 26, 'HAVING?�로 ?�터', '그룹 조건', 'challenge', 1,
'users ?�이블에???�용?��? 3�??�상??city�?조회?�세??',
'- HAVING COUNT(*) >= 3',
'[{"input": "", "output": "3�??�상??city"}]',
'-- ?�용?��? 3�??�상??city�?조회?�세??',
'SELECT city, COUNT(*) FROM users GROUP BY city HAVING COUNT(*) >= 3;',
'[{"input": "", "expected": "cities with 3+ users"}]',
'["HAVING?� 그룹????조건???�용?�니??]',
ARRAY['having', 'count'], 5),

('sql-having-sum', 'sql', 'basics', 27, 'HAVING�?SUM', '?�계 조건', 'challenge', 1,
'orders ?�이블에??�?주문?�이 100000 ?�상??user_id�?조회?�세??',
'- HAVING SUM(...) >= 100000',
'[{"input": "", "output": "sum >= 100000"}]',
'-- �?주문?�이 100000 ?�상???�용?��? 조회?�세??',
'SELECT user_id, SUM(amount) FROM orders GROUP BY user_id HAVING SUM(amount) >= 100000;',
'[{"input": "", "expected": "users with high total"}]',
'["집계 ?�수 결과??조건???�용?�니??]',
ARRAY['having', 'sum'], 5),

('sql-having-avg', 'sql', 'basics', 28, 'HAVING�?AVG', '?�균 조건', 'challenge', 1,
'products ?�이블에???�균 가격이 50000 ?�상??category�?조회?�세??',
'- HAVING AVG(...) >= 50000',
'[{"input": "", "output": "avg >= 50000"}]',
'-- ?�균 가격이 50000 ?�상??category�?조회?�세??',
'SELECT category, AVG(price) FROM products GROUP BY category HAVING AVG(price) >= 50000;',
'[{"input": "", "expected": "categories with high avg"}]',
'["?�균값으�?그룹???�터링합?�다"]',
ARRAY['having', 'avg'], 5),

('sql-where-having', 'sql', 'basics', 29, 'WHERE?� HAVING', '조건 조합', 'challenge', 1,
'users ?�이블에??age가 20 ?�상???�용??�?city별로 2�??�상??곳을 조회?�세??',
'- WHERE ... GROUP BY ... HAVING',
'[{"input": "", "output": "?�터 ??그룹??}]',
'-- age >= 20???�용??�?city�?2�??�상??곳을 조회?�세??',
'SELECT city, COUNT(*) FROM users WHERE age >= 20 GROUP BY city HAVING COUNT(*) >= 2;',
'[{"input": "", "expected": "filtered and grouped"}]',
'["WHERE??그룹???? HAVING?� 그룹????조건"]',
ARRAY['where', 'having'], 5),

('sql-having-multiple', 'sql', 'basics', 30, '복합 HAVING', '?�러 HAVING 조건', 'challenge', 1,
'orders ?�이블에??주문 건수가 5�??�상?�고 총액??500000 ?�상??user_id�?조회?�세??',
'- HAVING 조건1 AND 조건2',
'[{"input": "", "output": "복합 조건"}]',
'-- 주문 5�??�상?�고 총액 500000 ?�상???�용?��? 조회?�세??',
'SELECT user_id, COUNT(*), SUM(amount) FROM orders GROUP BY user_id HAVING COUNT(*) >= 5 AND SUM(amount) >= 500000;',
'[{"input": "", "expected": "users with multiple conditions"}]',
'["HAVING ?�에 AND�??�러 조건??결합?�니??]',
ARRAY['having', 'multiple'], 5);

-- Unit 7: JOIN - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-inner-join', 'sql', 'basics', 31, 'INNER JOIN', '?��? 조인', 'challenge', 1,
'users?� orders�?user_id�?조인?�여 조회?�세??',
'- INNER JOIN ... ON',
'[{"input": "", "output": "조인??결과"}]',
'-- users?� orders�?user_id�?조인?�세??',
'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id;',
'[{"input": "", "expected": "joined table"}]',
'["INNER JOIN?� ?�쪽??모두 ?�는 ?�이?�만 조회"]',
ARRAY['join', 'inner-join'], 5),

('sql-left-join', 'sql', 'basics', 32, 'LEFT JOIN', '?�쪽 조인', 'challenge', 1,
'users?� orders�?LEFT JOIN?�여 주문???�는 ?�용?�도 ?�함?�여 조회?�세??',
'- LEFT JOIN ... ON',
'[{"input": "", "output": "모든 users ?�함"}]',
'-- users?� orders�?LEFT JOIN?�세??',
'SELECT * FROM users LEFT JOIN orders ON users.id = orders.user_id;',
'[{"input": "", "expected": "all users with orders"}]',
'["LEFT JOIN?� ?�쪽 ?�이블의 모든 ?�을 ?�함"]',
ARRAY['join', 'left-join'], 5),

('sql-join-select', 'sql', 'basics', 33, 'JOIN 컬럼 ?�택', '?�정 컬럼�?조회', 'challenge', 1,
'users?� orders�?조인?�여 name�?amount�?조회?�세??',
'- SELECT ?�이�?컬럼',
'[{"input": "", "output": "name, amount"}]',
'-- users??name�?orders??amount�?조회?�세??',
'SELECT users.name, orders.amount FROM users INNER JOIN orders ON users.id = orders.user_id;',
'[{"input": "", "expected": "name and amount"}]',
'["?�이블명.컬럼명으�?구분?�니??]',
ARRAY['join', 'select'], 5),

('sql-join-where', 'sql', 'basics', 34, 'JOIN�?WHERE', '조인 ???�터', 'challenge', 1,
'users?� orders�?조인?�여 amount가 10000 ?�상??주문�?조회?�세??',
'- JOIN ... WHERE',
'[{"input": "", "output": "amount >= 10000"}]',
'-- 조인 ??amount >= 10000??주문??조회?�세??',
'SELECT * FROM users INNER JOIN orders ON users.id = orders.user_id WHERE orders.amount >= 10000;',
'[{"input": "", "expected": "high amount orders"}]',
'["JOIN ??WHERE�?조건??추�??�니??]',
ARRAY['join', 'where'], 5),

('sql-join-group', 'sql', 'basics', 35, 'JOIN�?GROUP BY', '조인 ??그룹??, 'challenge', 1,
'users?� orders�?조인?�여 ?�용?�별 주문 총액??조회?�세??',
'- JOIN ... GROUP BY',
'[{"input": "", "output": "user�?총액"}]',
'-- ?�용?�별 주문 총액??조회?�세??',
'SELECT users.name, SUM(orders.amount) FROM users INNER JOIN orders ON users.id = orders.user_id GROUP BY users.name;',
'[{"input": "", "expected": "total by user"}]',
'["JOIN ??GROUP BY�?집계?�니??]',
ARRAY['join', 'group-by'], 5);

-- Unit 8: ?�브쿼리 (Subqueries) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-subquery-where', 'sql', 'basics', 36, 'WHERE ?�브쿼리', '조건???�브쿼리', 'challenge', 1,
'products?�서 ?�균 가격보??비싼 ?�품??조회?�세??',
'- WHERE 컬럼 > (SELECT ...)',
'[{"input": "", "output": "?�균 ?�상 ?�품"}]',
'-- ?�균 가격보??비싼 ?�품??조회?�세??',
'SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);',
'[{"input": "", "expected": "above average products"}]',
'["?�브쿼리�??�적??조건??만듭?�다"]',
ARRAY['subquery', 'where'], 5),

('sql-subquery-in', 'sql', 'basics', 37, 'IN ?�브쿼리', 'IN?�에 ?�브쿼리', 'challenge', 1,
'주문???�는 ?�용?�만 users?�서 조회?�세??',
'- WHERE id IN (SELECT ...)',
'[{"input": "", "output": "주문 ?�는 ?�용??}]',
'-- 주문???�는 ?�용?�만 조회?�세??',
'SELECT * FROM users WHERE id IN (SELECT user_id FROM orders);',
'[{"input": "", "expected": "users with orders"}]',
'["?�브쿼리 결과�?IN?�로 ?�터�?]',
ARRAY['subquery', 'in'], 5),

('sql-subquery-exists', 'sql', 'basics', 38, 'EXISTS ?�브쿼리', '존재 ?��? ?�인', 'challenge', 1,
'주문???�는 ?�용?��? EXISTS�?조회?�세??',
'- WHERE EXISTS (SELECT ...)',
'[{"input": "", "output": "주문 ?�는 ?�용??}]',
'-- EXISTS�??�용?�여 주문???�는 ?�용?��? 조회?�세??',
'SELECT * FROM users WHERE EXISTS (SELECT 1 FROM orders WHERE orders.user_id = users.id);',
'[{"input": "", "expected": "users with orders"}]',
'["EXISTS??존재 ?��?�??�인?�니??]',
ARRAY['subquery', 'exists'], 5),

('sql-subquery-from', 'sql', 'basics', 39, 'FROM ?�브쿼리', '?�브쿼리�??�이블로', 'challenge', 1,
'�?city�??�균 age�?구한 결과?�서 ?�균??30 ?�상??city�?조회?�세??',
'- FROM (SELECT ...) AS alias',
'[{"input": "", "output": "avg >= 30??city"}]',
'-- city�??�균 age가 30 ?�상??곳을 조회?�세??',
'SELECT * FROM (SELECT city, AVG(age) AS avg_age FROM users GROUP BY city) AS t WHERE avg_age >= 30;',
'[{"input": "", "expected": "cities with avg age 30+"}]',
'["?�브쿼리�??�시 ?�이블처???�용?�니??]',
ARRAY['subquery', 'from'], 5),

('sql-subquery-select', 'sql', 'basics', 40, 'SELECT ?�브쿼리', '컬럼???�브쿼리', 'challenge', 1,
'users?� ?�께 �??�용?�의 주문 개수�?조회?�세??',
'- SELECT (SELECT ...) AS',
'[{"input": "", "output": "user?� 주문 개수"}]',
'-- �??�용?��? 주문 개수�?조회?�세??',
'SELECT name, (SELECT COUNT(*) FROM orders WHERE orders.user_id = users.id) AS order_count FROM users;',
'[{"input": "", "expected": "users with order count"}]',
'["SELECT ?�에 ?�브쿼리�??�용?�니??]',
ARRAY['subquery', 'select'], 5);

-- Unit 9: INSERT, UPDATE, DELETE - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-insert-basic', 'sql', 'basics', 41, '?�이???�입', 'INSERT INTO', 'challenge', 1,
'users ?�이블에 (name="John", age=25, city="Seoul") ?�이?��? ?�입?�세??',
'- INSERT INTO ... VALUES',
'[{"input": "", "output": "1 row inserted"}]',
'-- users??John, 25, Seoul???�입?�세??',
'INSERT INTO users (name, age, city) VALUES (''John'', 25, ''Seoul'');',
'[{"input": "", "expected": "inserted"}]',
'["VALUES�?값을 지?�합?�다"]',
ARRAY['insert', 'basics'], 5),

('sql-insert-multiple', 'sql', 'basics', 42, '?�러 ???�입', '??번에 ?�러 ?�이??, 'challenge', 1,
'users??2명의 ?�이?��? ??번에 ?�입?�세??',
'- VALUES (...), (...)',
'[{"input": "", "output": "2 rows inserted"}]',
'-- 2명의 ?�이?��? ??번에 ?�입?�세??',
'INSERT INTO users (name, age, city) VALUES (''Alice'', 30, ''Busan''), (''Bob'', 22, ''Incheon'');',
'[{"input": "", "expected": "2 inserted"}]',
'["VALUES�??�표�?구분?�니??]',
ARRAY['insert', 'multiple'], 5),

('sql-update-basic', 'sql', 'basics', 43, '?�이???�정', 'UPDATE SET', 'challenge', 1,
'users?�서 id=1???�용?�의 age�?30?�로 ?�정?�세??',
'- UPDATE ... SET ... WHERE',
'[{"input": "", "output": "1 row updated"}]',
'-- id=1???�용?�의 age�?30?�로 ?�정?�세??',
'UPDATE users SET age = 30 WHERE id = 1;',
'[{"input": "", "expected": "updated"}]',
'["WHERE ?�이 UPDATE?�면 모든 ?�이 ?�정?�니??"]',
ARRAY['update', 'basics'], 5),

('sql-update-multiple', 'sql', 'basics', 44, '?�러 컬럼 ?�정', 'SET ?�러 컬럼', 'challenge', 1,
'users?�서 id=2???�용?�의 name="Jane", city="Seoul"�??�정?�세??',
'- SET 컬럼1=�?, 컬럼2=�?',
'[{"input": "", "output": "1 row updated"}]',
'-- id=2???�용?�의 name�?city�??�정?�세??',
'UPDATE users SET name = ''Jane'', city = ''Seoul'' WHERE id = 2;',
'[{"input": "", "expected": "updated"}]',
'["SET ?�에 ?�표�??�러 컬럼??지?�합?�다"]',
ARRAY['update', 'multiple'], 5),

('sql-delete-basic', 'sql', 'basics', 45, '?�이????��', 'DELETE FROM', 'challenge', 1,
'users?�서 age가 20 미만???�용?��? ??��?�세??',
'- DELETE FROM ... WHERE',
'[{"input": "", "output": "rows deleted"}]',
'-- age < 20???�용?��? ??��?�세??',
'DELETE FROM users WHERE age < 20;',
'[{"input": "", "expected": "deleted"}]',
'["WHERE ?�이 DELETE?�면 모든 ?�이 ??��?�니??"]',
ARRAY['delete', 'basics'], 5);

-- Unit 10: ?�이�?관�?(Table Management) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('sql-create-table', 'sql', 'basics', 46, '?�이�??�성', 'CREATE TABLE', 'challenge', 1,
'id(INT), name(VARCHAR), age(INT) 컬럼??가�?students ?�이블을 ?�성?�세??',
'- CREATE TABLE ... (...)',
'[{"input": "", "output": "table created"}]',
'-- students ?�이블을 ?�성?�세??',
'CREATE TABLE students (id INT, name VARCHAR(100), age INT);',
'[{"input": "", "expected": "created"}]',
'["�?컬럼???�?�을 지?�합?�다"]',
ARRAY['ddl', 'create'], 5),

('sql-create-primary-key', 'sql', 'basics', 47, 'PRIMARY KEY', '기본???�정', 'challenge', 1,
'id�?PRIMARY KEY�??�는 products ?�이블을 ?�성?�세??',
'- PRIMARY KEY',
'[{"input": "", "output": "table with PK"}]',
'-- id�?PRIMARY KEY�??�는 products�??�성?�세??',
'CREATE TABLE products (id INT PRIMARY KEY, name VARCHAR(100), price INT);',
'[{"input": "", "expected": "created with PK"}]',
'["PRIMARY KEY??고유?�고 NULL???�닙?�다"]',
ARRAY['ddl', 'primary-key'], 5),

('sql-alter-add-column', 'sql', 'basics', 48, '컬럼 추�?', 'ALTER TABLE ADD', 'challenge', 1,
'users ?�이블에 email(VARCHAR) 컬럼??추�??�세??',
'- ALTER TABLE ... ADD',
'[{"input": "", "output": "column added"}]',
'-- users??email 컬럼??추�??�세??',
'ALTER TABLE users ADD email VARCHAR(100);',
'[{"input": "", "expected": "column added"}]',
'["ALTER TABLE�??�이�?구조�?변경합?�다"]',
ARRAY['ddl', 'alter', 'add'], 5),

('sql-drop-table', 'sql', 'basics', 49, '?�이�???��', 'DROP TABLE', 'challenge', 1,
'temp ?�이블을 ??��?�세??',
'- DROP TABLE',
'[{"input": "", "output": "table dropped"}]',
'-- temp ?�이블을 ??��?�세??',
'DROP TABLE temp;',
'[{"input": "", "expected": "dropped"}]',
'["DROP TABLE?� ?�이블을 ?�전????��?�니??]',
ARRAY['ddl', 'drop'], 5),

('sql-truncate', 'sql', 'basics', 50, '?�이�?비우�?, 'TRUNCATE TABLE', 'challenge', 1,
'logs ?�이블의 모든 ?�이?��? ??��?�세??구조???��?).',
'- TRUNCATE TABLE',
'[{"input": "", "output": "table truncated"}]',
'-- logs ?�이블을 비우?�요
',
'TRUNCATE TABLE logs;',
'[{"input": "", "expected": "truncated"}]',
'["TRUNCATE??DELETE보다 빠르지�?롤백 불�?"]',
ARRAY['ddl', 'truncate'], 5);

-- ============================================================================
-- End of SQL Language Part 1
-- ============================================================================


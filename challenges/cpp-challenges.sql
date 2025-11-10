-- ============================================================================
-- CPP Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-hello-world$$, $$cpp$$, $$syntax$$, 1, $$Hello World$$, $$C++로 첫 프로그램 작성하기$$, $$challenge$$, 1,
$$화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.$$,
$$- cout을 사용하세요\n- endl 또는 \n으로 줄바꿈$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pattern-triangle$$, $$cpp$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-hello-world', 'cpp', 'syntax', 1, 'Hello World', 'C++�?�??�로그램 ?�성?�기', 'challenge', 1,
'?�면??"Hello, World!"�?출력?�는 ?�로그램???�성?�세??',
'- cout???�용?�세??n- endl ?�는 \n?�로 줄바�?,
'[{"input": "", "output": "Hello, World!"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-pattern-triangle', 'cpp', 'syntax', 51, '?�각???�턴', '별표�??�각??그리�?, 'challenge', 2,
'?�수 N??주어�??? N줄의 ?�각???�턼??출력?�세??\n?? N=3????n*\n**\n***',
'- 중첩 반복�??�용\n- 1 ??N ??10',
'[{"input": "3", "output": "*\n**\n***"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-int-variable$$, $$cpp$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언과 출력$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 100을 저장한 후 출력하세요.$$,
$$- int 타입 사용$$,
$$[{"input": "", "output": "100"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bit-operations$$, $$cpp$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-int-variable', 'cpp', 'syntax', 6, '?�수 변??, '?�수??변???�언�?출력', 'challenge', 1,
'?�수??변??num???�언?�고 100???�?�한 ??출력?�세??',
'- int ?�???�용',
'[{"input": "", "output": "100"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-bit-operations', 'cpp', 'basics', 56, '비트 ?�산', '비트 ?�산?�로 �?조작?�기', 'challenge', 2,
'???�수 a, b가 주어�??? AND, OR, XOR ?�산 결과�?출력?�세??',
'- &, |, ^ ?�산???�용\n- �?줄에 ?�나??출력',
'[{"input": "12 10", "output": "8\n14\n6"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-arithmetic$$, $$cpp$$, $$basics$$, 11, $$사칙연산$$, $$기본 산술 연산하기$$, $$challenge$$, 1,
$$두 정수 a=20, b=3의 덧셈, 뺄셈, 곱셈, 나눗셈 결과를 각 줄에 출력하세요.$$,
$$- +, -, *, / 연산자 사용$$,
$$[{"input": "", "output": "23\n17\n60\n6"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-compound-interest$$, $$cpp$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-arithmetic', 'cpp', 'basics', 11, '?�칙?�산', '기본 ?�술 ?�산?�기', 'challenge', 1,
'???�수 a=20, b=3???�셈, 뺄셈, 곱셈, ?�눗??결과�?�?줄에 출력?�세??',
'- +, -, *, / ?�산???�용',
'[{"input": "", "output": "23\n17\n60\n6"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-compound-interest', 'cpp', 'basics', 61, '복리 계산', '복리 ?�자 계산?�기', 'challenge', 2,
'?�금 P, ?�율 r(%), 기간 n(????주어�??? 복리 ?�리금을 계산?�세??\n공식: P * (1 + r/100)^n',
'- pow ?�수 ?�용\n- #include <math.h>\n- ?�수??2?�리',
'[{"input": "1000 5 3", "output": "1157.63"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-if-positive$$, $$cpp$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인$$, $$challenge$$, 1,
$$정수 num을 입력받아 양수이면 "Positive"를 출력하세요.$$,
$$- if 문 사용$$,
$$[{"input": "10", "output": "Positive"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-leap-year$$, $$cpp$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-if-positive', 'cpp', 'basics', 16, '?�수 ?�별', '?�자가 ?�수?��? ?�인', 'challenge', 1,
'?�수 num???�력받아 ?�수?�면 "Positive"�?출력?�세??',
'- if �??�용',
'[{"input": "10", "output": "Positive"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-leap-year', 'cpp', 'basics', 66, '?�년 ?�별', '?�년?��? ?�인?�기', 'challenge', 2,
'?�도가 주어�??? ?�년?�면 "Leap", ?�년?�면 "Common"??출력?�세??\n?�년: 4??배수?�면??100??배수가 ?�니거나, 400??배수',
'- 조건???�확??구현',
'[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-for-loop$$, $$cpp$$, $$basics$$, 21, $$for 반복문$$, $$1부터 10까지 출력$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지 출력하세요.$$,
$$- for 문 사용$$,
$$[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fibonacci$$, $$cpp$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-for-loop', 'cpp', 'basics', 21, 'for 반복�?, '1부??10까�? 출력', 'challenge', 1,
'for문을 ?�용?�여 1부??10까�? 출력?�세??',
'- for �??�용',
'[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-fibonacci', 'cpp', 'basics', 71, '?�보?�치 ?�열', 'N번째 ?�보?�치 ??구하�?, 'challenge', 2,
'?�수 N??주어�??? N번째 ?�보?�치 ?��? 출력?�세??\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)',
'- 반복�??�용\n- 1 ??N ??20',
'[{"input": "7", "output": "13"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-function-add$$, $$cpp$$, $$basics$$, 26, $$덧셈 함수$$, $$두 수를 더하는 함수$$, $$challenge$$, 1,
$$두 정수를 더하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b)$$,
$$[{"input": "5 7", "output": "12"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-factorial-function$$, $$cpp$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-function-add', 'cpp', 'basics', 26, '?�셈 ?�수', '???��? ?�하???�수', 'challenge', 1,
'???�수�??�하??add ?�수�??�성?�세??',
'- int add(int a, int b)',
'[{"input": "5 7", "output": "12"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-factorial-function', 'cpp', 'basics', 76, '?�토리얼 ?�수', 'N! 계산 ?�수 만들�?, 'challenge', 2,
'?�수 N???�토리얼??계산?�는 ?�수�??�성?�세??',
'- int factorial(int n)\n- 반복�??�용',
'[{"input": "5", "output": "120"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-array-declare$$, $$cpp$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언과 초기화$$, $$challenge$$, 1,
$$크기 5인 정수 배열을 {1,2,3,4,5}로 초기화하고 모든 요소를 출력하세요.$$,
$$- int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bubble-sort$$, $$cpp$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-array-declare', 'cpp', 'basics', 31, '배열 ?�언', '배열 ?�언�?초기??, 'challenge', 1,
'?�기 5???�수 배열??{1,2,3,4,5}�?초기?�하�?모든 ?�소�?출력?�세??',
'- int arr[5]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-bubble-sort', 'cpp', 'advanced', 81, '버블 ?�렬', '배열???�름차순?�로 ?�렬?�기', 'challenge', 3,
'N개의 ?�수�?버블 ?�렬 ?�고리즘?�로 ?�름차순 ?�렬?�세??',
'- ?�접???�소�?비교?�여 교환\n- 1 ??N ??100',
'[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-vector-declare$$, $$cpp$$, $$basics$$, 36, $$벡터 선언$$, $$vector 사용하기$$, $$challenge$$, 1,
$$정수 벡터를 선언하고 {1,2,3,4,5}로 초기화한 후 출력하세요.$$,
$$- vector<int> 사용$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-arithmetic$$, $$cpp$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-vector-declare', 'cpp', 'basics', 36, '벡터 ?�언', 'vector ?�용?�기', 'challenge', 1,
'?�수 벡터�??�언?�고 {1,2,3,4,5}�?초기?�한 ??출력?�세??',
'- vector<int> ?�용',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <iostream>
#include <vector>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-pointer-arithmetic', 'cpp', 'advanced', 86, '?�인???�술', '?�인?�로 배열 ?�회?�기', 'challenge', 3,
'배열???�인???�술 ?�산만으�??�회?�여 ?�을 구하?�요.',
'- [] ?�용 금�?, *(ptr + i) ?�태 ?�용',
'[{"input": "5\n1 2 3 4 5", "output": "15"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-string-input$$, $$cpp$$, $$basics$$, 41, $$문자열 입력$$, $$문자열 입력받기$$, $$challenge$$, 1,
$$문자열을 입력받아 그대로 출력하세요.$$,
$$- cin 또는 getline 사용$$,
$$[{"input": "Hello", "output": "Hello"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-file-write$$, $$cpp$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-string-input', 'cpp', 'basics', 41, '문자???�력', '문자???�력받기', 'challenge', 1,
'문자?�을 ?�력받아 그�?�?출력?�세??',
'- cin ?�는 getline ?�용',
'[{"input": "Hello", "output": "Hello"}]',
'#include <iostream>
#include <string>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-file-write', 'cpp', 'advanced', 91, '?�일 ?�기', '?�일???�스???�기', 'challenge', 3,
'문자?�을 ?�력받아 "output.txt" ?�일???�세??',
'- fopen, fprintf, fclose ?�용',
'[{"input": "Hello World", "output": "File written"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-class-declare$$, $$cpp$$, $$basics$$, 46, $$클래스 선언$$, $$간단한 클래스 만들기$$, $$challenge$$, 1,
$$정수 멤버 변수 x를 가진 Point 클래스를 정의하고 값을 출력하세요.$$,
$$- class 키워드 사용$$,
$$[{"input": "", "output": "10"}]$$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-string-reverse$$, $$cpp$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-class-declare', 'cpp', 'basics', 46, '?�래???�언', '간단???�래??만들�?, 'challenge', 1,
'?�수 멤버 변??x�?가�?Point ?�래?��? ?�의?�고 값을 출력?�세??',
'- class ?�워???�용',
'[{"input": "", "output": "10"}]',
'#include <iostream>
using namespace std;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-string-reverse', 'cpp', 'advanced', 96, '문자???�집�?, '문자?�을 거꾸�?만들�?, 'challenge', 3,
'문자?�을 ?�력받아 ?�집?�서 출력?�세??',
'- 직접 구현 (strrev ?�용 금�?)',
'[{"input": "hello", "output": "olleh"}]',
'#include <iostream>
using namespace std;


-- ============================================================================
-- PYTHON Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-hello-world$$, $$python$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성하기$$, $$challenge$$, 1,
$$화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("Hello, World!")
$func$,
$$[{"input": "", "expected": "Hello, World!\n"}]$$,
$$["printf 함수의 사용법을 확인하세요", "문자열은 큰따옴표로 감싸야 합니다"]$$,
$$["basics", "output", "printf"]$$, 5),

($$python-print-name$$, $$python$$, $$syntax$$, 2, $$이름 출력하기$$, $$자신의 이름을 출력하세요$$, $$challenge$$, 1,
$$화면에 "My name is [이름]" 형식으로 출력하는 프로그램을 작성하세요.$$,
$$- [이름] 부분에는 원하는 이름을 넣으세요\n- 줄바꿈을 포함해야 합니다$$,
$$[{"input": "", "output": "My name is John"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("My name is John")
$func$,
$$[{"input": "", "expected": "My name is John\n"}]$$,
$$["printf로 문자열을 출력할 수 있습니다"]$$,
$$["basics", "output"]$$, 5),

($$python-multiline-output$$, $$python$$, $$syntax$$, 3, $$여러 줄 출력$$, $$여러 줄을 출력하세요$$, $$challenge$$, 1,
$$다음 세 줄을 출력하는 프로그램을 작성하세요:\nLine 1\nLine 2\nLine 3$$,
$$- 각 줄은 새로운 줄에 출력되어야 합니다$$,
$$[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    print("Line 1")
    print("Line 2")
    print("Line 3")
$func$,
$$[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]$$,
$$["printf를 여러 번 호출하거나 \\n을 사용하세요"]$$,
$$["basics", "output"]$$, 5),

($$python-single-line-comment$$, $$python$$, $$syntax$$, 4, $$한 줄 주석$$, $$주석을 사용하여 코드 설명하기$$, $$challenge$$, 1,
$$Hello를 출력하는 코드를 작성하고, 그 위에 한 줄 주석으로 "이것은 출력 코드입니다"를 추가하세요.$$,
$$- // 를 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "Hello"}]$$,
$func$
    // 여기에 주석과 코드를 작성하세요

$func$,
$func$
    // 이것은 출력 코드입니다
    print("Hello")
$func$,
$$[{"input": "", "expected": "Hello\n"}]$$,
$$["// 뒤의 내용은 실행되지 않습니다"]$$,
$$["basics", "comments"]$$, 5),

($$python-multi-line-comment$$, $$python$$, $$syntax$$, 5, $$여러 줄 주석$$, $$여러 줄 주석 사용하기$$, $$challenge$$, 1,
$$World를 출력하는 코드를 작성하고, 그 위에 여러 줄 주석으로 프로그램 설명을 추가하세요.$$,
$$- /* */ 를 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "World"}]$$,
$func$
    /* 여기에 주석과 코드를 작성하세요 */

$func$,
$func$
    /*
     * 이 프로그램은 World를 출력합니다
     * C 언어 기초 학습용입니다
     */
    print("World")
$func$,
$$[{"input": "", "expected": "World\n"}]$$,
$$["/* */ 사이의 내용은 모두 주석입니다"]$$,
$$["basics", "comments"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pattern-triangle$$, $$python$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-hello-world', 'python', 'syntax', 1, 'Hello World', 'C�?�??�로그램 ?�성?�기', 'challenge', 1,
'?�면??"Hello, World!"�?출력?�는 ?�로그램???�성?�세??',
'- printf ?�수�??�용?�세??n- 줄바�?\n)???�함?�야 ?�니??,
'[{"input": "", "output": "Hello, World!"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    print("Hello, World!")
',
'[{"input": "", "expected": "Hello, World!\n"}]',
'["printf ?�수???�용법을 ?�인?�세??, "문자?��? ?�따?�표�?감싸???�니??]',
ARRAY['basics', 'output', 'printf'], 5),

('python-print-name', 'python', 'syntax', 2, '?�름 출력?�기', '?�신???�름??출력?�세??, 'challenge', 1,
'?�면??"My name is [?�름]" ?�식?�로 출력?�는 ?�로그램???�성?�세??',
'- [?�름] 부분에???�하???�름???�으?�요\n- 줄바꿈을 ?�함?�야 ?�니??,
'[{"input": "", "output": "My name is John"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    print("My name is John")
',
'[{"input": "", "expected": "My name is John\n"}]',
'["printf�?문자?�을 출력?????�습?�다"]',
ARRAY['basics', 'output'], 5),

('python-multiline-output', 'python', 'syntax', 3, '?�러 �?출력', '?�러 줄을 출력?�세??, 'challenge', 1,
'?�음 ??줄을 출력?�는 ?�로그램???�성?�세??\nLine 1\nLine 2\nLine 3',
'- �?줄�? ?�로??줄에 출력?�어???�니??,
'[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    print("Line 1")
    print("Line 2")
    print("Line 3")
',
'[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]',
'["printf�??�러 �??�출?�거??\\n???�용?�세??]',
ARRAY['basics', 'output'], 5),

('python-single-line-comment', 'python', 'syntax', 4, '??�?주석', '주석???�용?�여 코드 ?�명?�기', 'challenge', 1,
'Hello�?출력?�는 코드�??�성?�고, �??�에 ??�?주석?�로 "?�것?� 출력 코드?�니??�?추�??�세??',
'- // �??�용?�여 주석???�성?�세??,
'[{"input": "", "output": "Hello"}]',
'
    // ?�기??주석�?코드�??�성?�세??
',
'
    // ?�것?� 출력 코드?�니??    print("Hello")
',
'[{"input": "", "expected": "Hello\n"}]',
'["// ?�의 ?�용?� ?�행?��? ?�습?�다"]',
ARRAY['basics', 'comments'], 5),

('python-multi-line-comment', 'python', 'syntax', 5, '?�러 �?주석', '?�러 �?주석 ?�용?�기', 'challenge', 1,
'World�?출력?�는 코드�??�성?�고, �??�에 ?�러 �?주석?�로 ?�로그램 ?�명??추�??�세??',
'- /* */ �??�용?�여 주석???�성?�세??,
'[{"input": "", "output": "World"}]',
'
    /* ?�기??주석�?코드�??�성?�세??*/

',
'
    /*
     * ???�로그램?� World�?출력?�니??     * C ?�어 기초 ?�습?�입?�다
     */
    print("World")
',
'[{"input": "", "expected": "World\n"}]',
'["/* */ ?�이???�용?� 모두 주석?�니??]',
ARRAY['basics', 'comments'], 5);

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-pattern-triangle', 'python', 'syntax', 51, '삼각형 패턴', '별표로 삼각형 그리기', 'challenge', 2,
'정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***',
'- 중첩 반복문 사용\n- 1 ≤ N ≤ 10',
'[{"input": "3", "output": "*\n**\n***"}]',
'
    int n;


-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-integer-variable$$, $$python$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42를 저장한 후 출력하세요.$$,
$$- int 타입을 사용하세요\n- %d를 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    int num = 42;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-bit-operations$$, $$python$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-integer-variable', 'python', 'syntax', 6, '?�수 변??, '?�수??변???�언?�고 출력?�기', 'challenge', 1,
'?�수??변??num???�언?�고 42�??�?�한 ??출력?�세??',
'- int ?�?�을 ?�용?�세??n- %d�??�용?�여 출력?�세??,
'[{"input": "", "output": "42"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    int num = 42;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-bit-operations', 'python', 'basics', 56, '비트 연산', '비트 연산자로 값 조작하기', 'challenge', 2,
'두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.',
'- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력',
'[{"input": "12 10", "output": "8\n14\n6"}]',
'
    int a, b;


-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-addition$$, $$python$$, $$basics$$, 11, $$덧셈 계산$$, $$두 수의 합 구하기$$, $$challenge$$, 1,
$$두 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-compound-interest$$, $$python$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-addition', 'python', 'basics', 11, '?�셈 계산', '???�의 ??구하�?, 'challenge', 1,
'???�수 a=15, b=25???�을 계산?�여 출력?�세??',
'- + ?�산?��? ?�용?�세??,
'[{"input": "", "output": "40"}]',
'
    int a = 15, b = 25;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-compound-interest', 'python', 'basics', 61, '복리 계산', '복리 이자 계산하기', 'challenge', 2,
'원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n',
'- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리',
'[{"input": "1000 5 3", "output": "1157.63"}]',
'#include <math.h>

int main() {
    double P, r;


-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-if-positive$$, $$python$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"를 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-leap-year$$, $$python$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-if-positive', 'python', 'basics', 16, '?�수 ?�별', '?�자가 ?�수?��? ?�인?�기', 'challenge', 1,
'?�수 num??주어�??? ?�수?�면 "Positive"�?출력?�세??',
'- if 문을 ?�용?�세??n- num > 0 조건???�인?�세??,
'[{"input": "5", "output": "Positive"}]',
'
    int num;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-leap-year', 'python', 'basics', 66, '윤년 판별', '윤년인지 확인하기', 'challenge', 2,
'연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수',
'- 조건을 정확히 구현',
'[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]',
'
    int year;


-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-for-1-to-10$$, $$python$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자를 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    for (int i = 1;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-fibonacci$$, $$python$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-for-1-to-10', 'python', 'basics', 21, '1부??10까�? 출력', 'for문으�?1부??10까�? 출력?�기', 'challenge', 1,
'for문을 ?�용?�여 1부??10까�????�자�???줄에 ?�나??출력?�세??',
'- for문을 ?�용?�세??,
'[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    for (int i = 1;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-fibonacci', 'python', 'basics', 71, '피보나치 수열', 'N번째 피보나치 수 구하기', 'challenge', 2,
'정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)',
'- 반복문 사용\n- 1 ≤ N ≤ 20',
'[{"input": "7", "output": "13"}]',
'
    int n;


-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-function-add$$, $$python$$, $$basics$$, 26, $$덧셈 함수$$, $$두 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$두 정수를 입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-factorial-function$$, $$python$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-function-add', 'python', 'basics', 26, '?�셈 ?�수', '???��? ?�하???�수 만들�?, 'challenge', 1,
'???�수�??�력받아 ?�을 반환?�는 add ?�수�??�성?�세??',
'- int add(int a, int b) ?�식?�로 ?�성?�세??,
'[{"input": "3 5", "output": "8"}]',
'
# ?�기??add ?�수�??�성?�세??
a, b = map(int, input().split())
print(add(a, b))
',
'',
'[{"input": "3 5", "expected": "8\n"}]',
'["return a + b;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-factorial-function', 'python', 'basics', 76, '팩토리얼 함수', 'N! 계산 함수 만들기', 'challenge', 2,
'정수 N의 팩토리얼을 계산하는 함수를 작성하세요.',
'- int factorial(int n)\n- 반복문 사용',
'[{"input": "5", "output": "120"}]',
'
# 여기에 코드를 작성하세요

',
'[{"input": "5", "expected": "120\n"}]',
'["1부터 n까지 곱하세요"]',
ARRAY['functions', 'factorial', 'math'], 10),

('python-recursive-fibonacci', 'python', 'basics', 77, '재귀 피보나치', '재귀 함수로 피보나치 수 구하기', 'challenge', 2,
'재귀 함수를 사용하여 N번째 피보나치 수를 구하세요.',
'- int fib(int n)\n- 재귀 호출',
'[{"input": "7", "output": "13"}]',
'
# 여기에 코드를 작성하세요

',
'[{"input": "7", "expected": "13\n"}]',
'["기저 사례와 재귀 호출을 구현하세요"]',
ARRAY['functions', 'recursion', 'fibonacci'], 15),

('python-power-function', 'python', 'basics', 78, '거듭제곱 함수', 'base^exponent 계산하기', 'challenge', 2,
'base와 exponent가 주어질 때, base^exponent를 계산하는 함수를 작성하세요.',
'- int power(int base, int exp)\n- 반복문 사용',
'[{"input": "2 10", "output": "1024"}]',
'
# 여기에 코드를 작성하세요

',
'[{"input": "2 10", "expected": "1024\n"}]',
'["base를 exp번 곱하세요"]',
ARRAY['functions', 'power', 'math'], 10),

('python-array-function', 'python', 'basics', 79, '배열 함수', '배열을 함수로 전달하기', 'challenge', 2,
'배열과 크기를 입력받아 평균을 계산하는 함수를 작성하세요.',
'- double average(int arr[], int size)',
'[{"input": "5\n10 20 30 40 50", "output": "30.00"}]',
'
# 여기에 코드를 작성하세요

',
'[{"input": "5\n10 20 30 40 50", "expected": "30.00\n"}]',
'["배열은 포인터로 전달됩니다"]',
ARRAY['functions', 'arrays', 'average'], 15),

('python-pass-by-reference', 'python', 'basics', 80, '참조로 전달', '포인터로 값 변경하기', 'challenge', 2,
'두 정수의 합과 차를 동시에 구하는 함수를 작성하세요.',
'- void calculate(int a, int b, int *sum, int *diff)',
'[{"input": "10 3", "output": "13\n7"}]',
'
# 여기에 코드를 작성하세요

',
'[{"input": "10 3", "expected": "13\n7\n"}]',
'["포인터를 통해 값을 변경하세요"]',
ARRAY['functions', 'pointers', 'pass-by-reference'], 15);


-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-array-declare$$, $$python$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$
    // 여기에 코드를 작성하세요

$func$,
$func$
    int arr[5] = {1, 2, 3, 4, 5};

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-bubble-sort$$, $$python$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-array-declare', 'python', 'basics', 31, '배열 ?�언', '배열 ?�언?�고 초기?�하�?, 'challenge', 1,
'?�기가 5???�수 배열???�언?�고 1, 2, 3, 4, 5�?초기?�한 ??모든 ?�소�?출력?�세??',
'- 배열 ?�언: int arr[5]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'
    // ?�기??코드�??�성?�세??
',
'
    int arr[5] = {1, 2, 3, 4, 5};

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-bubble-sort', 'python', 'advanced', 81, '버블 정렬', '배열을 오름차순으로 정렬하기', 'challenge', 3,
'N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.',
'- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100',
'[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]',
'
    int n;


-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pointer-address$$, $$python$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pointer-arithmetic$$, $$python$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-pointer-address', 'python', 'basics', 36, '변??주소 출력', '변?�의 메모�?주소 출력?�기', 'challenge', 1,
'?�수 변??num??값과 주소�?출력?�세??',
'- & ?�산?��? ?�용?�여 주소�??�으?�요\n- %p�?주소�?출력?�세??,
'[{"input": "", "output": "Value: 10\nAddress: 0x..."}]',
'
    int num = 10;

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-pointer-arithmetic', 'python', 'advanced', 86, '포인터 산술', '포인터로 배열 순회하기', 'challenge', 3,
'배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.',
'- [] 사용 금지, *(ptr + i) 형태 사용',
'[{"input": "5\n1 2 3 4 5", "output": "15"}]',
'
    int n;


-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-scanf-int$$, $$python$$, $$basics$$, 41, $$정수 입력받기$$, $$scanf로 정수 입력받기$$, $$challenge$$, 1,
$$정수 하나를 입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-file-write$$, $$python$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-scanf-int', 'python', 'basics', 41, '?�수 ?�력받기', 'scanf�??�수 ?�력받기', 'challenge', 1,
'?�수 ?�나�??�력받아 그�?�?출력?�세??',
'- scanf("%d", &num);

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-file-write', 'python', 'advanced', 91, '파일 쓰기', '파일에 텍스트 쓰기', 'challenge', 3,
'문자열을 입력받아 "output.txt" 파일에 쓰세요.',
'- fopen, fprintf, fclose 사용',
'[{"input": "Hello World", "output": "File written"}]',
'
    char str[100];


-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-struct-declare$$, $$python$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)를 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-string-reverse$$, $$python$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-struct-declare', 'python', 'basics', 46, '구조�??�언', '구조�??�의?�고 ?�용?�기', 'challenge', 1,
'?�름(문자??�??�이(?�수)�?가�?Person 구조체�? ?�의?�고 값을 출력?�세??',
'- struct Person { char name[50];

INSERT INTO challenges_python (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('python-string-reverse', 'python', 'advanced', 96, '문자열 뒤집기', '문자열을 거꾸로 만들기', 'challenge', 3,
'문자열을 입력받아 뒤집어서 출력하세요.',
'- 직접 구현 (strrev 사용 금지)',
'[{"input": "hello", "output": "olleh"}]',
'#include <string.h>

int main() {
    char str[100];


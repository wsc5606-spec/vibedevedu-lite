-- ============================================================================
-- C Language Challenges (Merged)
-- ============================================================================
-- Total: 40 challenges
-- Distribution: 4 challenges per unit (10 units)
-- ============================================================================


-- ============================================================================
-- Unit 1 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-hello-world$$, 'c', $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성하기$$, $$challenge$$, 1,
$$화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pattern-triangle$$, 'c', $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-hello-world', 'c', 'syntax', 1, 'Hello World', 'C�?�??�로그램 ?�성?�기', 'challenge', 1,
'?�면??"Hello, World!"�?출력?�는 ?�로그램???�성?�세??',
'- printf ?�수�??�용?�세??n- 줄바�?\n)???�함?�야 ?�니??,
'[{"input": "", "output": "Hello, World!"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-pattern-triangle', 'c', 'syntax', 51, '?�각???�턴', '별표�??�각??그리�?, 'challenge', 2,
'?�수 N??주어�??? N줄의 ?�각???�턼??출력?�세??\n?? N=3????n*\n**\n***',
'- 중첩 반복�??�용\n- 1 ??N ??10',
'[{"input": "3", "output": "*\n**\n***"}]',
'#include <stdio.h>

int main() {
    int n;


-- ============================================================================
-- Unit 2 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-integer-variable$$, 'c', $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42를 저장한 후 출력하세요.$$,
$$- int 타입을 사용하세요\n- %d를 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bit-operations$$, 'c', $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-integer-variable', 'c', 'syntax', 6, '?�수 변??, '?�수??변???�언?�고 출력?�기', 'challenge', 1,
'?�수??변??num???�언?�고 42�??�?�한 ??출력?�세??',
'- int ?�?�을 ?�용?�세??n- %d�??�용?�여 출력?�세??,
'[{"input": "", "output": "42"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-bit-operations', 'c', 'basics', 56, '비트 ?�산', '비트 ?�산?�로 �?조작?�기', 'challenge', 2,
'???�수 a, b가 주어�??? AND, OR, XOR ?�산 결과�?출력?�세??',
'- &, |, ^ ?�산???�용\n- �?줄에 ?�나??출력',
'[{"input": "12 10", "output": "8\n14\n6"}]',
'#include <stdio.h>

int main() {
    int a, b;


-- ============================================================================
-- Unit 3 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-addition$$, 'c', $$basics$$, 11, $$덧셈 계산$$, $$두 수의 합 구하기$$, $$challenge$$, 1,
$$두 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-compound-interest$$, 'c', $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-addition', 'c', 'basics', 11, '?�셈 계산', '???�의 ??구하�?, 'challenge', 1,
'???�수 a=15, b=25???�을 계산?�여 출력?�세??',
'- + ?�산?��? ?�용?�세??,
'[{"input": "", "output": "40"}]',
'#include <stdio.h>

int main() {
    int a = 15, b = 25;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-compound-interest', 'c', 'basics', 61, '복리 계산', '복리 ?�자 계산?�기', 'challenge', 2,
'?�금 P, ?�율 r(%), 기간 n(????주어�??? 복리 ?�리금을 계산?�세??\n공식: P * (1 + r/100)^n',
'- pow ?�수 ?�용\n- #include <math.h>\n- ?�수??2?�리',
'[{"input": "1000 5 3", "output": "1157.63"}]',
'#include <stdio.h>
#include <math.h>

int main() {
    double P, r;


-- ============================================================================
-- Unit 4 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-if-positive$$, 'c', $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"를 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-leap-year$$, 'c', $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-if-positive', 'c', 'basics', 16, '?�수 ?�별', '?�자가 ?�수?��? ?�인?�기', 'challenge', 1,
'?�수 num??주어�??? ?�수?�면 "Positive"�?출력?�세??',
'- if 문을 ?�용?�세??n- num > 0 조건???�인?�세??,
'[{"input": "5", "output": "Positive"}]',
'#include <stdio.h>

int main() {
    int num;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-leap-year', 'c', 'basics', 66, '?�년 ?�별', '?�년?��? ?�인?�기', 'challenge', 2,
'?�도가 주어�??? ?�년?�면 "Leap", ?�년?�면 "Common"??출력?�세??\n?�년: 4??배수?�면??100??배수가 ?�니거나, 400??배수',
'- 조건???�확??구현',
'[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]',
'#include <stdio.h>

int main() {
    int year;


-- ============================================================================
-- Unit 5 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-for-1-to-10$$, 'c', $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자를 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fibonacci$$, $$c$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-for-1-to-10', 'c', 'basics', 21, '1부??10까�? 출력', 'for문으�?1부??10까�? 출력?�기', 'challenge', 1,
'for문을 ?�용?�여 1부??10까�????�자�???줄에 ?�나??출력?�세??',
'- for문을 ?�용?�세??,
'[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-fibonacci', 'c', 'basics', 71, '?�보?�치 ?�열', 'N번째 ?�보?�치 ??구하�?, 'challenge', 2,
'?�수 N??주어�??? N번째 ?�보?�치 ?��? 출력?�세??\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)',
'- 반복�??�용\n- 1 ??N ??20',
'[{"input": "7", "output": "13"}]',
'#include <stdio.h>

int main() {
    int n;


-- ============================================================================
-- Unit 6 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-function-add$$, 'c', $$basics$$, 26, $$덧셈 함수$$, $$두 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$두 정수를 입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-factorial-function$$, $$c$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-function-add', 'c', 'basics', 26, '?�셈 ?�수', '???��? ?�하???�수 만들�?, 'challenge', 1,
'???�수�??�력받아 ?�을 반환?�는 add ?�수�??�성?�세??',
'- int add(int a, int b) ?�식?�로 ?�성?�세??,
'[{"input": "3 5", "output": "8"}]',
'#include <stdio.h>

// ?�기??add ?�수�??�성?�세??
int main() {
    int a, b;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-factorial-function', 'c', 'basics', 76, '?�토리얼 ?�수', 'N! 계산 ?�수 만들�?, 'challenge', 2,
'?�수 N???�토리얼??계산?�는 ?�수�??�성?�세??',
'- int factorial(int n)\n- 반복�??�용',
'[{"input": "5", "output": "120"}]',
'#include <stdio.h>

// ?�기??factorial ?�수�??�성?�세??
int main() {
    int n;


-- ============================================================================
-- Unit 7 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-array-declare$$, 'c', $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bubble-sort$$, $$c$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-array-declare', 'c', 'basics', 31, '배열 ?�언', '배열 ?�언?�고 초기?�하�?, 'challenge', 1,
'?�기가 5???�수 배열???�언?�고 1, 2, 3, 4, 5�?초기?�한 ??모든 ?�소�?출력?�세??',
'- 배열 ?�언: int arr[5]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-bubble-sort', 'c', 'advanced', 81, '버블 ?�렬', '배열???�름차순?�로 ?�렬?�기', 'challenge', 3,
'N개의 ?�수�?버블 ?�렬 ?�고리즘?�로 ?�름차순 ?�렬?�세??',
'- ?�접???�소�?비교?�여 교환\n- 1 ??N ??100',
'[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]',
'#include <stdio.h>

int main() {
    int n;


-- ============================================================================
-- Unit 8 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-address$$, 'c', $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-arithmetic$$, $$c$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-pointer-address', 'c', 'basics', 36, '변??주소 출력', '변?�의 메모�?주소 출력?�기', 'challenge', 1,
'?�수 변??num??값과 주소�?출력?�세??',
'- & ?�산?��? ?�용?�여 주소�??�으?�요\n- %p�?주소�?출력?�세??,
'[{"input": "", "output": "Value: 10\nAddress: 0x..."}]',
'#include <stdio.h>

int main() {
    int num = 10;

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-pointer-arithmetic', 'c', 'advanced', 86, '?�인???�술', '?�인?�로 배열 ?�회?�기', 'challenge', 3,
'배열???�인???�술 ?�산만으�??�회?�여 ?�을 구하?�요.',
'- [] ?�용 금�?, *(ptr + i) ?�태 ?�용',
'[{"input": "5\n1 2 3 4 5", "output": "15"}]',
'#include <stdio.h>

int main() {
    int n;


-- ============================================================================
-- Unit 9 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-scanf-int$$, 'c', $$basics$$, 41, $$정수 입력받기$$, $$scanf로 정수 입력받기$$, $$challenge$$, 1,
$$정수 하나를 입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-file-write$$, $$c$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-scanf-int', 'c', 'basics', 41, '?�수 ?�력받기', 'scanf�??�수 ?�력받기', 'challenge', 1,
'?�수 ?�나�??�력받아 그�?�?출력?�세??',
'- scanf("%d", &num);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-file-write', 'c', 'advanced', 91, '?�일 ?�기', '?�일???�스???�기', 'challenge', 3,
'문자?�을 ?�력받아 "output.txt" ?�일???�세??',
'- fopen, fprintf, fclose ?�용',
'[{"input": "Hello World", "output": "File written"}]',
'#include <stdio.h>

int main() {
    char str[100];


-- ============================================================================
-- Unit 10 - 4 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-struct-declare$$, 'c', $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)를 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-string-reverse$$, $$c$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-struct-declare', 'c', 'basics', 46, '구조�??�언', '구조�??�의?�고 ?�용?�기', 'challenge', 1,
'?�름(문자??�??�이(?�수)�?가�?Person 구조체�? ?�의?�고 값을 출력?�세??',
'- struct Person { char name[50];

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('c-string-reverse', 'c', 'advanced', 96, '문자???�집�?, '문자?�을 거꾸�?만들�?, 'challenge', 3,
'문자?�을 ?�력받아 ?�집?�서 출력?�세??',
'- 직접 구현 (strrev ?�용 금�?)',
'[{"input": "hello", "output": "olleh"}]',
'#include <stdio.h>
#include <string.h>

int main() {
    char str[100];


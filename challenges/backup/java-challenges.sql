-- ============================================================================
-- JAVA Language Challenges (Complete)
-- ============================================================================
-- Generated: 2025-11-01T14:07:10.162Z
-- ============================================================================

-- ============================================================================
-- Java Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

-- Unit 1: 출력과 주석 (Output and Comments) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-hello-world$$, $$java$$, $$syntax$$, 1, $$Hello World$$, $$C로 첫 프로그램 작성하기$$, $$challenge$$, 1,
$$화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.$$,
$$- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "Hello, World!\n"}]$$,
$$["printf 함수의 사용법을 확인하세요", "문자열은 큰따옴표로 감싸야 합니다"]$$,
$$["basics", "output", "printf"]$$, 5),

($$java-print-name$$, $$java$$, $$syntax$$, 2, $$이름 출력하기$$, $$자신의 이름을 출력하세요$$, $$challenge$$, 1,
$$화면에 "My name is [이름]" 형식으로 출력하는 프로그램을 작성하세요.$$,
$$- [이름] 부분에는 원하는 이름을 넣으세요\n- 줄바꿈을 포함해야 합니다$$,
$$[{"input": "", "output": "My name is John"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    printf("My name is John\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "My name is John\n"}]$$,
$$["printf로 문자열을 출력할 수 있습니다"]$$,
$$["basics", "output"]$$, 5),

($$java-multiline-output$$, $$java$$, $$syntax$$, 3, $$여러 줄 출력$$, $$여러 줄을 출력하세요$$, $$challenge$$, 1,
$$다음 세 줄을 출력하는 프로그램을 작성하세요:\nLine 1\nLine 2\nLine 3$$,
$$- 각 줄은 새로운 줄에 출력되어야 합니다$$,
$$[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    printf("Line 1\n");
    printf("Line 2\n");
    printf("Line 3\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]$$,
$$["printf를 여러 번 호출하거나 \\n을 사용하세요"]$$,
$$["basics", "output"]$$, 5),

($$java-single-line-comment$$, $$java$$, $$syntax$$, 4, $$한 줄 주석$$, $$주석을 사용하여 코드 설명하기$$, $$challenge$$, 1,
$$Hello를 출력하는 코드를 작성하고, 그 위에 한 줄 주석으로 "이것은 출력 코드입니다"를 추가하세요.$$,
$$- // 를 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "Hello"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 주석과 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    // 이것은 출력 코드입니다
    printf("Hello\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "Hello\n"}]$$,
$$["// 뒤의 내용은 실행되지 않습니다"]$$,
$$["basics", "comments"]$$, 5),

($$java-multi-line-comment$$, $$java$$, $$syntax$$, 5, $$여러 줄 주석$$, $$여러 줄 주석 사용하기$$, $$challenge$$, 1,
$$World를 출력하는 코드를 작성하고, 그 위에 여러 줄 주석으로 프로그램 설명을 추가하세요.$$,
$$- /* */ 를 사용하여 주석을 작성하세요$$,
$$[{"input": "", "output": "World"}]$$,
$func$#include <stdio.h>

int main() {
    /* 여기에 주석과 코드를 작성하세요 */

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    /*
     * 이 프로그램은 World를 출력합니다
     * C 언어 기초 학습용입니다
     */
    printf("World\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "World\n"}]$$,
$$["/* */ 사이의 내용은 모두 주석입니다"]$$,
$$["basics", "comments"]$$, 5);

-- Unit 2: 변수와 자료형 (Variables and Data Types) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-integer-variable$$, $$java$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 42를 저장한 후 출력하세요.$$,
$$- int 타입을 사용하세요\n- %d를 사용하여 출력하세요$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num = 42;
    printf("%d\n", num);
    return 0;
}$func$,
$$[{"input": "", "expected": "42\n"}]$$,
$$["int는 정수를 저장하는 타입입니다", "printf의 %d는 정수 출력용입니다"]$$,
$$["basics", "variables", "int"]$$, 5),

($$java-float-variable$$, $$java$$, $$syntax$$, 7, $$실수 변수$$, $$실수형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$실수형 변수 pi를 선언하고 3.14를 저장한 후 출력하세요.$$,
$$- float 타입을 사용하세요\n- %f를 사용하여 출력하세요$$,
$$[{"input": "", "output": "3.14"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    float pi = 3.14;
    printf("%.2f\n", pi);
    return 0;
}$func$,
$$[{"input": "", "expected": "3.14\n"}]$$,
$$["float는 실수를 저장합니다", "%.2f는 소수점 2자리까지 출력합니다"]$$,
$$["basics", "variables", "float"]$$, 5),

($$java-char-variable$$, $$java$$, $$syntax$$, 8, $$문자 변수$$, $$문자형 변수 선언하고 출력하기$$, $$challenge$$, 1,
$$문자형 변수 grade를 선언하고 'A'를 저장한 후 출력하세요.$$,
$$- char 타입을 사용하세요\n- %c를 사용하여 출력하세요$$,
$$[{"input": "", "output": "A"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    char grade = 'A';
    printf("%c\n", grade);
    return 0;
}$func$,
$$[{"input": "", "expected": "A\n"}]$$,
$$["char는 한 글자를 저장합니다", "문자는 작은따옴표로 감쌉니다"]$$,
$$["basics", "variables", "char"]$$, 5),

($$java-multiple-variables$$, $$java$$, $$syntax$$, 9, $$여러 변수 선언$$, $$여러 개의 변수 선언하기$$, $$challenge$$, 1,
$$정수 a=10, b=20을 선언하고 두 값을 공백으로 구분하여 출력하세요.$$,
$$- 한 줄에 출력해야 합니다$$,
$$[{"input": "", "output": "10 20"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 10, b = 20;
    printf("%d %d\n", a, b);
    return 0;
}$func$,
$$[{"input": "", "expected": "10 20\n"}]$$,
$$["여러 변수를 쉼표로 구분하여 선언할 수 있습니다"]$$,
$$["basics", "variables"]$$, 5),

($$java-variable-swap$$, $$java$$, $$syntax$$, 10, $$변수값 교환$$, $$두 변수의 값 바꾸기$$, $$challenge$$, 1,
$$a=5, b=10인 두 변수의 값을 서로 바꾼 후 출력하세요. (임시 변수 사용)$$,
$$- 출력 형식: a b$$,
$$[{"input": "", "output": "10 5"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 5, b = 10;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 5, b = 10;
    int temp = a;
    a = b;
    b = temp;
    printf("%d %d\n", a, b);
    return 0;
}$func$,
$$[{"input": "", "expected": "10 5\n"}]$$,
$$["임시 변수 temp를 사용하세요"]$$,
$$["basics", "variables", "swap"]$$, 5);

-- Unit 3: 연산자 (Operators) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-addition$$, $$java$$, $$basics$$, 11, $$덧셈 계산$$, $$두 수의 합 구하기$$, $$challenge$$, 1,
$$두 정수 a=15, b=25의 합을 계산하여 출력하세요.$$,
$$- + 연산자를 사용하세요$$,
$$[{"input": "", "output": "40"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;
    int sum = a + b;
    printf("%d\n", sum);
    return 0;
}$func$,
$$[{"input": "", "expected": "40\n"}]$$,
$$["+ 연산자로 덧셈을 수행합니다"]$$,
$$["basics", "operators", "arithmetic"]$$, 5),

($$java-subtraction$$, $$java$$, $$basics$$, 12, $$뺄셈 계산$$, $$두 수의 차 구하기$$, $$challenge$$, 1,
$$두 정수 a=50, b=30의 차를 계산하여 출력하세요.$$,
$$- - 연산자를 사용하세요$$,
$$[{"input": "", "output": "20"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 50, b = 30;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 50, b = 30;
    int diff = a - b;
    printf("%d\n", diff);
    return 0;
}$func$,
$$[{"input": "", "expected": "20\n"}]$$,
$$["- 연산자로 뺄셈을 수행합니다"]$$,
$$["basics", "operators", "arithmetic"]$$, 5),

($$java-multiplication$$, $$java$$, $$basics$$, 13, $$곱셈 계산$$, $$두 수의 곱 구하기$$, $$challenge$$, 1,
$$두 정수 a=7, b=8의 곱을 계산하여 출력하세요.$$,
$$- * 연산자를 사용하세요$$,
$$[{"input": "", "output": "56"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 7, b = 8;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 7, b = 8;
    int product = a * b;
    printf("%d\n", product);
    return 0;
}$func$,
$$[{"input": "", "expected": "56\n"}]$$,
$$["* 연산자로 곱셈을 수행합니다"]$$,
$$["basics", "operators", "arithmetic"]$$, 5),

($$java-division$$, $$java$$, $$basics$$, 14, $$나눗셈 계산$$, $$두 수의 몫 구하기$$, $$challenge$$, 1,
$$두 정수 a=20, b=4의 몫을 계산하여 출력하세요.$$,
$$- / 연산자를 사용하세요$$,
$$[{"input": "", "output": "5"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 20, b = 4;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 20, b = 4;
    int quotient = a / b;
    printf("%d\n", quotient);
    return 0;
}$func$,
$$[{"input": "", "expected": "5\n"}]$$,
$$["/ 연산자로 나눗셈을 수행합니다"]$$,
$$["basics", "operators", "arithmetic"]$$, 5),

($$java-modulo$$, $$java$$, $$basics$$, 15, $$나머지 계산$$, $$두 수의 나머지 구하기$$, $$challenge$$, 1,
$$두 정수 a=17, b=5의 나머지를 계산하여 출력하세요.$$,
$$- % 연산자를 사용하세요$$,
$$[{"input": "", "output": "2"}]$$,
$func$#include <stdio.h>

int main() {
    int a = 17, b = 5;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a = 17, b = 5;
    int remainder = a % b;
    printf("%d\n", remainder);
    return 0;
}$func$,
$$[{"input": "", "expected": "2\n"}]$$,
$$["% 연산자로 나머지를 구합니다"]$$,
$$["basics", "operators", "modulo"]$$, 5);

-- Unit 4: 조건문 (Conditional Statements) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-if-positive$$, $$java$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 양수이면 "Positive"를 출력하세요.$$,
$$- if 문을 사용하세요\n- num > 0 조건을 확인하세요$$,
$$[{"input": "5", "output": "Positive"}]$$,
$func$#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    if (num > 0) {
        printf("Positive\n");
    }
    return 0;
}$func$,
$$[{"input": "5", "expected": "Positive\n"}, {"input": "10", "expected": "Positive\n"}]$$,
$$["if (조건) { 실행할 코드 }"]$$,
$$["conditionals", "if"]$$, 5),

($$java-if-else-even$$, $$java$$, $$basics$$, 17, $$짝수 홀수 판별$$, $$짝수인지 홀수인지 판별하기$$, $$challenge$$, 1,
$$정수 num이 주어질 때, 짝수이면 "Even", 홀수이면 "Odd"를 출력하세요.$$,
$$- if-else 문을 사용하세요\n- % 연산자로 나머지를 확인하세요$$,
$$[{"input": "4", "output": "Even"}, {"input": "7", "output": "Odd"}]$$,
$func$#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    if (num % 2 == 0) {
        printf("Even\n");
    } else {
        printf("Odd\n");
    }
    return 0;
}$func$,
$$[{"input": "4", "expected": "Even\n"}, {"input": "7", "expected": "Odd\n"}]$$,
$$["num % 2 == 0 이면 짝수입니다"]$$,
$$["conditionals", "if-else", "modulo"]$$, 5),

($$java-if-else-max$$, $$java$$, $$basics$$, 18, $$두 수 중 큰 수$$, $$두 수 중 더 큰 수 찾기$$, $$challenge$$, 1,
$$두 정수 a, b가 주어질 때, 더 큰 수를 출력하세요.$$,
$$- if-else 문을 사용하세요$$,
$$[{"input": "10 20", "output": "20"}, {"input": "30 15", "output": "30"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    if (a > b) {
        printf("%d\n", a);
    } else {
        printf("%d\n", b);
    }
    return 0;
}$func$,
$$[{"input": "10 20", "expected": "20\n"}, {"input": "30 15", "expected": "30\n"}]$$,
$$["a > b를 비교하세요"]$$,
$$["conditionals", "comparison"]$$, 5),

($$java-if-else-if-grade$$, $$java$$, $$basics$$, 19, $$점수로 등급 판정$$, $$점수에 따라 등급 출력하기$$, $$challenge$$, 1,
$$점수 score가 주어질 때, 90 이상이면 "A", 80 이상이면 "B", 그 외는 "C"를 출력하세요.$$,
$$- if-else if-else 문을 사용하세요$$,
$$[{"input": "95", "output": "A"}, {"input": "85", "output": "B"}, {"input": "75", "output": "C"}]$$,
$func$#include <stdio.h>

int main() {
    int score;
    scanf("%d", &score);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int score;
    scanf("%d", &score);
    if (score >= 90) {
        printf("A\n");
    } else if (score >= 80) {
        printf("B\n");
    } else {
        printf("C\n");
    }
    return 0;
}$func$,
$func$[{"input": "95", "expected": "A\n"}, {"input": "85", "expected": "B\n"}, {"input": "75", "expected": "C\n"}]$func$,
$$["조건을 순서대로 확인하세요"]$$,
$$["conditionals", "if-else-if"]$$, 5),

($$java-logical-and$$, $$java$$, $$basics$$, 20, $$논리 연산 AND$$, $$두 조건이 모두 참인지 확인하기$$, $$challenge$$, 1,
$$나이 age가 주어질 때, 18세 이상 65세 미만이면 "Adult"를 출력하세요.$$,
$$- && 연산자를 사용하세요$$,
$$[{"input": "25", "output": "Adult"}, {"input": "70", "output": ""}]$$,
$func$#include <stdio.h>

int main() {
    int age;
    scanf("%d", &age);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int age;
    scanf("%d", &age);
    if (age >= 18 && age < 65) {
        printf("Adult\n");
    }
    return 0;
}$func$,
$$[{"input": "25", "expected": "Adult\n"}, {"input": "70", "expected": ""}]$$,
$$["&& 는 AND 연산자입니다"]$$,
$$["conditionals", "logical-operators"]$$, 5);

-- Unit 5: 반복문 (Loops) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-for-1-to-10$$, $$java$$, $$basics$$, 21, $$1부터 10까지 출력$$, $$for문으로 1부터 10까지 출력하기$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지의 숫자를 한 줄에 하나씩 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        printf("%d\n", i);
    }
    return 0;
}$func$,
$$[{"input": "", "expected": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"}]$$,
$$["for (int i = 1; i <= 10; i++)"]$$,
$$["loops", "for"]$$, 5),

($$java-while-countdown$$, $$java$$, $$basics$$, 22, $$카운트다운$$, $$while문으로 카운트다운하기$$, $$challenge$$, 1,
$$while문을 사용하여 5부터 1까지 카운트다운을 출력하세요.$$,
$$- while문을 사용하세요$$,
$$[{"input": "", "output": "5\n4\n3\n2\n1"}]$$,
$func$#include <stdio.h>

int main() {
    int count = 5;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int count = 5;
    while (count > 0) {
        printf("%d\n", count);
        count--;
    }
    return 0;
}$func$,
$$[{"input": "", "expected": "5\n4\n3\n2\n1\n"}]$$,
$$["while (조건) { ... count--; }"]$$,
$$["loops", "while"]$$, 5),

($$java-sum-1-to-n$$, $$java$$, $$basics$$, 23, $$1부터 N까지의 합$$, $$1부터 N까지의 합 구하기$$, $$challenge$$, 1,
$$정수 N이 주어질 때, 1부터 N까지의 합을 계산하여 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "5", "output": "15"}, {"input": "10", "output": "55"}]$$,
$func$#include <stdio.h>

int main() {
    int n, sum = 0;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n, sum = 0;
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    printf("%d\n", sum);
    return 0;
}$func$,
$$[{"input": "5", "expected": "15\n"}, {"input": "10", "expected": "55\n"}]$$,
$$["sum += i 로 누적합을 구하세요"]$$,
$$["loops", "for", "sum"]$$, 5),

($$java-multiplication-table$$, $$java$$, $$basics$$, 24, $$구구단$$, $$구구단 출력하기$$, $$challenge$$, 1,
$$정수 N이 주어질 때, N단 구구단을 출력하세요. (1~9까지)$$,
$$- 형식: N x 1 = 결과$$,
$func$[{"input": "3", "output": "3 x 1 = 3\n3 x 2 = 6\n3 x 3 = 9\n3 x 4 = 12\n3 x 5 = 15\n3 x 6 = 18\n3 x 7 = 21\n3 x 8 = 24\n3 x 9 = 27"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    for (int i = 1; i <= 9; i++) {
        printf("%d x %d = %d\n", n, i, n * i);
    }
    return 0;
}$func$,
$func$[{"input": "3", "expected": "3 x 1 = 3\n3 x 2 = 6\n3 x 3 = 9\n3 x 4 = 12\n3 x 5 = 15\n3 x 6 = 18\n3 x 7 = 21\n3 x 8 = 24\n3 x 9 = 27\n"}]$func$,
$$["for문으로 1~9까지 반복하세요"]$$,
$$["loops", "for", "multiplication"]$$, 5),

($$java-do-while$$, $$java$$, $$basics$$, 25, $$do-while 반복$$, $$do-while문 사용하기$$, $$challenge$$, 1,
$$do-while문을 사용하여 1부터 5까지 출력하세요.$$,
$$- do-while문을 사용하세요$$,
$$[{"input": "", "output": "1\n2\n3\n4\n5"}]$$,
$func$#include <stdio.h>

int main() {
    int i = 1;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int i = 1;
    do {
        printf("%d\n", i);
        i++;
    } while (i <= 5);
    return 0;
}$func$,
$$[{"input": "", "expected": "1\n2\n3\n4\n5\n"}]$$,
$$["do { ... } while (조건);"]$$,
$$["loops", "do-while"]$$, 5);

-- Unit 6: 함수 (Functions) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-function-add$$, $$java$$, $$basics$$, 26, $$덧셈 함수$$, $$두 수를 더하는 함수 만들기$$, $$challenge$$, 1,
$$두 정수를 입력받아 합을 반환하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b) 형식으로 작성하세요$$,
$$[{"input": "3 5", "output": "8"}]$$,
$func$#include <stdio.h>

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", add(a, b));
    return 0;
}$func$,
$func$#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", add(a, b));
    return 0;
}$func$,
$$[{"input": "3 5", "expected": "8\n"}]$$,
$$["return a + b;"]$$,
$$["functions", "return"]$$, 5),

($$java-function-square$$, $$java$$, $$basics$$, 27, $$제곱 함수$$, $$숫자의 제곱을 구하는 함수 만들기$$, $$challenge$$, 1,
$$정수 n을 입력받아 n의 제곱을 반환하는 square 함수를 작성하세요.$$,
$$- int square(int n) 형식으로 작성하세요$$,
$$[{"input": "4", "output": "16"}]$$,
$func$#include <stdio.h>

// 여기에 square 함수를 작성하세요

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", square(n));
    return 0;
}$func$,
$func$#include <stdio.h>

int square(int n) {
    return n * n;
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", square(n));
    return 0;
}$func$,
$$[{"input": "4", "expected": "16\n"}]$$,
$$["return n * n;"]$$,
$$["functions", "return"]$$, 5),

($$java-function-void$$, $$java$$, $$basics$$, 28, $$void 함수$$, $$반환값이 없는 함수 만들기$$, $$challenge$$, 1,
$$문자열을 출력하는 void 타입의 greet 함수를 작성하세요. "Hello!"를 출력합니다.$$,
$$- void greet() 형식으로 작성하세요$$,
$$[{"input": "", "output": "Hello!"}]$$,
$func$#include <stdio.h>

// 여기에 greet 함수를 작성하세요

int main() {
    greet();
    return 0;
}$func$,
$func$#include <stdio.h>

void greet() {
    printf("Hello!\n");
}

int main() {
    greet();
    return 0;
}$func$,
$$[{"input": "", "expected": "Hello!\n"}]$$,
$$["void는 반환값이 없습니다"]$$,
$$["functions", "void"]$$, 5),

($$java-function-max$$, $$java$$, $$basics$$, 29, $$최댓값 함수$$, $$두 수 중 큰 수를 반환하는 함수$$, $$challenge$$, 1,
$$두 정수 중 큰 값을 반환하는 max 함수를 작성하세요.$$,
$$- if-else를 사용하세요$$,
$$[{"input": "7 12", "output": "12"}]$$,
$func$#include <stdio.h>

// 여기에 max 함수를 작성하세요

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", max(a, b));
    return 0;
}$func$,
$func$#include <stdio.h>

int max(int a, int b) {
    if (a > b) return a;
    else return b;
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", max(a, b));
    return 0;
}$func$,
$$[{"input": "7 12", "expected": "12\n"}]$$,
$$["조건에 따라 다른 값을 반환하세요"]$$,
$$["functions", "conditionals"]$$, 5),

($$java-function-is-even$$, $$java$$, $$basics$$, 30, $$짝수 판별 함수$$, $$짝수인지 판별하는 함수$$, $$challenge$$, 1,
$$정수 n이 짝수이면 1, 홀수이면 0을 반환하는 isEven 함수를 작성하세요.$$,
$$- % 연산자를 사용하세요$$,
$$[{"input": "4", "output": "1"}, {"input": "7", "output": "0"}]$$,
$func$#include <stdio.h>

// 여기에 isEven 함수를 작성하세요

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", isEven(n));
    return 0;
}$func$,
$func$#include <stdio.h>

int isEven(int n) {
    return n % 2 == 0;
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", isEven(n));
    return 0;
}$func$,
$$[{"input": "4", "expected": "1\n"}, {"input": "7", "expected": "0\n"}]$$,
$$["n % 2 == 0은 1(true) 또는 0(false)을 반환합니다"]$$,
$$["functions", "modulo"]$$, 5);

-- Unit 7: 배열 (Arrays) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-array-declare$$, $$java$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언하고 초기화하기$$, $$challenge$$, 1,
$$크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소를 출력하세요.$$,
$$- 배열 선언: int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 \n"}]$$,
$$["int arr[] = {1, 2, 3, 4, 5};"]$$,
$$["arrays", "basics"]$$, 5),

($$java-array-sum$$, $$java$$, $$basics$$, 32, $$배열 합계$$, $$배열 요소의 합 구하기$$, $$challenge$$, 1,
$$크기가 5인 배열의 모든 요소의 합을 계산하여 출력하세요.$$,
$$- for문을 사용하세요$$,
$$[{"input": "1 2 3 4 5", "output": "15"}]$$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    int sum = 0;
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
        sum += arr[i];
    }
    printf("%d\n", sum);
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5", "expected": "15\n"}]$$,
$$["sum += arr[i]로 누적하세요"]$$,
$$["arrays", "sum"]$$, 5),

($$java-array-max$$, $$java$$, $$basics$$, 33, $$배열 최댓값$$, $$배열에서 가장 큰 값 찾기$$, $$challenge$$, 1,
$$크기가 5인 배열에서 가장 큰 값을 찾아 출력하세요.$$,
$$- for문과 if문을 사용하세요$$,
$$[{"input": "3 7 2 9 5", "output": "9"}]$$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    int max = arr[0];
    for (int i = 1; i < 5; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    printf("%d\n", max);
    return 0;
}$func$,
$$[{"input": "3 7 2 9 5", "expected": "9\n"}]$$,
$$["첫 요소를 max로 설정하고 비교하세요"]$$,
$$["arrays", "max"]$$, 5),

($$java-array-reverse$$, $$java$$, $$basics$$, 34, $$배열 뒤집기$$, $$배열을 역순으로 출력하기$$, $$challenge$$, 1,
$$크기가 5인 배열을 입력받아 역순으로 출력하세요.$$,
$$- for문을 역순으로 돌리세요$$,
$$[{"input": "1 2 3 4 5", "output": "5 4 3 2 1"}]$$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    for (int i = 4; i >= 0; i--) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5", "expected": "5 4 3 2 1 \n"}]$$,
$$["i = 4부터 i >= 0까지 감소시키세요"]$$,
$$["arrays", "reverse"]$$, 5),

($$java-array-search$$, $$java$$, $$basics$$, 35, $$배열 검색$$, $$배열에서 특정 값 찾기$$, $$challenge$$, 1,
$$크기가 5인 배열과 찾을 값 target이 주어질 때, target이 배열에 있으면 인덱스를, 없으면 -1을 출력하세요.$$,
$$- for문과 if문을 사용하세요$$,
$$[{"input": "1 2 3 4 5\n3", "output": "2"}]$$,
$func$#include <stdio.h>

int main() {
    int arr[5], target;
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    scanf("%d", &target);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5], target;
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    scanf("%d", &target);
    int index = -1;
    for (int i = 0; i < 5; i++) {
        if (arr[i] == target) {
            index = i;
            break;
        }
    }
    printf("%d\n", index);
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5\n3", "expected": "2\n"}]$$,
$$["찾으면 break로 반복을 중단하세요"]$$,
$$["arrays", "search"]$$, 5);

-- Unit 8: 포인터 기초 (Pointers Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pointer-address$$, $$java$$, $$basics$$, 36, $$변수 주소 출력$$, $$변수의 메모리 주소 출력하기$$, $$challenge$$, 1,
$$정수 변수 num의 값과 주소를 출력하세요.$$,
$$- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요$$,
$$[{"input": "", "output": "Value: 10\nAddress: 0x..."}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num = 10;
    printf("Value: %d\n", num);
    printf("Address: %p\n", (void*)&num);
    return 0;
}$func$,
$$[{"input": "", "expected": "Value: 10\nAddress: "}]$$,
$$["&num은 num의 주소입니다"]$$,
$$["pointers", "address"]$$, 5),

($$java-pointer-declare$$, $$java$$, $$basics$$, 37, $$포인터 선언$$, $$포인터 변수 선언하고 사용하기$$, $$challenge$$, 1,
$$정수 변수 num과 그것을 가리키는 포인터 ptr을 선언하고, 포인터를 통해 값을 출력하세요.$$,
$$- int *ptr = &num;$$,
$$[{"input": "", "output": "20"}]$$,
$func$#include <stdio.h>

int main() {
    int num = 20;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num = 20;
    int *ptr = &num;
    printf("%d\n", *ptr);
    return 0;
}$func$,
$$[{"input": "", "expected": "20\n"}]$$,
$$["*ptr로 포인터가 가리키는 값을 얻습니다"]$$,
$$["pointers", "basics"]$$, 5),

($$java-pointer-modify$$, $$java$$, $$basics$$, 38, $$포인터로 값 수정$$, $$포인터를 통해 변수 값 변경하기$$, $$challenge$$, 1,
$$정수 변수 num=10을 포인터를 통해 30으로 변경하고 출력하세요.$$,
$$- *ptr = 30;$$,
$$[{"input": "", "output": "30"}]$$,
$func$#include <stdio.h>

int main() {
    int num = 10;
    int *ptr = &num;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num = 10;
    int *ptr = &num;
    *ptr = 30;
    printf("%d\n", num);
    return 0;
}$func$,
$$[{"input": "", "expected": "30\n"}]$$,
$$["*ptr = 30으로 값을 변경합니다"]$$,
$$["pointers", "modify"]$$, 5),

($$java-pointer-swap$$, $$java$$, $$basics$$, 39, $$포인터로 swap 함수$$, $$포인터를 이용한 swap 함수 만들기$$, $$challenge$$, 1,
$$두 정수의 값을 바꾸는 swap 함수를 포인터를 사용하여 작성하세요.$$,
$$- void swap(int *a, int *b)$$,
$$[{"input": "5 10", "output": "10 5"}]$$,
$func$#include <stdio.h>

// 여기에 swap 함수를 작성하세요

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    swap(&a, &b);
    printf("%d %d\n", a, b);
    return 0;
}$func$,
$func$#include <stdio.h>

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    swap(&a, &b);
    printf("%d %d\n", a, b);
    return 0;
}$func$,
$$[{"input": "5 10", "expected": "10 5\n"}]$$,
$$["임시 변수로 값을 바꾸세요"]$$,
$$["pointers", "functions"]$$, 5),

($$java-pointer-array$$, $$java$$, $$basics$$, 40, $$포인터와 배열$$, $$포인터로 배열 접근하기$$, $$challenge$$, 1,
$$배열을 포인터로 접근하여 모든 요소를 출력하세요.$$,
$$- *(arr + i) 또는 arr[i]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    int *ptr = arr;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    int *ptr = arr;
    for (int i = 0; i < 5; i++) {
        printf("%d ", *(ptr + i));
    }
    printf("\n");
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 \n"}]$$,
$$["배열 이름은 첫 요소의 주소입니다"]$$,
$$["pointers", "arrays"]$$, 5);

-- Unit 9: 입출력 (Input/Output) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-scanf-int$$, $$java$$, $$basics$$, 41, $$정수 입력받기$$, $$scanf로 정수 입력받기$$, $$challenge$$, 1,
$$정수 하나를 입력받아 그대로 출력하세요.$$,
$$- scanf("%d", &num);$$,
$$[{"input": "42", "output": "42"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    printf("%d\n", num);
    return 0;
}$func$,
$$[{"input": "42", "expected": "42\n"}]$$,
$$["&num으로 주소를 전달하세요"]$$,
$$["io", "scanf"]$$, 5),

($$java-scanf-multiple$$, $$java$$, $$basics$$, 42, $$여러 값 입력받기$$, $$여러 개의 값을 한 번에 입력받기$$, $$challenge$$, 1,
$$세 개의 정수를 입력받아 합을 출력하세요.$$,
$$- scanf("%d %d %d", &a, &b, &c);$$,
$$[{"input": "1 2 3", "output": "6"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    printf("%d\n", a + b + c);
    return 0;
}$func$,
$$[{"input": "1 2 3", "expected": "6\n"}]$$,
$$["공백으로 구분된 입력을 받을 수 있습니다"]$$,
$$["io", "scanf"]$$, 5),

($$java-printf-formatted$$, $$java$$, $$basics$$, 43, $$형식 지정 출력$$, $$printf로 형식을 지정하여 출력하기$$, $$challenge$$, 1,
$$정수와 실수를 입력받아 "Int: [정수], Float: [실수]" 형식으로 출력하세요.$$,
$$- 실수는 소수점 2자리까지$$,
$$[{"input": "10 3.14", "output": "Int: 10, Float: 3.14"}]$$,
$func$#include <stdio.h>

int main() {
    int num;
    float fnum;
    scanf("%d %f", &num, &fnum);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int num;
    float fnum;
    scanf("%d %f", &num, &fnum);
    printf("Int: %d, Float: %.2f\n", num, fnum);
    return 0;
}$func$,
$$[{"input": "10 3.14", "expected": "Int: 10, Float: 3.14\n"}]$$,
$$["%.2f는 소수점 2자리입니다"]$$,
$$["io", "printf", "format"]$$, 5),

($$java-getchar$$, $$java$$, $$basics$$, 44, $$문자 입력$$, $$getchar로 문자 입력받기$$, $$challenge$$, 1,
$$문자 하나를 입력받아 그대로 출력하세요.$$,
$$- char ch = getchar();$$,
$$[{"input": "A", "output": "A"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    char ch = getchar();
    putchar(ch);
    putchar('\n');
    return 0;
}$func$,
$$[{"input": "A", "expected": "A\n"}]$$,
$$["putchar로 문자를 출력할 수 있습니다"]$$,
$$["io", "getchar"]$$, 5),

($$java-fgets$$, $$java$$, $$basics$$, 45, $$문자열 입력$$, $$fgets로 문자열 입력받기$$, $$challenge$$, 1,
$$한 줄의 문자열을 입력받아 그대로 출력하세요.$$,
$$- fgets(str, sizeof(str), stdin);$$,
$$[{"input": "Hello World", "output": "Hello World"}]$$,
$func$#include <stdio.h>

int main() {
    char str[100];
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);
    printf("%s", str);
    return 0;
}$func$,
$$[{"input": "Hello World", "expected": "Hello World\n"}]$$,
$$["fgets는 줄바꿈도 포함합니다"]$$,
$$["io", "fgets", "string"]$$, 5);

-- Unit 10: 구조체 기초 (Structures Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-struct-declare$$, $$java$$, $$basics$$, 46, $$구조체 선언$$, $$구조체 정의하고 사용하기$$, $$challenge$$, 1,
$$이름(문자열)과 나이(정수)를 가진 Person 구조체를 정의하고 값을 출력하세요.$$,
$$- struct Person { char name[50]; int age; };$$,
$$[{"input": "", "output": "Name: John, Age: 25"}]$$,
$func$#include <stdio.h>
#include <string.h>

// 여기에 구조체를 정의하세요

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>

struct Person {
    char name[50];
    int age;
};

int main() {
    struct Person p;
    strcpy(p.name, "John");
    p.age = 25;
    printf("Name: %s, Age: %d\n", p.name, p.age);
    return 0;
}$func$,
$$[{"input": "", "expected": "Name: John, Age: 25\n"}]$$,
$$["struct로 구조체를 정의합니다"]$$,
$$["struct", "basics"]$$, 5),

($$java-struct-input$$, $$java$$, $$basics$$, 47, $$구조체 입력$$, $$구조체에 값 입력받기$$, $$challenge$$, 1,
$$Point 구조체(x, y 좌표)를 정의하고 값을 입력받아 출력하세요.$$,
$$- 출력 형식: (x, y)$$,
$$[{"input": "3 4", "output": "(3, 4)"}]$$,
$func$#include <stdio.h>

struct Point {
    int x;
    int y;
};

int main() {
    struct Point p;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

struct Point {
    int x;
    int y;
};

int main() {
    struct Point p;
    scanf("%d %d", &p.x, &p.y);
    printf("(%d, %d)\n", p.x, p.y);
    return 0;
}$func$,
$$[{"input": "3 4", "expected": "(3, 4)\n"}]$$,
$$["p.x, p.y로 멤버에 접근하세요"]$$,
$$["struct", "input"]$$, 5),

($$java-struct-array$$, $$java$$, $$basics$$, 48, $$구조체 배열$$, $$구조체 배열 사용하기$$, $$challenge$$, 1,
$$Student 구조체(이름, 점수) 3개를 배열로 선언하고 평균 점수를 계산하세요.$$,
$$- 구조체 배열: struct Student students[3];$$,
$$[{"input": "Alice 90\nBob 80\nCharlie 85", "output": "85"}]$$,
$func$#include <stdio.h>

struct Student {
    char name[50];
    int score;
};

int main() {
    struct Student students[3];
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

struct Student {
    char name[50];
    int score;
};

int main() {
    struct Student students[3];
    int sum = 0;
    for (int i = 0; i < 3; i++) {
        scanf("%s %d", students[i].name, &students[i].score);
        sum += students[i].score;
    }
    printf("%d\n", sum / 3);
    return 0;
}$func$,
$$[{"input": "Alice 90\nBob 80\nCharlie 85", "expected": "85\n"}]$$,
$$["배열로 여러 구조체를 관리할 수 있습니다"]$$,
$$["struct", "array"]$$, 5),

($$java-struct-pointer$$, $$java$$, $$basics$$, 49, $$구조체 포인터$$, $$구조체 포인터 사용하기$$, $$challenge$$, 1,
$$Rectangle 구조체(width, height)의 포인터를 사용하여 넓이를 계산하세요.$$,
$$- ptr->width 형식으로 접근$$,
$$[{"input": "5 10", "output": "50"}]$$,
$func$#include <stdio.h>

struct Rectangle {
    int width;
    int height;
};

int main() {
    struct Rectangle r;
    struct Rectangle *ptr = &r;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

struct Rectangle {
    int width;
    int height;
};

int main() {
    struct Rectangle r;
    struct Rectangle *ptr = &r;
    scanf("%d %d", &ptr->width, &ptr->height);
    printf("%d\n", ptr->width * ptr->height);
    return 0;
}$func$,
$$[{"input": "5 10", "expected": "50\n"}]$$,
$$["-> 연산자로 포인터를 통해 멤버에 접근합니다"]$$,
$$["struct", "pointer"]$$, 5),

($$java-struct-typedef$$, $$java$$, $$basics$$, 50, $$typedef 사용$$, $$typedef로 구조체 간단히 사용하기$$, $$challenge$$, 1,
$$typedef를 사용하여 Book 구조체(title, price)를 정의하고 사용하세요.$$,
$$- typedef struct { ... } Book;$$,
$$[{"input": "C_Programming 30", "output": "Title: C_Programming, Price: 30"}]$$,
$func$#include <stdio.h>

// 여기에 typedef 구조체를 정의하세요

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

typedef struct {
    char title[50];
    int price;
} Book;

int main() {
    Book b;
    scanf("%s %d", b.title, &b.price);
    printf("Title: %s, Price: %d\n", b.title, b.price);
    return 0;
}$func$,
$$[{"input": "C_Programming 30", "expected": "Title: C_Programming, Price: 30\n"}]$$,
$$["typedef를 사용하면 struct 키워드 없이 사용 가능합니다"]$$,
$$["struct", "typedef"]$$, 5);

-- ============================================================================
-- End of Java Language Part 1
-- ============================================================================

-- ============================================================================
-- Java Language Challenges - Part 2 (Medium & Hard)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: MEDIUM (2) for Units 1-6, HARD (3) for Units 7-10
-- ============================================================================

-- Unit 1: 출력과 주석 (Output and Comments) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pattern-triangle$$, $$java$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            printf("*");
        }
        printf("\n");
    }
    return 0;
}$func$,
$func$[{"input": "3", "expected": "*\n**\n***\n"}, {"input": "5", "expected": "*\n**\n***\n****\n*****\n"}]$func$,
$$["바깥 루프는 줄 수, 안쪽 루프는 별의 개수입니다"]$$,
$$["loops", "pattern", "nested"]$$, 10),

($$java-pyramid-pattern$$, $$java$$, $$syntax$$, 52, $$피라미드 패턴$$, $$공백과 별표로 피라미드 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 피라미드를 출력하세요.\n예: N=3일 때\n  *\n ***\n*****$$,
$$- 공백과 별표 계산 필요\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "  *\n ***\n*****"}]$$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < n - i; j++) {
            printf(" ");
        }
        for (int j = 0; j < 2 * i - 1; j++) {
            printf("*");
        }
        printf("\n");
    }
    return 0;
}$func$,
$$[{"input": "3", "expected": "  *\n ***\n*****\n"}]$$,
$$["각 줄의 공백 수와 별 수를 계산하세요"]$$,
$$["loops", "pattern", "pyramid"]$$, 15),

($$java-diamond-pattern$$, $$java$$, $$syntax$$, 53, $$다이아몬드 패턴$$, $$다이아몬드 모양 그리기$$, $$challenge$$, 2,
$$홀수 N이 주어질 때, N줄의 다이아몬드를 출력하세요.$$,
$$- 상단 절반과 하단 절반으로 나누어 생각\n- N은 홀수$$,
$$[{"input": "5", "output": "  *\n ***\n*****\n ***\n  *"}]$$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int mid = n / 2 + 1;

    // 상단
    for (int i = 1; i <= mid; i++) {
        for (int j = 0; j < mid - i; j++) printf(" ");
        for (int j = 0; j < 2 * i - 1; j++) printf("*");
        printf("\n");
    }

    // 하단
    for (int i = mid - 1; i >= 1; i--) {
        for (int j = 0; j < mid - i; j++) printf(" ");
        for (int j = 0; j < 2 * i - 1; j++) printf("*");
        printf("\n");
    }

    return 0;
}$func$,
$$[{"input": "5", "expected": "  *\n ***\n*****\n ***\n  *\n"}]$$,
$$["중간 지점을 기준으로 상하로 나누세요"]$$,
$$["loops", "pattern", "diamond"]$$, 15),

($$java-formatted-table$$, $$java$$, $$syntax$$, 54, $$테이블 형식 출력$$, $$정렬된 테이블 출력하기$$, $$challenge$$, 2,
$$N개의 숫자를 입력받아 3열로 정렬하여 출력하세요.$$,
$$- 각 열의 너비는 5칸\n- 오른쪽 정렬$$,
$$[{"input": "6\n1 22 333 4 55 666", "output": "    1   22  333\n    4   55  666"}]$$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    for (int i = 0; i < n; i++) {
        printf("%5d", arr[i]);
        if ((i + 1) % 3 == 0) printf("\n");
    }
    if (n % 3 != 0) printf("\n");

    return 0;
}$func$,
$$[{"input": "6\n1 22 333 4 55 666", "expected": "    1   22  333\n    4   55  666\n"}]$$,
$$["%5d는 5칸 오른쪽 정렬입니다"]$$,
$$["output", "formatting", "alignment"]$$, 10),

($$java-ascii-art$$, $$java$$, $$syntax$$, 55, $$ASCII 아트$$, $$ASCII 문자로 그림 그리기$$, $$challenge$$, 2,
$$입력받은 문자로 5x5 사각형 테두리를 그리세요.$$,
$$- 테두리만 입력 문자로, 내부는 공백$$,
$$[{"input": "#", "output": "#####\n#   #\n#   #\n#   #\n#####"}]$$,
$func$#include <stdio.h>

int main() {
    char ch;
    scanf("%c", &ch);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    char ch;
    scanf("%c", &ch);

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (i == 0 || i == 4 || j == 0 || j == 4) {
                printf("%c", ch);
            } else {
                printf(" ");
            }
        }
        printf("\n");
    }

    return 0;
}$func$,
$$[{"input": "#", "expected": "#####\n#   #\n#   #\n#   #\n#####\n"}]$$,
$$["테두리 조건: 첫/마지막 행 또는 첫/마지막 열"]$$,
$$["pattern", "ascii", "loops"]$$, 15);

-- Unit 2: 변수와 자료형 (Variables and Data Types) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-bit-operations$$, $$java$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", a & b);
    printf("%d\n", a | b);
    printf("%d\n", a ^ b);
    return 0;
}$func$,
$$[{"input": "12 10", "expected": "8\n14\n6\n"}]$$,
$$["& (AND), | (OR), ^ (XOR)"]$$,
$$["bitwise", "operators"]$$, 10),

($$java-sizeof-types$$, $$java$$, $$basics$$, 57, $$자료형 크기$$, $$다양한 자료형의 크기 출력하기$$, $$challenge$$, 2,
$$char, int, float, double의 크기를 바이트 단위로 출력하세요.$$,
$$- sizeof 연산자 사용$$,
$$[{"input": "", "output": "1\n4\n4\n8"}]$$,
$func$#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    printf("%zu\n", sizeof(char));
    printf("%zu\n", sizeof(int));
    printf("%zu\n", sizeof(float));
    printf("%zu\n", sizeof(double));
    return 0;
}$func$,
$$[{"input": "", "expected": "1\n4\n4\n8\n"}]$$,
$$["sizeof는 바이트 크기를 반환합니다"]$$,
$$["sizeof", "data-types"]$$, 10),

($$java-type-casting$$, $$java$$, $$basics$$, 58, $$타입 캐스팅$$, $$명시적 타입 변환하기$$, $$challenge$$, 2,
$$정수 나눗셈과 실수 나눗셈 결과를 각각 출력하세요.$$,
$$- (float) 캐스팅 사용\n- 소수점 2자리$$,
$$[{"input": "7 2", "output": "3\n3.50"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", a / b);
    printf("%.2f\n", (float)a / b);
    return 0;
}$func$,
$$[{"input": "7 2", "expected": "3\n3.50\n"}]$$,
$$["정수 나눗셈은 소수점을 버립니다"]$$,
$$["casting", "division"]$$, 10),

($$java-const-variables$$, $$java$$, $$basics$$, 59, $$상수 사용$$, $$const 키워드로 상수 선언하기$$, $$challenge$$, 2,
$$원의 반지름을 입력받아 둘레와 넓이를 계산하세요. (PI는 상수로 정의)$$,
$$- const double PI = 3.14159;\n- 소수점 2자리$$,
$$[{"input": "5", "output": "31.42\n78.54"}]$$,
$func$#include <stdio.h>

int main() {
    const double PI = 3.14159;
    int r;
    scanf("%d", &r);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    const double PI = 3.14159;
    int r;
    scanf("%d", &r);
    printf("%.2f\n", 2 * PI * r);
    printf("%.2f\n", PI * r * r);
    return 0;
}$func$,
$$[{"input": "5", "expected": "31.42\n78.54\n"}]$$,
$$["const는 값을 변경할 수 없게 합니다"]$$,
$$["const", "math"]$$, 10),

($$java-enum-weekday$$, $$java$$, $$basics$$, 60, $$열거형 사용$$, $$enum으로 요일 표현하기$$, $$challenge$$, 2,
$$0-6의 숫자를 입력받아 해당하는 요일을 출력하세요.$$,
$$- enum 사용\n- 0=MON, 1=TUE, ..., 6=SUN$$,
$$[{"input": "0", "output": "MON"}, {"input": "3", "output": "THU"}]$$,
$func$#include <stdio.h>

enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN };

int main() {
    int day;
    scanf("%d", &day);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN };

int main() {
    int day;
    scanf("%d", &day);
    const char *days[] = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
    printf("%s\n", days[day]);
    return 0;
}$func$,
$$[{"input": "0", "expected": "MON\n"}, {"input": "3", "expected": "THU\n"}]$$,
$$["enum은 0부터 시작하는 정수값입니다"]$$,
$$["enum", "array"]$$, 10);

-- Unit 3: 연산자 (Operators) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-compound-interest$$, $$java$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;
    int n;
    scanf("%lf %lf %d", &P, &r, &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    double P, r;
    int n;
    scanf("%lf %lf %d", &P, &r, &n);
    double amount = P * pow(1 + r / 100, n);
    printf("%.2f\n", amount);
    return 0;
}$func$,
$$[{"input": "1000 5 3", "expected": "1157.63\n"}]$$,
$$["pow(base, exponent)로 거듭제곱을 계산합니다"]$$,
$$["math", "pow", "operators"]$$, 15),

($$java-increment-decrement$$, $$java$$, $$basics$$, 62, $$증감 연산자$$, $$전위/후위 증감 연산자 이해하기$$, $$challenge$$, 2,
$$정수 x가 주어질 때, ++x, x++, --x, x--의 결과를 순서대로 출력하세요.$$,
$$- 각 연산 후 x값도 변경됨$$,
$$[{"input": "5", "output": "6\n6\n6\n6"}]$$,
$func$#include <stdio.h>

int main() {
    int x;
    scanf("%d", &x);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int x;
    scanf("%d", &x);
    printf("%d\n", ++x);  // 6
    printf("%d\n", x++);  // 6 (출력 후 증가)
    printf("%d\n", --x);  // 6 (다시 감소)
    printf("%d\n", x--);  // 6 (출력 후 감소)
    return 0;
}$func$,
$$[{"input": "5", "expected": "6\n6\n6\n6\n"}]$$,
$$["전위는 먼저 증가/감소, 후위는 나중에 증가/감소"]$$,
$$["operators", "increment"]$$, 10),

($$java-ternary-operator$$, $$java$$, $$basics$$, 63, $$삼항 연산자$$, $$조건 연산자로 간결한 코드 작성$$, $$challenge$$, 2,
$$세 정수 a, b, c가 주어질 때, 가장 큰 값을 삼항 연산자로 찾아 출력하세요.$$,
$$- ? : 연산자 사용\n- 중첩 삼항 연산자$$,
$$[{"input": "5 8 3", "output": "8"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    int max = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
    printf("%d\n", max);
    return 0;
}$func$,
$$[{"input": "5 8 3", "expected": "8\n"}]$$,
$$["조건 ? 참일때값 : 거짓일때값"]$$,
$$["operators", "ternary"]$$, 10),

($$java-bitwise-shift$$, $$java$$, $$basics$$, 64, $$비트 시프트$$, $$좌측/우측 시프트 연산$$, $$challenge$$, 2,
$$정수 n과 k가 주어질 때, n을 왼쪽으로 k번, 오른쪽으로 k번 시프트한 결과를 출력하세요.$$,
$$- << 와 >> 연산자$$,
$$[{"input": "8 2", "output": "32\n2"}]$$,
$func$#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    printf("%d\n", n << k);
    printf("%d\n", n >> k);
    return 0;
}$func$,
$$[{"input": "8 2", "expected": "32\n2\n"}]$$,
$$["왼쪽 시프트는 2배씩, 오른쪽은 2로 나누기"]$$,
$$["bitwise", "shift"]$$, 10),

($$java-gcd-lcm$$, $$java$$, $$basics$$, 65, $$최대공약수와 최소공배수$$, $$GCD와 LCM 구하기$$, $$challenge$$, 2,
$$두 정수의 최대공약수(GCD)와 최소공배수(LCM)를 구하세요.$$,
$$- 유클리드 호제법 사용\n- LCM = (a * b) / GCD$$,
$$[{"input": "12 18", "output": "6\n36"}]$$,
$func$#include <stdio.h>

int gcd(int a, int b) {
    // 여기에 GCD 함수를 작성하세요
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int g = gcd(a, b);
    printf("%d\n", g);
    printf("%d\n", (a * b) / g);
    return 0;
}$func$,
$func$#include <stdio.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int g = gcd(a, b);
    printf("%d\n", g);
    printf("%d\n", (a * b) / g);
    return 0;
}$func$,
$$[{"input": "12 18", "expected": "6\n36\n"}]$$,
$$["GCD(a, b) = GCD(b, a % b)"]$$,
$$["math", "gcd", "algorithm"]$$, 15);

-- Unit 4: 조건문 (Conditional Statements) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-leap-year$$, $$java$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <stdio.h>

int main() {
    int year;
    scanf("%d", &year);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int year;
    scanf("%d", &year);
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        printf("Leap\n");
    } else {
        printf("Common\n");
    }
    return 0;
}$func$,
$$[{"input": "2000", "expected": "Leap\n"}, {"input": "1900", "expected": "Common\n"}]$$,
$$["논리 연산자를 조합하세요"]$$,
$$["conditionals", "logic"]$$, 10),

($$java-triangle-type$$, $$java$$, $$basics$$, 67, $$삼각형 종류$$, $$세 변의 길이로 삼각형 종류 판별$$, $$challenge$$, 2,
$func$세 변 a, b, c가 주어질 때, 정삼각형(Equilateral), 이등변삼각형(Isosceles), 부등변삼각형(Scalene), 또는 삼각형 아님(Not a triangle)을 출력하세요.$func$,
$$- 삼각형 성립 조건: 두 변의 합 > 나머지 한 변$$,
$$[{"input": "3 3 3", "output": "Equilateral"}, {"input": "3 3 5", "output": "Isosceles"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);

    if (a + b <= c || b + c <= a || a + c <= b) {
        printf("Not a triangle\n");
    } else if (a == b && b == c) {
        printf("Equilateral\n");
    } else if (a == b || b == c || a == c) {
        printf("Isosceles\n");
    } else {
        printf("Scalene\n");
    }

    return 0;
}$func$,
$$[{"input": "3 3 3", "expected": "Equilateral\n"}, {"input": "3 3 5", "expected": "Isosceles\n"}]$$,
$$["먼저 삼각형이 성립하는지 확인하세요"]$$,
$$["conditionals", "geometry"]$$, 15),

($$java-quadrant$$, $$java$$, $$basics$$, 68, $$사분면 판별$$, $$좌표의 사분면 결정하기$$, $$challenge$$, 2,
$$점 (x, y)가 주어질 때, 어느 사분면에 속하는지 출력하세요.\n1, 2, 3, 4 중 하나 또는 "Axis"(축 위)$$,
$$- x축, y축 위도 고려$$,
$$[{"input": "5 3", "output": "1"}, {"input": "-2 4", "output": "2"}]$$,
$func$#include <stdio.h>

int main() {
    int x, y;
    scanf("%d %d", &x, &y);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int x, y;
    scanf("%d %d", &x, &y);

    if (x == 0 || y == 0) {
        printf("Axis\n");
    } else if (x > 0 && y > 0) {
        printf("1\n");
    } else if (x < 0 && y > 0) {
        printf("2\n");
    } else if (x < 0 && y < 0) {
        printf("3\n");
    } else {
        printf("4\n");
    }

    return 0;
}$func$,
$$[{"input": "5 3", "expected": "1\n"}, {"input": "-2 4", "expected": "2\n"}]$$,
$$["x, y의 부호를 확인하세요"]$$,
$$["conditionals", "math"]$$, 10),

($$java-bmi-calculator$$, $$java$$, $$basics$$, 69, $$BMI 계산기$$, $$체질량지수로 비만도 판정$$, $$challenge$$, 2,
$func$체중(kg)과 키(cm)가 주어질 때, BMI를 계산하고 등급을 출력하세요.\nBMI = 체중 / (키/100)²\n18.5 미만: Underweight, 18.5-25: Normal, 25-30: Overweight, 30 이상: Obese$func$,
$$- 소수점 계산 주의$$,
$$[{"input": "70 175", "output": "Normal"}]$$,
$func$#include <stdio.h>

int main() {
    double weight, height;
    scanf("%lf %lf", &weight, &height);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    double weight, height;
    scanf("%lf %lf", &weight, &height);

    double bmi = weight / ((height / 100) * (height / 100));

    if (bmi < 18.5) {
        printf("Underweight\n");
    } else if (bmi < 25) {
        printf("Normal\n");
    } else if (bmi < 30) {
        printf("Overweight\n");
    } else {
        printf("Obese\n");
    }

    return 0;
}$func$,
$$[{"input": "70 175", "expected": "Normal\n"}]$$,
$$["키를 미터로 변환하세요"]$$,
$$["conditionals", "math", "health"]$$, 10),

($$java-switch-calculator$$, $$java$$, $$basics$$, 70, $$Switch 계산기$$, $$switch문으로 계산기 만들기$$, $$challenge$$, 2,
$$두 정수 a, b와 연산자(+, -, *, /)가 주어질 때, 결과를 출력하세요.$$,
$$- switch 문 사용\n- 나눗셈은 정수 나눗셈$$,
$$[{"input": "10 5 +", "output": "15"}, {"input": "10 3 /", "output": "3"}]$$,
$func$#include <stdio.h>

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    switch (op) {
        case '+':
            printf("%d\n", a + b);
            break;
        case '-':
            printf("%d\n", a - b);
            break;
        case '*':
            printf("%d\n", a * b);
            break;
        case '/':
            printf("%d\n", a / b);
            break;
    }

    return 0;
}$func$,
$func$[{"input": "10 5 +", "expected": "15\n"}, {"input": "10 3 /", "expected": "3\n"}]$func$,
$func$["switch는 정수/문자 값으로 분기합니다"]$func$,
$$["switch", "calculator"]$$, 10);

-- Unit 5: 반복문 (Loops) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-fibonacci$$, $$java$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);

    int a = 1, b = 1;
    if (n == 1 || n == 2) {
        printf("1\n");
    } else {
        for (int i = 3; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        printf("%d\n", b);
    }

    return 0;
}$func$,
$func$[{"input": "7", "expected": "13\n"}]$func$,
$func$["이전 두 값을 유지하세요"]$func$,
$$["loops", "fibonacci", "sequence"]$$, 15),

($$java-prime-check$$, $$java$$, $$basics$$, 72, $$소수 판별$$, $$소수인지 확인하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 소수이면 "Prime", 아니면 "Not Prime"을 출력하세요.$func$,
$func$- 2부터 √N까지 나누어떨어지는지 확인\n- N ≥ 2$func$,
$func$[{"input": "17", "output": "Prime"}, {"input": "20", "output": "Not Prime"}]$func$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);

    if (n < 2) {
        printf("Not Prime\n");
        return 0;
    }

    int isPrime = 1;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i == 0) {
            isPrime = 0;
            break;
        }
    }

    printf("%s\n", isPrime ? "Prime" : "Not Prime");
    return 0;
}$func$,
$func$[{"input": "17", "expected": "Prime\n"}, {"input": "20", "expected": "Not Prime\n"}]$func$,
$func$["sqrt(n)까지만 확인하면 됩니다"]$func$,
$$["loops", "prime", "math"]$$, 15),

($$java-digit-sum$$, $$java$$, $$basics$$, 73, $$자릿수 합$$, $$각 자릿수의 합 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 각 자릿수의 합을 구하세요.$func$,
$func$- % 10으로 마지막 자리 추출\n- / 10으로 자릿수 제거$func$,
$func$[{"input": "12345", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);

    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }

    printf("%d\n", sum);
    return 0;
}$func$,
$func$[{"input": "12345", "expected": "15\n"}]$func$,
$func$["반복하면서 자릿수를 줄여가세요"]$func$,
$$["loops", "digits", "math"]$$, 10),

($$java-reverse-number$$, $$java$$, $$basics$$, 74, $$숫자 뒤집기$$, $$숫자를 거꾸로 만들기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 자릿수를 거꾸로 뒤집은 수를 출력하세요.$func$,
$func$- 1230 → 321 (앞의 0은 무시)$func$,
$func$[{"input": "12345", "output": "54321"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);

    int reversed = 0;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }

    printf("%d\n", reversed);
    return 0;
}$func$,
$func$[{"input": "12345", "expected": "54321\n"}]$func$,
$func$["역순 수를 10배 하고 마지막 자리를 더하세요"]$func$,
$$["loops", "digits"]$$, 10),

($$java-collatz-conjecture$$, $$java$$, $$basics$$, 75, $$콜라츠 추측$$, $$1이 될 때까지의 단계 수$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 1이 될 때까지의 단계 수를 출력하세요.\n짝수: N/2, 홀수: 3N+1$func$,
$func$- N ≥ 1$func$,
$func$[{"input": "6", "output": "8"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);

    int count = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        count++;
    }

    printf("%d\n", count);
    return 0;
}$func$,
$func$[{"input": "6", "expected": "8\n"}]$func$,
$func$["단계마다 카운트를 증가시키세요"]$func$,
$$["loops", "algorithm", "math"]$$, 15);

-- Unit 6: 함수 (Functions) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-factorial-function$$, $$java$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <stdio.h>

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", factorial(n));
    return 0;
}$func$,
$func$#include <stdio.h>

int factorial(int n) {
    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", factorial(n));
    return 0;
}$func$,
$func$[{"input": "5", "expected": "120\n"}]$func$,
$func$["1부터 n까지 곱하세요"]$func$,
$$["functions", "factorial", "math"]$$, 10),

($$java-recursive-fibonacci$$, $$java$$, $$basics$$, 77, $$재귀 피보나치$$, $$재귀 함수로 피보나치 수 구하기$$, $$challenge$$, 2,
$func$재귀 함수를 사용하여 N번째 피보나치 수를 구하세요.$func$,
$func$- int fib(int n)\n- 재귀 호출$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <stdio.h>

// 여기에 fib 함수를 작성하세요

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", fib(n));
    return 0;
}$func$,
$func$#include <stdio.h>

int fib(int n) {
    if (n <= 2) return 1;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", fib(n));
    return 0;
}$func$,
$func$[{"input": "7", "expected": "13\n"}]$func$,
$func$["기저 사례와 재귀 호출을 구현하세요"]$func$,
$$["functions", "recursion", "fibonacci"]$$, 15),

($$java-power-function$$, $$java$$, $$basics$$, 78, $$거듭제곱 함수$$, $$base^exponent 계산하기$$, $$challenge$$, 2,
$func$base와 exponent가 주어질 때, base^exponent를 계산하는 함수를 작성하세요.$func$,
$func$- int power(int base, int exp)\n- 반복문 사용$func$,
$func$[{"input": "2 10", "output": "1024"}]$func$,
$func$#include <stdio.h>

// 여기에 power 함수를 작성하세요

int main() {
    int base, exp;
    scanf("%d %d", &base, &exp);
    printf("%d\n", power(base, exp));
    return 0;
}$func$,
$func$#include <stdio.h>

int power(int base, int exp) {
    int result = 1;
    for (int i = 0; i < exp; i++) {
        result *= base;
    }
    return result;
}

int main() {
    int base, exp;
    scanf("%d %d", &base, &exp);
    printf("%d\n", power(base, exp));
    return 0;
}$func$,
$func$[{"input": "2 10", "expected": "1024\n"}]$func$,
$func$["base를 exp번 곱하세요"]$func$,
$$["functions", "power", "math"]$$, 10),

($$java-array-function$$, $$java$$, $$basics$$, 79, $$배열 함수$$, $$배열을 함수로 전달하기$$, $$challenge$$, 2,
$func$배열과 크기를 입력받아 평균을 계산하는 함수를 작성하세요.$func$,
$func$- double average(int arr[], int size)$func$,
$func$[{"input": "5\n10 20 30 40 50", "output": "30.00"}]$func$,
$func$#include <stdio.h>

// 여기에 average 함수를 작성하세요

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    printf("%.2f\n", average(arr, n));
    return 0;
}$func$,
$func$#include <stdio.h>

double average(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return (double)sum / size;
}

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    printf("%.2f\n", average(arr, n));
    return 0;
}$func$,
$func$[{"input": "5\n10 20 30 40 50", "expected": "30.00\n"}]$func$,
$func$["배열은 포인터로 전달됩니다"]$func$,
$$["functions", "arrays", "average"]$$, 15),

($$java-pass-by-reference$$, $$java$$, $$basics$$, 80, $$참조로 전달$$, $$포인터로 값 변경하기$$, $$challenge$$, 2,
$func$두 정수의 합과 차를 동시에 구하는 함수를 작성하세요.$func$,
$func$- void calculate(int a, int b, int *sum, int *diff)$func$,
$func$[{"input": "10 3", "output": "13\n7"}]$func$,
$func$#include <stdio.h>

// 여기에 calculate 함수를 작성하세요

int main() {
    int a, b, sum, diff;
    scanf("%d %d", &a, &b);
    calculate(a, b, &sum, &diff);
    printf("%d\n%d\n", sum, diff);
    return 0;
}$func$,
$func$#include <stdio.h>

void calculate(int a, int b, int *sum, int *diff) {
    *sum = a + b;
    *diff = a - b;
}

int main() {
    int a, b, sum, diff;
    scanf("%d %d", &a, &b);
    calculate(a, b, &sum, &diff);
    printf("%d\n%d\n", sum, diff);
    return 0;
}$func$,
$func$[{"input": "10 3", "expected": "13\n7\n"}]$func$,
$func$["포인터를 통해 값을 변경하세요"]$func$,
$$["functions", "pointers", "pass-by-reference"]$$, 15);

-- Unit 7: 배열 (Arrays) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-bubble-sort$$, $$java$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 버블 정렬 코드를 작성하세요

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$func$[{"input": "5\n64 34 25 12 22", "expected": "12 22 25 34 64 \n"}]$func$,
$func$["중첩 루프로 인접 원소를 비교하세요"]$func$,
$$["arrays", "sorting", "bubble-sort"]$$, 20),

($$java-binary-search$$, $$java$$, $$advanced$$, 82, $$이진 탐색$$, $$정렬된 배열에서 값 찾기$$, $$challenge$$, 3,
$func$정렬된 배열에서 target을 이진 탐색으로 찾아 인덱스를 반환하세요. 없으면 -1$func$,
$func$- 중간값과 비교하여 탐색 범위를 절반씩 줄임$func$,
$func$[{"input": "5\n1 3 5 7 9\n5", "output": "2"}]$func$,
$func$#include <stdio.h>

int binarySearch(int arr[], int size, int target) {
    // 여기에 이진 탐색 코드를 작성하세요
}

int main() {
    int n, target;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    scanf("%d", &target);
    printf("%d\n", binarySearch(arr, n, target));
    return 0;
}$func$,
$func$#include <stdio.h>

int binarySearch(int arr[], int size, int target) {
    int left = 0, right = size - 1;
    while (left <= right) {
        int mid = (left + right) / 2;
        if (arr[mid] == target) return mid;
        else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1;
}

int main() {
    int n, target;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    scanf("%d", &target);
    printf("%d\n", binarySearch(arr, n, target));
    return 0;
}$func$,
$func$[{"input": "5\n1 3 5 7 9\n5", "expected": "2\n"}]$func$,
$func$["left, right 포인터로 범위를 좁혀가세요"]$func$,
$$["arrays", "search", "binary-search"]$$, 20),

($$java-2d-array-transpose$$, $$java$$, $$advanced$$, 83, $$행렬 전치$$, $$2차원 배열 전치하기$$, $$challenge$$, 3,
$func$N×M 행렬을 전치(행과 열을 바꿈)하여 출력하세요.$func$,
$func$- 2 ≤ N, M ≤ 10$func$,
$func$[{"input": "2 3\n1 2 3\n4 5 6", "output": "1 4\n2 5\n3 6"}]$func$,
$func$#include <stdio.h>

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    int arr[10][10];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &arr[i][j]);
        }
    }
    // 여기에 전치 및 출력 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    int arr[10][10];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &arr[i][j]);
        }
    }

    for (int j = 0; j < m; j++) {
        for (int i = 0; i < n; i++) {
            printf("%d ", arr[i][j]);
        }
        printf("\n");
    }

    return 0;
}$func$,
$func$[{"input": "2 3\n1 2 3\n4 5 6", "expected": "1 4 \n2 5 \n3 6 \n"}]$func$,
$func$["행과 열의 인덱스를 바꿔서 출력하세요"]$func$,
$$["arrays", "2d-array", "matrix"]$$, 20),

($$java-array-rotation$$, $$java$$, $$advanced$$, 84, $$배열 회전$$, $$배열을 K번 회전하기$$, $$challenge$$, 3,
$func$N개의 정수 배열을 왼쪽으로 K번 회전하세요.$func$,
$func$- 회전: [1,2,3,4,5]를 1번 회전 → [2,3,4,5,1]$func$,
$func$[{"input": "5 2\n1 2 3 4 5", "output": "3 4 5 1 2"}]$func$,
$func$#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 회전 코드를 작성하세요

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int arr[100], temp[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    k = k % n;  // k가 n보다 클 경우 대비
    for (int i = 0; i < n; i++) {
        temp[i] = arr[(i + k) % n];
    }
    for (int i = 0; i < n; i++) {
        arr[i] = temp[i];
    }

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}$func$,
$func$[{"input": "5 2\n1 2 3 4 5", "expected": "3 4 5 1 2 \n"}]$func$,
$func$["임시 배열을 사용하거나 % 연산으로 인덱스 계산"]$func$,
$$["arrays", "rotation"]$$, 25),

($$java-subarray-sum$$, $$java$$, $$advanced$$, 85, $$부분 배열 합$$, $$연속된 부분 배열의 최대 합$$, $$challenge$$, 3,
$func$N개의 정수 배열에서 연속된 부분 배열의 합 중 최댓값을 구하세요. (카데인 알고리즘)$func$,
$func$- 음수 포함 가능\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "output": "6"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // 여기에 카데인 알고리즘을 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    int maxSum = arr[0];
    int currentSum = arr[0];

    for (int i = 1; i < n; i++) {
        currentSum = (currentSum + arr[i] > arr[i]) ? currentSum + arr[i] : arr[i];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    printf("%d\n", maxSum);
    return 0;
}$func$,
$func$[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "expected": "6\n"}]$func$,
$func$["현재까지의 합 vs 새로 시작, 둘 중 큰 값 선택"]$func$,
$$["arrays", "kadane", "algorithm"]$$, 30);

-- Unit 8: 포인터 (Pointers) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-pointer-arithmetic$$, $$java$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    int *ptr = arr;
    // 여기에 포인터 산술로 합을 구하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    int *ptr = arr;
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += *(ptr + i);
    }

    printf("%d\n", sum);
    return 0;
}$func$,
$func$[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]$func$,
$func$["ptr + i는 i번째 요소의 주소입니다"]$func$,
$$["pointers", "arithmetic"]$$, 20),

($$java-double-pointer$$, $$java$$, $$advanced$$, 87, $$이중 포인터$$, $$포인터의 포인터 사용하기$$, $$challenge$$, 3,
$func$이중 포인터를 사용하여 두 포인터가 가리키는 값을 교환하세요.$func$,
$func$- void swap(int **pp1, int **pp2)$func$,
$func$[{"input": "10 20", "output": "20 10"}]$func$,
$func$#include <stdio.h>

void swap(int **pp1, int **pp2) {
    // 여기에 이중 포인터로 교환하는 코드를 작성하세요
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int *p1 = &a, *p2 = &b;
    swap(&p1, &p2);
    printf("%d %d\n", *p1, *p2);
    return 0;
}$func$,
$func$#include <stdio.h>

void swap(int **pp1, int **pp2) {
    int *temp = *pp1;
    *pp1 = *pp2;
    *pp2 = temp;
}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int *p1 = &a, *p2 = &b;
    swap(&p1, &p2);
    printf("%d %d\n", *p1, *p2);
    return 0;
}$func$,
$func$[{"input": "10 20", "expected": "20 10\n"}]$func$,
$func$["**pp는 포인터가 가리키는 포인터가 가리키는 값"]$func$,
$$["pointers", "double-pointer"]$$, 25),

($$java-function-pointer$$, $$java$$, $$advanced$$, 88, $$함수 포인터$$, $$함수 포인터로 연산 선택$$, $$challenge$$, 3,
$func$함수 포인터를 사용하여 사칙연산을 선택적으로 수행하세요.$func$,
$func$- int (*operation)(int, int)$func$,
$func$[{"input": "10 5 +", "output": "15"}]$func$,
$func$#include <stdio.h>

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    // 여기에 함수 포인터를 사용하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return a / b; }

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    int (*operation)(int, int);

    switch (op) {
        case '+': operation = add; break;
        case '-': operation = subtract; break;
        case '*': operation = multiply; break;
        case '/': operation = divide; break;
    }

    printf("%d\n", operation(a, b));
    return 0;
}$func$,
$func$[{"input": "10 5 +", "expected": "15\n"}]$func$,
$func$["함수 이름은 함수의 주소입니다"]$func$,
$$["pointers", "function-pointer"]$$, 30),

($$java-dynamic-array$$, $$java$$, $$advanced$$, 89, $$동적 배열$$, $$malloc으로 동적 메모리 할당$$, $$challenge$$, 3,
$func$크기를 입력받아 동적 배열을 생성하고, 값을 입력받아 합을 구하세요.$func$,
$func$- malloc 사용\n- free로 메모리 해제$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    scanf("%d", &n);

    // 여기에 malloc으로 배열을 할당하고 사용하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    scanf("%d", &n);

    int *arr = (int*)malloc(n * sizeof(int));

    int sum = 0;
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
        sum += arr[i];
    }

    printf("%d\n", sum);

    free(arr);
    return 0;
}$func$,
$func$[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]$func$,
$func$["malloc(크기)로 할당, free(포인터)로 해제"]$func$,
$$["pointers", "malloc", "dynamic"]$$, 25),

($$java-linked-list-basics$$, $$java$$, $$advanced$$, 90, $$연결 리스트 기초$$, $$단순 연결 리스트 구현$$, $$challenge$$, 3,
$func$정수를 저장하는 연결 리스트를 만들고 모든 값을 출력하세요.$func$,
$func$- struct Node 정의\n- 동적 할당 사용$func$,
$func$[{"input": "3\n1 2 3", "output": "1 2 3"}]$func$,
$func$#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;
    struct Node *next;
};

int main() {
    int n;
    scanf("%d", &n);

    // 여기에 연결 리스트를 만들고 출력하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;
    struct Node *next;
};

int main() {
    int n;
    scanf("%d", &n);

    struct Node *head = NULL, *tail = NULL;

    for (int i = 0; i < n; i++) {
        int val;
        scanf("%d", &val);

        struct Node *newNode = (struct Node*)malloc(sizeof(struct Node));
        newNode->data = val;
        newNode->next = NULL;

        if (head == NULL) {
            head = tail = newNode;
        } else {
            tail->next = newNode;
            tail = newNode;
        }
    }

    struct Node *current = head;
    while (current != NULL) {
        printf("%d ", current->data);
        current = current->next;
    }
    printf("\n");

    return 0;
}$func$,
$func$[{"input": "3\n1 2 3", "expected": "1 2 3 \n"}]$func$,
$func$["각 노드를 동적 할당하고 연결하세요"]$func$,
$$["pointers", "linked-list", "data-structures"]$$, 30);

-- Unit 9: 파일 입출력 (File I/O) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-file-write$$, $$java$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <stdio.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // 여기에 파일 쓰기 코드를 작성하세요

    printf("File written\n");
    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    FILE *fp = fopen("output.txt", "w");
    if (fp != NULL) {
        fprintf(fp, "%s", str);
        fclose(fp);
    }

    printf("File written\n");
    return 0;
}$func$,
$func$[{"input": "Hello World", "expected": "File written\n"}]$func$,
$func$["fopen(파일명, 모드), fprintf(파일, 형식, ...), fclose(파일)"]$func$,
$$["file-io", "write"]$$, 20),

($$java-file-read$$, $$java$$, $$advanced$$, 92, $$파일 읽기$$, $$파일에서 텍스트 읽기$$, $$challenge$$, 3,
$func$"input.txt" 파일의 내용을 읽어 화면에 출력하세요.$func$,
$func$- fopen, fgets, fclose 사용$func$,
$func$[{"input": "", "output": "File content"}]$func$,
$func$#include <stdio.h>

int main() {
    // 여기에 파일 읽기 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (fp != NULL) {
        char line[256];
        while (fgets(line, sizeof(line), fp) != NULL) {
            printf("%s", line);
        }
        fclose(fp);
    }

    return 0;
}$func$,
$func$[{"input": "", "expected": "File content\n"}]$func$,
$func$["fgets는 한 줄씩 읽습니다"]$func$,
$$["file-io", "read"]$$, 20),

($$java-file-copy$$, $$java$$, $$advanced$$, 93, $$파일 복사$$, $$파일 내용을 다른 파일로 복사$$, $$challenge$$, 3,
$func$"source.txt"의 내용을 "dest.txt"로 복사하세요.$func$,
$func$- 읽기와 쓰기를 동시에$func$,
$func$[{"input": "", "output": "File copied"}]$func$,
$func$#include <stdio.h>

int main() {
    // 여기에 파일 복사 코드를 작성하세요

    printf("File copied\n");
    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    FILE *src = fopen("source.txt", "r");
    FILE *dest = fopen("dest.txt", "w");

    if (src != NULL && dest != NULL) {
        char ch;
        while ((ch = fgetc(src)) != EOF) {
            fputc(ch, dest);
        }
        fclose(src);
        fclose(dest);
    }

    printf("File copied\n");
    return 0;
}$func$,
$func$[{"input": "", "expected": "File copied\n"}]$func$,
$func$["fgetc로 한 문자씩 읽고 fputc로 씁니다"]$func$,
$$["file-io", "copy"]$$, 25),

($$java-file-word-count$$, $$java$$, $$advanced$$, 94, $$파일 단어 수$$, $$파일의 단어 개수 세기$$, $$challenge$$, 3,
$func$"text.txt" 파일의 단어 개수를 세어 출력하세요.$func$,
$func$- 공백으로 구분된 단어$func$,
$func$[{"input": "", "output": "5"}]$func$,
$func$#include <stdio.h>

int main() {
    // 여기에 단어 카운트 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

int main() {
    FILE *fp = fopen("text.txt", "r");
    int count = 0;
    char word[100];

    if (fp != NULL) {
        while (fscanf(fp, "%s", word) == 1) {
            count++;
        }
        fclose(fp);
    }

    printf("%d\n", count);
    return 0;
}$func$,
$func$[{"input": "", "expected": "5\n"}]$func$,
$func$["fscanf로 단어를 하나씩 읽으세요"]$func$,
$$["file-io", "parsing"]$$, 25),

($$java-binary-file$$, $$java$$, $$advanced$$, 95, $$바이너리 파일$$, $$구조체를 바이너리 파일로 저장$$, $$challenge$$, 3,
$func$Person 구조체를 바이너리 파일에 쓰고 읽으세요.$func$,
$func$- fwrite, fread 사용\n- "rb", "wb" 모드$func$,
$func$[{"input": "John 25", "output": "John 25"}]$func$,
$func$#include <stdio.h>

struct Person {
    char name[50];
    int age;
};

int main() {
    struct Person p;
    scanf("%s %d", p.name, &p.age);

    // 여기에 바이너리 파일 쓰기/읽기 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>

struct Person {
    char name[50];
    int age;
};

int main() {
    struct Person p, readP;
    scanf("%s %d", p.name, &p.age);

    FILE *fp = fopen("person.dat", "wb");
    if (fp != NULL) {
        fwrite(&p, sizeof(struct Person), 1, fp);
        fclose(fp);
    }

    fp = fopen("person.dat", "rb");
    if (fp != NULL) {
        fread(&readP, sizeof(struct Person), 1, fp);
        printf("%s %d\n", readP.name, readP.age);
        fclose(fp);
    }

    return 0;
}$func$,
$func$[{"input": "John 25", "expected": "John 25\n"}]$func$,
$func$["fwrite(&구조체, 크기, 개수, 파일)"]$func$,
$$["file-io", "binary", "struct"]$$, 30);

-- Unit 10: 문자열 처리 (String Processing) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-string-reverse$$, $$java$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    scanf("%s", str);

    // 여기에 문자열 뒤집기 코드를 작성하세요

    printf("%s\n", str);
    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    scanf("%s", str);

    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }

    printf("%s\n", str);
    return 0;
}$func$,
$func$[{"input": "hello", "expected": "olleh\n"}]$func$,
$func$["양 끝부터 중간까지 교환하세요"]$func$,
$$["strings", "reverse"]$$, 20),

($$java-palindrome-check$$, $$java$$, $$advanced$$, 97, $$회문 검사$$, $$회문인지 확인하기$$, $$challenge$$, 3,
$func$문자열이 회문(앞뒤가 같음)인지 확인하세요. "Yes" 또는 "No"$func$,
$func$- 대소문자 구분 없음$func$,
$func$[{"input": "racecar", "output": "Yes"}, {"input": "hello", "output": "No"}]$func$,
$func$#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main() {
    char str[100];
    scanf("%s", str);

    // 여기에 회문 검사 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main() {
    char str[100];
    scanf("%s", str);

    int len = strlen(str);
    int isPalindrome = 1;

    for (int i = 0; i < len / 2; i++) {
        if (tolower(str[i]) != tolower(str[len - 1 - i])) {
            isPalindrome = 0;
            break;
        }
    }

    printf("%s\n", isPalindrome ? "Yes" : "No");
    return 0;
}$func$,
$func$[{"input": "racecar", "expected": "Yes\n"}, {"input": "hello", "expected": "No\n"}]$func$,
$func$["tolower로 소문자 변환하여 비교"]$func$,
$$["strings", "palindrome"]$$, 20),

($$java-string-tokenize$$, $$java$$, $$advanced$$, 98, $$문자열 토큰화$$, $$공백으로 문자열 나누기$$, $$challenge$$, 3,
$func$공백으로 구분된 문자열을 나누어 각 단어를 한 줄씩 출력하세요.$func$,
$func$- strtok 사용$func$,
$func$[{"input": "hello world test", "output": "hello\nworld\ntest"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // 여기에 토큰화 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    char *token = strtok(str, " \n");
    while (token != NULL) {
        printf("%s\n", token);
        token = strtok(NULL, " \n");
    }

    return 0;
}$func$,
$func$[{"input": "hello world test", "expected": "hello\nworld\ntest\n"}]$func$,
$func$["strtok(문자열, 구분자)를 반복 호출"]$func$,
$$["strings", "tokenize", "parsing"]$$, 25),

($$java-anagram-check$$, $$java$$, $$advanced$$, 99, $$애너그램 검사$$, $$두 문자열이 애너그램인지 확인$$, $$challenge$$, 3,
$func$두 문자열이 애너그램(같은 문자로 구성)인지 확인하세요.$func$,
$func$- 문자 빈도수를 세어 비교$func$,
$func$[{"input": "listen\nsilent", "output": "Yes"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str1[100], str2[100];
    scanf("%s %s", str1, str2);

    // 여기에 애너그램 검사 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char str1[100], str2[100];
    scanf("%s %s", str1, str2);

    if (strlen(str1) != strlen(str2)) {
        printf("No\n");
        return 0;
    }

    int count[26] = {0};

    for (int i = 0; str1[i]; i++) {
        count[str1[i] - 'a']++;
        count[str2[i] - 'a']--;
    }

    int isAnagram = 1;
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) {
            isAnagram = 0;
            break;
        }
    }

    printf("%s\n", isAnagram ? "Yes" : "No");
    return 0;
}$func$,
$func$[{"input": "listen\nsilent", "expected": "Yes\n"}]$func$,
$func$["각 문자의 출현 횟수를 세세요"]$func$,
$$["strings", "anagram", "algorithm"]$$, 25),

($$java-substring-search$$, $$java$$, $$advanced$$, 100, $$부분 문자열 찾기$$, $$문자열 내 부분 문자열 위치 찾기$$, $$challenge$$, 3,
$func$문자열 s에서 패턴 p가 처음 나타나는 위치를 출력하세요. 없으면 -1$func$,
$func$- 직접 구현 (strstr 사용 금지)\n- 인덱스는 0부터$func$,
$func$[{"input": "hello world\nworld", "output": "6"}]$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char s[100], p[100];
    fgets(s, sizeof(s), stdin);
    fgets(p, sizeof(p), stdin);

    // 줄바꿈 제거
    s[strcspn(s, "\n")] = 0;
    p[strcspn(p, "\n")] = 0;

    // 여기에 부분 문자열 검색 코드를 작성하세요

    return 0;
}$func$,
$func$#include <stdio.h>
#include <string.h>

int main() {
    char s[100], p[100];
    fgets(s, sizeof(s), stdin);
    fgets(p, sizeof(p), stdin);

    s[strcspn(s, "\n")] = 0;
    p[strcspn(p, "\n")] = 0;

    int sLen = strlen(s), pLen = strlen(p);
    int found = -1;

    for (int i = 0; i <= sLen - pLen; i++) {
        int match = 1;
        for (int j = 0; j < pLen; j++) {
            if (s[i + j] != p[j]) {
                match = 0;
                break;
            }
        }
        if (match) {
            found = i;
            break;
        }
    }

    printf("%d\n", found);
    return 0;
}$func$,
$func$[{"input": "hello world\nworld", "expected": "6\n"}]$func$,
$$["각 위치에서 패턴과 일치하는지 확인"]$$,
$$["strings", "search", "algorithm"]$$, 30);

-- ============================================================================
-- End of Java Language Part 2
-- ============================================================================

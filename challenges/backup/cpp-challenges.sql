-- ============================================================================
-- CPP Language Challenges (Complete)
-- ============================================================================
-- Generated: 2025-11-01T14:07:10.127Z
-- ============================================================================

-- ============================================================================
-- C++ Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

-- Unit 1: 출력과 주석 (Output and Comments) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-hello-world$$, $$cpp$$, $$syntax$$, 1, $$Hello World$$, $$C++로 첫 프로그램 작성하기$$, $$challenge$$, 1,
$$화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.$$,
$$- cout을 사용하세요\n- endl 또는 \n으로 줄바꿈$$,
$$[{"input": "", "output": "Hello, World!"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "Hello, World!\n"}]$$,
$$["cout << 로 출력합니다", "endl은 줄바꿈을 의미합니다"]$$,
$$["basics", "output", "cout"]$$, 5),

($$cpp-print-numbers$$, $$cpp$$, $$syntax$$, 2, $$숫자 출력$$, $$여러 숫자 출력하기$$, $$challenge$$, 1,
$$정수 10, 20, 30을 공백으로 구분하여 한 줄에 출력하세요.$$,
$$- << 연산자를 연결하여 사용$$,
$$[{"input": "", "output": "10 20 30"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    cout << 10 << " " << 20 << " " << 30 << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "10 20 30\n"}]$$,
$$["<< 연산자를 여러 번 사용할 수 있습니다"]$$,
$$["basics", "output"]$$, 5),

($$cpp-multiline$$, $$cpp$$, $$syntax$$, 3, $$여러 줄 출력$$, $$여러 줄로 출력하기$$, $$challenge$$, 1,
$$세 줄에 걸쳐 "Line 1", "Line 2", "Line 3"을 출력하세요.$$,
$$- endl 또는 \n 사용$$,
$$[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    cout << "Line 1" << endl;
    cout << "Line 2" << endl;
    cout << "Line 3" << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]$$,
$$["cout을 여러 번 호출하거나 \\n을 사용하세요"]$$,
$$["basics", "output"]$$, 5),

($$cpp-single-comment$$, $$cpp$$, $$syntax$$, 4, $$한 줄 주석$$, $$주석 사용하기$$, $$challenge$$, 1,
$$"C++"를 출력하고, 그 위에 한 줄 주석으로 "This is C++"를 추가하세요.$$,
$$- // 주석 사용$$,
$$[{"input": "", "output": "C++"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 주석과 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    // This is C++
    cout << "C++" << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "C++\n"}]$$,
$$["// 뒤의 내용은 실행되지 않습니다"]$$,
$$["basics", "comments"]$$, 5),

($$cpp-multi-comment$$, $$cpp$$, $$syntax$$, 5, $$여러 줄 주석$$, $$여러 줄 주석 사용하기$$, $$challenge$$, 1,
$$"Programming"을 출력하고, 위에 여러 줄 주석을 추가하세요.$$,
$$- /* */ 사용$$,
$$[{"input": "", "output": "Programming"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    /* 여기에 주석을 작성하세요 */

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    /*
     * This program prints Programming
     * C++ learning example
     */
    cout << "Programming" << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "Programming\n"}]$$,
$$["/* */ 사이의 모든 내용은 주석입니다"]$$,
$$["basics", "comments"]$$, 5);

-- Unit 2: 변수와 자료형 (Variables and Data Types) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-int-variable$$, $$cpp$$, $$syntax$$, 6, $$정수 변수$$, $$정수형 변수 선언과 출력$$, $$challenge$$, 1,
$$정수형 변수 num을 선언하고 100을 저장한 후 출력하세요.$$,
$$- int 타입 사용$$,
$$[{"input": "", "output": "100"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int num = 100;
    cout << num << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "100\n"}]$$,
$$["int는 정수를 저장합니다"]$$,
$$["basics", "variables", "int"]$$, 5),

($$cpp-double-variable$$, $$cpp$$, $$syntax$$, 7, $$실수 변수$$, $$실수형 변수 선언과 출력$$, $$challenge$$, 1,
$$실수형 변수 pi를 선언하고 3.14159를 저장한 후 출력하세요.$$,
$$- double 타입 사용$$,
$$[{"input": "", "output": "3.14159"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    double pi = 3.14159;
    cout << pi << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "3.14159\n"}]$$,
$$["double은 실수를 저장합니다"]$$,
$$["basics", "variables", "double"]$$, 5),

($$cpp-string-variable$$, $$cpp$$, $$syntax$$, 8, $$문자열 변수$$, $$string 타입 사용하기$$, $$challenge$$, 1,
$$문자열 변수 name에 "Alice"를 저장하고 출력하세요.$$,
$$- string 타입 사용$$,
$$[{"input": "", "output": "Alice"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string name = "Alice";
    cout << name << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "Alice\n"}]$$,
$$["string은 C++의 문자열 타입입니다"]$$,
$$["basics", "variables", "string"]$$, 5),

($$cpp-bool-variable$$, $$cpp$$, $$syntax$$, 9, $$불린 변수$$, $$bool 타입 사용하기$$, $$challenge$$, 1,
$$불린 변수 isTrue에 true를 저장하고 출력하세요.$$,
$$- bool 타입 사용\n- boolalpha 사용하여 true/false로 출력$$,
$$[{"input": "", "output": "true"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요
    // cout << boolalpha 를 사용하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    bool isTrue = true;
    cout << boolalpha << isTrue << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "true\n"}]$$,
$$["boolalpha는 불린값을 문자로 출력합니다"]$$,
$$["basics", "variables", "bool"]$$, 5),

($$cpp-auto-keyword$$, $$cpp$$, $$syntax$$, 10, $$auto 키워드$$, $$타입 자동 추론하기$$, $$challenge$$, 1,
$$auto 키워드로 변수를 선언하고 42를 저장한 후 출력하세요.$$,
$$- auto 키워드 사용$$,
$$[{"input": "", "output": "42"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    auto value = 42;
    cout << value << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "42\n"}]$$,
$$["auto는 초기값으로 타입을 자동 추론합니다"]$$,
$$["basics", "variables", "auto"]$$, 5);

-- Unit 3: 연산자 (Operators) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-arithmetic$$, $$cpp$$, $$basics$$, 11, $$사칙연산$$, $$기본 산술 연산하기$$, $$challenge$$, 1,
$$두 정수 a=20, b=3의 덧셈, 뺄셈, 곱셈, 나눗셈 결과를 각 줄에 출력하세요.$$,
$$- +, -, *, / 연산자 사용$$,
$$[{"input": "", "output": "23\n17\n60\n6"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 20, b = 3;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 20, b = 3;
    cout << a + b << endl;
    cout << a - b << endl;
    cout << a * b << endl;
    cout << a / b << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "23\n17\n60\n6\n"}]$$,
$$["정수 나눗셈은 소수점을 버립니다"]$$,
$$["basics", "operators", "arithmetic"]$$, 5),

($$cpp-modulo$$, $$cpp$$, $$basics$$, 12, $$나머지 연산$$, $$나머지 구하기$$, $$challenge$$, 1,
$$두 정수 a=17, b=5의 나머지를 출력하세요.$$,
$$- % 연산자 사용$$,
$$[{"input": "", "output": "2"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 17, b = 5;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 17, b = 5;
    cout << a % b << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "2\n"}]$$,
$$["% 연산자로 나머지를 구합니다"]$$,
$$["basics", "operators", "modulo"]$$, 5),

($$cpp-increment$$, $$cpp$$, $$basics$$, 13, $$증감 연산자$$, $$++와 -- 사용하기$$, $$challenge$$, 1,
$$정수 x=5에 대해 ++x, x++의 결과를 각 줄에 출력하세요.$$,
$$- 전위/후위 증가 연산자$$,
$$[{"input": "", "output": "6\n6"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int x = 5;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int x = 5;
    cout << ++x << endl;  // 6
    cout << x++ << endl;  // 6 (출력 후 증가)
    return 0;
}$func$,
$$[{"input": "", "expected": "6\n6\n"}]$$,
$$["전위는 먼저 증가, 후위는 나중에 증가"]$$,
$$["basics", "operators", "increment"]$$, 5),

($$cpp-comparison$$, $$cpp$$, $$basics$$, 14, $$비교 연산자$$, $$값 비교하기$$, $$challenge$$, 1,
$$두 정수 a=10, b=20에 대해 a < b, a == b의 결과를 출력하세요.$$,
$$- boolalpha 사용하여 true/false로 출력$$,
$$[{"input": "", "output": "true\nfalse"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 10, b = 20;
    cout << boolalpha;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a = 10, b = 20;
    cout << boolalpha;
    cout << (a < b) << endl;
    cout << (a == b) << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "true\nfalse\n"}]$$,
$$["비교 연산자는 bool 값을 반환합니다"]$$,
$$["basics", "operators", "comparison"]$$, 5),

($$cpp-logical$$, $$cpp$$, $$basics$$, 15, $$논리 연산자$$, $$AND, OR, NOT 사용하기$$, $$challenge$$, 1,
$$bool a=true, b=false에 대해 a && b, a || b, !a의 결과를 출력하세요.$$,
$$- &&, ||, ! 연산자$$,
$$[{"input": "", "output": "false\ntrue\nfalse"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    bool a = true, b = false;
    cout << boolalpha;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    bool a = true, b = false;
    cout << boolalpha;
    cout << (a && b) << endl;
    cout << (a || b) << endl;
    cout << !a << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "false\ntrue\nfalse\n"}]$$,
$$["&&는 AND, ||는 OR, !는 NOT"]$$,
$$["basics", "operators", "logical"]$$, 5);

-- Unit 4: 조건문 (Conditional Statements) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-if-positive$$, $$cpp$$, $$basics$$, 16, $$양수 판별$$, $$숫자가 양수인지 확인$$, $$challenge$$, 1,
$$정수 num을 입력받아 양수이면 "Positive"를 출력하세요.$$,
$$- if 문 사용$$,
$$[{"input": "10", "output": "Positive"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    if (num > 0) {
        cout << "Positive" << endl;
    }
    return 0;
}$func$,
$$[{"input": "10", "expected": "Positive\n"}]$$,
$$["if (조건) { 실행할 코드 }"]$$,
$$["conditionals", "if"]$$, 5),

($$cpp-if-else-even$$, $$cpp$$, $$basics$$, 17, $$짝수 홀수$$, $$짝수인지 홀수인지 판별$$, $$challenge$$, 1,
$$정수 num을 입력받아 짝수면 "Even", 홀수면 "Odd"를 출력하세요.$$,
$$- if-else 문 사용$$,
$$[{"input": "8", "output": "Even"}, {"input": "5", "output": "Odd"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    if (num % 2 == 0) {
        cout << "Even" << endl;
    } else {
        cout << "Odd" << endl;
    }
    return 0;
}$func$,
$$[{"input": "8", "expected": "Even\n"}, {"input": "5", "expected": "Odd\n"}]$$,
$$["num % 2 == 0이면 짝수입니다"]$$,
$$["conditionals", "if-else"]$$, 5),

($$cpp-if-else-max$$, $$cpp$$, $$basics$$, 18, $$큰 수 찾기$$, $$두 수 중 큰 수 출력$$, $$challenge$$, 1,
$$두 정수 a, b를 입력받아 큰 수를 출력하세요.$$,
$$- if-else 문 사용$$,
$$[{"input": "15 25", "output": "25"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    if (a > b) {
        cout << a << endl;
    } else {
        cout << b << endl;
    }
    return 0;
}$func$,
$$[{"input": "15 25", "expected": "25\n"}]$$,
$$["a와 b를 비교하세요"]$$,
$$["conditionals", "comparison"]$$, 5),

($$cpp-if-else-if-grade$$, $$cpp$$, $$basics$$, 19, $$학점 계산$$, $$점수로 등급 매기기$$, $$challenge$$, 1,
$$점수를 입력받아 90 이상 A, 80 이상 B, 70 이상 C, 그 외 F를 출력하세요.$$,
$$- if-else if-else 문$$,
$$[{"input": "95", "output": "A"}, {"input": "85", "output": "B"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int score;
    cin >> score;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int score;
    cin >> score;
    if (score >= 90) {
        cout << "A" << endl;
    } else if (score >= 80) {
        cout << "B" << endl;
    } else if (score >= 70) {
        cout << "C" << endl;
    } else {
        cout << "F" << endl;
    }
    return 0;
}$func$,
$$[{"input": "95", "expected": "A\n"}, {"input": "85", "expected": "B\n"}]$$,
$$["조건을 순서대로 확인하세요"]$$,
$$["conditionals", "if-else-if"]$$, 5),

($$cpp-ternary$$, $$cpp$$, $$basics$$, 20, $$삼항 연산자$$, $$조건 연산자 사용하기$$, $$challenge$$, 1,
$$정수 n을 입력받아 짝수면 "Even", 홀수면 "Odd"를 삼항 연산자로 출력하세요.$$,
$$- ? : 연산자 사용$$,
$$[{"input": "6", "output": "Even"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    cout << (n % 2 == 0 ? "Even" : "Odd") << endl;
    return 0;
}$func$,
$$[{"input": "6", "expected": "Even\n"}]$$,
$$["조건 ? 참일때값 : 거짓일때값"]$$,
$$["conditionals", "ternary"]$$, 5);

-- Unit 5: 반복문 (Loops) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-for-loop$$, $$cpp$$, $$basics$$, 21, $$for 반복문$$, $$1부터 10까지 출력$$, $$challenge$$, 1,
$$for문을 사용하여 1부터 10까지 출력하세요.$$,
$$- for 문 사용$$,
$$[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 10; i++) {
        cout << i << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 6 7 8 9 10 \n"}]$$,
$$["for (초기값; 조건; 증감) { }"]$$,
$$["loops", "for"]$$, 5),

($$cpp-while-loop$$, $$cpp$$, $$basics$$, 22, $$while 반복문$$, $$카운트다운 출력$$, $$challenge$$, 1,
$$while문으로 5부터 1까지 카운트다운하세요.$$,
$$- while 문 사용$$,
$$[{"input": "", "output": "5 4 3 2 1"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int count = 5;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int count = 5;
    while (count > 0) {
        cout << count << " ";
        count--;
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "5 4 3 2 1 \n"}]$$,
$$["while (조건) { ... }"]$$,
$$["loops", "while"]$$, 5),

($$cpp-sum-loop$$, $$cpp$$, $$basics$$, 23, $$합계 계산$$, $$1부터 N까지 합$$, $$challenge$$, 1,
$$정수 N을 입력받아 1부터 N까지의 합을 계산하세요.$$,
$$- for 문 사용$$,
$$[{"input": "10", "output": "55"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int sum = 0;
    for (int i = 1; i <= n; i++) {
        sum += i;
    }
    cout << sum << endl;
    return 0;
}$func$,
$$[{"input": "10", "expected": "55\n"}]$$,
$$["sum에 누적하세요"]$$,
$$["loops", "for", "sum"]$$, 5),

($$cpp-multiplication-table$$, $$cpp$$, $$basics$$, 24, $$구구단$$, $$N단 구구단 출력$$, $$challenge$$, 1,
$$정수 N을 입력받아 N단 구구단(1~9)을 출력하세요.$$,
$$- 형식: N x 1 = 결과$$,
$func$[{"input": "5", "output": "5 x 1 = 5\n5 x 2 = 10\n5 x 3 = 15\n5 x 4 = 20\n5 x 5 = 25\n5 x 6 = 30\n5 x 7 = 35\n5 x 8 = 40\n5 x 9 = 45"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= 9; i++) {
        cout << n << " x " << i << " = " << n * i << endl;
    }
    return 0;
}$func$,
$func$[{"input": "5", "expected": "5 x 1 = 5\n5 x 2 = 10\n5 x 3 = 15\n5 x 4 = 20\n5 x 5 = 25\n5 x 6 = 30\n5 x 7 = 35\n5 x 8 = 40\n5 x 9 = 45\n"}]$func$,
$$["1부터 9까지 반복하세요"]$$,
$$["loops", "multiplication"]$$, 5),

($$cpp-do-while$$, $$cpp$$, $$basics$$, 25, $$do-while 반복문$$, $$do-while 사용하기$$, $$challenge$$, 1,
$$do-while문으로 1부터 5까지 출력하세요.$$,
$$- do-while 문 사용$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int i = 1;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int i = 1;
    do {
        cout << i << " ";
        i++;
    } while (i <= 5);
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 \n"}]$$,
$$["do { } while (조건);"]$$,
$$["loops", "do-while"]$$, 5);

-- Unit 6: 함수 (Functions) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-function-add$$, $$cpp$$, $$basics$$, 26, $$덧셈 함수$$, $$두 수를 더하는 함수$$, $$challenge$$, 1,
$$두 정수를 더하는 add 함수를 작성하세요.$$,
$$- int add(int a, int b)$$,
$$[{"input": "5 7", "output": "12"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;
    cin >> a >> b;
    cout << add(a, b) << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int add(int a, int b) {
    return a + b;
}

int main() {
    int a, b;
    cin >> a >> b;
    cout << add(a, b) << endl;
    return 0;
}$func$,
$$[{"input": "5 7", "expected": "12\n"}]$$,
$$["return a + b;"]$$,
$$["functions", "return"]$$, 5),

($$cpp-function-max$$, $$cpp$$, $$basics$$, 27, $$최댓값 함수$$, $$큰 수 반환하기$$, $$challenge$$, 1,
$$두 정수 중 큰 값을 반환하는 max 함수를 작성하세요.$$,
$$- int max(int a, int b)$$,
$$[{"input": "10 20", "output": "20"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 max 함수를 작성하세요

int main() {
    int a, b;
    cin >> a >> b;
    cout << max(a, b) << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int max(int a, int b) {
    return (a > b) ? a : b;
}

int main() {
    int a, b;
    cin >> a >> b;
    cout << max(a, b) << endl;
    return 0;
}$func$,
$$[{"input": "10 20", "expected": "20\n"}]$$,
$$["조건에 따라 다른 값을 반환"]$$,
$$["functions", "conditionals"]$$, 5),

($$cpp-function-void$$, $$cpp$$, $$basics$$, 28, $$void 함수$$, $$반환값 없는 함수$$, $$challenge$$, 1,
$$문자열을 출력하는 void 타입 printMessage 함수를 작성하세요.$$,
$$- void printMessage()$$,
$$[{"input": "", "output": "Hello from function"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 printMessage 함수를 작성하세요

int main() {
    printMessage();
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

void printMessage() {
    cout << "Hello from function" << endl;
}

int main() {
    printMessage();
    return 0;
}$func$,
$$[{"input": "", "expected": "Hello from function\n"}]$$,
$$["void는 반환값이 없습니다"]$$,
$$["functions", "void"]$$, 5),

($$cpp-function-square$$, $$cpp$$, $$basics$$, 29, $$제곱 함수$$, $$숫자의 제곱 구하기$$, $$challenge$$, 1,
$$정수 n의 제곱을 반환하는 square 함수를 작성하세요.$$,
$$- int square(int n)$$,
$$[{"input": "7", "output": "49"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 square 함수를 작성하세요

int main() {
    int n;
    cin >> n;
    cout << square(n) << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int square(int n) {
    return n * n;
}

int main() {
    int n;
    cin >> n;
    cout << square(n) << endl;
    return 0;
}$func$,
$$[{"input": "7", "expected": "49\n"}]$$,
$$["return n * n;"]$$,
$$["functions", "math"]$$, 5),

($$cpp-function-is-even$$, $$cpp$$, $$basics$$, 30, $$짝수 판별 함수$$, $$짝수인지 확인하는 함수$$, $$challenge$$, 1,
$$정수가 짝수면 true, 홀수면 false를 반환하는 isEven 함수를 작성하세요.$$,
$$- bool isEven(int n)$$,
$$[{"input": "8", "output": "true"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 isEven 함수를 작성하세요

int main() {
    int n;
    cin >> n;
    cout << boolalpha << isEven(n) << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

bool isEven(int n) {
    return n % 2 == 0;
}

int main() {
    int n;
    cin >> n;
    cout << boolalpha << isEven(n) << endl;
    return 0;
}$func$,
$$[{"input": "8", "expected": "true\n"}]$$,
$$["n % 2 == 0을 반환하세요"]$$,
$$["functions", "bool"]$$, 5);

-- Unit 7: 배열 (Arrays) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-array-declare$$, $$cpp$$, $$basics$$, 31, $$배열 선언$$, $$배열 선언과 초기화$$, $$challenge$$, 1,
$$크기 5인 정수 배열을 {1,2,3,4,5}로 초기화하고 모든 요소를 출력하세요.$$,
$$- int arr[5]$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 5; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 \n"}]$$,
$$["int arr[] = {1, 2, 3, 4, 5};"]$$,
$$["arrays", "basics"]$$, 5),

($$cpp-array-sum$$, $$cpp$$, $$basics$$, 32, $$배열 합계$$, $$배열 요소의 합$$, $$challenge$$, 1,
$$5개의 정수를 입력받아 합을 계산하세요.$$,
$$- for 문 사용$$,
$$[{"input": "1 2 3 4 5", "output": "15"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // 여기에 합계 계산 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    int sum = 0;
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
        sum += arr[i];
    }
    cout << sum << endl;
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5", "expected": "15\n"}]$$,
$$["sum += arr[i]로 누적"]$$,
$$["arrays", "sum"]$$, 5),

($$cpp-array-max$$, $$cpp$$, $$basics$$, 33, $$배열 최댓값$$, $$배열에서 최댓값 찾기$$, $$challenge$$, 1,
$$5개의 정수를 입력받아 최댓값을 출력하세요.$$,
$$- for 문과 if 문 사용$$,
$$[{"input": "3 7 2 9 5", "output": "9"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // 여기에 최댓값 찾기 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    int maxVal = arr[0];
    for (int i = 1; i < 5; i++) {
        if (arr[i] > maxVal) {
            maxVal = arr[i];
        }
    }
    cout << maxVal << endl;
    return 0;
}$func$,
$$[{"input": "3 7 2 9 5", "expected": "9\n"}]$$,
$$["첫 요소를 max로 설정하고 비교"]$$,
$$["arrays", "max"]$$, 5),

($$cpp-array-reverse$$, $$cpp$$, $$basics$$, 34, $$배열 역순 출력$$, $$배열을 거꾸로 출력$$, $$challenge$$, 1,
$$5개의 정수를 입력받아 역순으로 출력하세요.$$,
$$- 역순 for 문$$,
$$[{"input": "1 2 3 4 5", "output": "5 4 3 2 1"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // 여기에 역순 출력 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    for (int i = 4; i >= 0; i--) {
        cout << arr[i] << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5", "expected": "5 4 3 2 1 \n"}]$$,
$$["i = 4부터 i >= 0까지"]$$,
$$["arrays", "reverse"]$$, 5),

($$cpp-range-based-loop$$, $$cpp$$, $$basics$$, 35, $$범위 기반 for문$$, $$range-based for 사용$$, $$challenge$$, 1,
$$배열 {10, 20, 30, 40, 50}의 모든 요소를 범위 기반 for문으로 출력하세요.$$,
$$- for (auto x : arr)$$,
$$[{"input": "", "output": "10 20 30 40 50"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    // 여기에 범위 기반 for문을 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    for (auto x : arr) {
        cout << x << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "10 20 30 40 50 \n"}]$$,
$$["for (auto 변수 : 배열)"]$$,
$$["arrays", "range-for", "c++11"]$$, 5);

-- Unit 8: 벡터 (Vectors) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-vector-declare$$, $$cpp$$, $$basics$$, 36, $$벡터 선언$$, $$vector 사용하기$$, $$challenge$$, 1,
$$정수 벡터를 선언하고 {1,2,3,4,5}로 초기화한 후 출력하세요.$$,
$$- vector<int> 사용$$,
$$[{"input": "", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {1, 2, 3, 4, 5};
    for (auto x : v) {
        cout << x << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "1 2 3 4 5 \n"}]$$,
$$["vector<int> v = {...};"]$$,
$$["vector", "basics", "stl"]$$, 5),

($$cpp-vector-push$$, $$cpp$$, $$basics$$, 37, $$벡터 추가$$, $$push_back 사용하기$$, $$challenge$$, 1,
$$빈 벡터에 5개의 정수를 입력받아 추가한 후 출력하세요.$$,
$$- push_back() 사용$$,
$$[{"input": "1 2 3 4 5", "output": "1 2 3 4 5"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v;
    for (int i = 0; i < 5; i++) {
        int x;
        cin >> x;
        v.push_back(x);
    }
    for (auto x : v) {
        cout << x << " ";
    }
    cout << endl;
    return 0;
}$func$,
$$[{"input": "1 2 3 4 5", "expected": "1 2 3 4 5 \n"}]$$,
$$["v.push_back(값)으로 추가"]$$,
$$["vector", "push_back", "stl"]$$, 5),

($$cpp-vector-size$$, $$cpp$$, $$basics$$, 38, $$벡터 크기$$, $$size() 사용하기$$, $$challenge$$, 1,
$$벡터 {10,20,30,40,50}의 크기를 출력하세요.$$,
$$- size() 메서드$$,
$$[{"input": "", "output": "5"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {10, 20, 30, 40, 50};
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {10, 20, 30, 40, 50};
    cout << v.size() << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "5\n"}]$$,
$$["v.size()는 원소 개수를 반환"]$$,
$$["vector", "size", "stl"]$$, 5),

($$cpp-vector-access$$, $$cpp$$, $$basics$$, 39, $$벡터 접근$$, $$인덱스로 접근하기$$, $$challenge$$, 1,
$$벡터 {5,10,15,20,25}에서 인덱스 2의 값을 출력하세요.$$,
$$- v[index] 또는 v.at(index)$$,
$$[{"input": "", "output": "15"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {5, 10, 15, 20, 25};
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {5, 10, 15, 20, 25};
    cout << v[2] << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "15\n"}]$$,
$$["v[2] 또는 v.at(2)"]$$,
$$["vector", "access", "stl"]$$, 5),

($$cpp-vector-clear$$, $$cpp$$, $$basics$$, 40, $$벡터 비우기$$, $$clear() 사용하기$$, $$challenge$$, 1,
$$벡터 {1,2,3}을 비운 후 크기를 출력하세요.$$,
$$- clear() 메서드$$,
$$[{"input": "", "output": "0"}]$$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {1, 2, 3};
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {1, 2, 3};
    v.clear();
    cout << v.size() << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "0\n"}]$$,
$$["v.clear()는 모든 원소를 제거"]$$,
$$["vector", "clear", "stl"]$$, 5);

-- Unit 9: 문자열 (Strings) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-string-input$$, $$cpp$$, $$basics$$, 41, $$문자열 입력$$, $$문자열 입력받기$$, $$challenge$$, 1,
$$문자열을 입력받아 그대로 출력하세요.$$,
$$- cin 또는 getline 사용$$,
$$[{"input": "Hello", "output": "Hello"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    cout << str << endl;
    return 0;
}$func$,
$$[{"input": "Hello", "expected": "Hello\n"}]$$,
$$["cin >> str로 문자열 입력"]$$,
$$["strings", "input"]$$, 5),

($$cpp-string-length$$, $$cpp$$, $$basics$$, 42, $$문자열 길이$$, $$length() 사용하기$$, $$challenge$$, 1,
$$문자열을 입력받아 길이를 출력하세요.$$,
$$- length() 또는 size() 메서드$$,
$$[{"input": "programming", "output": "11"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    cout << str.length() << endl;
    return 0;
}$func$,
$$[{"input": "programming", "expected": "11\n"}]$$,
$$["str.length() 또는 str.size()"]$$,
$$["strings", "length"]$$, 5),

($$cpp-string-concat$$, $$cpp$$, $$basics$$, 43, $$문자열 연결$$, $$+ 연산자로 연결$$, $$challenge$$, 1,
$$두 문자열을 입력받아 연결한 후 출력하세요.$$,
$$- + 연산자 사용$$,
$$[{"input": "Hello World", "output": "HelloWorld"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    cout << s1 + s2 << endl;
    return 0;
}$func$,
$$[{"input": "Hello World", "expected": "HelloWorld\n"}]$$,
$$["s1 + s2로 연결"]$$,
$$["strings", "concatenation"]$$, 5),

($$cpp-string-compare$$, $$cpp$$, $$basics$$, 44, $$문자열 비교$$, $$== 연산자로 비교$$, $$challenge$$, 1,
$$두 문자열을 입력받아 같으면 "Same", 다르면 "Different"를 출력하세요.$$,
$$- == 연산자$$,
$$[{"input": "hello hello", "output": "Same"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    if (s1 == s2) {
        cout << "Same" << endl;
    } else {
        cout << "Different" << endl;
    }
    return 0;
}$func$,
$$[{"input": "hello hello", "expected": "Same\n"}]$$,
$$["s1 == s2로 비교"]$$,
$$["strings", "comparison"]$$, 5),

($$cpp-string-substr$$, $$cpp$$, $$basics$$, 45, $$부분 문자열$$, $$substr() 사용하기$$, $$challenge$$, 1,
$$문자열 "programming"의 인덱스 3부터 4글자를 출력하세요.$$,
$$- substr(pos, len) 메서드$$,
$$[{"input": "", "output": "gram"}]$$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str = "programming";
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
#include <string>
using namespace std;

int main() {
    string str = "programming";
    cout << str.substr(3, 4) << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "gram\n"}]$$,
$$["str.substr(시작위치, 길이)"]$$,
$$["strings", "substr"]$$, 5);

-- Unit 10: 클래스 기초 (Classes Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-class-declare$$, $$cpp$$, $$basics$$, 46, $$클래스 선언$$, $$간단한 클래스 만들기$$, $$challenge$$, 1,
$$정수 멤버 변수 x를 가진 Point 클래스를 정의하고 값을 출력하세요.$$,
$$- class 키워드 사용$$,
$$[{"input": "", "output": "10"}]$$,
$func$#include <iostream>
using namespace std;

// 여기에 Point 클래스를 정의하세요

int main() {
    Point p;
    p.x = 10;
    cout << p.x << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

class Point {
public:
    int x;
};

int main() {
    Point p;
    p.x = 10;
    cout << p.x << endl;
    return 0;
}$func$,
$$[{"input": "", "expected": "10\n"}]$$,
$$["class Point { public: int x; };"]$$,
$$["oop", "class", "basics"]$$, 5),

($$cpp-class-constructor$$, $$cpp$$, $$basics$$, 47, $$생성자$$, $$생성자로 초기화하기$$, $$challenge$$, 1,
$$정수 멤버 변수 value를 가진 Number 클래스를 만들고, 생성자로 초기화하세요.$$,
$$- Number(int v) 생성자$$,
$$[{"input": "42", "output": "42"}]$$,
$func$#include <iostream>
using namespace std;

class Number {
public:
    int value;
    // 여기에 생성자를 작성하세요
};

int main() {
    int v;
    cin >> v;
    Number n(v);
    cout << n.value << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

class Number {
public:
    int value;
    Number(int v) {
        value = v;
    }
};

int main() {
    int v;
    cin >> v;
    Number n(v);
    cout << n.value << endl;
    return 0;
}$func$,
$$[{"input": "42", "expected": "42\n"}]$$,
$$["생성자는 클래스 이름과 같습니다"]$$,
$$["oop", "constructor"]$$, 5),

($$cpp-class-method$$, $$cpp$$, $$basics$$, 48, $$멤버 함수$$, $$클래스 메서드 만들기$$, $$challenge$$, 1,
$$두 정수 a, b를 더하는 add() 메서드를 가진 Calculator 클래스를 만드세요.$$,
$$- int add() 메서드$$,
$$[{"input": "5 3", "output": "8"}]$$,
$func$#include <iostream>
using namespace std;

class Calculator {
public:
    int a, b;
    // 여기에 add 메서드를 작성하세요
};

int main() {
    Calculator calc;
    cin >> calc.a >> calc.b;
    cout << calc.add() << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

class Calculator {
public:
    int a, b;
    int add() {
        return a + b;
    }
};

int main() {
    Calculator calc;
    cin >> calc.a >> calc.b;
    cout << calc.add() << endl;
    return 0;
}$func$,
$$[{"input": "5 3", "expected": "8\n"}]$$,
$$["멤버 변수에 접근할 수 있습니다"]$$,
$$["oop", "methods"]$$, 5),

($$cpp-class-private$$, $$cpp$$, $$basics$$, 49, $$private 멤버$$, $$접근 제한자 사용하기$$, $$challenge$$, 1,
$$private 정수 age와 public getter getAge()를 가진 Person 클래스를 만드세요.$$,
$$- private와 public 구분$$,
$$[{"input": "25", "output": "25"}]$$,
$func$#include <iostream>
using namespace std;

class Person {
private:
    int age;
public:
    // 여기에 setAge와 getAge를 작성하세요
};

int main() {
    Person p;
    int a;
    cin >> a;
    p.setAge(a);
    cout << p.getAge() << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

class Person {
private:
    int age;
public:
    void setAge(int a) {
        age = a;
    }
    int getAge() {
        return age;
    }
};

int main() {
    Person p;
    int a;
    cin >> a;
    p.setAge(a);
    cout << p.getAge() << endl;
    return 0;
}$func$,
$$[{"input": "25", "expected": "25\n"}]$$,
$$["private 멤버는 외부에서 접근 불가"]$$,
$$["oop", "encapsulation", "private"]$$, 5),

($$cpp-class-rectangle$$, $$cpp$$, $$basics$$, 50, $$직사각형 클래스$$, $$Rectangle 클래스 만들기$$, $$challenge$$, 1,
$$width, height를 가진 Rectangle 클래스를 만들고 넓이를 계산하는 area() 메서드를 작성하세요.$$,
$$- int area() 메서드$$,
$$[{"input": "5 10", "output": "50"}]$$,
$func$#include <iostream>
using namespace std;

class Rectangle {
public:
    int width, height;
    // 여기에 area 메서드를 작성하세요
};

int main() {
    Rectangle rect;
    cin >> rect.width >> rect.height;
    cout << rect.area() << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

class Rectangle {
public:
    int width, height;
    int area() {
        return width * height;
    }
};

int main() {
    Rectangle rect;
    cin >> rect.width >> rect.height;
    cout << rect.area() << endl;
    return 0;
}$func$,
$$[{"input": "5 10", "expected": "50\n"}]$$,
$$["return width * height;"]$$,
$$["oop", "class", "methods"]$$, 5);

-- ============================================================================
-- End of C++ Language Part 1
-- ============================================================================

-- ============================================================================
-- C++ Language Challenges - Part 2 (Medium & Hard)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: MEDIUM (2) for Units 1-6, HARD (3) for Units 7-10
-- ============================================================================

-- Unit 1: 출력과 주석 (Output and Comments) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pattern-triangle$$, $$cpp$$, $$syntax$$, 51, $$삼각형 패턴$$, $$별표로 삼각형 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***$$,
$$- 중첩 반복문 사용\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "*\n**\n***"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < i; j++) {
            cout << "*";
        }
        cout << "\n";
    }
    return 0;
}$func$,
$func$[{"input": "3", "expected": "*\n**\n***\n"}, {"input": "5", "expected": "*\n**\n***\n****\n*****\n"}]$func$,
$$["바깥 루프는 줄 수, 안쪽 루프는 별의 개수입니다"]$$,
$$["loops", "pattern", "nested"]$$, 10),

($$c-pyramid-pattern$$, $$cpp$$, $$syntax$$, 52, $$피라미드 패턴$$, $$공백과 별표로 피라미드 그리기$$, $$challenge$$, 2,
$$정수 N이 주어질 때, N줄의 피라미드를 출력하세요.\n예: N=3일 때\n  *\n ***\n*****$$,
$$- 공백과 별표 계산 필요\n- 1 ≤ N ≤ 10$$,
$$[{"input": "3", "output": "  *\n ***\n*****"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < n - i; j++) {
            cout << " ";
        }
        for (int j = 0; j < 2 * i - 1; j++) {
            cout << "*";
        }
        cout << "\n";
    }
    return 0;
}$func$,
$$[{"input": "3", "expected": "  *\n ***\n*****\n"}]$$,
$$["각 줄의 공백 수와 별 수를 계산하세요"]$$,
$$["loops", "pattern", "pyramid"]$$, 15),

($$c-diamond-pattern$$, $$cpp$$, $$syntax$$, 53, $$다이아몬드 패턴$$, $$다이아몬드 모양 그리기$$, $$challenge$$, 2,
$$홀수 N이 주어질 때, N줄의 다이아몬드를 출력하세요.$$,
$$- 상단 절반과 하단 절반으로 나누어 생각\n- N은 홀수$$,
$$[{"input": "5", "output": "  *\n ***\n*****\n ***\n  *"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int mid = n / 2 + 1;

    // 상단
    for (int i = 1; i <= mid; i++) {
        for (int j = 0; j < mid - i; j++) cout << " ";
        for (int j = 0; j < 2 * i - 1; j++) cout << "*";
        cout << "\n";
    }

    // 하단
    for (int i = mid - 1; i >= 1; i--) {
        for (int j = 0; j < mid - i; j++) cout << " ";
        for (int j = 0; j < 2 * i - 1; j++) cout << "*";
        cout << "\n";
    }

    return 0;
}$func$,
$$[{"input": "5", "expected": "  *\n ***\n*****\n ***\n  *\n"}]$$,
$$["중간 지점을 기준으로 상하로 나누세요"]$$,
$$["loops", "pattern", "diamond"]$$, 15),

($$c-formatted-table$$, $$cpp$$, $$syntax$$, 54, $$테이블 형식 출력$$, $$정렬된 테이블 출력하기$$, $$challenge$$, 2,
$$N개의 숫자를 입력받아 3열로 정렬하여 출력하세요.$$,
$$- 각 열의 너비는 5칸\n- 오른쪽 정렬$$,
$$[{"input": "6\n1 22 333 4 55 666", "output": "    1   22  333\n    4   55  666"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    for (int i = 0; i < n; i++) {
        printf("%5d", arr[i]);
        if ((i + 1) % 3 == 0) cout << "\n";
    }
    if (n % 3 != 0) cout << "\n";

    return 0;
}$func$,
$$[{"input": "6\n1 22 333 4 55 666", "expected": "    1   22  333\n    4   55  666\n"}]$$,
$$["%5d는 5칸 오른쪽 정렬입니다"]$$,
$$["output", "formatting", "alignment"]$$, 10),

($$c-ascii-art$$, $$cpp$$, $$syntax$$, 55, $$ASCII 아트$$, $$ASCII 문자로 그림 그리기$$, $$challenge$$, 2,
$$입력받은 문자로 5x5 사각형 테두리를 그리세요.$$,
$$- 테두리만 입력 문자로, 내부는 공백$$,
$$[{"input": "#", "output": "#####\n#   #\n#   #\n#   #\n#####"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    char ch;
    scanf("%c", &ch);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    char ch;
    scanf("%c", &ch);

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (i == 0 || i == 4 || j == 0 || j == 4) {
                printf("%c", ch);
            } else {
                cout << " ";
            }
        }
        cout << "\n";
    }

    return 0;
}$func$,
$$[{"input": "#", "expected": "#####\n#   #\n#   #\n#   #\n#####\n"}]$$,
$$["테두리 조건: 첫/마지막 행 또는 첫/마지막 열"]$$,
$$["pattern", "ascii", "loops"]$$, 15);

-- Unit 2: 변수와 자료형 (Variables and Data Types) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-bit-operations$$, $$cpp$$, $$basics$$, 56, $$비트 연산$$, $$비트 연산자로 값 조작하기$$, $$challenge$$, 2,
$$두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.$$,
$$- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력$$,
$$[{"input": "12 10", "output": "8\n14\n6"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << a & b << endl;
    cout << a | b << endl;
    cout << a ^ b << endl;
    return 0;
}$func$,
$$[{"input": "12 10", "expected": "8\n14\n6\n"}]$$,
$$["& (AND), | (OR), ^ (XOR)"]$$,
$$["bitwise", "operators"]$$, 10),

($$c-sizeof-types$$, $$cpp$$, $$basics$$, 57, $$자료형 크기$$, $$다양한 자료형의 크기 출력하기$$, $$challenge$$, 2,
$$char, int, float, double의 크기를 바이트 단위로 출력하세요.$$,
$$- sizeof 연산자 사용$$,
$$[{"input": "", "output": "1\n4\n4\n8"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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

($$c-type-casting$$, $$cpp$$, $$basics$$, 58, $$타입 캐스팅$$, $$명시적 타입 변환하기$$, $$challenge$$, 2,
$$정수 나눗셈과 실수 나눗셈 결과를 각각 출력하세요.$$,
$$- (float) 캐스팅 사용\n- 소수점 2자리$$,
$$[{"input": "7 2", "output": "3\n3.50"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << a / b << endl;
    printf("%.2f\n", (float)a / b);
    return 0;
}$func$,
$$[{"input": "7 2", "expected": "3\n3.50\n"}]$$,
$$["정수 나눗셈은 소수점을 버립니다"]$$,
$$["casting", "division"]$$, 10),

($$c-const-variables$$, $$cpp$$, $$basics$$, 59, $$상수 사용$$, $$const 키워드로 상수 선언하기$$, $$challenge$$, 2,
$$원의 반지름을 입력받아 둘레와 넓이를 계산하세요. (PI는 상수로 정의)$$,
$$- const double PI = 3.14159;\n- 소수점 2자리$$,
$$[{"input": "5", "output": "31.42\n78.54"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    const double PI = 3.14159;
    int r;
    cin >> r;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    const double PI = 3.14159;
    int r;
    cin >> r;
    printf("%.2f\n", 2 * PI * r);
    printf("%.2f\n", PI * r * r);
    return 0;
}$func$,
$$[{"input": "5", "expected": "31.42\n78.54\n"}]$$,
$$["const는 값을 변경할 수 없게 합니다"]$$,
$$["const", "math"]$$, 10),

($$c-enum-weekday$$, $$cpp$$, $$basics$$, 60, $$열거형 사용$$, $$enum으로 요일 표현하기$$, $$challenge$$, 2,
$$0-6의 숫자를 입력받아 해당하는 요일을 출력하세요.$$,
$$- enum 사용\n- 0=MON, 1=TUE, ..., 6=SUN$$,
$$[{"input": "0", "output": "MON"}, {"input": "3", "output": "THU"}]$$,
$func$#include <iostream>
using namespace std;

enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN };

int main() {
    int day;
    cin >> day;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN };

int main() {
    int day;
    cin >> day;
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
($$c-compound-interest$$, $$cpp$$, $$basics$$, 61, $$복리 계산$$, $$복리 이자 계산하기$$, $$challenge$$, 2,
$$원금 P, 이율 r(%), 기간 n(년)이 주어질 때, 복리 원리금을 계산하세요.\n공식: P * (1 + r/100)^n$$,
$$- pow 함수 사용\n- #include <math.h>\n- 소수점 2자리$$,
$$[{"input": "1000 5 3", "output": "1157.63"}]$$,
$func$#include <iostream>
using namespace std;
#include <math.h>

int main() {
    double P, r;
    int n;
    scanf("%lf %lf %d", &P, &r, &n);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
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

($$c-increment-decrement$$, $$cpp$$, $$basics$$, 62, $$증감 연산자$$, $$전위/후위 증감 연산자 이해하기$$, $$challenge$$, 2,
$$정수 x가 주어질 때, ++x, x++, --x, x--의 결과를 순서대로 출력하세요.$$,
$$- 각 연산 후 x값도 변경됨$$,
$$[{"input": "5", "output": "6\n6\n6\n6"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int x;
    cin >> x;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int x;
    cin >> x;
    cout << ++x << endl;  // 6
    cout << x++ << endl;  // 6 (출력 후 증가)
    cout << --x << endl;  // 6 (다시 감소)
    cout << x-- << endl;  // 6 (출력 후 감소)
    return 0;
}$func$,
$$[{"input": "5", "expected": "6\n6\n6\n6\n"}]$$,
$$["전위는 먼저 증가/감소, 후위는 나중에 증가/감소"]$$,
$$["operators", "increment"]$$, 10),

($$c-ternary-operator$$, $$cpp$$, $$basics$$, 63, $$삼항 연산자$$, $$조건 연산자로 간결한 코드 작성$$, $$challenge$$, 2,
$$세 정수 a, b, c가 주어질 때, 가장 큰 값을 삼항 연산자로 찾아 출력하세요.$$,
$$- ? : 연산자 사용\n- 중첩 삼항 연산자$$,
$$[{"input": "5 8 3", "output": "8"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b >> c;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b >> c;
    int max = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
    cout << max << endl;
    return 0;
}$func$,
$$[{"input": "5 8 3", "expected": "8\n"}]$$,
$$["조건 ? 참일때값 : 거짓일때값"]$$,
$$["operators", "ternary"]$$, 10),

($$c-bitwise-shift$$, $$cpp$$, $$basics$$, 64, $$비트 시프트$$, $$좌측/우측 시프트 연산$$, $$challenge$$, 2,
$$정수 n과 k가 주어질 때, n을 왼쪽으로 k번, 오른쪽으로 k번 시프트한 결과를 출력하세요.$$,
$$- << 와 >> 연산자$$,
$$[{"input": "8 2", "output": "32\n2"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    cout << n << k << endl;
    cout << n >> k << endl;
    return 0;
}$func$,
$$[{"input": "8 2", "expected": "32\n2\n"}]$$,
$$["왼쪽 시프트는 2배씩, 오른쪽은 2로 나누기"]$$,
$$["bitwise", "shift"]$$, 10),

($$c-gcd-lcm$$, $$cpp$$, $$basics$$, 65, $$최대공약수와 최소공배수$$, $$GCD와 LCM 구하기$$, $$challenge$$, 2,
$$두 정수의 최대공약수(GCD)와 최소공배수(LCM)를 구하세요.$$,
$$- 유클리드 호제법 사용\n- LCM = (a * b) / GCD$$,
$$[{"input": "12 18", "output": "6\n36"}]$$,
$func$#include <iostream>
using namespace std;

int gcd(int a, int b) {
    // 여기에 GCD 함수를 작성하세요
}

int main() {
    int a, b;
    cin >> a >> b;
    int g = gcd(a, b);
    cout << g << endl;
    printf("%d\n", (a * b) / g);
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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
    cin >> a >> b;
    int g = gcd(a, b);
    cout << g << endl;
    printf("%d\n", (a * b) / g);
    return 0;
}$func$,
$$[{"input": "12 18", "expected": "6\n36\n"}]$$,
$$["GCD(a, b) = GCD(b, a % b)"]$$,
$$["math", "gcd", "algorithm"]$$, 15);

-- Unit 4: 조건문 (Conditional Statements) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-leap-year$$, $$cpp$$, $$basics$$, 66, $$윤년 판별$$, $$윤년인지 확인하기$$, $$challenge$$, 2,
$$연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수$$,
$$- 조건을 정확히 구현$$,
$$[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int year;
    cin >> year;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int year;
    cin >> year;
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        cout << "Leap" << endl;
    } else {
        cout << "Common" << endl;
    }
    return 0;
}$func$,
$$[{"input": "2000", "expected": "Leap\n"}, {"input": "1900", "expected": "Common\n"}]$$,
$$["논리 연산자를 조합하세요"]$$,
$$["conditionals", "logic"]$$, 10),

($$c-triangle-type$$, $$cpp$$, $$basics$$, 67, $$삼각형 종류$$, $$세 변의 길이로 삼각형 종류 판별$$, $$challenge$$, 2,
$func$세 변 a, b, c가 주어질 때, 정삼각형(Equilateral), 이등변삼각형(Isosceles), 부등변삼각형(Scalene), 또는 삼각형 아님(Not a triangle)을 출력하세요.$func$,
$$- 삼각형 성립 조건: 두 변의 합 > 나머지 한 변$$,
$$[{"input": "3 3 3", "output": "Equilateral"}, {"input": "3 3 5", "output": "Isosceles"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b >> c;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b >> c;

    if (a + b <= c || b + c <= a || a + c <= b) {
        cout << "Not a triangle" << endl;
    } else if (a == b && b == c) {
        cout << "Equilateral" << endl;
    } else if (a == b || b == c || a == c) {
        cout << "Isosceles" << endl;
    } else {
        cout << "Scalene" << endl;
    }

    return 0;
}$func$,
$$[{"input": "3 3 3", "expected": "Equilateral\n"}, {"input": "3 3 5", "expected": "Isosceles\n"}]$$,
$$["먼저 삼각형이 성립하는지 확인하세요"]$$,
$$["conditionals", "geometry"]$$, 15),

($$c-quadrant$$, $$cpp$$, $$basics$$, 68, $$사분면 판별$$, $$좌표의 사분면 결정하기$$, $$challenge$$, 2,
$$점 (x, y)가 주어질 때, 어느 사분면에 속하는지 출력하세요.\n1, 2, 3, 4 중 하나 또는 "Axis"(축 위)$$,
$$- x축, y축 위도 고려$$,
$$[{"input": "5 3", "output": "1"}, {"input": "-2 4", "output": "2"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int x, y;
    cin >> x >> y;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int x, y;
    cin >> x >> y;

    if (x == 0 || y == 0) {
        cout << "Axis" << endl;
    } else if (x > 0 && y > 0) {
        cout << "1" << endl;
    } else if (x < 0 && y > 0) {
        cout << "2" << endl;
    } else if (x < 0 && y < 0) {
        cout << "3" << endl;
    } else {
        cout << "4" << endl;
    }

    return 0;
}$func$,
$$[{"input": "5 3", "expected": "1\n"}, {"input": "-2 4", "expected": "2\n"}]$$,
$$["x, y의 부호를 확인하세요"]$$,
$$["conditionals", "math"]$$, 10),

($$c-bmi-calculator$$, $$cpp$$, $$basics$$, 69, $$BMI 계산기$$, $$체질량지수로 비만도 판정$$, $$challenge$$, 2,
$func$체중(kg)과 키(cm)가 주어질 때, BMI를 계산하고 등급을 출력하세요.\nBMI = 체중 / (키/100)²\n18.5 미만: Underweight, 18.5-25: Normal, 25-30: Overweight, 30 이상: Obese$func$,
$$- 소수점 계산 주의$$,
$$[{"input": "70 175", "output": "Normal"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    double weight, height;
    scanf("%lf %lf", &weight, &height);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    double weight, height;
    scanf("%lf %lf", &weight, &height);

    double bmi = weight / ((height / 100) * (height / 100));

    if (bmi < 18.5) {
        cout << "Underweight" << endl;
    } else if (bmi < 25) {
        cout << "Normal" << endl;
    } else if (bmi < 30) {
        cout << "Overweight" << endl;
    } else {
        cout << "Obese" << endl;
    }

    return 0;
}$func$,
$$[{"input": "70 175", "expected": "Normal\n"}]$$,
$$["키를 미터로 변환하세요"]$$,
$$["conditionals", "math", "health"]$$, 10),

($$c-switch-calculator$$, $$cpp$$, $$basics$$, 70, $$Switch 계산기$$, $$switch문으로 계산기 만들기$$, $$challenge$$, 2,
$$두 정수 a, b와 연산자(+, -, *, /)가 주어질 때, 결과를 출력하세요.$$,
$$- switch 문 사용\n- 나눗셈은 정수 나눗셈$$,
$$[{"input": "10 5 +", "output": "15"}, {"input": "10 3 /", "output": "3"}]$$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    switch (op) {
        case '+':
            cout << a + b << endl;
            break;
        case '-':
            cout << a - b << endl;
            break;
        case '*':
            cout << a * b << endl;
            break;
        case '/':
            cout << a / b << endl;
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
($$c-fibonacci$$, $$cpp$$, $$basics$$, 71, $$피보나치 수열$$, $$N번째 피보나치 수 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)$func$,
$func$- 반복문 사용\n- 1 ≤ N ≤ 20$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;

    int a = 1, b = 1;
    if (n == 1 || n == 2) {
        cout << "1" << endl;
    } else {
        for (int i = 3; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        cout << b << endl;
    }

    return 0;
}$func$,
$func$[{"input": "7", "expected": "13\n"}]$func$,
$func$["이전 두 값을 유지하세요"]$func$,
$$["loops", "fibonacci", "sequence"]$$, 15),

($$c-prime-check$$, $$cpp$$, $$basics$$, 72, $$소수 판별$$, $$소수인지 확인하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 소수이면 "Prime", 아니면 "Not Prime"을 출력하세요.$func$,
$func$- 2부터 √N까지 나누어떨어지는지 확인\n- N ≥ 2$func$,
$func$[{"input": "17", "output": "Prime"}, {"input": "20", "output": "Not Prime"}]$func$,
$func$#include <iostream>
using namespace std;
#include <math.h>

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
#include <math.h>

int main() {
    int n;
    cin >> n;

    if (n < 2) {
        cout << "Not Prime" << endl;
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

($$c-digit-sum$$, $$cpp$$, $$basics$$, 73, $$자릿수 합$$, $$각 자릿수의 합 구하기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 각 자릿수의 합을 구하세요.$func$,
$func$- % 10으로 마지막 자리 추출\n- / 10으로 자릿수 제거$func$,
$func$[{"input": "12345", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;

    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }

    cout << sum << endl;
    return 0;
}$func$,
$func$[{"input": "12345", "expected": "15\n"}]$func$,
$func$["반복하면서 자릿수를 줄여가세요"]$func$,
$$["loops", "digits", "math"]$$, 10),

($$c-reverse-number$$, $$cpp$$, $$basics$$, 74, $$숫자 뒤집기$$, $$숫자를 거꾸로 만들기$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 자릿수를 거꾸로 뒤집은 수를 출력하세요.$func$,
$func$- 1230 → 321 (앞의 0은 무시)$func$,
$func$[{"input": "12345", "output": "54321"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;

    int reversed = 0;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }

    cout << reversed << endl;
    return 0;
}$func$,
$func$[{"input": "12345", "expected": "54321\n"}]$func$,
$func$["역순 수를 10배 하고 마지막 자리를 더하세요"]$func$,
$$["loops", "digits"]$$, 10),

($$c-collatz-conjecture$$, $$cpp$$, $$basics$$, 75, $$콜라츠 추측$$, $$1이 될 때까지의 단계 수$$, $$challenge$$, 2,
$func$정수 N이 주어질 때, 1이 될 때까지의 단계 수를 출력하세요.\n짝수: N/2, 홀수: 3N+1$func$,
$func$- N ≥ 1$func$,
$func$[{"input": "6", "output": "8"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;

    int count = 0;
    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        count++;
    }

    cout << count << endl;
    return 0;
}$func$,
$func$[{"input": "6", "expected": "8\n"}]$func$,
$func$["단계마다 카운트를 증가시키세요"]$func$,
$$["loops", "algorithm", "math"]$$, 15);

-- Unit 6: 함수 (Functions) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-factorial-function$$, $$cpp$$, $$basics$$, 76, $$팩토리얼 함수$$, $$N! 계산 함수 만들기$$, $$challenge$$, 2,
$func$정수 N의 팩토리얼을 계산하는 함수를 작성하세요.$func$,
$func$- int factorial(int n)\n- 반복문 사용$func$,
$func$[{"input": "5", "output": "120"}]$func$,
$func$#include <iostream>
using namespace std;

// 여기에 factorial 함수를 작성하세요

int main() {
    int n;
    cin >> n;
    printf("%d\n", factorial(n));
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int factorial(int n) {
    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main() {
    int n;
    cin >> n;
    printf("%d\n", factorial(n));
    return 0;
}$func$,
$func$[{"input": "5", "expected": "120\n"}]$func$,
$func$["1부터 n까지 곱하세요"]$func$,
$$["functions", "factorial", "math"]$$, 10),

($$c-recursive-fibonacci$$, $$cpp$$, $$basics$$, 77, $$재귀 피보나치$$, $$재귀 함수로 피보나치 수 구하기$$, $$challenge$$, 2,
$func$재귀 함수를 사용하여 N번째 피보나치 수를 구하세요.$func$,
$func$- int fib(int n)\n- 재귀 호출$func$,
$func$[{"input": "7", "output": "13"}]$func$,
$func$#include <iostream>
using namespace std;

// 여기에 fib 함수를 작성하세요

int main() {
    int n;
    cin >> n;
    printf("%d\n", fib(n));
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int fib(int n) {
    if (n <= 2) return 1;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    int n;
    cin >> n;
    printf("%d\n", fib(n));
    return 0;
}$func$,
$func$[{"input": "7", "expected": "13\n"}]$func$,
$func$["기저 사례와 재귀 호출을 구현하세요"]$func$,
$$["functions", "recursion", "fibonacci"]$$, 15),

($$c-power-function$$, $$cpp$$, $$basics$$, 78, $$거듭제곱 함수$$, $$base^exponent 계산하기$$, $$challenge$$, 2,
$func$base와 exponent가 주어질 때, base^exponent를 계산하는 함수를 작성하세요.$func$,
$func$- int power(int base, int exp)\n- 반복문 사용$func$,
$func$[{"input": "2 10", "output": "1024"}]$func$,
$func$#include <iostream>
using namespace std;

// 여기에 power 함수를 작성하세요

int main() {
    int base, exp;
    cin >> base >> exp;
    printf("%d\n", power(base, exp));
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int power(int base, int exp) {
    int result = 1;
    for (int i = 0; i < exp; i++) {
        result *= base;
    }
    return result;
}

int main() {
    int base, exp;
    cin >> base >> exp;
    printf("%d\n", power(base, exp));
    return 0;
}$func$,
$func$[{"input": "2 10", "expected": "1024\n"}]$func$,
$func$["base를 exp번 곱하세요"]$func$,
$$["functions", "power", "math"]$$, 10),

($$c-array-function$$, $$cpp$$, $$basics$$, 79, $$배열 함수$$, $$배열을 함수로 전달하기$$, $$challenge$$, 2,
$func$배열과 크기를 입력받아 평균을 계산하는 함수를 작성하세요.$func$,
$func$- double average(int arr[], int size)$func$,
$func$[{"input": "5\n10 20 30 40 50", "output": "30.00"}]$func$,
$func$#include <iostream>
using namespace std;

// 여기에 average 함수를 작성하세요

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    printf("%.2f\n", average(arr, n));
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

double average(int arr[], int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return (double)sum / size;
}

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    printf("%.2f\n", average(arr, n));
    return 0;
}$func$,
$func$[{"input": "5\n10 20 30 40 50", "expected": "30.00\n"}]$func$,
$func$["배열은 포인터로 전달됩니다"]$func$,
$$["functions", "arrays", "average"]$$, 15),

($$c-pass-by-reference$$, $$cpp$$, $$basics$$, 80, $$참조로 전달$$, $$포인터로 값 변경하기$$, $$challenge$$, 2,
$func$두 정수의 합과 차를 동시에 구하는 함수를 작성하세요.$func$,
$func$- void calculate(int a, int b, int *sum, int *diff)$func$,
$func$[{"input": "10 3", "output": "13\n7"}]$func$,
$func$#include <iostream>
using namespace std;

// 여기에 calculate 함수를 작성하세요

int main() {
    int a, b, sum, diff;
    cin >> a >> b;
    calculate(a, b, &sum, &diff);
    printf("%d\n%d\n", sum, diff);
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

void calculate(int a, int b, int *sum, int *diff) {
    *sum = a + b;
    *diff = a - b;
}

int main() {
    int a, b, sum, diff;
    cin >> a >> b;
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
($$c-bubble-sort$$, $$cpp$$, $$advanced$$, 81, $$버블 정렬$$, $$배열을 오름차순으로 정렬하기$$, $$challenge$$, 3,
$func$N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.$func$,
$func$- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    // 여기에 버블 정렬 코드를 작성하세요

    for (int i = 0; i < n; i++) {
        cout << arr[i] << " ";
    }
    cout << "\n";
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
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
        cout << arr[i] << " ";
    }
    cout << "\n";
    return 0;
}$func$,
$func$[{"input": "5\n64 34 25 12 22", "expected": "12 22 25 34 64 \n"}]$func$,
$func$["중첩 루프로 인접 원소를 비교하세요"]$func$,
$$["arrays", "sorting", "bubble-sort"]$$, 20),

($$c-binary-search$$, $$cpp$$, $$advanced$$, 82, $$이진 탐색$$, $$정렬된 배열에서 값 찾기$$, $$challenge$$, 3,
$func$정렬된 배열에서 target을 이진 탐색으로 찾아 인덱스를 반환하세요. 없으면 -1$func$,
$func$- 중간값과 비교하여 탐색 범위를 절반씩 줄임$func$,
$func$[{"input": "5\n1 3 5 7 9\n5", "output": "2"}]$func$,
$func$#include <iostream>
using namespace std;

int binarySearch(int arr[], int size, int target) {
    // 여기에 이진 탐색 코드를 작성하세요
}

int main() {
    int n, target;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cin >> target;
    printf("%d\n", binarySearch(arr, n, target));
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cin >> target;
    printf("%d\n", binarySearch(arr, n, target));
    return 0;
}$func$,
$func$[{"input": "5\n1 3 5 7 9\n5", "expected": "2\n"}]$func$,
$func$["left, right 포인터로 범위를 좁혀가세요"]$func$,
$$["arrays", "search", "binary-search"]$$, 20),

($$c-2d-array-transpose$$, $$cpp$$, $$advanced$$, 83, $$행렬 전치$$, $$2차원 배열 전치하기$$, $$challenge$$, 3,
$func$N×M 행렬을 전치(행과 열을 바꿈)하여 출력하세요.$func$,
$func$- 2 ≤ N, M ≤ 10$func$,
$func$[{"input": "2 3\n1 2 3\n4 5 6", "output": "1 4\n2 5\n3 6"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, m;
    cin >> n >> m;
    int arr[10][10];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> arr[i][j];
        }
    }
    // 여기에 전치 및 출력 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, m;
    cin >> n >> m;
    int arr[10][10];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> arr[i][j];
        }
    }

    for (int j = 0; j < m; j++) {
        for (int i = 0; i < n; i++) {
            cout << arr[i][j] << " ";
        }
        cout << "\n";
    }

    return 0;
}$func$,
$func$[{"input": "2 3\n1 2 3\n4 5 6", "expected": "1 4 \n2 5 \n3 6 \n"}]$func$,
$func$["행과 열의 인덱스를 바꿔서 출력하세요"]$func$,
$$["arrays", "2d-array", "matrix"]$$, 20),

($$c-array-rotation$$, $$cpp$$, $$advanced$$, 84, $$배열 회전$$, $$배열을 K번 회전하기$$, $$challenge$$, 3,
$func$N개의 정수 배열을 왼쪽으로 K번 회전하세요.$func$,
$func$- 회전: [1,2,3,4,5]를 1번 회전 → [2,3,4,5,1]$func$,
$func$[{"input": "5 2\n1 2 3 4 5", "output": "3 4 5 1 2"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    // 여기에 회전 코드를 작성하세요

    for (int i = 0; i < n; i++) {
        cout << arr[i] << " ";
    }
    cout << "\n";
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    int arr[100], temp[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    k = k % n;  // k가 n보다 클 경우 대비
    for (int i = 0; i < n; i++) {
        temp[i] = arr[(i + k) % n];
    }
    for (int i = 0; i < n; i++) {
        arr[i] = temp[i];
    }

    for (int i = 0; i < n; i++) {
        cout << arr[i] << " ";
    }
    cout << "\n";
    return 0;
}$func$,
$func$[{"input": "5 2\n1 2 3 4 5", "expected": "3 4 5 1 2 \n"}]$func$,
$func$["임시 배열을 사용하거나 % 연산으로 인덱스 계산"]$func$,
$$["arrays", "rotation"]$$, 25),

($$c-subarray-sum$$, $$cpp$$, $$advanced$$, 85, $$부분 배열 합$$, $$연속된 부분 배열의 최대 합$$, $$challenge$$, 3,
$func$N개의 정수 배열에서 연속된 부분 배열의 합 중 최댓값을 구하세요. (카데인 알고리즘)$func$,
$func$- 음수 포함 가능\n- 1 ≤ N ≤ 100$func$,
$func$[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "output": "6"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    // 여기에 카데인 알고리즘을 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int maxSum = arr[0];
    int currentSum = arr[0];

    for (int i = 1; i < n; i++) {
        currentSum = (currentSum + arr[i] > arr[i]) ? currentSum + arr[i] : arr[i];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    cout << maxSum << endl;
    return 0;
}$func$,
$func$[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "expected": "6\n"}]$func$,
$func$["현재까지의 합 vs 새로 시작, 둘 중 큰 값 선택"]$func$,
$$["arrays", "kadane", "algorithm"]$$, 30);

-- Unit 8: 포인터 (Pointers) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-pointer-arithmetic$$, $$cpp$$, $$advanced$$, 86, $$포인터 산술$$, $$포인터로 배열 순회하기$$, $$challenge$$, 3,
$func$배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.$func$,
$func$- [] 사용 금지, *(ptr + i) 형태 사용$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int *ptr = arr;
    // 여기에 포인터 산술로 합을 구하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int *ptr = arr;
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += *(ptr + i);
    }

    cout << sum << endl;
    return 0;
}$func$,
$func$[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]$func$,
$func$["ptr + i는 i번째 요소의 주소입니다"]$func$,
$$["pointers", "arithmetic"]$$, 20),

($$c-double-pointer$$, $$cpp$$, $$advanced$$, 87, $$이중 포인터$$, $$포인터의 포인터 사용하기$$, $$challenge$$, 3,
$func$이중 포인터를 사용하여 두 포인터가 가리키는 값을 교환하세요.$func$,
$func$- void swap(int **pp1, int **pp2)$func$,
$func$[{"input": "10 20", "output": "20 10"}]$func$,
$func$#include <iostream>
using namespace std;

void swap(int **pp1, int **pp2) {
    // 여기에 이중 포인터로 교환하는 코드를 작성하세요
}

int main() {
    int a, b;
    cin >> a >> b;
    int *p1 = &a, *p2 = &b;
    swap(&p1, &p2);
    printf("%d %d\n", *p1, *p2);
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

void swap(int **pp1, int **pp2) {
    int *temp = *pp1;
    *pp1 = *pp2;
    *pp2 = temp;
}

int main() {
    int a, b;
    cin >> a >> b;
    int *p1 = &a, *p2 = &b;
    swap(&p1, &p2);
    printf("%d %d\n", *p1, *p2);
    return 0;
}$func$,
$func$[{"input": "10 20", "expected": "20 10\n"}]$func$,
$func$["**pp는 포인터가 가리키는 포인터가 가리키는 값"]$func$,
$$["pointers", "double-pointer"]$$, 25),

($$c-function-pointer$$, $$cpp$$, $$advanced$$, 88, $$함수 포인터$$, $$함수 포인터로 연산 선택$$, $$challenge$$, 3,
$func$함수 포인터를 사용하여 사칙연산을 선택적으로 수행하세요.$func$,
$func$- int (*operation)(int, int)$func$,
$func$[{"input": "10 5 +", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    // 여기에 함수 포인터를 사용하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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

($$c-dynamic-array$$, $$cpp$$, $$advanced$$, 89, $$동적 배열$$, $$malloc으로 동적 메모리 할당$$, $$challenge$$, 3,
$func$크기를 입력받아 동적 배열을 생성하고, 값을 입력받아 합을 구하세요.$func$,
$func$- malloc 사용\n- free로 메모리 해제$func$,
$func$[{"input": "5\n1 2 3 4 5", "output": "15"}]$func$,
$func$#include <iostream>
using namespace std;
#include <stdlib.h>

int main() {
    int n;
    cin >> n;

    // 여기에 malloc으로 배열을 할당하고 사용하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
#include <stdlib.h>

int main() {
    int n;
    cin >> n;

    int *arr = (int*)malloc(n * sizeof(int));

    int sum = 0;
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        sum += arr[i];
    }

    cout << sum << endl;

    free(arr);
    return 0;
}$func$,
$func$[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]$func$,
$func$["malloc(크기)로 할당, free(포인터)로 해제"]$func$,
$$["pointers", "malloc", "dynamic"]$$, 25),

($$c-linked-list-basics$$, $$cpp$$, $$advanced$$, 90, $$연결 리스트 기초$$, $$단순 연결 리스트 구현$$, $$challenge$$, 3,
$func$정수를 저장하는 연결 리스트를 만들고 모든 값을 출력하세요.$func$,
$func$- struct Node 정의\n- 동적 할당 사용$func$,
$func$[{"input": "3\n1 2 3", "output": "1 2 3"}]$func$,
$func$#include <iostream>
using namespace std;
#include <stdlib.h>

struct Node {
    int data;
    struct Node *next;
};

int main() {
    int n;
    cin >> n;

    // 여기에 연결 리스트를 만들고 출력하는 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
#include <stdlib.h>

struct Node {
    int data;
    struct Node *next;
};

int main() {
    int n;
    cin >> n;

    struct Node *head = NULL, *tail = NULL;

    for (int i = 0; i < n; i++) {
        int val;
        cin >> val;

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
        cout << current->data << " ";
        current = current->next;
    }
    cout << "\n";

    return 0;
}$func$,
$func$[{"input": "3\n1 2 3", "expected": "1 2 3 \n"}]$func$,
$func$["각 노드를 동적 할당하고 연결하세요"]$func$,
$$["pointers", "linked-list", "data-structures"]$$, 30);

-- Unit 9: 파일 입출력 (File I/O) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-file-write$$, $$cpp$$, $$advanced$$, 91, $$파일 쓰기$$, $$파일에 텍스트 쓰기$$, $$challenge$$, 3,
$func$문자열을 입력받아 "output.txt" 파일에 쓰세요.$func$,
$func$- fopen, fprintf, fclose 사용$func$,
$func$[{"input": "Hello World", "output": "File written"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // 여기에 파일 쓰기 코드를 작성하세요

    cout << "File written" << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    FILE *fp = fopen("output.txt", "w");
    if (fp != NULL) {
        fprintf(fp, "%s", str);
        fclose(fp);
    }

    cout << "File written" << endl;
    return 0;
}$func$,
$func$[{"input": "Hello World", "expected": "File written\n"}]$func$,
$func$["fopen(파일명, 모드), fprintf(파일, 형식, ...), fclose(파일)"]$func$,
$$["file-io", "write"]$$, 20),

($$c-file-read$$, $$cpp$$, $$advanced$$, 92, $$파일 읽기$$, $$파일에서 텍스트 읽기$$, $$challenge$$, 3,
$func$"input.txt" 파일의 내용을 읽어 화면에 출력하세요.$func$,
$func$- fopen, fgets, fclose 사용$func$,
$func$[{"input": "", "output": "File content"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 파일 읽기 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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

($$c-file-copy$$, $$cpp$$, $$advanced$$, 93, $$파일 복사$$, $$파일 내용을 다른 파일로 복사$$, $$challenge$$, 3,
$func$"source.txt"의 내용을 "dest.txt"로 복사하세요.$func$,
$func$- 읽기와 쓰기를 동시에$func$,
$func$[{"input": "", "output": "File copied"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 파일 복사 코드를 작성하세요

    cout << "File copied" << endl;
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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

    cout << "File copied" << endl;
    return 0;
}$func$,
$func$[{"input": "", "expected": "File copied\n"}]$func$,
$func$["fgetc로 한 문자씩 읽고 fputc로 씁니다"]$func$,
$$["file-io", "copy"]$$, 25),

($$c-file-word-count$$, $$cpp$$, $$advanced$$, 94, $$파일 단어 수$$, $$파일의 단어 개수 세기$$, $$challenge$$, 3,
$func$"text.txt" 파일의 단어 개수를 세어 출력하세요.$func$,
$func$- 공백으로 구분된 단어$func$,
$func$[{"input": "", "output": "5"}]$func$,
$func$#include <iostream>
using namespace std;

int main() {
    // 여기에 단어 카운트 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;

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

    cout << count << endl;
    return 0;
}$func$,
$func$[{"input": "", "expected": "5\n"}]$func$,
$func$["fscanf로 단어를 하나씩 읽으세요"]$func$,
$$["file-io", "parsing"]$$, 25),

($$c-binary-file$$, $$cpp$$, $$advanced$$, 95, $$바이너리 파일$$, $$구조체를 바이너리 파일로 저장$$, $$challenge$$, 3,
$func$Person 구조체를 바이너리 파일에 쓰고 읽으세요.$func$,
$func$- fwrite, fread 사용\n- "rb", "wb" 모드$func$,
$func$[{"input": "John 25", "output": "John 25"}]$func$,
$func$#include <iostream>
using namespace std;

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
$func$#include <iostream>
using namespace std;

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
($$c-string-reverse$$, $$cpp$$, $$advanced$$, 96, $$문자열 뒤집기$$, $$문자열을 거꾸로 만들기$$, $$challenge$$, 3,
$func$문자열을 입력받아 뒤집어서 출력하세요.$func$,
$func$- 직접 구현 (strrev 사용 금지)$func$,
$func$[{"input": "hello", "output": "olleh"}]$func$,
$func$#include <iostream>
using namespace std;
#include <string.h>

int main() {
    char str[100];
    scanf("%s", str);

    // 여기에 문자열 뒤집기 코드를 작성하세요

    printf("%s\n", str);
    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
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

($$c-palindrome-check$$, $$cpp$$, $$advanced$$, 97, $$회문 검사$$, $$회문인지 확인하기$$, $$challenge$$, 3,
$func$문자열이 회문(앞뒤가 같음)인지 확인하세요. "Yes" 또는 "No"$func$,
$func$- 대소문자 구분 없음$func$,
$func$[{"input": "racecar", "output": "Yes"}, {"input": "hello", "output": "No"}]$func$,
$func$#include <iostream>
using namespace std;
#include <string.h>
#include <ctype.h>

int main() {
    char str[100];
    scanf("%s", str);

    // 여기에 회문 검사 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
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

($$c-string-tokenize$$, $$cpp$$, $$advanced$$, 98, $$문자열 토큰화$$, $$공백으로 문자열 나누기$$, $$challenge$$, 3,
$func$공백으로 구분된 문자열을 나누어 각 단어를 한 줄씩 출력하세요.$func$,
$func$- strtok 사용$func$,
$func$[{"input": "hello world test", "output": "hello\nworld\ntest"}]$func$,
$func$#include <iostream>
using namespace std;
#include <string.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // 여기에 토큰화 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
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

($$c-anagram-check$$, $$cpp$$, $$advanced$$, 99, $$애너그램 검사$$, $$두 문자열이 애너그램인지 확인$$, $$challenge$$, 3,
$func$두 문자열이 애너그램(같은 문자로 구성)인지 확인하세요.$func$,
$func$- 문자 빈도수를 세어 비교$func$,
$func$[{"input": "listen\nsilent", "output": "Yes"}]$func$,
$func$#include <iostream>
using namespace std;
#include <string.h>

int main() {
    char str1[100], str2[100];
    scanf("%s %s", str1, str2);

    // 여기에 애너그램 검사 코드를 작성하세요

    return 0;
}$func$,
$func$#include <iostream>
using namespace std;
#include <string.h>

int main() {
    char str1[100], str2[100];
    scanf("%s %s", str1, str2);

    if (strlen(str1) != strlen(str2)) {
        cout << "No" << endl;
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

($$c-substring-search$$, $$cpp$$, $$advanced$$, 100, $$부분 문자열 찾기$$, $$문자열 내 부분 문자열 위치 찾기$$, $$challenge$$, 3,
$func$문자열 s에서 패턴 p가 처음 나타나는 위치를 출력하세요. 없으면 -1$func$,
$func$- 직접 구현 (strstr 사용 금지)\n- 인덱스는 0부터$func$,
$func$[{"input": "hello world\nworld", "output": "6"}]$func$,
$func$#include <iostream>
using namespace std;
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
$func$#include <iostream>
using namespace std;
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

    cout << found << endl;
    return 0;
}$func$,
$func$[{"input": "hello world\nworld", "expected": "6\n"}]$func$,
$$["각 위치에서 패턴과 일치하는지 확인"]$$,
$$["strings", "search", "algorithm"]$$, 30);

-- ============================================================================
-- End of C Language Part 2
-- ============================================================================

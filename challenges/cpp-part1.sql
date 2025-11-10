-- ============================================================================
-- C++ Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

-- Unit 1: 출력�?주석 (Output and Comments) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-hello-world', 'cpp', 'syntax', 1, 'Hello World', 'C++�?�??�로그램 ?�성?�기', 'challenge', 1,
'?�면??"Hello, World!"�?출력?�는 ?�로그램???�성?�세??',
'- cout???�용?�세??n- endl ?�는 \n?�로 줄바�?,
'[{"input": "", "output": "Hello, World!"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Hello, World!\n"}]',
'["cout << �?출력?�니??, "endl?� 줄바꿈을 ?��??�니??]',
ARRAY['basics', 'output', 'cout'], 5),

('cpp-print-numbers', 'cpp', 'syntax', 2, '?�자 출력', '?�러 ?�자 출력?�기', 'challenge', 1,
'?�수 10, 20, 30??공백?�로 구분?�여 ??줄에 출력?�세??',
'- << ?�산?��? ?�결?�여 ?�용',
'[{"input": "", "output": "10 20 30"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "10 20 30\n"}]',
'["<< ?�산?��? ?�러 �??�용?????�습?�다"]',
ARRAY['basics', 'output'], 5),

('cpp-multiline', 'cpp', 'syntax', 3, '?�러 �?출력', '?�러 줄로 출력?�기', 'challenge', 1,
'??줄에 걸쳐 "Line 1", "Line 2", "Line 3"??출력?�세??',
'- endl ?�는 \n ?�용',
'[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]',
'["cout???�러 �??�출?�거??\\n???�용?�세??]',
ARRAY['basics', 'output'], 5),

('cpp-single-comment', 'cpp', 'syntax', 4, '??�?주석', '주석 ?�용?�기', 'challenge', 1,
'"C++"�?출력?�고, �??�에 ??�?주석?�로 "This is C++"�?추�??�세??',
'- // 주석 ?�용',
'[{"input": "", "output": "C++"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??주석�?코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "C++\n"}]',
'["// ?�의 ?�용?� ?�행?��? ?�습?�다"]',
ARRAY['basics', 'comments'], 5),

('cpp-multi-comment', 'cpp', 'syntax', 5, '?�러 �?주석', '?�러 �?주석 ?�용?�기', 'challenge', 1,
'"Programming"??출력?�고, ?�에 ?�러 �?주석??추�??�세??',
'- /* */ ?�용',
'[{"input": "", "output": "Programming"}]',
'#include <iostream>
using namespace std;

int main() {
    /* ?�기??주석???�성?�세??*/

    return 0;
}',
'',
'[{"input": "", "expected": "Programming\n"}]',
'["/* */ ?�이??모든 ?�용?� 주석?�니??]',
ARRAY['basics', 'comments'], 5);

-- Unit 2: 변?��? ?�료??(Variables and Data Types) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-int-variable', 'cpp', 'syntax', 6, '?�수 변??, '?�수??변???�언�?출력', 'challenge', 1,
'?�수??변??num???�언?�고 100???�?�한 ??출력?�세??',
'- int ?�???�용',
'[{"input": "", "output": "100"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "100\n"}]',
'["int???�수�??�?�합?�다"]',
ARRAY['basics', 'variables', 'int'], 5),

('cpp-double-variable', 'cpp', 'syntax', 7, '?�수 변??, '?�수??변???�언�?출력', 'challenge', 1,
'?�수??변??pi�??�언?�고 3.14159�??�?�한 ??출력?�세??',
'- double ?�???�용',
'[{"input": "", "output": "3.14159"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "3.14159\n"}]',
'["double?� ?�수�??�?�합?�다"]',
ARRAY['basics', 'variables', 'double'], 5),

('cpp-string-variable', 'cpp', 'syntax', 8, '문자??변??, 'string ?�???�용?�기', 'challenge', 1,
'문자??변??name??"Alice"�??�?�하�?출력?�세??',
'- string ?�???�용',
'[{"input": "", "output": "Alice"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Alice\n"}]',
'["string?� C++??문자???�?�입?�다"]',
ARRAY['basics', 'variables', 'string'], 5),

('cpp-bool-variable', 'cpp', 'syntax', 9, '불린 변??, 'bool ?�???�용?�기', 'challenge', 1,
'불린 변??isTrue??true�??�?�하�?출력?�세??',
'- bool ?�???�용\n- boolalpha ?�용?�여 true/false�?출력',
'[{"input": "", "output": "true"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??    // cout << boolalpha �??�용?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "true\n"}]',
'["boolalpha??불린값을 문자�?출력?�니??]',
ARRAY['basics', 'variables', 'bool'], 5),

('cpp-auto-keyword', 'cpp', 'syntax', 10, 'auto ?�워??, '?�???�동 추론?�기', 'challenge', 1,
'auto ?�워?�로 변?��? ?�언?�고 42�??�?�한 ??출력?�세??',
'- auto ?�워???�용',
'[{"input": "", "output": "42"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "42\n"}]',
'["auto??초기값으�??�?�을 ?�동 추론?�니??]',
ARRAY['basics', 'variables', 'auto'], 5);

-- Unit 3: ?�산??(Operators) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-arithmetic', 'cpp', 'basics', 11, '?�칙?�산', '기본 ?�술 ?�산?�기', 'challenge', 1,
'???�수 a=20, b=3???�셈, 뺄셈, 곱셈, ?�눗??결과�?�?줄에 출력?�세??',
'- +, -, *, / ?�산???�용',
'[{"input": "", "output": "23\n17\n60\n6"}]',
'#include <iostream>
using namespace std;

int main() {
    int a = 20, b = 3;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "23\n17\n60\n6\n"}]',
'["?�수 ?�눗?��? ?�수?�을 버립?�다"]',
ARRAY['basics', 'operators', 'arithmetic'], 5),

('cpp-modulo', 'cpp', 'basics', 12, '?�머지 ?�산', '?�머지 구하�?, 'challenge', 1,
'???�수 a=17, b=5???�머지�?출력?�세??',
'- % ?�산???�용',
'[{"input": "", "output": "2"}]',
'#include <iostream>
using namespace std;

int main() {
    int a = 17, b = 5;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "2\n"}]',
'["% ?�산?�로 ?�머지�?구합?�다"]',
ARRAY['basics', 'operators', 'modulo'], 5),

('cpp-increment', 'cpp', 'basics', 13, '증감 ?�산??, '++?� -- ?�용?�기', 'challenge', 1,
'?�수 x=5???�??++x, x++??결과�?�?줄에 출력?�세??',
'- ?�위/?�위 증�? ?�산??,
'[{"input": "", "output": "6\n6"}]',
'#include <iostream>
using namespace std;

int main() {
    int x = 5;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "6\n6\n"}]',
'["?�위??먼�? 증�?, ?�위???�중??증�?"]',
ARRAY['basics', 'operators', 'increment'], 5),

('cpp-comparison', 'cpp', 'basics', 14, '비교 ?�산??, '�?비교?�기', 'challenge', 1,
'???�수 a=10, b=20???�??a < b, a == b??결과�?출력?�세??',
'- boolalpha ?�용?�여 true/false�?출력',
'[{"input": "", "output": "true\nfalse"}]',
'#include <iostream>
using namespace std;

int main() {
    int a = 10, b = 20;
    cout << boolalpha;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "true\nfalse\n"}]',
'["비교 ?�산?�는 bool 값을 반환?�니??]',
ARRAY['basics', 'operators', 'comparison'], 5),

('cpp-logical', 'cpp', 'basics', 15, '?�리 ?�산??, 'AND, OR, NOT ?�용?�기', 'challenge', 1,
'bool a=true, b=false???�??a && b, a || b, !a??결과�?출력?�세??',
'- &&, ||, ! ?�산??,
'[{"input": "", "output": "false\ntrue\nfalse"}]',
'#include <iostream>
using namespace std;

int main() {
    bool a = true, b = false;
    cout << boolalpha;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "false\ntrue\nfalse\n"}]',
'["&&??AND, ||??OR, !??NOT"]',
ARRAY['basics', 'operators', 'logical'], 5);

-- Unit 4: 조건�?(Conditional Statements) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-if-positive', 'cpp', 'basics', 16, '?�수 ?�별', '?�자가 ?�수?��? ?�인', 'challenge', 1,
'?�수 num???�력받아 ?�수?�면 "Positive"�?출력?�세??',
'- if �??�용',
'[{"input": "10", "output": "Positive"}]',
'#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10", "expected": "Positive\n"}]',
'["if (조건) { ?�행??코드 }"]',
ARRAY['conditionals', 'if'], 5),

('cpp-if-else-even', 'cpp', 'basics', 17, '짝수 ?�??, '짝수?��? ?�?�인지 ?�별', 'challenge', 1,
'?�수 num???�력받아 짝수�?"Even", ?�?�면 "Odd"�?출력?�세??',
'- if-else �??�용',
'[{"input": "8", "output": "Even"}, {"input": "5", "output": "Odd"}]',
'#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "8", "expected": "Even\n"}, {"input": "5", "expected": "Odd\n"}]',
'["num % 2 == 0?�면 짝수?�니??]',
ARRAY['conditionals', 'if-else'], 5),

('cpp-if-else-max', 'cpp', 'basics', 18, '????찾기', '????�?????출력', 'challenge', 1,
'???�수 a, b�??�력받아 ???��? 출력?�세??',
'- if-else �??�용',
'[{"input": "15 25", "output": "25"}]',
'#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "15 25", "expected": "25\n"}]',
'["a?� b�?비교?�세??]',
ARRAY['conditionals', 'comparison'], 5),

('cpp-if-else-if-grade', 'cpp', 'basics', 19, '?�점 계산', '?�수�??�급 매기�?, 'challenge', 1,
'?�수�??�력받아 90 ?�상 A, 80 ?�상 B, 70 ?�상 C, �???F�?출력?�세??',
'- if-else if-else �?,
'[{"input": "95", "output": "A"}, {"input": "85", "output": "B"}]',
'#include <iostream>
using namespace std;

int main() {
    int score;
    cin >> score;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "95", "expected": "A\n"}, {"input": "85", "expected": "B\n"}]',
'["조건???�서?��??�인?�세??]',
ARRAY['conditionals', 'if-else-if'], 5),

('cpp-ternary', 'cpp', 'basics', 20, '?�항 ?�산??, '조건 ?�산???�용?�기', 'challenge', 1,
'?�수 n???�력받아 짝수�?"Even", ?�?�면 "Odd"�??�항 ?�산?�로 출력?�세??',
'- ? : ?�산???�용',
'[{"input": "6", "output": "Even"}]',
'#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "6", "expected": "Even\n"}]',
'["조건 ? 참일?�값 : 거짓?�때�?]',
ARRAY['conditionals', 'ternary'], 5);

-- Unit 5: 반복�?(Loops) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-for-loop', 'cpp', 'basics', 21, 'for 반복�?, '1부??10까�? 출력', 'challenge', 1,
'for문을 ?�용?�여 1부??10까�? 출력?�세??',
'- for �??�용',
'[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 6 7 8 9 10 \n"}]',
'["for (초기�? 조건; 증감) { }"]',
ARRAY['loops', 'for'], 5),

('cpp-while-loop', 'cpp', 'basics', 22, 'while 반복�?, '카운?�다??출력', 'challenge', 1,
'while문으�?5부??1까�? 카운?�다?�하?�요.',
'- while �??�용',
'[{"input": "", "output": "5 4 3 2 1"}]',
'#include <iostream>
using namespace std;

int main() {
    int count = 5;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "5 4 3 2 1 \n"}]',
'["while (조건) { ... }"]',
ARRAY['loops', 'while'], 5),

('cpp-sum-loop', 'cpp', 'basics', 23, '?�계 계산', '1부??N까�? ??, 'challenge', 1,
'?�수 N???�력받아 1부??N까�????�을 계산?�세??',
'- for �??�용',
'[{"input": "10", "output": "55"}]',
'#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10", "expected": "55\n"}]',
'["sum???�적?�세??]',
ARRAY['loops', 'for', 'sum'], 5),

('cpp-multiplication-table', 'cpp', 'basics', 24, '구구??, 'N??구구??출력', 'challenge', 1,
'?�수 N???�력받아 N??구구??1~9)??출력?�세??',
'- ?�식: N x 1 = 결과',
'[{"input": "5", "output": "5 x 1 = 5\n5 x 2 = 10\n5 x 3 = 15\n5 x 4 = 20\n5 x 5 = 25\n5 x 6 = 30\n5 x 7 = 35\n5 x 8 = 40\n5 x 9 = 45"}]',
'#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "5 x 1 = 5\n5 x 2 = 10\n5 x 3 = 15\n5 x 4 = 20\n5 x 5 = 25\n5 x 6 = 30\n5 x 7 = 35\n5 x 8 = 40\n5 x 9 = 45\n"}]',
'["1부??9까�? 반복?�세??]',
ARRAY['loops', 'multiplication'], 5),

('cpp-do-while', 'cpp', 'basics', 25, 'do-while 반복�?, 'do-while ?�용?�기', 'challenge', 1,
'do-while문으�?1부??5까�? 출력?�세??',
'- do-while �??�용',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <iostream>
using namespace std;

int main() {
    int i = 1;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 \n"}]',
'["do { } while (조건);"]',
ARRAY['loops', 'do-while'], 5);

-- Unit 6: ?�수 (Functions) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-function-add', 'cpp', 'basics', 26, '?�셈 ?�수', '???��? ?�하???�수', 'challenge', 1,
'???�수�??�하??add ?�수�??�성?�세??',
'- int add(int a, int b)',
'[{"input": "5 7", "output": "12"}]',
'#include <iostream>
using namespace std;

// ?�기??add ?�수�??�성?�세??
int main() {
    int a, b;
    cin >> a >> b;
    cout << add(a, b) << endl;
    return 0;
}',
'',
'[{"input": "5 7", "expected": "12\n"}]',
'["return a + b;"]',
ARRAY['functions', 'return'], 5),

('cpp-function-max', 'cpp', 'basics', 27, '최댓�??�수', '????반환?�기', 'challenge', 1,
'???�수 �???값을 반환?�는 max ?�수�??�성?�세??',
'- int max(int a, int b)',
'[{"input": "10 20", "output": "20"}]',
'#include <iostream>
using namespace std;

// ?�기??max ?�수�??�성?�세??
int main() {
    int a, b;
    cin >> a >> b;
    cout << max(a, b) << endl;
    return 0;
}',
'',
'[{"input": "10 20", "expected": "20\n"}]',
'["조건???�라 ?�른 값을 반환"]',
ARRAY['functions', 'conditionals'], 5),

('cpp-function-void', 'cpp', 'basics', 28, 'void ?�수', '반환�??�는 ?�수', 'challenge', 1,
'문자?�을 출력?�는 void ?�??printMessage ?�수�??�성?�세??',
'- void printMessage()',
'[{"input": "", "output": "Hello from function"}]',
'#include <iostream>
using namespace std;

// ?�기??printMessage ?�수�??�성?�세??
int main() {
    printMessage();
    return 0;
}',
'',
'[{"input": "", "expected": "Hello from function\n"}]',
'["void??반환값이 ?�습?�다"]',
ARRAY['functions', 'void'], 5),

('cpp-function-square', 'cpp', 'basics', 29, '?�곱 ?�수', '?�자???�곱 구하�?, 'challenge', 1,
'?�수 n???�곱??반환?�는 square ?�수�??�성?�세??',
'- int square(int n)',
'[{"input": "7", "output": "49"}]',
'#include <iostream>
using namespace std;

// ?�기??square ?�수�??�성?�세??
int main() {
    int n;
    cin >> n;
    cout << square(n) << endl;
    return 0;
}',
'',
'[{"input": "7", "expected": "49\n"}]',
'["return n * n;"]',
ARRAY['functions', 'math'], 5),

('cpp-function-is-even', 'cpp', 'basics', 30, '짝수 ?�별 ?�수', '짝수?��? ?�인?�는 ?�수', 'challenge', 1,
'?�수가 짝수�?true, ?�?�면 false�?반환?�는 isEven ?�수�??�성?�세??',
'- bool isEven(int n)',
'[{"input": "8", "output": "true"}]',
'#include <iostream>
using namespace std;

// ?�기??isEven ?�수�??�성?�세??
int main() {
    int n;
    cin >> n;
    cout << boolalpha << isEven(n) << endl;
    return 0;
}',
'',
'[{"input": "8", "expected": "true\n"}]',
'["n % 2 == 0??반환?�세??]',
ARRAY['functions', 'bool'], 5);

-- Unit 7: 배열 (Arrays) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-array-declare', 'cpp', 'basics', 31, '배열 ?�언', '배열 ?�언�?초기??, 'challenge', 1,
'?�기 5???�수 배열??{1,2,3,4,5}�?초기?�하�?모든 ?�소�?출력?�세??',
'- int arr[5]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <iostream>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 \n"}]',
'["int arr[] = {1, 2, 3, 4, 5};"]',
ARRAY['arrays', 'basics'], 5),

('cpp-array-sum', 'cpp', 'basics', 32, '배열 ?�계', '배열 ?�소????, 'challenge', 1,
'5개의 ?�수�??�력받아 ?�을 계산?�세??',
'- for �??�용',
'[{"input": "1 2 3 4 5", "output": "15"}]',
'#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // ?�기???�계 계산 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5", "expected": "15\n"}]',
'["sum += arr[i]�??�적"]',
ARRAY['arrays', 'sum'], 5),

('cpp-array-max', 'cpp', 'basics', 33, '배열 최댓�?, '배열?�서 최댓�?찾기', 'challenge', 1,
'5개의 ?�수�??�력받아 최댓값을 출력?�세??',
'- for 문과 if �??�용',
'[{"input": "3 7 2 9 5", "output": "9"}]',
'#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // ?�기??최댓�?찾기 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3 7 2 9 5", "expected": "9\n"}]',
'["�??�소�?max�??�정?�고 비교"]',
ARRAY['arrays', 'max'], 5),

('cpp-array-reverse', 'cpp', 'basics', 34, '배열 ??�� 출력', '배열??거꾸�?출력', 'challenge', 1,
'5개의 ?�수�??�력받아 ??��?�로 출력?�세??',
'- ??�� for �?,
'[{"input": "1 2 3 4 5", "output": "5 4 3 2 1"}]',
'#include <iostream>
using namespace std;

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        cin >> arr[i];
    }
    // ?�기????�� 출력 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5", "expected": "5 4 3 2 1 \n"}]',
'["i = 4부??i >= 0까�?"]',
ARRAY['arrays', 'reverse'], 5),

('cpp-range-based-loop', 'cpp', 'basics', 35, '범위 기반 for�?, 'range-based for ?�용', 'challenge', 1,
'배열 {10, 20, 30, 40, 50}??모든 ?�소�?범위 기반 for문으�?출력?�세??',
'- for (auto x : arr)',
'[{"input": "", "output": "10 20 30 40 50"}]',
'#include <iostream>
using namespace std;

int main() {
    int arr[] = {10, 20, 30, 40, 50};
    // ?�기??범위 기반 for문을 ?�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "10 20 30 40 50 \n"}]',
'["for (auto 변??: 배열)"]',
ARRAY['arrays', 'range-for', 'c++11'], 5);

-- Unit 8: 벡터 (Vectors) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-vector-declare', 'cpp', 'basics', 36, '벡터 ?�언', 'vector ?�용?�기', 'challenge', 1,
'?�수 벡터�??�언?�고 {1,2,3,4,5}�?초기?�한 ??출력?�세??',
'- vector<int> ?�용',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <iostream>
#include <vector>
using namespace std;

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 \n"}]',
'["vector<int> v = {...};"]',
ARRAY['vector', 'basics', 'stl'], 5),

('cpp-vector-push', 'cpp', 'basics', 37, '벡터 추�?', 'push_back ?�용?�기', 'challenge', 1,
'�?벡터??5개의 ?�수�??�력받아 추�?????출력?�세??',
'- push_back() ?�용',
'[{"input": "1 2 3 4 5", "output": "1 2 3 4 5"}]',
'#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5", "expected": "1 2 3 4 5 \n"}]',
'["v.push_back(�??�로 추�?"]',
ARRAY['vector', 'push_back', 'stl'], 5),

('cpp-vector-size', 'cpp', 'basics', 38, '벡터 ?�기', 'size() ?�용?�기', 'challenge', 1,
'벡터 {10,20,30,40,50}???�기�?출력?�세??',
'- size() 메서??,
'[{"input": "", "output": "5"}]',
'#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {10, 20, 30, 40, 50};
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "5\n"}]',
'["v.size()???�소 개수�?반환"]',
ARRAY['vector', 'size', 'stl'], 5),

('cpp-vector-access', 'cpp', 'basics', 39, '벡터 ?�근', '?�덱?�로 ?�근?�기', 'challenge', 1,
'벡터 {5,10,15,20,25}?�서 ?�덱??2??값을 출력?�세??',
'- v[index] ?�는 v.at(index)',
'[{"input": "", "output": "15"}]',
'#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {5, 10, 15, 20, 25};
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "15\n"}]',
'["v[2] ?�는 v.at(2)"]',
ARRAY['vector', 'access', 'stl'], 5),

('cpp-vector-clear', 'cpp', 'basics', 40, '벡터 비우�?, 'clear() ?�용?�기', 'challenge', 1,
'벡터 {1,2,3}??비운 ???�기�?출력?�세??',
'- clear() 메서??,
'[{"input": "", "output": "0"}]',
'#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {1, 2, 3};
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "0\n"}]',
'["v.clear()??모든 ?�소�??�거"]',
ARRAY['vector', 'clear', 'stl'], 5);

-- Unit 9: 문자??(Strings) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-string-input', 'cpp', 'basics', 41, '문자???�력', '문자???�력받기', 'challenge', 1,
'문자?�을 ?�력받아 그�?�?출력?�세??',
'- cin ?�는 getline ?�용',
'[{"input": "Hello", "output": "Hello"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "Hello", "expected": "Hello\n"}]',
'["cin >> str�?문자???�력"]',
ARRAY['strings', 'input'], 5),

('cpp-string-length', 'cpp', 'basics', 42, '문자??길이', 'length() ?�용?�기', 'challenge', 1,
'문자?�을 ?�력받아 길이�?출력?�세??',
'- length() ?�는 size() 메서??,
'[{"input": "programming", "output": "11"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "programming", "expected": "11\n"}]',
'["str.length() ?�는 str.size()"]',
ARRAY['strings', 'length'], 5),

('cpp-string-concat', 'cpp', 'basics', 43, '문자???�결', '+ ?�산?�로 ?�결', 'challenge', 1,
'??문자?�을 ?�력받아 ?�결????출력?�세??',
'- + ?�산???�용',
'[{"input": "Hello World", "output": "HelloWorld"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "Hello World", "expected": "HelloWorld\n"}]',
'["s1 + s2�??�결"]',
ARRAY['strings', 'concatenation'], 5),

('cpp-string-compare', 'cpp', 'basics', 44, '문자??비교', '== ?�산?�로 비교', 'challenge', 1,
'??문자?�을 ?�력받아 같으�?"Same", ?�르�?"Different"�?출력?�세??',
'- == ?�산??,
'[{"input": "hello hello", "output": "Same"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    string s1, s2;
    cin >> s1 >> s2;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "hello hello", "expected": "Same\n"}]',
'["s1 == s2�?비교"]',
ARRAY['strings', 'comparison'], 5),

('cpp-string-substr', 'cpp', 'basics', 45, '부�?문자??, 'substr() ?�용?�기', 'challenge', 1,
'문자??"programming"???�덱??3부??4글?��? 출력?�세??',
'- substr(pos, len) 메서??,
'[{"input": "", "output": "gram"}]',
'#include <iostream>
#include <string>
using namespace std;

int main() {
    string str = "programming";
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "gram\n"}]',
'["str.substr(?�작?�치, 길이)"]',
ARRAY['strings', 'substr'], 5);

-- Unit 10: ?�래??기초 (Classes Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('cpp-class-declare', 'cpp', 'basics', 46, '?�래???�언', '간단???�래??만들�?, 'challenge', 1,
'?�수 멤버 변??x�?가�?Point ?�래?��? ?�의?�고 값을 출력?�세??',
'- class ?�워???�용',
'[{"input": "", "output": "10"}]',
'#include <iostream>
using namespace std;

// ?�기??Point ?�래?��? ?�의?�세??
int main() {
    Point p;
    p.x = 10;
    cout << p.x << endl;
    return 0;
}',
'',
'[{"input": "", "expected": "10\n"}]',
'["class Point { public: int x; };"]',
ARRAY['oop', 'class', 'basics'], 5),

('cpp-class-constructor', 'cpp', 'basics', 47, '?�성??, '?�성?�로 초기?�하�?, 'challenge', 1,
'?�수 멤버 변??value�?가�?Number ?�래?��? 만들�? ?�성?�로 초기?�하?�요.',
'- Number(int v) ?�성??,
'[{"input": "42", "output": "42"}]',
'#include <iostream>
using namespace std;

class Number {
public:
    int value;
    // ?�기???�성?��? ?�성?�세??};

int main() {
    int v;
    cin >> v;
    Number n(v);
    cout << n.value << endl;
    return 0;
}',
'',
'[{"input": "42", "expected": "42\n"}]',
'["?�성?�는 ?�래???�름�?같습?�다"]',
ARRAY['oop', 'constructor'], 5),

('cpp-class-method', 'cpp', 'basics', 48, '멤버 ?�수', '?�래??메서??만들�?, 'challenge', 1,
'???�수 a, b�??�하??add() 메서?��? 가�?Calculator ?�래?��? 만드?�요.',
'- int add() 메서??,
'[{"input": "5 3", "output": "8"}]',
'#include <iostream>
using namespace std;

class Calculator {
public:
    int a, b;
    // ?�기??add 메서?��? ?�성?�세??};

int main() {
    Calculator calc;
    cin >> calc.a >> calc.b;
    cout << calc.add() << endl;
    return 0;
}',
'',
'[{"input": "5 3", "expected": "8\n"}]',
'["멤버 변?�에 ?�근?????�습?�다"]',
ARRAY['oop', 'methods'], 5),

('cpp-class-private', 'cpp', 'basics', 49, 'private 멤버', '?�근 ?�한???�용?�기', 'challenge', 1,
'private ?�수 age?� public getter getAge()�?가�?Person ?�래?��? 만드?�요.',
'- private?� public 구분',
'[{"input": "25", "output": "25"}]',
'#include <iostream>
using namespace std;

class Person {
private:
    int age;
public:
    // ?�기??setAge?� getAge�??�성?�세??};

int main() {
    Person p;
    int a;
    cin >> a;
    p.setAge(a);
    cout << p.getAge() << endl;
    return 0;
}',
'',
'[{"input": "25", "expected": "25\n"}]',
'["private 멤버???��??�서 ?�근 불�?"]',
ARRAY['oop', 'encapsulation', 'private'], 5),

('cpp-class-rectangle', 'cpp', 'basics', 50, '직사각형 ?�래??, 'Rectangle ?�래??만들�?, 'challenge', 1,
'width, height�?가�?Rectangle ?�래?��? 만들�??�이�?계산?�는 area() 메서?��? ?�성?�세??',
'- int area() 메서??,
'[{"input": "5 10", "output": "50"}]',
'#include <iostream>
using namespace std;

class Rectangle {
public:
    int width, height;
    // ?�기??area 메서?��? ?�성?�세??};

int main() {
    Rectangle rect;
    cin >> rect.width >> rect.height;
    cout << rect.area() << endl;
    return 0;
}',
'',
'[{"input": "5 10", "expected": "50\n"}]',
'["return width * height;"]',
ARRAY['oop', 'class', 'methods'], 5);

-- ============================================================================
-- End of C++ Language Part 1
-- ============================================================================


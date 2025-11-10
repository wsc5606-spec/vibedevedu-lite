-- ============================================================================
-- Kotlin Language Challenges - Part 1 (Easy)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: EASY (1)
-- ============================================================================

-- Unit 1: 출력�?주석 (Output and Comments) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-hello-world', 'kotlin', 'syntax', 1, 'Hello World', 'C�?�??�로그램 ?�성?�기', 'challenge', 1,
'?�면??"Hello, World!"�?출력?�는 ?�로그램???�성?�세??',
'- printf ?�수�??�용?�세??n- 줄바�?\n)???�함?�야 ?�니??,
'[{"input": "", "output": "Hello, World!"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Hello, World!\n"}]',
'["printf ?�수???�용법을 ?�인?�세??, "문자?��? ?�따?�표�?감싸???�니??]',
ARRAY['basics', 'output', 'printf'], 5),

('kotlin-print-name', 'kotlin', 'syntax', 2, '?�름 출력?�기', '?�신???�름??출력?�세??, 'challenge', 1,
'?�면??"My name is [?�름]" ?�식?�로 출력?�는 ?�로그램???�성?�세??',
'- [?�름] 부분에???�하???�름???�으?�요\n- 줄바꿈을 ?�함?�야 ?�니??,
'[{"input": "", "output": "My name is John"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "My name is John\n"}]',
'["printf�?문자?�을 출력?????�습?�다"]',
ARRAY['basics', 'output'], 5),

('kotlin-multiline-output', 'kotlin', 'syntax', 3, '?�러 �?출력', '?�러 줄을 출력?�세??, 'challenge', 1,
'?�음 ??줄을 출력?�는 ?�로그램???�성?�세??\nLine 1\nLine 2\nLine 3',
'- �?줄�? ?�로??줄에 출력?�어???�니??,
'[{"input": "", "output": "Line 1\nLine 2\nLine 3"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Line 1\nLine 2\nLine 3\n"}]',
'["printf�??�러 �??�출?�거??\\n???�용?�세??]',
ARRAY['basics', 'output'], 5),

('kotlin-single-line-comment', 'kotlin', 'syntax', 4, '??�?주석', '주석???�용?�여 코드 ?�명?�기', 'challenge', 1,
'Hello�?출력?�는 코드�??�성?�고, �??�에 ??�?주석?�로 "?�것?� 출력 코드?�니??�?추�??�세??',
'- // �??�용?�여 주석???�성?�세??,
'[{"input": "", "output": "Hello"}]',
'#include <stdio.h>

int main() {
    // ?�기??주석�?코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Hello\n"}]',
'["// ?�의 ?�용?� ?�행?��? ?�습?�다"]',
ARRAY['basics', 'comments'], 5),

('kotlin-multi-line-comment', 'kotlin', 'syntax', 5, '?�러 �?주석', '?�러 �?주석 ?�용?�기', 'challenge', 1,
'World�?출력?�는 코드�??�성?�고, �??�에 ?�러 �?주석?�로 ?�로그램 ?�명??추�??�세??',
'- /* */ �??�용?�여 주석???�성?�세??,
'[{"input": "", "output": "World"}]',
'#include <stdio.h>

int main() {
    /* ?�기??주석�?코드�??�성?�세??*/

    return 0;
}',
'',
'[{"input": "", "expected": "World\n"}]',
'["/* */ ?�이???�용?� 모두 주석?�니??]',
ARRAY['basics', 'comments'], 5);

-- Unit 2: 변?��? ?�료??(Variables and Data Types) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-integer-variable', 'kotlin', 'syntax', 6, '?�수 변??, '?�수??변???�언?�고 출력?�기', 'challenge', 1,
'?�수??변??num???�언?�고 42�??�?�한 ??출력?�세??',
'- int ?�?�을 ?�용?�세??n- %d�??�용?�여 출력?�세??,
'[{"input": "", "output": "42"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "42\n"}]',
'["int???�수�??�?�하???�?�입?�다", "printf??%d???�수 출력?�입?�다"]',
ARRAY['basics', 'variables', 'int'], 5),

('kotlin-float-variable', 'kotlin', 'syntax', 7, '?�수 변??, '?�수??변???�언?�고 출력?�기', 'challenge', 1,
'?�수??변??pi�??�언?�고 3.14�??�?�한 ??출력?�세??',
'- float ?�?�을 ?�용?�세??n- %f�??�용?�여 출력?�세??,
'[{"input": "", "output": "3.14"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "3.14\n"}]',
'["float???�수�??�?�합?�다", "%.2f???�수??2?�리까�? 출력?�니??]',
ARRAY['basics', 'variables', 'float'], 5),

('kotlin-char-variable', 'kotlin', 'syntax', 8, '문자 변??, '문자??변???�언?�고 출력?�기', 'challenge', 1,
'문자??변??grade�??�언?�고 ''A''�??�?�한 ??출력?�세??',
'- char ?�?�을 ?�용?�세??n- %c�??�용?�여 출력?�세??,
'[{"input": "", "output": "A"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "A\n"}]',
'["char????글?��? ?�?�합?�다", "문자???��??�옴?�로 감쌉?�다"]',
ARRAY['basics', 'variables', 'char'], 5),

('kotlin-multiple-variables', 'kotlin', 'syntax', 9, '?�러 변???�언', '?�러 개의 변???�언?�기', 'challenge', 1,
'?�수 a=10, b=20???�언?�고 ??값을 공백?�로 구분?�여 출력?�세??',
'- ??줄에 출력?�야 ?�니??,
'[{"input": "", "output": "10 20"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "10 20\n"}]',
'["?�러 변?��? ?�표�?구분?�여 ?�언?????�습?�다"]',
ARRAY['basics', 'variables'], 5),

('kotlin-variable-swap', 'kotlin', 'syntax', 10, '변?�값 교환', '??변?�의 �?바꾸�?, 'challenge', 1,
'a=5, b=10????변?�의 값을 ?�로 바꾼 ??출력?�세?? (?�시 변???�용)',
'- 출력 ?�식: a b',
'[{"input": "", "output": "10 5"}]',
'#include <stdio.h>

int main() {
    int a = 5, b = 10;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "10 5\n"}]',
'["?�시 변??temp�??�용?�세??]',
ARRAY['basics', 'variables', 'swap'], 5);

-- Unit 3: ?�산??(Operators) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-addition', 'kotlin', 'basics', 11, '?�셈 계산', '???�의 ??구하�?, 'challenge', 1,
'???�수 a=15, b=25???�을 계산?�여 출력?�세??',
'- + ?�산?��? ?�용?�세??,
'[{"input": "", "output": "40"}]',
'#include <stdio.h>

int main() {
    int a = 15, b = 25;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "40\n"}]',
'["+ ?�산?�로 ?�셈???�행?�니??]',
ARRAY['basics', 'operators', 'arithmetic'], 5),

('kotlin-subtraction', 'kotlin', 'basics', 12, '뺄셈 계산', '???�의 �?구하�?, 'challenge', 1,
'???�수 a=50, b=30??차�? 계산?�여 출력?�세??',
'- - ?�산?��? ?�용?�세??,
'[{"input": "", "output": "20"}]',
'#include <stdio.h>

int main() {
    int a = 50, b = 30;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "20\n"}]',
'["- ?�산?�로 뺄셈???�행?�니??]',
ARRAY['basics', 'operators', 'arithmetic'], 5),

('kotlin-multiplication', 'kotlin', 'basics', 13, '곱셈 계산', '???�의 �?구하�?, 'challenge', 1,
'???�수 a=7, b=8??곱을 계산?�여 출력?�세??',
'- * ?�산?��? ?�용?�세??,
'[{"input": "", "output": "56"}]',
'#include <stdio.h>

int main() {
    int a = 7, b = 8;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "56\n"}]',
'["* ?�산?�로 곱셈???�행?�니??]',
ARRAY['basics', 'operators', 'arithmetic'], 5),

('kotlin-division', 'kotlin', 'basics', 14, '?�눗??계산', '???�의 �?구하�?, 'challenge', 1,
'???�수 a=20, b=4??몫을 계산?�여 출력?�세??',
'- / ?�산?��? ?�용?�세??,
'[{"input": "", "output": "5"}]',
'#include <stdio.h>

int main() {
    int a = 20, b = 4;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "5\n"}]',
'["/ ?�산?�로 ?�눗?�을 ?�행?�니??]',
ARRAY['basics', 'operators', 'arithmetic'], 5),

('kotlin-modulo', 'kotlin', 'basics', 15, '?�머지 계산', '???�의 ?�머지 구하�?, 'challenge', 1,
'???�수 a=17, b=5???�머지�?계산?�여 출력?�세??',
'- % ?�산?��? ?�용?�세??,
'[{"input": "", "output": "2"}]',
'#include <stdio.h>

int main() {
    int a = 17, b = 5;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "2\n"}]',
'["% ?�산?�로 ?�머지�?구합?�다"]',
ARRAY['basics', 'operators', 'modulo'], 5);

-- Unit 4: 조건�?(Conditional Statements) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-if-positive', 'kotlin', 'basics', 16, '?�수 ?�별', '?�자가 ?�수?��? ?�인?�기', 'challenge', 1,
'?�수 num??주어�??? ?�수?�면 "Positive"�?출력?�세??',
'- if 문을 ?�용?�세??n- num > 0 조건???�인?�세??,
'[{"input": "5", "output": "Positive"}]',
'#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "Positive\n"}, {"input": "10", "expected": "Positive\n"}]',
'["if (조건) { ?�행??코드 }"]',
ARRAY['conditionals', 'if'], 5),

('kotlin-if-else-even', 'kotlin', 'basics', 17, '짝수 ?�???�별', '짝수?��? ?�?�인지 ?�별?�기', 'challenge', 1,
'?�수 num??주어�??? 짝수?�면 "Even", ?�?�이�?"Odd"�?출력?�세??',
'- if-else 문을 ?�용?�세??n- % ?�산?�로 ?�머지�??�인?�세??,
'[{"input": "4", "output": "Even"}, {"input": "7", "output": "Odd"}]',
'#include <stdio.h>

int main() {
    int num;
    scanf("%d", &num);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "4", "expected": "Even\n"}, {"input": "7", "expected": "Odd\n"}]',
'["num % 2 == 0 ?�면 짝수?�니??]',
ARRAY['conditionals', 'if-else', 'modulo'], 5),

('kotlin-if-else-max', 'kotlin', 'basics', 18, '????�?????, '????�???????찾기', 'challenge', 1,
'???�수 a, b가 주어�??? ?????��? 출력?�세??',
'- if-else 문을 ?�용?�세??,
'[{"input": "10 20", "output": "20"}, {"input": "30 15", "output": "30"}]',
'#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10 20", "expected": "20\n"}, {"input": "30 15", "expected": "30\n"}]',
'["a > b�?비교?�세??]',
ARRAY['conditionals', 'comparison'], 5),

('kotlin-if-else-if-grade', 'kotlin', 'basics', 19, '?�수�??�급 ?�정', '?�수???�라 ?�급 출력?�기', 'challenge', 1,
'?�수 score가 주어�??? 90 ?�상?�면 "A", 80 ?�상?�면 "B", �??�는 "C"�?출력?�세??',
'- if-else if-else 문을 ?�용?�세??,
'[{"input": "95", "output": "A"}, {"input": "85", "output": "B"}, {"input": "75", "output": "C"}]',
'#include <stdio.h>

int main() {
    int score;
    scanf("%d", &score);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "95", "expected": "A\n"}, {"input": "85", "expected": "B\n"}, {"input": "75", "expected": "C\n"}]',
'["조건???�서?��??�인?�세??]',
ARRAY['conditionals', 'if-else-if'], 5),

('kotlin-logical-and', 'kotlin', 'basics', 20, '?�리 ?�산 AND', '??조건??모두 참인지 ?�인?�기', 'challenge', 1,
'?�이 age가 주어�??? 18???�상 65??미만?�면 "Adult"�?출력?�세??',
'- && ?�산?��? ?�용?�세??,
'[{"input": "25", "output": "Adult"}, {"input": "70", "output": ""}]',
'#include <stdio.h>

int main() {
    int age;
    scanf("%d", &age);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "25", "expected": "Adult\n"}, {"input": "70", "expected": ""}]',
'["&& ??AND ?�산?�입?�다"]',
ARRAY['conditionals', 'logical-operators'], 5);

-- Unit 5: 반복�?(Loops) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-for-1-to-10', 'kotlin', 'basics', 21, '1부??10까�? 출력', 'for문으�?1부??10까�? 출력?�기', 'challenge', 1,
'for문을 ?�용?�여 1부??10까�????�자�???줄에 ?�나??출력?�세??',
'- for문을 ?�용?�세??,
'[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"}]',
'["for (int i = 1; i <= 10; i++)"]',
ARRAY['loops', 'for'], 5),

('kotlin-while-countdown', 'kotlin', 'basics', 22, '카운?�다??, 'while문으�?카운?�다?�하�?, 'challenge', 1,
'while문을 ?�용?�여 5부??1까�? 카운?�다?�을 출력?�세??',
'- while문을 ?�용?�세??,
'[{"input": "", "output": "5\n4\n3\n2\n1"}]',
'#include <stdio.h>

int main() {
    int count = 5;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "5\n4\n3\n2\n1\n"}]',
'["while (조건) { ... count--; }"]',
ARRAY['loops', 'while'], 5),

('kotlin-sum-1-to-n', 'kotlin', 'basics', 23, '1부??N까�?????, '1부??N까�?????구하�?, 'challenge', 1,
'?�수 N??주어�??? 1부??N까�????�을 계산?�여 출력?�세??',
'- for문을 ?�용?�세??,
'[{"input": "5", "output": "15"}, {"input": "10", "output": "55"}]',
'#include <stdio.h>

int main() {
    int n, sum = 0;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "15\n"}, {"input": "10", "expected": "55\n"}]',
'["sum += i �??�적?�을 구하?�요"]',
ARRAY['loops', 'for', 'sum'], 5),

('kotlin-multiplication-table', 'kotlin', 'basics', 24, '구구??, '구구??출력?�기', 'challenge', 1,
'?�수 N??주어�??? N??구구?�을 출력?�세?? (1~9까�?)',
'- ?�식: N x 1 = 결과',
'[{"input": "3", "output": "3 x 1 = 3\n3 x 2 = 6\n3 x 3 = 9\n3 x 4 = 12\n3 x 5 = 15\n3 x 6 = 18\n3 x 7 = 21\n3 x 8 = 24\n3 x 9 = 27"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3", "expected": "3 x 1 = 3\n3 x 2 = 6\n3 x 3 = 9\n3 x 4 = 12\n3 x 5 = 15\n3 x 6 = 18\n3 x 7 = 21\n3 x 8 = 24\n3 x 9 = 27\n"}]',
'["for문으�?1~9까�? 반복?�세??]',
ARRAY['loops', 'for', 'multiplication'], 5),

('kotlin-do-while', 'kotlin', 'basics', 25, 'do-while 반복', 'do-while�??�용?�기', 'challenge', 1,
'do-while문을 ?�용?�여 1부??5까�? 출력?�세??',
'- do-while문을 ?�용?�세??,
'[{"input": "", "output": "1\n2\n3\n4\n5"}]',
'#include <stdio.h>

int main() {
    int i = 1;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1\n2\n3\n4\n5\n"}]',
'["do { ... } while (조건);"]',
ARRAY['loops', 'do-while'], 5);

-- Unit 6: ?�수 (Functions) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-function-add', 'kotlin', 'basics', 26, '?�셈 ?�수', '???��? ?�하???�수 만들�?, 'challenge', 1,
'???�수�??�력받아 ?�을 반환?�는 add ?�수�??�성?�세??',
'- int add(int a, int b) ?�식?�로 ?�성?�세??,
'[{"input": "3 5", "output": "8"}]',
'#include <stdio.h>

// ?�기??add ?�수�??�성?�세??
int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", add(a, b));
    return 0;
}',
'',
'[{"input": "3 5", "expected": "8\n"}]',
'["return a + b;"]',
ARRAY['functions', 'return'], 5),

('kotlin-function-square', 'kotlin', 'basics', 27, '?�곱 ?�수', '?�자???�곱??구하???�수 만들�?, 'challenge', 1,
'?�수 n???�력받아 n???�곱??반환?�는 square ?�수�??�성?�세??',
'- int square(int n) ?�식?�로 ?�성?�세??,
'[{"input": "4", "output": "16"}]',
'#include <stdio.h>

// ?�기??square ?�수�??�성?�세??
int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", square(n));
    return 0;
}',
'',
'[{"input": "4", "expected": "16\n"}]',
'["return n * n;"]',
ARRAY['functions', 'return'], 5),

('kotlin-function-void', 'kotlin', 'basics', 28, 'void ?�수', '반환값이 ?�는 ?�수 만들�?, 'challenge', 1,
'문자?�을 출력?�는 void ?�?�의 greet ?�수�??�성?�세?? "Hello!"�?출력?�니??',
'- void greet() ?�식?�로 ?�성?�세??,
'[{"input": "", "output": "Hello!"}]',
'#include <stdio.h>

// ?�기??greet ?�수�??�성?�세??
int main() {
    greet();
    return 0;
}',
'',
'[{"input": "", "expected": "Hello!\n"}]',
'["void??반환값이 ?�습?�다"]',
ARRAY['functions', 'void'], 5),

('kotlin-function-max', 'kotlin', 'basics', 29, '최댓�??�수', '????�????��? 반환?�는 ?�수', 'challenge', 1,
'???�수 �???값을 반환?�는 max ?�수�??�성?�세??',
'- if-else�??�용?�세??,
'[{"input": "7 12", "output": "12"}]',
'#include <stdio.h>

// ?�기??max ?�수�??�성?�세??
int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    printf("%d\n", max(a, b));
    return 0;
}',
'',
'[{"input": "7 12", "expected": "12\n"}]',
'["조건???�라 ?�른 값을 반환?�세??]',
ARRAY['functions', 'conditionals'], 5),

('kotlin-function-is-even', 'kotlin', 'basics', 30, '짝수 ?�별 ?�수', '짝수?��? ?�별?�는 ?�수', 'challenge', 1,
'?�수 n??짝수?�면 1, ?�?�이�?0??반환?�는 isEven ?�수�??�성?�세??',
'- % ?�산?��? ?�용?�세??,
'[{"input": "4", "output": "1"}, {"input": "7", "output": "0"}]',
'#include <stdio.h>

// ?�기??isEven ?�수�??�성?�세??
int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", isEven(n));
    return 0;
}',
'',
'[{"input": "4", "expected": "1\n"}, {"input": "7", "expected": "0\n"}]',
'["n % 2 == 0?� 1(true) ?�는 0(false)??반환?�니??]',
ARRAY['functions', 'modulo'], 5);

-- Unit 7: 배열 (Arrays) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-array-declare', 'kotlin', 'basics', 31, '배열 ?�언', '배열 ?�언?�고 초기?�하�?, 'challenge', 1,
'?�기가 5???�수 배열???�언?�고 1, 2, 3, 4, 5�?초기?�한 ??모든 ?�소�?출력?�세??',
'- 배열 ?�언: int arr[5]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 \n"}]',
'["int arr[] = {1, 2, 3, 4, 5};"]',
ARRAY['arrays', 'basics'], 5),

('kotlin-array-sum', 'kotlin', 'basics', 32, '배열 ?�계', '배열 ?�소????구하�?, 'challenge', 1,
'?�기가 5??배열??모든 ?�소???�을 계산?�여 출력?�세??',
'- for문을 ?�용?�세??,
'[{"input": "1 2 3 4 5", "output": "15"}]',
'#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5", "expected": "15\n"}]',
'["sum += arr[i]�??�적?�세??]',
ARRAY['arrays', 'sum'], 5),

('kotlin-array-max', 'kotlin', 'basics', 33, '배열 최댓�?, '배열?�서 가????�?찾기', 'challenge', 1,
'?�기가 5??배열?�서 가????값을 찾아 출력?�세??',
'- for문과 if문을 ?�용?�세??,
'[{"input": "3 7 2 9 5", "output": "9"}]',
'#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3 7 2 9 5", "expected": "9\n"}]',
'["�??�소�?max�??�정?�고 비교?�세??]',
ARRAY['arrays', 'max'], 5),

('kotlin-array-reverse', 'kotlin', 'basics', 34, '배열 ?�집�?, '배열????��?�로 출력?�기', 'challenge', 1,
'?�기가 5??배열???�력받아 ??��?�로 출력?�세??',
'- for문을 ??��?�로 ?�리?�요',
'[{"input": "1 2 3 4 5", "output": "5 4 3 2 1"}]',
'#include <stdio.h>

int main() {
    int arr[5];
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5", "expected": "5 4 3 2 1 \n"}]',
'["i = 4부??i >= 0까�? 감소?�키?�요"]',
ARRAY['arrays', 'reverse'], 5),

('kotlin-array-search', 'kotlin', 'basics', 35, '배열 검??, '배열?�서 ?�정 �?찾기', 'challenge', 1,
'?�기가 5??배열�?찾을 �?target??주어�??? target??배열???�으�??�덱?��?, ?�으�?-1??출력?�세??',
'- for문과 if문을 ?�용?�세??,
'[{"input": "1 2 3 4 5\n3", "output": "2"}]',
'#include <stdio.h>

int main() {
    int arr[5], target;
    for (int i = 0; i < 5; i++) {
        scanf("%d", &arr[i]);
    }
    scanf("%d", &target);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3 4 5\n3", "expected": "2\n"}]',
'["찾으�?break�?반복??중단?�세??]',
ARRAY['arrays', 'search'], 5);

-- Unit 8: ?�인??기초 (Pointers Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-pointer-address', 'kotlin', 'basics', 36, '변??주소 출력', '변?�의 메모�?주소 출력?�기', 'challenge', 1,
'?�수 변??num??값과 주소�?출력?�세??',
'- & ?�산?��? ?�용?�여 주소�??�으?�요\n- %p�?주소�?출력?�세??,
'[{"input": "", "output": "Value: 10\nAddress: 0x..."}]',
'#include <stdio.h>

int main() {
    int num = 10;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Value: 10\nAddress: "}]',
'["&num?� num??주소?�니??]',
ARRAY['pointers', 'address'], 5),

('kotlin-pointer-declare', 'kotlin', 'basics', 37, '?�인???�언', '?�인??변???�언?�고 ?�용?�기', 'challenge', 1,
'?�수 변??num�?그것??가리키???�인??ptr???�언?�고, ?�인?��? ?�해 값을 출력?�세??',
'- int *ptr = &num;',
'[{"input": "", "output": "20"}]',
'#include <stdio.h>

int main() {
    int num = 20;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "20\n"}]',
'["*ptr�??�인?��? 가리키??값을 ?�습?�다"]',
ARRAY['pointers', 'basics'], 5),

('kotlin-pointer-modify', 'kotlin', 'basics', 38, '?�인?�로 �??�정', '?�인?��? ?�해 변??�?변경하�?, 'challenge', 1,
'?�수 변??num=10???�인?��? ?�해 30?�로 변경하�?출력?�세??',
'- *ptr = 30;',
'[{"input": "", "output": "30"}]',
'#include <stdio.h>

int main() {
    int num = 10;
    int *ptr = &num;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "30\n"}]',
'["*ptr = 30?�로 값을 변경합?�다"]',
ARRAY['pointers', 'modify'], 5),

('kotlin-pointer-swap', 'kotlin', 'basics', 39, '?�인?�로 swap ?�수', '?�인?��? ?�용??swap ?�수 만들�?, 'challenge', 1,
'???�수??값을 바꾸??swap ?�수�??�인?��? ?�용?�여 ?�성?�세??',
'- void swap(int *a, int *b)',
'[{"input": "5 10", "output": "10 5"}]',
'#include <stdio.h>

// ?�기??swap ?�수�??�성?�세??
int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    swap(&a, &b);
    printf("%d %d\n", a, b);
    return 0;
}',
'',
'[{"input": "5 10", "expected": "10 5\n"}]',
'["?�시 변?�로 값을 바꾸?�요"]',
ARRAY['pointers', 'functions'], 5),

('kotlin-pointer-array', 'kotlin', 'basics', 40, '?�인?��? 배열', '?�인?�로 배열 ?�근?�기', 'challenge', 1,
'배열???�인?�로 ?�근?�여 모든 ?�소�?출력?�세??',
'- *(arr + i) ?�는 arr[i]',
'[{"input": "", "output": "1 2 3 4 5"}]',
'#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    int *ptr = arr;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1 2 3 4 5 \n"}]',
'["배열 ?�름?� �??�소??주소?�니??]',
ARRAY['pointers', 'arrays'], 5);

-- Unit 9: ?�출??(Input/Output) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-scanf-int', 'kotlin', 'basics', 41, '?�수 ?�력받기', 'scanf�??�수 ?�력받기', 'challenge', 1,
'?�수 ?�나�??�력받아 그�?�?출력?�세??',
'- scanf("%d", &num);',
'[{"input": "42", "output": "42"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "42", "expected": "42\n"}]',
'["&num?�로 주소�??�달?�세??]',
ARRAY['io', 'scanf'], 5),

('kotlin-scanf-multiple', 'kotlin', 'basics', 42, '?�러 �??�력받기', '?�러 개의 값을 ??번에 ?�력받기', 'challenge', 1,
'??개의 ?�수�??�력받아 ?�을 출력?�세??',
'- scanf("%d %d %d", &a, &b, &c);',
'[{"input": "1 2 3", "output": "6"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1 2 3", "expected": "6\n"}]',
'["공백?�로 구분???�력??받을 ???�습?�다"]',
ARRAY['io', 'scanf'], 5),

('kotlin-printf-formatted', 'kotlin', 'basics', 43, '?�식 지??출력', 'printf�??�식??지?�하??출력?�기', 'challenge', 1,
'?�수?� ?�수�??�력받아 "Int: [?�수], Float: [?�수]" ?�식?�로 출력?�세??',
'- ?�수???�수??2?�리까�?',
'[{"input": "10 3.14", "output": "Int: 10, Float: 3.14"}]',
'#include <stdio.h>

int main() {
    int num;
    float fnum;
    scanf("%d %f", &num, &fnum);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10 3.14", "expected": "Int: 10, Float: 3.14\n"}]',
'["%.2f???�수??2?�리?�니??]',
ARRAY['io', 'printf', 'format'], 5),

('kotlin-getchar', 'kotlin', 'basics', 44, '문자 ?�력', 'getchar�?문자 ?�력받기', 'challenge', 1,
'문자 ?�나�??�력받아 그�?�?출력?�세??',
'- char ch = getchar();',
'[{"input": "A", "output": "A"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "A", "expected": "A\n"}]',
'["putchar�?문자�?출력?????�습?�다"]',
ARRAY['io', 'getchar'], 5),

('kotlin-fgets', 'kotlin', 'basics', 45, '문자???�력', 'fgets�?문자???�력받기', 'challenge', 1,
'??줄의 문자?�을 ?�력받아 그�?�?출력?�세??',
'- fgets(str, sizeof(str), stdin);',
'[{"input": "Hello World", "output": "Hello World"}]',
'#include <stdio.h>

int main() {
    char str[100];
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "Hello World", "expected": "Hello World\n"}]',
'["fgets??줄바꿈도 ?�함?�니??]',
ARRAY['io', 'fgets', 'string'], 5);

-- Unit 10: 구조�?기초 (Structures Basics) - 5 challenges
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('kotlin-struct-declare', 'kotlin', 'basics', 46, '구조�??�언', '구조�??�의?�고 ?�용?�기', 'challenge', 1,
'?�름(문자??�??�이(?�수)�?가�?Person 구조체�? ?�의?�고 값을 출력?�세??',
'- struct Person { char name[50]; int age; };',
'[{"input": "", "output": "Name: John, Age: 25"}]',
'#include <stdio.h>
#include <string.h>

// ?�기??구조체�? ?�의?�세??
int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "Name: John, Age: 25\n"}]',
'["struct�?구조체�? ?�의?�니??]',
ARRAY['struct', 'basics'], 5),

('kotlin-struct-input', 'kotlin', 'basics', 47, '구조�??�력', '구조체에 �??�력받기', 'challenge', 1,
'Point 구조�?x, y 좌표)�??�의?�고 값을 ?�력받아 출력?�세??',
'- 출력 ?�식: (x, y)',
'[{"input": "3 4", "output": "(3, 4)"}]',
'#include <stdio.h>

struct Point {
    int x;
    int y;
};

int main() {
    struct Point p;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3 4", "expected": "(3, 4)\n"}]',
'["p.x, p.y�?멤버???�근?�세??]',
ARRAY['struct', 'input'], 5),

('kotlin-struct-array', 'kotlin', 'basics', 48, '구조�?배열', '구조�?배열 ?�용?�기', 'challenge', 1,
'Student 구조�??�름, ?�수) 3개�? 배열�??�언?�고 ?�균 ?�수�?계산?�세??',
'- 구조�?배열: struct Student students[3];',
'[{"input": "Alice 90\nBob 80\nCharlie 85", "output": "85"}]',
'#include <stdio.h>

struct Student {
    char name[50];
    int score;
};

int main() {
    struct Student students[3];
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "Alice 90\nBob 80\nCharlie 85", "expected": "85\n"}]',
'["배열�??�러 구조체�? 관리할 ???�습?�다"]',
ARRAY['struct', 'array'], 5),

('kotlin-struct-pointer', 'kotlin', 'basics', 49, '구조�??�인??, '구조�??�인???�용?�기', 'challenge', 1,
'Rectangle 구조�?width, height)???�인?��? ?�용?�여 ?�이�?계산?�세??',
'- ptr->width ?�식?�로 ?�근',
'[{"input": "5 10", "output": "50"}]',
'#include <stdio.h>

struct Rectangle {
    int width;
    int height;
};

int main() {
    struct Rectangle r;
    struct Rectangle *ptr = &r;
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5 10", "expected": "50\n"}]',
'["-> ?�산?�로 ?�인?��? ?�해 멤버???�근?�니??]',
ARRAY['struct', 'pointer'], 5),

('kotlin-struct-typedef', 'kotlin', 'basics', 50, 'typedef ?�용', 'typedef�?구조�?간단???�용?�기', 'challenge', 1,
'typedef�??�용?�여 Book 구조�?title, price)�??�의?�고 ?�용?�세??',
'- typedef struct { ... } Book;',
'[{"input": "C_Programming 30", "output": "Title: C_Programming, Price: 30"}]',
'#include <stdio.h>

// ?�기??typedef 구조체�? ?�의?�세??
int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "C_Programming 30", "expected": "Title: C_Programming, Price: 30\n"}]',
'["typedef�??�용?�면 struct ?�워???�이 ?�용 가?�합?�다"]',
ARRAY['struct', 'typedef'], 5);

-- ============================================================================
-- End of Kotlin Language Part 1
-- ============================================================================


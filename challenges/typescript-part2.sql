-- ============================================================================
-- TypeScript Language Challenges - Part 2 (Medium & Hard)
-- ============================================================================
-- Total: 50 challenges (5 per unit × 10 units)
-- Difficulty: MEDIUM (2) for Units 1-6, HARD (3) for Units 7-10
-- ============================================================================

-- Unit 1: 출력�?주석 (Output and Comments) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-pattern-triangle', 'typescript', 'syntax', 51, '?�각???�턴', '별표�??�각??그리�?, 'challenge', 2,
'?�수 N??주어�??? N줄의 ?�각???�턼??출력?�세??\n?? N=3????n*\n**\n***',
'- 중첩 반복�??�용\n- 1 ??N ??10',
'[{"input": "3", "output": "*\n**\n***"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3", "expected": "*\n**\n***\n"}, {"input": "5", "expected": "*\n**\n***\n****\n*****\n"}]',
'["바깥 루프??�??? ?�쪽 루프??별의 개수?�니??]',
ARRAY['loops', 'pattern', 'nested'], 10),

('typescript-pyramid-pattern', 'typescript', 'syntax', 52, '?�라미드 ?�턴', '공백�?별표�??�라미드 그리�?, 'challenge', 2,
'?�수 N??주어�??? N줄의 ?�라미드�?출력?�세??\n?? N=3????n  *\n ***\n*****',
'- 공백�?별표 계산 ?�요\n- 1 ??N ??10',
'[{"input": "3", "output": "  *\n ***\n*****"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3", "expected": "  *\n ***\n*****\n"}]',
'["�?줄의 공백 ?��? �??��? 계산?�세??]',
ARRAY['loops', 'pattern', 'pyramid'], 15),

('typescript-diamond-pattern', 'typescript', 'syntax', 53, '?�이?�몬???�턴', '?�이?�몬??모양 그리�?, 'challenge', 2,
'?�??N??주어�??? N줄의 ?�이?�몬?��? 출력?�세??',
'- ?�단 ?�반�??�단 ?�반?�로 ?�누???�각\n- N?� ?�??,
'[{"input": "5", "output": "  *\n ***\n*****\n ***\n  *"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "  *\n ***\n*****\n ***\n  *\n"}]',
'["중간 지?�을 기�??�로 ?�하�??�누?�요"]',
ARRAY['loops', 'pattern', 'diamond'], 15),

('typescript-formatted-table', 'typescript', 'syntax', 54, '?�이�??�식 출력', '?�렬???�이�?출력?�기', 'challenge', 2,
'N개의 ?�자�??�력받아 3?�로 ?�렬?�여 출력?�세??',
'- �??�의 ?�비??5�?n- ?�른�??�렬',
'[{"input": "6\n1 22 333 4 55 666", "output": "    1   22  333\n    4   55  666"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "6\n1 22 333 4 55 666", "expected": "    1   22  333\n    4   55  666\n"}]',
'["%5d??5�??�른�??�렬?�니??]',
ARRAY['output', 'formatting', 'alignment'], 10),

('typescript-ascii-art', 'typescript', 'syntax', 55, 'ASCII ?�트', 'ASCII 문자�?그림 그리�?, 'challenge', 2,
'?�력받�? 문자�?5x5 ?�각???�두리�? 그리?�요.',
'- ?�두리만 ?�력 문자�? ?��???공백',
'[{"input": "#", "output": "#####\n#   #\n#   #\n#   #\n#####"}]',
'#include <stdio.h>

int main() {
    char ch;
    scanf("%c", &ch);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "#", "expected": "#####\n#   #\n#   #\n#   #\n#####\n"}]',
'["?�두�?조건: �?마�?�????�는 �?마�?�???]',
ARRAY['pattern', 'ascii', 'loops'], 15);

-- Unit 2: 변?��? ?�료??(Variables and Data Types) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-bit-operations', 'typescript', 'basics', 56, '비트 ?�산', '비트 ?�산?�로 �?조작?�기', 'challenge', 2,
'???�수 a, b가 주어�??? AND, OR, XOR ?�산 결과�?출력?�세??',
'- &, |, ^ ?�산???�용\n- �?줄에 ?�나??출력',
'[{"input": "12 10", "output": "8\n14\n6"}]',
'#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "12 10", "expected": "8\n14\n6\n"}]',
'["& (AND), | (OR), ^ (XOR)"]',
ARRAY['bitwise', 'operators'], 10),

('typescript-sizeof-types', 'typescript', 'basics', 57, '?�료???�기', '?�양???�료?�의 ?�기 출력?�기', 'challenge', 2,
'char, int, float, double???�기�?바이???�위�?출력?�세??',
'- sizeof ?�산???�용',
'[{"input": "", "output": "1\n4\n4\n8"}]',
'#include <stdio.h>

int main() {
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "1\n4\n4\n8\n"}]',
'["sizeof??바이???�기�?반환?�니??]',
ARRAY['sizeof', 'data-types'], 10),

('typescript-type-casting', 'typescript', 'basics', 58, '?�??캐스??, '명시???�??변?�하�?, 'challenge', 2,
'?�수 ?�눗?�과 ?�수 ?�눗??결과�?각각 출력?�세??',
'- (float) 캐스???�용\n- ?�수??2?�리',
'[{"input": "7 2", "output": "3\n3.50"}]',
'#include <stdio.h>

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "7 2", "expected": "3\n3.50\n"}]',
'["?�수 ?�눗?��? ?�수?�을 버립?�다"]',
ARRAY['casting', 'division'], 10),

('typescript-const-variables', 'typescript', 'basics', 59, '?�수 ?�용', 'const ?�워?�로 ?�수 ?�언?�기', 'challenge', 2,
'?�의 반�?름을 ?�력받아 ?�레?� ?�이�?계산?�세?? (PI???�수�??�의)',
'- const double PI = 3.14159;\n- ?�수??2?�리',
'[{"input": "5", "output": "31.42\n78.54"}]',
'#include <stdio.h>

int main() {
    const double PI = 3.14159;
    int r;
    scanf("%d", &r);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "31.42\n78.54\n"}]',
'["const??값을 변경할 ???�게 ?�니??]',
ARRAY['const', 'math'], 10),

('typescript-enum-weekday', 'typescript', 'basics', 60, '?�거???�용', 'enum?�로 ?�일 ?�현?�기', 'challenge', 2,
'0-6???�자�??�력받아 ?�당?�는 ?�일??출력?�세??',
'- enum ?�용\n- 0=MON, 1=TUE, ..., 6=SUN',
'[{"input": "0", "output": "MON"}, {"input": "3", "output": "THU"}]',
'#include <stdio.h>

enum Weekday { MON, TUE, WED, THU, FRI, SAT, SUN };

int main() {
    int day;
    scanf("%d", &day);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "0", "expected": "MON\n"}, {"input": "3", "expected": "THU\n"}]',
'["enum?� 0부???�작?�는 ?�수값입?�다"]',
ARRAY['enum', 'array'], 10);

-- Unit 3: ?�산??(Operators) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-compound-interest', 'typescript', 'basics', 61, '복리 계산', '복리 ?�자 계산?�기', 'challenge', 2,
'?�금 P, ?�율 r(%), 기간 n(????주어�??? 복리 ?�리금을 계산?�세??\n공식: P * (1 + r/100)^n',
'- pow ?�수 ?�용\n- #include <math.h>\n- ?�수??2?�리',
'[{"input": "1000 5 3", "output": "1157.63"}]',
'#include <stdio.h>
#include <math.h>

int main() {
    double P, r;
    int n;
    scanf("%lf %lf %d", &P, &r, &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "1000 5 3", "expected": "1157.63\n"}]',
'["pow(base, exponent)�?거듭?�곱??계산?�니??]',
ARRAY['math', 'pow', 'operators'], 15),

('typescript-increment-decrement', 'typescript', 'basics', 62, '증감 ?�산??, '?�위/?�위 증감 ?�산???�해?�기', 'challenge', 2,
'?�수 x가 주어�??? ++x, x++, --x, x--??결과�??�서?��?출력?�세??',
'- �??�산 ??x값도 변경됨',
'[{"input": "5", "output": "6\n6\n6\n6"}]',
'#include <stdio.h>

int main() {
    int x;
    scanf("%d", &x);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5", "expected": "6\n6\n6\n6\n"}]',
'["?�위??먼�? 증�?/감소, ?�위???�중??증�?/감소"]',
ARRAY['operators', 'increment'], 10),

('typescript-ternary-operator', 'typescript', 'basics', 63, '?�항 ?�산??, '조건 ?�산?�로 간결??코드 ?�성', 'challenge', 2,
'???�수 a, b, c가 주어�??? 가????값을 ?�항 ?�산?�로 찾아 출력?�세??',
'- ? : ?�산???�용\n- 중첩 ?�항 ?�산??,
'[{"input": "5 8 3", "output": "8"}]',
'#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5 8 3", "expected": "8\n"}]',
'["조건 ? 참일?�값 : 거짓?�때�?]',
ARRAY['operators', 'ternary'], 10),

('typescript-bitwise-shift', 'typescript', 'basics', 64, '비트 ?�프??, '좌측/?�측 ?�프???�산', 'challenge', 2,
'?�수 n�?k가 주어�??? n???�쪽?�로 k�? ?�른쪽으�?k�??�프?�한 결과�?출력?�세??',
'- << ?� >> ?�산??,
'[{"input": "8 2", "output": "32\n2"}]',
'#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "8 2", "expected": "32\n2\n"}]',
'["?�쪽 ?�프?�는 2배씩, ?�른쪽�? 2�??�누�?]',
ARRAY['bitwise', 'shift'], 10),

('typescript-gcd-lcm', 'typescript', 'basics', 65, '최�?공약?��? 최소공배??, 'GCD?� LCM 구하�?, 'challenge', 2,
'???�수??최�?공약??GCD)?� 최소공배??LCM)�?구하?�요.',
'- ?�클리드 ?�제�??�용\n- LCM = (a * b) / GCD',
'[{"input": "12 18", "output": "6\n36"}]',
'#include <stdio.h>

int gcd(int a, int b) {
    // ?�기??GCD ?�수�??�성?�세??}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int g = gcd(a, b);
    printf("%d\n", g);
    printf("%d\n", (a * b) / g);
    return 0;
}',
'',
'[{"input": "12 18", "expected": "6\n36\n"}]',
'["GCD(a, b) = GCD(b, a % b)"]',
ARRAY['math', 'gcd', 'algorithm'], 15);

-- Unit 4: 조건�?(Conditional Statements) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-leap-year', 'typescript', 'basics', 66, '?�년 ?�별', '?�년?��? ?�인?�기', 'challenge', 2,
'?�도가 주어�??? ?�년?�면 "Leap", ?�년?�면 "Common"??출력?�세??\n?�년: 4??배수?�면??100??배수가 ?�니거나, 400??배수',
'- 조건???�확??구현',
'[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]',
'#include <stdio.h>

int main() {
    int year;
    scanf("%d", &year);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "2000", "expected": "Leap\n"}, {"input": "1900", "expected": "Common\n"}]',
'["?�리 ?�산?��? 조합?�세??]',
ARRAY['conditionals', 'logic'], 10),

('typescript-triangle-type', 'typescript', 'basics', 67, '?�각??종류', '??변??길이�??�각??종류 ?�별', 'challenge', 2,
'??변 a, b, c가 주어�??? ?�삼각형(Equilateral), ?�등변?�각??Isosceles), 부?��??�각??Scalene), ?�는 ?�각???�님(Not a triangle)??출력?�세??',
'- ?�각???�립 조건: ??변????> ?�머지 ??변',
'[{"input": "3 3 3", "output": "Equilateral"}, {"input": "3 3 5", "output": "Isosceles"}]',
'#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3 3 3", "expected": "Equilateral\n"}, {"input": "3 3 5", "expected": "Isosceles\n"}]',
'["먼�? ?�각?�이 ?�립?�는지 ?�인?�세??]',
ARRAY['conditionals', 'geometry'], 15),

('typescript-quadrant', 'typescript', 'basics', 68, '?�분�??�별', '좌표???�분�?결정?�기', 'challenge', 2,
'??(x, y)가 주어�??? ?�느 ?�분면에 ?�하?��? 출력?�세??\n1, 2, 3, 4 �??�나 ?�는 "Axis"(�???',
'- x�? y�??�도 고려',
'[{"input": "5 3", "output": "1"}, {"input": "-2 4", "output": "2"}]',
'#include <stdio.h>

int main() {
    int x, y;
    scanf("%d %d", &x, &y);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5 3", "expected": "1\n"}, {"input": "-2 4", "expected": "2\n"}]',
'["x, y??부?��? ?�인?�세??]',
ARRAY['conditionals', 'math'], 10),

('typescript-bmi-calculator', 'typescript', 'basics', 69, 'BMI 계산�?, '체질?��??�로 비만???�정', 'challenge', 2,
'체중(kg)�???cm)가 주어�??? BMI�?계산?�고 ?�급??출력?�세??\nBMI = 체중 / (??100)²\n18.5 미만: Underweight, 18.5-25: Normal, 25-30: Overweight, 30 ?�상: Obese',
'- ?�수??계산 주의',
'[{"input": "70 175", "output": "Normal"}]',
'#include <stdio.h>

int main() {
    double weight, height;
    scanf("%lf %lf", &weight, &height);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "70 175", "expected": "Normal\n"}]',
'["?��? 미터�?변?�하?�요"]',
ARRAY['conditionals', 'math', 'health'], 10),

('typescript-switch-calculator', 'typescript', 'basics', 70, 'Switch 계산�?, 'switch문으�?계산�?만들�?, 'challenge', 2,
'???�수 a, b?� ?�산??+, -, *, /)가 주어�??? 결과�?출력?�세??',
'- switch �??�용\n- ?�눗?��? ?�수 ?�눗??,
'[{"input": "10 5 +", "output": "15"}, {"input": "10 3 /", "output": "3"}]',
'#include <stdio.h>

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10 5 +", "expected": "15\n"}, {"input": "10 3 /", "expected": "3\n"}]',
'["switch???�수/문자 값으�?분기?�니??]',
ARRAY['switch', 'calculator'], 10);

-- Unit 5: 반복�?(Loops) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-fibonacci', 'typescript', 'basics', 71, '?�보?�치 ?�열', 'N번째 ?�보?�치 ??구하�?, 'challenge', 2,
'?�수 N??주어�??? N번째 ?�보?�치 ?��? 출력?�세??\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)',
'- 반복�??�용\n- 1 ??N ??20',
'[{"input": "7", "output": "13"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "7", "expected": "13\n"}]',
'["?�전 ??값을 ?��??�세??]',
ARRAY['loops', 'fibonacci', 'sequence'], 15),

('typescript-prime-check', 'typescript', 'basics', 72, '?�수 ?�별', '?�수?��? ?�인?�기', 'challenge', 2,
'?�수 N??주어�??? ?�수?�면 "Prime", ?�니�?"Not Prime"??출력?�세??',
'- 2부???�N까�? ?�누?�떨?��??��? ?�인\n- N ??2',
'[{"input": "17", "output": "Prime"}, {"input": "20", "output": "Not Prime"}]',
'#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "17", "expected": "Prime\n"}, {"input": "20", "expected": "Not Prime\n"}]',
'["sqrt(n)까�?�??�인?�면 ?�니??]',
ARRAY['loops', 'prime', 'math'], 15),

('typescript-digit-sum', 'typescript', 'basics', 73, '?�릿????, '�??�릿?�의 ??구하�?, 'challenge', 2,
'?�수 N??주어�??? �??�릿?�의 ?�을 구하?�요.',
'- % 10?�로 마�?�??�리 추출\n- / 10?�로 ?�릿???�거',
'[{"input": "12345", "output": "15"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "12345", "expected": "15\n"}]',
'["반복?�면???�릿?��? 줄여가?�요"]',
ARRAY['loops', 'digits', 'math'], 10),

('typescript-reverse-number', 'typescript', 'basics', 74, '?�자 ?�집�?, '?�자�?거꾸�?만들�?, 'challenge', 2,
'?�수 N??주어�??? ?�릿?��? 거꾸�??�집?� ?��? 출력?�세??',
'- 1230 ??321 (?�의 0?� 무시)',
'[{"input": "12345", "output": "54321"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "12345", "expected": "54321\n"}]',
'["??�� ?��? 10�??�고 마�?�??�리�??�하?�요"]',
ARRAY['loops', 'digits'], 10),

('typescript-collatz-conjecture', 'typescript', 'basics', 75, '콜라�?추측', '1?????�까지???�계 ??, 'challenge', 2,
'?�수 N??주어�??? 1?????�까지???�계 ?��? 출력?�세??\n짝수: N/2, ?�?? 3N+1',
'- N ??1',
'[{"input": "6", "output": "8"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    // ?�기??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "6", "expected": "8\n"}]',
'["?�계마다 카운?��? 증�??�키?�요"]',
ARRAY['loops', 'algorithm', 'math'], 15);

-- Unit 6: ?�수 (Functions) - 5 challenges (MEDIUM)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-factorial-function', 'typescript', 'basics', 76, '?�토리얼 ?�수', 'N! 계산 ?�수 만들�?, 'challenge', 2,
'?�수 N???�토리얼??계산?�는 ?�수�??�성?�세??',
'- int factorial(int n)\n- 반복�??�용',
'[{"input": "5", "output": "120"}]',
'#include <stdio.h>

// ?�기??factorial ?�수�??�성?�세??
int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", factorial(n));
    return 0;
}',
'',
'[{"input": "5", "expected": "120\n"}]',
'["1부??n까�? 곱하?�요"]',
ARRAY['functions', 'factorial', 'math'], 10),

('typescript-recursive-fibonacci', 'typescript', 'basics', 77, '?��? ?�보?�치', '?��? ?�수�??�보?�치 ??구하�?, 'challenge', 2,
'?��? ?�수�??�용?�여 N번째 ?�보?�치 ?��? 구하?�요.',
'- int fib(int n)\n- ?��? ?�출',
'[{"input": "7", "output": "13"}]',
'#include <stdio.h>

// ?�기??fib ?�수�??�성?�세??
int main() {
    int n;
    scanf("%d", &n);
    printf("%d\n", fib(n));
    return 0;
}',
'',
'[{"input": "7", "expected": "13\n"}]',
'["기�? ?��??� ?��? ?�출??구현?�세??]',
ARRAY['functions', 'recursion', 'fibonacci'], 15),

('typescript-power-function', 'typescript', 'basics', 78, '거듭?�곱 ?�수', 'base^exponent 계산?�기', 'challenge', 2,
'base?� exponent가 주어�??? base^exponent�?계산?�는 ?�수�??�성?�세??',
'- int power(int base, int exp)\n- 반복�??�용',
'[{"input": "2 10", "output": "1024"}]',
'#include <stdio.h>

// ?�기??power ?�수�??�성?�세??
int main() {
    int base, exp;
    scanf("%d %d", &base, &exp);
    printf("%d\n", power(base, exp));
    return 0;
}',
'',
'[{"input": "2 10", "expected": "1024\n"}]',
'["base�?exp�?곱하?�요"]',
ARRAY['functions', 'power', 'math'], 10),

('typescript-array-function', 'typescript', 'basics', 79, '배열 ?�수', '배열???�수�??�달?�기', 'challenge', 2,
'배열�??�기�??�력받아 ?�균??계산?�는 ?�수�??�성?�세??',
'- double average(int arr[], int size)',
'[{"input": "5\n10 20 30 40 50", "output": "30.00"}]',
'#include <stdio.h>

// ?�기??average ?�수�??�성?�세??
int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    printf("%.2f\n", average(arr, n));
    return 0;
}',
'',
'[{"input": "5\n10 20 30 40 50", "expected": "30.00\n"}]',
'["배열?� ?�인?�로 ?�달?�니??]',
ARRAY['functions', 'arrays', 'average'], 15),

('typescript-pass-by-reference', 'typescript', 'basics', 80, '참조�??�달', '?�인?�로 �?변경하�?, 'challenge', 2,
'???�수???�과 차�? ?�시??구하???�수�??�성?�세??',
'- void calculate(int a, int b, int *sum, int *diff)',
'[{"input": "10 3", "output": "13\n7"}]',
'#include <stdio.h>

// ?�기??calculate ?�수�??�성?�세??
int main() {
    int a, b, sum, diff;
    scanf("%d %d", &a, &b);
    calculate(a, b, &sum, &diff);
    printf("%d\n%d\n", sum, diff);
    return 0;
}',
'',
'[{"input": "10 3", "expected": "13\n7\n"}]',
'["?�인?��? ?�해 값을 변경하?�요"]',
ARRAY['functions', 'pointers', 'pass-by-reference'], 15);

-- Unit 7: 배열 (Arrays) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-bubble-sort', 'typescript', 'advanced', 81, '버블 ?�렬', '배열???�름차순?�로 ?�렬?�기', 'challenge', 3,
'N개의 ?�수�?버블 ?�렬 ?�고리즘?�로 ?�름차순 ?�렬?�세??',
'- ?�접???�소�?비교?�여 교환\n- 1 ??N ??100',
'[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기??버블 ?�렬 코드�??�성?�세??
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}',
'',
'[{"input": "5\n64 34 25 12 22", "expected": "12 22 25 34 64 \n"}]',
'["중첩 루프�??�접 ?�소�?비교?�세??]',
ARRAY['arrays', 'sorting', 'bubble-sort'], 20),

('typescript-binary-search', 'typescript', 'advanced', 82, '?�진 ?�색', '?�렬??배열?�서 �?찾기', 'challenge', 3,
'?�렬??배열?�서 target???�진 ?�색?�로 찾아 ?�덱?��? 반환?�세?? ?�으�?-1',
'- 중간값과 비교?�여 ?�색 범위�??�반??줄임',
'[{"input": "5\n1 3 5 7 9\n5", "output": "2"}]',
'#include <stdio.h>

int binarySearch(int arr[], int size, int target) {
    // ?�기???�진 ?�색 코드�??�성?�세??}

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
}',
'',
'[{"input": "5\n1 3 5 7 9\n5", "expected": "2\n"}]',
'["left, right ?�인?�로 범위�?좁�?가?�요"]',
ARRAY['arrays', 'search', 'binary-search'], 20),

('typescript-2d-array-transpose', 'typescript', 'advanced', 83, '?�렬 ?�치', '2차원 배열 ?�치?�기', 'challenge', 3,
'N×M ?�렬???�치(?�과 ?�을 바꿈)?�여 출력?�세??',
'- 2 ??N, M ??10',
'[{"input": "2 3\n1 2 3\n4 5 6", "output": "1 4\n2 5\n3 6"}]',
'#include <stdio.h>

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    int arr[10][10];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &arr[i][j]);
        }
    }
    // ?�기???�치 �?출력 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "2 3\n1 2 3\n4 5 6", "expected": "1 4 \n2 5 \n3 6 \n"}]',
'["?�과 ?�의 ?�덱?��? 바꿔??출력?�세??]',
ARRAY['arrays', '2d-array', 'matrix'], 20),

('typescript-array-rotation', 'typescript', 'advanced', 84, '배열 ?�전', '배열??K�??�전?�기', 'challenge', 3,
'N개의 ?�수 배열???�쪽?�로 K�??�전?�세??',
'- ?�전: [1,2,3,4,5]�?1�??�전 ??[2,3,4,5,1]',
'[{"input": "5 2\n1 2 3 4 5", "output": "3 4 5 1 2"}]',
'#include <stdio.h>

int main() {
    int n, k;
    scanf("%d %d", &n, &k);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기???�전 코드�??�성?�세??
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}',
'',
'[{"input": "5 2\n1 2 3 4 5", "expected": "3 4 5 1 2 \n"}]',
'["?�시 배열???�용?�거??% ?�산?�로 ?�덱??계산"]',
ARRAY['arrays', 'rotation'], 25),

('typescript-subarray-sum', 'typescript', 'advanced', 85, '부�?배열 ??, '?�속??부�?배열??최�? ??, 'challenge', 3,
'N개의 ?�수 배열?�서 ?�속??부�?배열????�?최댓값을 구하?�요. (카데???�고리즘)',
'- ?�수 ?�함 가??n- 1 ??N ??100',
'[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "output": "6"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    // ?�기??카데???�고리즘???�성?�세??
    return 0;
}',
'',
'[{"input": "8\n-2 1 -3 4 -1 2 1 -5", "expected": "6\n"}]',
'["?�재까�?????vs ?�로 ?�작, ??�???�??�택"]',
ARRAY['arrays', 'kadane', 'algorithm'], 30);

-- Unit 8: ?�인??(Pointers) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-pointer-arithmetic', 'typescript', 'advanced', 86, '?�인???�술', '?�인?�로 배열 ?�회?�기', 'challenge', 3,
'배열???�인???�술 ?�산만으�??�회?�여 ?�을 구하?�요.',
'- [] ?�용 금�?, *(ptr + i) ?�태 ?�용',
'[{"input": "5\n1 2 3 4 5", "output": "15"}]',
'#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    int arr[100];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }

    int *ptr = arr;
    // ?�기???�인???�술�??�을 구하??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]',
'["ptr + i??i번째 ?�소??주소?�니??]',
ARRAY['pointers', 'arithmetic'], 20),

('typescript-double-pointer', 'typescript', 'advanced', 87, '?�중 ?�인??, '?�인?�의 ?�인???�용?�기', 'challenge', 3,
'?�중 ?�인?��? ?�용?�여 ???�인?��? 가리키??값을 교환?�세??',
'- void swap(int **pp1, int **pp2)',
'[{"input": "10 20", "output": "20 10"}]',
'#include <stdio.h>

void swap(int **pp1, int **pp2) {
    // ?�기???�중 ?�인?�로 교환?�는 코드�??�성?�세??}

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int *p1 = &a, *p2 = &b;
    swap(&p1, &p2);
    printf("%d %d\n", *p1, *p2);
    return 0;
}',
'',
'[{"input": "10 20", "expected": "20 10\n"}]',
'["**pp???�인?��? 가리키???�인?��? 가리키??�?]',
ARRAY['pointers', 'double-pointer'], 25),

('typescript-function-pointer', 'typescript', 'advanced', 88, '?�수 ?�인??, '?�수 ?�인?�로 ?�산 ?�택', 'challenge', 3,
'?�수 ?�인?��? ?�용?�여 ?�칙?�산???�택?�으�??�행?�세??',
'- int (*operation)(int, int)',
'[{"input": "10 5 +", "output": "15"}]',
'#include <stdio.h>

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

int main() {
    int a, b;
    char op;
    scanf("%d %d %c", &a, &b, &op);

    // ?�기???�수 ?�인?��? ?�용?�는 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "10 5 +", "expected": "15\n"}]',
'["?�수 ?�름?� ?�수??주소?�니??]',
ARRAY['pointers', 'function-pointer'], 30),

('typescript-dynamic-array', 'typescript', 'advanced', 89, '?�적 배열', 'malloc?�로 ?�적 메모�??�당', 'challenge', 3,
'?�기�??�력받아 ?�적 배열???�성?�고, 값을 ?�력받아 ?�을 구하?�요.',
'- malloc ?�용\n- free�?메모�??�제',
'[{"input": "5\n1 2 3 4 5", "output": "15"}]',
'#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    scanf("%d", &n);

    // ?�기??malloc?�로 배열???�당?�고 ?�용?�는 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "5\n1 2 3 4 5", "expected": "15\n"}]',
'["malloc(?�기)�??�당, free(?�인??�??�제"]',
ARRAY['pointers', 'malloc', 'dynamic'], 25),

('typescript-linked-list-basics', 'typescript', 'advanced', 90, '?�결 리스??기초', '?�순 ?�결 리스??구현', 'challenge', 3,
'?�수�??�?�하???�결 리스?��? 만들�?모든 값을 출력?�세??',
'- struct Node ?�의\n- ?�적 ?�당 ?�용',
'[{"input": "3\n1 2 3", "output": "1 2 3"}]',
'#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;
    struct Node *next;
};

int main() {
    int n;
    scanf("%d", &n);

    // ?�기???�결 리스?��? 만들�?출력?�는 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "3\n1 2 3", "expected": "1 2 3 \n"}]',
'["�??�드�??�적 ?�당?�고 ?�결?�세??]',
ARRAY['pointers', 'linked-list', 'data-structures'], 30);

-- Unit 9: ?�일 ?�출??(File I/O) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-file-write', 'typescript', 'advanced', 91, '?�일 ?�기', '?�일???�스???�기', 'challenge', 3,
'문자?�을 ?�력받아 "output.txt" ?�일???�세??',
'- fopen, fprintf, fclose ?�용',
'[{"input": "Hello World", "output": "File written"}]',
'#include <stdio.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // ?�기???�일 ?�기 코드�??�성?�세??
    printf("File written\n");
    return 0;
}',
'',
'[{"input": "Hello World", "expected": "File written\n"}]',
'["fopen(?�일�? 모드), fprintf(?�일, ?�식, ...), fclose(?�일)"]',
ARRAY['file-io', 'write'], 20),

('typescript-file-read', 'typescript', 'advanced', 92, '?�일 ?�기', '?�일?�서 ?�스???�기', 'challenge', 3,
'"input.txt" ?�일???�용???�어 ?�면??출력?�세??',
'- fopen, fgets, fclose ?�용',
'[{"input": "", "output": "File content"}]',
'#include <stdio.h>

int main() {
    // ?�기???�일 ?�기 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "File content\n"}]',
'["fgets????줄씩 ?�습?�다"]',
ARRAY['file-io', 'read'], 20),

('typescript-file-copy', 'typescript', 'advanced', 93, '?�일 복사', '?�일 ?�용???�른 ?�일�?복사', 'challenge', 3,
'"source.txt"???�용??"dest.txt"�?복사?�세??',
'- ?�기?� ?�기�??�시??,
'[{"input": "", "output": "File copied"}]',
'#include <stdio.h>

int main() {
    // ?�기???�일 복사 코드�??�성?�세??
    printf("File copied\n");
    return 0;
}',
'',
'[{"input": "", "expected": "File copied\n"}]',
'["fgetc�???문자???�고 fputc�??�니??]',
ARRAY['file-io', 'copy'], 25),

('typescript-file-word-count', 'typescript', 'advanced', 94, '?�일 ?�어 ??, '?�일???�어 개수 ?�기', 'challenge', 3,
'"text.txt" ?�일???�어 개수�??�어 출력?�세??',
'- 공백?�로 구분???�어',
'[{"input": "", "output": "5"}]',
'#include <stdio.h>

int main() {
    // ?�기???�어 카운??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "", "expected": "5\n"}]',
'["fscanf�??�어�??�나???�으?�요"]',
ARRAY['file-io', 'parsing'], 25),

('typescript-binary-file', 'typescript', 'advanced', 95, '바이?�리 ?�일', '구조체�? 바이?�리 ?�일�??�??, 'challenge', 3,
'Person 구조체�? 바이?�리 ?�일???�고 ?�으?�요.',
'- fwrite, fread ?�용\n- "rb", "wb" 모드',
'[{"input": "John 25", "output": "John 25"}]',
'#include <stdio.h>

struct Person {
    char name[50];
    int age;
};

int main() {
    struct Person p;
    scanf("%s %d", p.name, &p.age);

    // ?�기??바이?�리 ?�일 ?�기/?�기 코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "John 25", "expected": "John 25\n"}]',
'["fwrite(&구조�? ?�기, 개수, ?�일)"]',
ARRAY['file-io', 'binary', 'struct'], 30);

-- Unit 10: 문자??처리 (String Processing) - 5 challenges (HARD)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
('typescript-string-reverse', 'typescript', 'advanced', 96, '문자???�집�?, '문자?�을 거꾸�?만들�?, 'challenge', 3,
'문자?�을 ?�력받아 ?�집?�서 출력?�세??',
'- 직접 구현 (strrev ?�용 금�?)',
'[{"input": "hello", "output": "olleh"}]',
'#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    scanf("%s", str);

    // ?�기??문자???�집�?코드�??�성?�세??
    printf("%s\n", str);
    return 0;
}',
'',
'[{"input": "hello", "expected": "olleh\n"}]',
'["???��???중간까�? 교환?�세??]',
ARRAY['strings', 'reverse'], 20),

('typescript-palindrome-check', 'typescript', 'advanced', 97, '?�문 검??, '?�문?��? ?�인?�기', 'challenge', 3,
'문자?�이 ?�문(?�뒤가 같음)?��? ?�인?�세?? "Yes" ?�는 "No"',
'- ?�?�문??구분 ?�음',
'[{"input": "racecar", "output": "Yes"}, {"input": "hello", "output": "No"}]',
'#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main() {
    char str[100];
    scanf("%s", str);

    // ?�기???�문 검??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "racecar", "expected": "Yes\n"}, {"input": "hello", "expected": "No\n"}]',
'["tolower�??�문??변?�하??비교"]',
ARRAY['strings', 'palindrome'], 20),

('typescript-string-tokenize', 'typescript', 'advanced', 98, '문자???�큰??, '공백?�로 문자???�누�?, 'challenge', 3,
'공백?�로 구분??문자?�을 ?�누??�??�어�???줄씩 출력?�세??',
'- strtok ?�용',
'[{"input": "hello world test", "output": "hello\nworld\ntest"}]',
'#include <stdio.h>
#include <string.h>

int main() {
    char str[100];
    fgets(str, sizeof(str), stdin);

    // ?�기???�큰??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "hello world test", "expected": "hello\nworld\ntest\n"}]',
'["strtok(문자?? 구분??�?반복 ?�출"]',
ARRAY['strings', 'tokenize', 'parsing'], 25),

('typescript-anagram-check', 'typescript', 'advanced', 99, '?�너그램 검??, '??문자?�이 ?�너그램?��? ?�인', 'challenge', 3,
'??문자?�이 ?�너그램(같�? 문자�?구성)?��? ?�인?�세??',
'- 문자 빈도?��? ?�어 비교',
'[{"input": "listen\nsilent", "output": "Yes"}]',
'#include <stdio.h>
#include <string.h>

int main() {
    char str1[100], str2[100];
    scanf("%s %s", str1, str2);

    // ?�기???�너그램 검??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "listen\nsilent", "expected": "Yes\n"}]',
'["�?문자??출현 ?�수�??�세??]',
ARRAY['strings', 'anagram', 'algorithm'], 25),

('typescript-substring-search', 'typescript', 'advanced', 100, '부�?문자??찾기', '문자????부�?문자???�치 찾기', 'challenge', 3,
'문자??s?�서 ?�턴 p가 처음 ?��??�는 ?�치�?출력?�세?? ?�으�?-1',
'- 직접 구현 (strstr ?�용 금�?)\n- ?�덱?�는 0부??,
'[{"input": "hello world\nworld", "output": "6"}]',
'#include <stdio.h>
#include <string.h>

int main() {
    char s[100], p[100];
    fgets(s, sizeof(s), stdin);
    fgets(p, sizeof(p), stdin);

    // 줄바�??�거
    s[strcspn(s, "\n")] = 0;
    p[strcspn(p, "\n")] = 0;

    // ?�기??부�?문자??검??코드�??�성?�세??
    return 0;
}',
'',
'[{"input": "hello world\nworld", "expected": "6\n"}]',
'["�??�치?�서 ?�턴�??�치?�는지 ?�인"]',
ARRAY['strings', 'search', 'algorithm'], 30);

-- ============================================================================
-- End of TypeScript Language Part 2
-- ============================================================================


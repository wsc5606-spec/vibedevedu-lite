/// CPP 챌린지 데이터 (총 16개)
/// SQL에서 자동 변환됨

class CppChallenges {
  static List<Map<String, dynamic>> getChallenges() {
    return [
      {
        'slug': r'''cpp-hello-world''',
        'language': r'''cpp''',
        'kind': r'''syntax''',
        'level': 1,
        'title': r'''Hello World''',
        'description': r'''C++로 첫 프로그램 작성하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.''',
        'constraints': r'''- cout을 사용하세요\n- endl 또는 \n으로 줄바꿈''',
        'examples': r'''[{"input": "", "output": "Hello, World!"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "Hello, World!\n"}]''',
        'hints': r'''["cout << 로 출력합니다", "endl은 줄바꿈을 의미합니다"]''',
        'tags': r'''["basics", "output", "cout"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-int-variable''',
        'language': r'''cpp''',
        'kind': r'''syntax''',
        'level': 6,
        'title': r'''정수 변수''',
        'description': r'''정수형 변수 선언과 출력''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수형 변수 num을 선언하고 100을 저장한 후 출력하세요.''',
        'constraints': r'''- int 타입 사용''',
        'examples': r'''[{"input": "", "output": "100"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    int num = 100;
    cout << num << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "100\n"}]''',
        'hints': r'''["int는 정수를 저장합니다"]''',
        'tags': r'''["basics", "variables", "int"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-arithmetic''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 11,
        'title': r'''사칙연산''',
        'description': r'''기본 산술 연산하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''두 정수 a=20, b=3의 덧셈, 뺄셈, 곱셈, 나눗셈 결과를 각 줄에 출력하세요.''',
        'constraints': r'''- +, -, *, / 연산자 사용''',
        'examples': r'''[{"input": "", "output": "23\n17\n60\n6"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int a = 20, b = 3;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    int a = 20, b = 3;
    cout << a + b << endl;
    cout << a - b << endl;
    cout << a * b << endl;
    cout << a / b << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "23\n17\n60\n6\n"}]''',
        'hints': r'''["정수 나눗셈은 소수점을 버립니다"]''',
        'tags': r'''["basics", "operators", "arithmetic"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-if-positive''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 16,
        'title': r'''양수 판별''',
        'description': r'''숫자가 양수인지 확인''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수 num을 입력받아 양수이면 "Positive"를 출력하세요.''',
        'constraints': r'''- if 문 사용''',
        'examples': r'''[{"input": "10", "output": "Positive"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    int num;
    cin >> num;
    if (num > 0) {
        cout << "Positive" << endl;
    }
    return 0;
}''',
        'test_cases': r'''[{"input": "10", "expected": "Positive\n"}]''',
        'hints': r'''["if (조건) { 실행할 코드 }"]''',
        'tags': r'''["conditionals", "if"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-for-loop''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 21,
        'title': r'''for 반복문''',
        'description': r'''1부터 10까지 출력''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''for문을 사용하여 1부터 10까지 출력하세요.''',
        'constraints': r'''- for 문 사용''',
        'examples': r'''[{"input": "", "output": "1 2 3 4 5 6 7 8 9 10"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    for (int i = 1; i <= 10; i++) {
        cout << i << " ";
    }
    cout << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "1 2 3 4 5 6 7 8 9 10 \n"}]''',
        'hints': r'''["for (초기값; 조건; 증감) { }"]''',
        'tags': r'''["loops", "for"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-function-add''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 26,
        'title': r'''덧셈 함수''',
        'description': r'''두 수를 더하는 함수''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''두 정수를 더하는 add 함수를 작성하세요.''',
        'constraints': r'''- int add(int a, int b)''',
        'examples': r'''[{"input": "5 7", "output": "12"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

// 여기에 add 함수를 작성하세요

int main() {
    int a, b;
    cin >> a >> b;
    cout << add(a, b) << endl;
    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int add(int a, int b) {
    return a + b;
}

int main() {
    int a, b;
    cin >> a >> b;
    cout << add(a, b) << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "5 7", "expected": "12\n"}]''',
        'hints': r'''["return a + b;"]''',
        'tags': r'''["functions", "return"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-array-declare''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 31,
        'title': r'''배열 선언''',
        'description': r'''배열 선언과 초기화''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''크기 5인 정수 배열을 {1,2,3,4,5}로 초기화하고 모든 요소를 출력하세요.''',
        'constraints': r'''- int arr[5]''',
        'examples': r'''[{"input": "", "output": "1 2 3 4 5"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 5; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "1 2 3 4 5 \n"}]''',
        'hints': r'''["int arr[] = {1, 2, 3, 4, 5};"]''',
        'tags': r'''["arrays", "basics"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-vector-declare''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 36,
        'title': r'''벡터 선언''',
        'description': r'''vector 사용하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수 벡터를 선언하고 {1,2,3,4,5}로 초기화한 후 출력하세요.''',
        'constraints': r'''- vector<int> 사용''',
        'examples': r'''[{"input": "", "output": "1 2 3 4 5"}]''',
        'initial_code': r'''#include <iostream>
#include <vector>
using namespace std;

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {1, 2, 3, 4, 5};
    for (auto x : v) {
        cout << x << " ";
    }
    cout << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "", "expected": "1 2 3 4 5 \n"}]''',
        'hints': r'''["vector<int> v = {...};"]''',
        'tags': r'''["vector", "basics", "stl"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-string-input''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 41,
        'title': r'''문자열 입력''',
        'description': r'''문자열 입력받기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''문자열을 입력받아 그대로 출력하세요.''',
        'constraints': r'''- cin 또는 getline 사용''',
        'examples': r'''[{"input": "Hello", "output": "Hello"}]''',
        'initial_code': r'''#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
#include <string>
using namespace std;

int main() {
    string str;
    cin >> str;
    cout << str << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "Hello", "expected": "Hello\n"}]''',
        'hints': r'''["cin >> str로 문자열 입력"]''',
        'tags': r'''["strings", "input"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''cpp-class-declare''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 46,
        'title': r'''클래스 선언''',
        'description': r'''간단한 클래스 만들기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수 멤버 변수 x를 가진 Point 클래스를 정의하고 값을 출력하세요.''',
        'constraints': r'''- class 키워드 사용''',
        'examples': r'''[{"input": "", "output": "10"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

// 여기에 Point 클래스를 정의하세요

int main() {
    Point p;
    p.x = 10;
    cout << p.x << endl;
    return 0;
}''',
        'solution_code': r'''#include <iostream>
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
}''',
        'test_cases': r'''[{"input": "", "expected": "10\n"}]''',
        'hints': r'''["class Point { public: int x; };"]''',
        'tags': r'''["oop", "class", "basics"]''',
        'estimated_time': 5,
      },
      {
        'slug': r'''c-pattern-triangle''',
        'language': r'''cpp''',
        'kind': r'''syntax''',
        'level': 51,
        'title': r'''삼각형 패턴''',
        'description': r'''별표로 삼각형 그리기''',
        'category': r'''challenge''',
        'difficulty': 2,
        'problem_description': r'''정수 N이 주어질 때, N줄의 삼각형 패턼을 출력하세요.\n예: N=3일 때\n*\n**\n***''',
        'constraints': r'''- 중첩 반복문 사용\n- 1 ≤ N ≤ 10''',
        'examples': r'''[{"input": "3", "output": "*\n**\n***"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
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
}''',
        'test_cases': r'''[{"input": "3", "expected": "*\n**\n***\n"}, {"input": "5", "expected": "*\n**\n***\n****\n*****\n"}]''',
        'hints': r'''["바깥 루프는 줄 수, 안쪽 루프는 별의 개수입니다"]''',
        'tags': r'''["loops", "pattern", "nested"]''',
        'estimated_time': 10,
      },
      {
        'slug': r'''c-bit-operations''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 56,
        'title': r'''비트 연산''',
        'description': r'''비트 연산자로 값 조작하기''',
        'category': r'''challenge''',
        'difficulty': 2,
        'problem_description': r'''두 정수 a, b가 주어질 때, AND, OR, XOR 연산 결과를 출력하세요.''',
        'constraints': r'''- &, |, ^ 연산자 사용\n- 각 줄에 하나씩 출력''',
        'examples': r'''[{"input": "12 10", "output": "8\n14\n6"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
using namespace std;

int main() {
    int a, b;
    cin >> a >> b;
    cout << a & b << endl;
    cout << a | b << endl;
    cout << a ^ b << endl;
    return 0;
}''',
        'test_cases': r'''[{"input": "12 10", "expected": "8\n14\n6\n"}]''',
        'hints': r'''$$["& (AND''',
      },
      {
        'slug': r'''c-leap-year''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 66,
        'title': r'''윤년 판별''',
        'description': r'''윤년인지 확인하기''',
        'category': r'''challenge''',
        'difficulty': 2,
        'problem_description': r'''연도가 주어질 때, 윤년이면 "Leap", 평년이면 "Common"을 출력하세요.\n윤년: 4의 배수이면서 100의 배수가 아니거나, 400의 배수''',
        'constraints': r'''- 조건을 정확히 구현''',
        'examples': r'''[{"input": "2000", "output": "Leap"}, {"input": "1900", "output": "Common"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int year;
    cin >> year;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
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
}''',
        'test_cases': r'''[{"input": "2000", "expected": "Leap\n"}, {"input": "1900", "expected": "Common\n"}]''',
        'hints': r'''["논리 연산자를 조합하세요"]''',
        'tags': r'''["conditionals", "logic"]''',
        'estimated_time': 10,
      },
      {
        'slug': r'''c-fibonacci''',
        'language': r'''cpp''',
        'kind': r'''basics''',
        'level': 71,
        'title': r'''피보나치 수열''',
        'description': r'''N번째 피보나치 수 구하기''',
        'category': r'''challenge''',
        'difficulty': 2,
        'problem_description': r'''정수 N이 주어질 때, N번째 피보나치 수를 출력하세요.\nF(1)=1, F(2)=1, F(n)=F(n-1)+F(n-2)''',
        'constraints': r'''- 반복문 사용\n- 1 ≤ N ≤ 20''',
        'examples': r'''[{"input": "7", "output": "13"}]''',
        'initial_code': r'''#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''#include <iostream>
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
}''',
        'test_cases': r'''[{"input": "7", "expected": "13\n"}]''',
        'hints': r'''["이전 두 값을 유지하세요"]''',
        'tags': r'''["loops", "fibonacci", "sequence"]''',
        'estimated_time': 15,
      },
      {
        'slug': r'''c-bubble-sort''',
        'language': r'''cpp''',
        'kind': r'''advanced''',
        'level': 81,
        'title': r'''버블 정렬''',
        'description': r'''배열을 오름차순으로 정렬하기''',
        'category': r'''challenge''',
        'difficulty': 3,
        'problem_description': r'''N개의 정수를 버블 정렬 알고리즘으로 오름차순 정렬하세요.''',
        'constraints': r'''- 인접한 원소를 비교하여 교환\n- 1 ≤ N ≤ 100''',
        'examples': r'''[{"input": "5\n64 34 25 12 22", "output": "12 22 25 34 64"}]''',
        'initial_code': r'''#include <iostream>
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
}''',
        'solution_code': r'''#include <iostream>
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
}''',
        'test_cases': r'''[{"input": "5\n64 34 25 12 22", "expected": "12 22 25 34 64 \n"}]''',
        'hints': r'''["중첩 루프로 인접 원소를 비교하세요"]''',
        'tags': r'''["arrays", "sorting", "bubble-sort"]''',
        'estimated_time': 20,
      },
      {
        'slug': r'''c-pointer-arithmetic''',
        'language': r'''cpp''',
        'kind': r'''advanced''',
        'level': 86,
        'title': r'''포인터 산술''',
        'description': r'''포인터로 배열 순회하기''',
        'category': r'''challenge''',
        'difficulty': 3,
        'problem_description': r'''배열을 포인터 산술 연산만으로 순회하여 합을 구하세요.''',
        'constraints': r'''- [] 사용 금지, *(ptr + i) 형태 사용''',
        'examples': r'''[{"input": "5\n1 2 3 4 5", "output": "15"}]''',
        'initial_code': r'''#include <iostream>
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
}''',
        'solution_code': r'''$func$#include <iostream>
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
        sum += *(ptr + i''',
      },
    ];
  }
}

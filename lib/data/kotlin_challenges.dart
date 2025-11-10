/// KOTLIN 챌린지 데이터 (총 7개)
/// SQL에서 자동 변환됨

class KotlinChallenges {
  static List<Map<String, dynamic>> getChallenges() {
    return [
      {
        'slug': r'''kotlin-hello-world''',
        'language': r'''kotlin''',
        'kind': r'''syntax''',
        'level': 1,
        'title': r'''Hello World''',
        'description': r'''C로 첫 프로그램 작성하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''화면에 "Hello, World!"를 출력하는 프로그램을 작성하세요.''',
        'constraints': r'''- printf 함수를 사용하세요\n- 줄바꿈(\n)을 포함해야 합니다''',
        'examples': r'''[{"input": "", "output": "Hello, World!"}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    printf("Hello, World!\n"''',
      },
      {
        'slug': r'''kotlin-integer-variable''',
        'language': r'''kotlin''',
        'kind': r'''syntax''',
        'level': 6,
        'title': r'''정수 변수''',
        'description': r'''정수형 변수 선언하고 출력하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수형 변수 num을 선언하고 42를 저장한 후 출력하세요.''',
        'constraints': r'''- int 타입을 사용하세요\n- %d를 사용하여 출력하세요''',
        'examples': r'''[{"input": "", "output": "42"}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    int num = 42;
    printf("%d\n", num''',
      },
      {
        'slug': r'''kotlin-addition''',
        'language': r'''kotlin''',
        'kind': r'''basics''',
        'level': 11,
        'title': r'''덧셈 계산''',
        'description': r'''두 수의 합 구하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''두 정수 a=15, b=25의 합을 계산하여 출력하세요.''',
        'constraints': r'''- + 연산자를 사용하세요''',
        'examples': r'''[{"input": "", "output": "40"}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    int a = 15, b = 25;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    int a = 15, b = 25;
    int sum = a + b;
    printf("%d\n", sum''',
      },
      {
        'slug': r'''kotlin-for-1-to-10''',
        'language': r'''kotlin''',
        'kind': r'''basics''',
        'level': 21,
        'title': r'''1부터 10까지 출력''',
        'description': r'''for문으로 1부터 10까지 출력하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''for문을 사용하여 1부터 10까지의 숫자를 한 줄에 하나씩 출력하세요.''',
        'constraints': r'''- for문을 사용하세요''',
        'examples': r'''[{"input": "", "output": "1\n2\n3\n4\n5\n6\n7\n8\n9\n10"}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    for (int i = 1; i <= 10; i++) {
        printf("%d\n", i''',
      },
      {
        'slug': r'''kotlin-array-declare''',
        'language': r'''kotlin''',
        'kind': r'''basics''',
        'level': 31,
        'title': r'''배열 선언''',
        'description': r'''배열 선언하고 초기화하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''크기가 5인 정수 배열을 선언하고 1, 2, 3, 4, 5로 초기화한 후 모든 요소를 출력하세요.''',
        'constraints': r'''- 배열 선언: int arr[5]''',
        'examples': r'''[{"input": "", "output": "1 2 3 4 5"}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]''',
      },
      {
        'slug': r'''kotlin-pointer-address''',
        'language': r'''kotlin''',
        'kind': r'''basics''',
        'level': 36,
        'title': r'''변수 주소 출력''',
        'description': r'''변수의 메모리 주소 출력하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''정수 변수 num의 값과 주소를 출력하세요.''',
        'constraints': r'''- & 연산자를 사용하여 주소를 얻으세요\n- %p로 주소를 출력하세요''',
        'examples': r'''[{"input": "", "output": "Value: 10\nAddress: 0x..."}]''',
        'initial_code': r'''#include <stdio.h>

int main() {
    int num = 10;
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>

int main() {
    int num = 10;
    printf("Value: %d\n", num''',
      },
      {
        'slug': r'''kotlin-struct-declare''',
        'language': r'''kotlin''',
        'kind': r'''basics''',
        'level': 46,
        'title': r'''구조체 선언''',
        'description': r'''구조체 정의하고 사용하기''',
        'category': r'''challenge''',
        'difficulty': 1,
        'problem_description': r'''이름(문자열)과 나이(정수)를 가진 Person 구조체를 정의하고 값을 출력하세요.''',
        'constraints': r'''- struct Person { char name[50]; int age; };''',
        'examples': r'''[{"input": "", "output": "Name: John, Age: 25"}]''',
        'initial_code': r'''#include <stdio.h>
#include <string.h>

// 여기에 구조체를 정의하세요

int main() {
    // 여기에 코드를 작성하세요

    return 0;
}''',
        'solution_code': r'''$func$#include <stdio.h>
#include <string.h>

struct Person {
    char name[50];
    int age;
};

int main() {
    struct Person p;
    strcpy(p.name, "John"''',
      },
    ];
  }
}

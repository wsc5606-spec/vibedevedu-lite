#!/usr/bin/env python3
"""
모든 끊긴 INSERT 문 자동 수정
"""
import re

def fix_incomplete_inserts(content):
    """끊긴 INSERT 문들을 모두 수정"""

    # 패턴 1: CSS 코드 블록이 끊긴 경우 - 닫는 중괄호와 필드 추가
    # 예: $$selector {\n    property: value;\n\nINSERT
    pattern1 = r'\$\$([^$]+\{[^}]+);?\s*\n\s*\nINSERT INTO challenges'

    def replace_css(match):
        css_content = match.group(1)
        return f'$${css_content};\n}}$$,\n$$[{{"input": "", "expected": "css applied"}}]$$,\n$$["CSS 속성이 적용되었습니다"]$$,\n$$["css", "basic"]$$, 5);\n\nINSERT INTO challenges'

    content = re.sub(pattern1, replace_css, content)

    # 패턴 2: C 구조체 constraints가 끊긴 경우
    # 예: $$- struct Person { char name[50];\n\nINSERT
    pattern2 = r'\$\$- struct Person \{ char name\[50\];\s*\n\s*\nINSERT INTO challenges'

    def replace_struct(match):
        return '$$- struct Person { char name[50]; int age; };$$,\n$$[{"input": "", "output": "Person struct"}]$$,\n$$#include <stdio.h>\\n\\nstruct Person {\\n    char name[50];\\n    int age;\\n};\\n\\nint main() {\\n    // 구조체 사용\\n    return 0;\\n}$$,\n$$#include <stdio.h>\\n\\nstruct Person {\\n    char name[50];\\n    int age;\\n};\\n\\nint main() {\\n    struct Person p;\\n    strcpy(p.name, "John");\\n    p.age = 30;\\n    printf("%s, %d\\\\n", p.name, p.age);\\n    return 0;\\n}$$,\n$$[{"input": "", "expected": "struct output"}]$$,\n$$["구조체는 여러 데이터를 묶어서 관리합니다"]$$,\n$$["struct", "basics"]$$, 10);\n\nINSERT INTO challenges'

    content = re.sub(pattern2, replace_struct, content)

    # 패턴 3: JavaScript/C hello-world initial_code가 끊긴 경우
    # 예: return 0;\n\nINSERT
    pattern3 = r'return 0;\s*\n\s*\nINSERT INTO challenges'

    def replace_main(match):
        return 'return 0;\n}$func$,\n$func$#include <stdio.h>\\n\\nint main() {\\n    printf("Hello, World!\\\\n");\\n    return 0;\\n}$func$,\n$$[{"input": "", "expected": "Hello, World!"}]$$,\n$$["printf로 문자열을 출력합니다"]$$,\n$$["basics", "hello-world"]$$, 3);\n\nINSERT INTO challenges'

    content = re.sub(pattern3, replace_main, content)

    return content

def main():
    print("끊긴 INSERT 문 수정 시작...")

    with open('ALL-CHALLENGES-FINAL.sql', 'r', encoding='utf-8') as f:
        content = f.read()

    print("패턴 매칭 및 수정 중...")
    fixed = fix_incomplete_inserts(content)

    # 변경 사항 확인
    if content == fixed:
        print("변경 사항이 없습니다.")
    else:
        print("변경 사항을 파일에 저장 중...")
        with open('ALL-CHALLENGES-FINAL.sql', 'w', encoding='utf-8') as f:
            f.write(fixed)
        print("✅ 완료!")

if __name__ == "__main__":
    main()

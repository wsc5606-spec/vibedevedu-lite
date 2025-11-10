#!/usr/bin/env python3
"""
마지막 폴리싱 스크립트 - 남은 조사 교체
"""
import re

def polish_fix(text):
    """남은 "은" -> "를" 패턴 수정"""

    result = text

    # 특정 패턴들
    patterns = {
        'HTML5은 의미': 'HTML5를 의미',
        'HTML5은': 'HTML5를',
        '것을 은': '것을 를',
        '값을 은': '값을 를',
        '데이터은': '데이터를',
        '스타일을 은': '스타일을 를',
        '함수은': '함수를',
        '변수은': '변수를',
        '객체은': '객체를',
        '배열을 은': '배열을 를',
        '클래스은': '클래스를',
        '인터페이스은': '인터페이스를',
        '타입을 은': '타입을 를',
    }

    for old, new in patterns.items():
        result = result.replace(old, new)

    # 일반 패턴: "XXX은 " -> "XXX를 " (명사 뒤의 은)
    # 단, "은"이 "은행", "은퇴" 등의 단어가 아닌 경우만
    result = re.sub(r'([가-힣]+)은 ([가-힣]+(하|시|되|합니다|입니다|세요|니다))', r'\1를 \2', result)

    return result

def main():
    input_file = 'ALL-CHALLENGES-FINAL-V2.sql'
    output_file = 'ALL-CHALLENGES-READY.sql'

    print(f"Reading {input_file}...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    print("Applying polish fixes...")
    fixed_content = polish_fix(content)

    print(f"Writing to {output_file}...")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(fixed_content)

    print(f"\nDone! Use {output_file}")
    print("\nFile is ready for Supabase upload!")

if __name__ == "__main__":
    main()

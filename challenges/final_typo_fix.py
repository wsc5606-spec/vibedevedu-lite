#!/usr/bin/env python3
"""
마지막 오타 일괄 수정
"""

def fix_typos(text):
    """남은 모든 오타 수정"""

    replacements = {
        # 입력 관련
        '삽입력': '입력',

        # 속성 관련
        '작성과': '속성과',
        '작성은': '속성은',
        '작성에': '속성에',
        '작성을': '속성을',

        # 입니다 관련
        '삽입니다': '입니다',
        '유사용합니다': '유용합니다',

        # 타입 관련
        '타삽입은': '타입은',

        # 조사 오류
        '은 의미적 중요도은,': '은 의미적 중요도,',
        '은 강조은,': '은 강조,',
        '나이은 ': '나이를 ',
        '트 정수은 ': '두 정수를 ',
        '정수 하나은 ': '정수 하나를 ',
        '모트 주석': '모두 주석',
        '"이것은 출력 코드삽입니다"은': '"이것은 출력 코드입니다"를',
        'Hello은 출력': 'Hello를 출력',
        '에디터은 만들': '에디터를 만들',
        '"Positive"은 출력': '"Positive"를 출력',

        # 기타
        '라레벨': '라벨',
        '공유사용': '공유를 위한',
        '학습사용삽입니다': '학습용입니다',
    }

    result = text
    for old, new in replacements.items():
        result = result.replace(old, new)

    return result

def main():
    print("최종 오타 수정 중...")

    with open('ALL-CHALLENGES-FINAL.sql', 'r', encoding='utf-8') as f:
        content = f.read()

    fixed = fix_typos(content)

    with open('ALL-CHALLENGES-FINAL.sql', 'w', encoding='utf-8') as f:
        f.write(fixed)

    print("완료! ALL-CHALLENGES-FINAL.sql 파일이 수정되었습니다.")
    print("\n이제 Supabase에 업로드할 준비가 되었습니다!")

if __name__ == "__main__":
    main()

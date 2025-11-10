#!/usr/bin/env python3
"""
포괄적인 한글 복구 스크립트
모든 깨진 패턴을 자동으로 복구
"""

import re

def comprehensive_fix(text):
    """포괄적인 한글 복구"""

    # 1단계: 명확한 깨진 패턴들을 직접 교체
    patterns = {
        # 조사/어미 - 가장 먼저 처리
        '두': '를',
        '�?': '를',
        '세': '세요',
        '다': '다',
        '니': '니다',
        '요': '요',
        '의': '의',
        '에': '에',
        '가': '가',
        '는': '는',
        '로': '로',
        '지': '지',
        '이': '이',

        # 자주 나오는 단어들
        '그': '태그',
        '스두': '텍스트',
        '력': '입력',
        '성': '속성',
        '션': '섹션',
        '창': '창',
        '택': '선택',
        '형': '형식',
        '굵�?': '굵은',
        '탤�?': '이탤릭',
        '일': '파일',
        '검두': '검색',
        '범위': '범위',
        '라더': '슬라이더',
        '러': '여러',
        '평': '수평',
        '중첩': '중첩',
    }

    result = text

    # 2단계: SQL 구문 내의 한글 부분만 안전하게 교체
    # INSERT 문의 VALUES 부분에서만 교체
    def replace_in_values(match):
        content = match.group(0)
        for old, new in patterns.items():
            # 따옴표 안의 내용만 교체하도록 주의
            content = re.sub(
                rf"(['\"])([^'\"]*?){re.escape(old)}([^'\"]*?)(\1)",
                rf"\1\2{new}\3\4",
                content
            )
        return content

    # VALUES(...) 부분만 찾아서 교체
    result = re.sub(
        r'VALUES\s*\([^)]+\)',
        replace_in_values,
        result,
        flags=re.DOTALL
    )

    return result

def main():
    print("Reading ALL-CHALLENGES-FIXED.sql...")
    with open('ALL-CHALLENGES-FIXED.sql', 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()

    print("Applying comprehensive fixes...")
    fixed = comprehensive_fix(content)

    print("Writing to ALL-CHALLENGES-FINAL.sql...")
    with open('ALL-CHALLENGES-FINAL.sql', 'w', encoding='utf-8') as f:
        f.write(fixed)

    print("\nDone! Use ALL-CHALLENGES-FINAL.sql")

if __name__ == "__main__":
    main()

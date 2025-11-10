#!/usr/bin/env python3
"""
간단 일괄 치환 스크립트
"""

def simple_fix(text):
    """간단한 일괄 치환"""

    replacements = [
        # 먼저 복합 패턴부터 처리
        ('작속성하기', '작성하기'),
        ('작속성하세요요', '작성하세요'),
        ('태태그', '태그'),
        ('출입력', '출력'),
        ('입입력', '입력'),
        ('프로태그램', '프로그램'),
        ('형식 태그리기', '형 그리기'),
        ('형식 변수', '형 변수'),
        ('를 수의', '두 수의'),
        ('를 수를', '두 수를'),
        ('주소개', '주소'),
        ('파파일', '파일'),
        ('생속성파일', '생성일'),
        ('선선택사항', '선택사항'),

        # 단일 패턴
        ('속성', '성'),
        ('형식', '형'),
        ('태그', '그'),
        ('입력', '력'),
        ('섹션', '션'),
        ('선택', '택'),
        ('파일', '일'),
        ('여러', '러'),
        ('검색', '검두'),
        ('슬라이더', '라더'),
        ('수평선', '평두'),
        ('텍스트', '스두'),
        ('이탤릭', '탤�?'),
        ('굵은', '굵�?'),
        ('하세요', '세'),
        ('니다', '니'),
        ('를', '�?'),
    ]

    result = text
    for old, new in replacements:
        result = result.replace(old, new)

    return result

with open('ALL-CHALLENGES-FIXED.sql', 'r', encoding='utf-8') as f:
    content = f.read()

fixed = simple_fix(content)

with open('ALL-CHALLENGES-FINAL.sql', 'w', encoding='utf-8') as f:
    f.write(fixed)

print("Fixed! Use ALL-CHALLENGES-FINAL.sql")

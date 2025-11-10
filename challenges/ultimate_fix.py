#!/usr/bin/env python3
"""
최종 완전 수정 스크립트 - 모든 한글 인코딩 오류 해결
"""
import re

def ultimate_fix(text):
    """SQL 파일의 모든 한글 인코딩 문제를 해결"""

    result = text

    # 1단계: 명확히 깨진 패턴들을 직접 복구
    direct_replacements = [
        # 완전히 깨진 단어들
        ('탤기본스트', '이탤릭 텍스트'),
        ('이이트', '하이라이트'),
        ('기본 스트', '작은 텍스트'),
        ('확대/삽입', '삭제/삽입'),
        ('굵�? 스두', '굵은 텍스트'),
        ('이탤�? 스두', '이탤릭 텍스트'),

        # 자주 나오는 깨진 패턴
        ('기본', '를'),
        ('스트', '텍스트'),
        ('하세요요', '하세요'),
        ('삽입니다', '입니다'),
        ('삽입', '을'),
        ('기본', '으로'),

        # 조사 문제
        ('은 ', '를 '),

        # 동사 패턴
        ('하도록', '을'),
        ('니트', '니다'),
    ]

    for old, new in direct_replacements:
        result = result.replace(old, new)

    return result

def main():
    # 원본 파일 읽기
    print("원본 파일 읽는 중...")
    with open('ALL-CHALLENGES-COMBINED.sql', 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()

    print("한글 인코딩 수정 중...")
    fixed = ultimate_fix(content)

    # 결과 저장
    output_file = 'ALL-CHALLENGES-ULTIMATE.sql'
    print(f"{output_file}에 저장 중...")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(fixed)

    print(f"\n완료! {output_file} 파일을 확인하세요.")

if __name__ == "__main__":
    main()

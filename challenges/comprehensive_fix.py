#!/usr/bin/env python3
"""
포괄적인 한글 복구 스크립트 - 모든 깨진 패턴 수정
"""

def comprehensive_fix(text):
    """모든 깨진 한글 패턴을 올바른 텍스트로 교체"""

    # 복합 패턴부터 먼저 처리 (긴 패턴이 먼저)
    replacements = [
        # 복합 패턴
        ('작속성하기', '작성하기'),
        ('작속성하세요', '작성하세요'),
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
        ('반응형메타 그', '반응형 메타 태그'),
        ('뷰포두정', '뷰포트 설정'),
        ('디두입', '오디오 삽입'),
        ('�?지 캡션', '이미지 캡션'),
        ('반응형�?지', '반응형 이미지'),
        ('목 그', '제목 태그'),
        ('러 목 벨', '여러 제목 레벨'),
        ('문단 그', '문단 태그'),
        ('평두', '수평선'),
        ('굵�? 스두', '굵은 텍스트'),
        ('이탤�? 스두', '이탤릭 텍스트'),
        ('를 스두', '작은 텍스트'),
        ('�?HTML 문서 성기', '기본 HTML 문서 작성'),
        ('title 그 용', 'title 태그 사용'),
        ('주석 성기', '주석 작성'),
        ('h1 그 용', 'h1 태그 사용'),
        ('p 그 용', 'p 태그 사용'),
        ('br 그', 'br 태그'),
        ('hr 그', 'hr 태그'),
        ('strong 그', 'strong 태그'),
        ('em 그', 'em 태그'),
        ('mark 그', 'mark 태그'),
        ('small 그', 'small 태그'),
        ('video 그', 'video 태그'),
        ('audio 그', 'audio 태그'),
        ('picture 그', 'picture 태그'),
        ('비디오입', '비디오 삽입'),
        ('이이를', '하이라이트'),

        # 단일 패턴 (짧은 패턴들)
        ('속성', '작성'),
        ('그 ', '태그 '),
        (' 그,', ' 태그,'),
        (' 그\'', ' 태그\''),
        ('두정', '트 설정'),
        ('성기', '작성'),
        ('용', '사용'),
        ('입', '삽입'),
        ('벨', '레벨'),
        ('�?', '기본'),
        ('두', '트'),
        ('를', '은'),
        ('�?', '이미지'),
    ]

    result = text
    total_replacements = 0
    for old, new in replacements:
        if old in result:
            count = result.count(old)
            total_replacements += count
            result = result.replace(old, new)

    print(f"Total replacements made: {total_replacements}")
    return result

def main():
    input_file = 'ALL-CHALLENGES-FIXED.sql'
    output_file = 'ALL-CHALLENGES-FINAL.sql'

    print(f"Reading {input_file}...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    print("\nApplying comprehensive fixes...")
    fixed_content = comprehensive_fix(content)

    print(f"\nWriting to {output_file}...")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(fixed_content)

    print(f"\nDone! Check {output_file}")

if __name__ == "__main__":
    main()

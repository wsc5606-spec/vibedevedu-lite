#!/usr/bin/env python3
"""
최종 한글 복구 스크립트
"""
import re

def final_fix(text):
    """모든 깨진 한글 패턴을 올바른 텍스트로 교체"""

    # 1단계: 중복된 글자 패턴 수정
    doubled_patterns = {
        '태태그': '태그',
        '사사용': '사용',
        '삽삽입': '삽입',
        '작작성': '작성',
        '설설정': '설정',
        '표표시': '표시',
        '선선언': '선언',
        '위위치': '위치',
        '필필수': '필수',
        '추추가': '추가',
        '제제공': '공제',
        '지지원': '지원',
        '반반응': '반응',
    }

    result = text
    for old, new in doubled_patterns.items():
        result = result.replace(old, new)

    # 2단계: 잘못된 조사 교체
    # "은" -> "를" 패턴 (단, "은"이 조사로 쓰인 경우만)
    result = re.sub(r'구조은 작성', '구조를 작성', result)
    result = re.sub(r'태그은 추가', '태그를 추가', result)
    result = re.sub(r'비디오은 삽입', '비디오를 삽입', result)
    result = re.sub(r'오디오은 삽입', '오디오를 삽입', result)
    result = re.sub(r'이미지은 삽입', '이미지를 삽입', result)
    result = re.sub(r'소개스은', '소스를', result)
    result = re.sub(r'콘텐츠은', '콘텐츠를', result)
    result = re.sub(r'문서은', '문서를', result)
    result = re.sub(r'제목을 ', '제목을 ', result)
    result = re.sub(r'주석을 ', '주석을 ', result)
    result = re.sub(r'DOCTYPE은', 'DOCTYPE는', result)

    # 3단계: 특정 단어 교체
    specific_words = {
        '소개스': '소스',
        '내사용': '내용',
        '필수삽입니다': '필수입니다',
        'self-closing삽입니다': 'self-closing입니다',
        '작성하기': '작성',
        '주석 작성하기': '주석 작성',
        '비디오 삽삽입': '비디오 삽입',
        '오디오 삽삽입': '오디오 삽입',
    }

    for old, new in specific_words.items():
        result = result.replace(old, new)

    # 4단계: 전반적인 "은"을 찾아서 문맥에 맞게 교체
    # 명사 + 은 -> 명사 + 를
    common_nouns = ['문서', '태그', '요소', '속성', '값', '텍스트', '이미지',
                    '비디오', '오디오', '링크', '목록', '테이블', '폼', '버튼']
    for noun in common_nouns:
        result = re.sub(rf'{noun}은 ', f'{noun}를 ', result)

    return result

def main():
    input_file = 'ALL-CHALLENGES-FINAL.sql'
    output_file = 'ALL-CHALLENGES-FINAL-V2.sql'

    print(f"Reading {input_file}...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    print("Applying final fixes...")
    fixed_content = final_fix(content)

    print(f"Writing to {output_file}...")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(fixed_content)

    print(f"\nDone! Use {output_file}")

if __name__ == "__main__":
    main()

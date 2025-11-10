#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""650개 챌린지 최종 검증"""

def validate():
    with open('ALL-CHALLENGES-650-CLEAN.sql', 'r', encoding='utf-8') as f:
        content = f.read()

    print("=" * 80)
    print("최종 검증 리포트")
    print("=" * 80)

    # 기본 통계
    print(f"\n파일 크기: {len(content):,} bytes")
    print(f"총 라인 수: {len(content.splitlines()):,}")

    # SQL 문법 검증
    insert_count = content.count('INSERT INTO challenges')
    semicolon_count = content.count(');')
    dollar_count = content.count('$$')

    print(f"\nSQL 구조:")
    print(f"  INSERT 문: {insert_count}")
    print(f"  세미콜론: {semicolon_count}")
    print(f"  $$ 패턴: {dollar_count}")
    print(f"  균형 체크: {'[OK]' if insert_count == semicolon_count == 650 else '[ERROR]'}")

    # 한글 인코딩 체크
    broken_chars = content.count('\ufffd')
    print(f"\n인코딩:")
    print(f"  깨진 문자: {broken_chars} {'[OK]' if broken_chars == 0 else '[ERROR]'}")

    # 언어별 챌린지 수
    print(f"\n언어별 챌린지 수:")
    langs = ['html', 'css', 'javascript', 'typescript', 'python', 'dart',
             'kotlin', 'csharp', 'java', 'go', 'c', 'cpp', 'sql']

    total = 0
    for lang in langs:
        count = content.count(f'$${lang}$$')
        status = '[OK]' if count == 50 else '[ERROR]'
        print(f"  {lang:12s}: {count:3d} {status}")
        total += count

    print(f"\n총 챌린지: {total} {'[OK]' if total == 650 else '[ERROR]'}")

    # 필수 필드 확인
    print(f"\n필수 필드 검증:")
    fields = ['slug', 'language', 'kind', 'level', 'title', 'description',
              'category', 'difficulty', 'problem_description', 'constraints',
              'examples', 'initial_code', 'solution_code', 'test_cases',
              'hints', 'tags', 'estimated_time']

    all_ok = True
    for field in fields:
        count = content.count(field)
        # 각 필드는 최소 650번 이상 나와야 함
        if count < 650:
            print(f"  {field}: {count} [ERROR - 부족]")
            all_ok = False

    if all_ok:
        print(f"  모든 필드 정상 [OK]")

    # 최종 결과
    print("\n" + "=" * 80)
    if insert_count == semicolon_count == 650 and total == 650 and broken_chars == 0:
        print("[SUCCESS] 완벽한 650개 챌린지 파일입니다!")
        print("Supabase에 업로드할 준비가 완료되었습니다.")
        print("\n업로드 방법:")
        print("1. Supabase Dashboard > SQL Editor 열기")
        print("2. ALL-CHALLENGES-650-CLEAN.sql 파일 내용 복사")
        print("3. SQL Editor에 붙여넣기")
        print("4. Run 버튼 클릭")
    else:
        print("[ERROR] 파일에 문제가 있습니다. 위의 오류를 확인하세요.")
    print("=" * 80)

if __name__ == "__main__":
    validate()

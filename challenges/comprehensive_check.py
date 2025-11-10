#!/usr/bin/env python3
"""
PostgreSQL/Supabase 업로드 전 종합 점검
"""
import re

def comprehensive_check():
    """SQL 파일의 모든 잠재적 오류 점검"""

    with open('ALL-CHALLENGES-FINAL.sql', 'r', encoding='utf-8') as f:
        content = f.read()
        lines = content.split('\n')

    print("=" * 60)
    print("PostgreSQL/Supabase 종합 오류 점검")
    print("=" * 60)

    # 1. INSERT 문 개수 확인
    insert_count = content.count('INSERT INTO challenges')
    semicolon_count = content.count(');')
    print(f"\n1. INSERT 문 구조 점검:")
    print(f"   - INSERT INTO challenges 수: {insert_count}")
    print(f"   - 세미콜론 종료 수: {semicolon_count}")
    if insert_count == semicolon_count:
        print(f"   [OK] 모든 INSERT 문이 올바르게 종료됨")
    else:
        print(f"   [ERROR] 경고: INSERT 문과 세미콜론 수가 불일치")

    # 2. VALUES 키워드 확인
    values_count = content.count('VALUES')
    print(f"\n2. VALUES 키워드 점검:")
    print(f"   - VALUES 키워드 수: {values_count}")
    if values_count == insert_count:
        print(f"   [OK] 모든 INSERT 문에 VALUES 존재")
    else:
        print(f"   [ERROR] 경고: VALUES 누락 가능성")

    # 3. 달러 인용 균형 확인
    dollar_quotes = re.findall(r'\$\$', content)
    print(f"\n3. 달러 인용 균형 점검:")
    print(f"   - $$ 패턴 총 개수: {len(dollar_quotes)}")
    if len(dollar_quotes) % 2 == 0:
        print(f"   [OK] 달러 인용이 짝을 이룸 (총 {len(dollar_quotes)//2}쌍)")
    else:
        print(f"   [ERROR] 오류: 달러 인용이 홀수개 (불완전)")

    # 4. 각 INSERT 문의 필드 개수 확인 (17개 필드)
    print(f"\n4. INSERT 문 필드 개수 점검:")
    field_errors = []
    for i, line in enumerate(lines, 1):
        if 'INSERT INTO challenges' in line and 'VALUES' in line:
            # VALUES 이후 부분 추출
            values_part = line.split('VALUES', 1)[1] if 'VALUES' in line else ''
            # 다음 세미콜론까지의 내용 가져오기
            full_insert = line
            j = i
            while j < len(lines) and ');' not in lines[j-1]:
                if j < len(lines):
                    full_insert += lines[j]
                j += 1

            # $$ 패턴 개수 세기 (필드 구분자)
            dollar_count = full_insert.count('$$')
            # 필드는 17개, 각 필드는 2개의 $$로 둘러싸임 (시작과 끝)
            # 따라서 총 34개의 $$ 필요
            expected_dollars = 34

            if dollar_count != expected_dollars and dollar_count > 10:
                field_errors.append((i, dollar_count // 2))

    if field_errors:
        print(f"   [ERROR] {len(field_errors)}개 INSERT 문에서 필드 개수 이상:")
        for line_num, field_count in field_errors[:5]:  # 처음 5개만 표시
            print(f"      라인 {line_num}: {field_count}개 필드")
    else:
        print(f"   [OK] 필드 개수 정상")

    # 5. 잘린 INSERT 문 찾기
    print(f"\n5. 불완전한 INSERT 문 점검:")
    incomplete = []
    for i, line in enumerate(lines, 1):
        if 'INSERT INTO challenges' in line:
            # 다음 5줄 확인
            next_lines = '\n'.join(lines[i:min(i+5, len(lines))])
            # VALUES가 없거나, 바로 다음에 INSERT가 나오는 경우
            if 'VALUES' not in next_lines or ('INSERT INTO challenges' in next_lines.replace(line, '')):
                incomplete.append(i)

    if incomplete:
        print(f"   [ERROR] {len(incomplete)}개의 불완전한 INSERT 문 발견:")
        for line_num in incomplete[:5]:
            print(f"      라인 {line_num}")
    else:
        print(f"   [OK] 모든 INSERT 문이 완전함")

    # 6. 한글 인코딩 문제 확인
    print(f"\n6. 한글 인코딩 점검:")
    encoding_issues = []
    problematic_patterns = ['�', '\\x', '\\u', '삽입력', '작성과', '작성은', '작성을']
    for pattern in problematic_patterns:
        if pattern in content:
            count = content.count(pattern)
            encoding_issues.append((pattern, count))

    if encoding_issues:
        print(f"   [ERROR] 인코딩 문제 패턴 발견:")
        for pattern, count in encoding_issues:
            print(f"      '{pattern}': {count}개")
    else:
        print(f"   [OK] 인코딩 문제 없음")

    # 7. SQL 예약어 충돌 확인
    print(f"\n7. SQL 예약어 충돌 점검:")
    reserved_words = ['SELECT', 'DROP', 'DELETE', 'UPDATE', 'ALTER', 'CREATE TABLE']
    conflicts = []
    for word in reserved_words:
        # $$ 밖에서 예약어가 사용되는지 확인
        pattern = r'(?<!\$\$)' + word + r'(?!\$\$)'
        matches = re.findall(pattern, content, re.IGNORECASE)
        if matches and word not in ['SELECT']:  # SELECT는 예시에 쓰일 수 있음
            conflicts.append((word, len(matches)))

    if conflicts:
        print(f"   ! 주의: SQL 예약어 사용:")
        for word, count in conflicts:
            print(f"      {word}: {count}회")
        print(f"   (달러 인용 내부라면 안전함)")
    else:
        print(f"   [OK] SQL 예약어 충돌 없음")

    print("\n" + "=" * 60)
    print("점검 완료!")
    print("=" * 60)

    # 최종 판정
    if not field_errors and not incomplete and not encoding_issues:
        print("\n[SUCCESS] Supabase 업로드 준비 완료!")
    else:
        print("\n[WARNING] 위의 문제들을 확인하고 수정이 필요할 수 있습니다.")

if __name__ == "__main__":
    comprehensive_check()

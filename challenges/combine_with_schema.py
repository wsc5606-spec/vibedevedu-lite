#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""테이블 스키마 + 650개 챌린지를 하나의 파일로 통합"""

def combine():
    # 1. 테이블 생성 SQL 읽기
    with open('CREATE-CHALLENGES-TABLE.sql', 'r', encoding='utf-8') as f:
        schema_sql = f.read()

    # 2. 챌린지 데이터 읽기
    with open('ALL-CHALLENGES-650-CLEAN.sql', 'r', encoding='utf-8') as f:
        challenges_sql = f.read()

    # 3. 통합 파일 생성
    combined = f"""{schema_sql}

-- ============================================================================
-- 650개 챌린지 데이터 삽입 시작
-- ============================================================================

{challenges_sql}
"""

    # 4. 저장
    output_file = 'COMPLETE-WITH-SCHEMA.sql'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(combined)

    print("=" * 80)
    print("통합 완료!")
    print("=" * 80)
    print(f"파일명: {output_file}")
    print(f"내용:")
    print(f"  1. challenges 테이블 스키마")
    print(f"  2. 650개 챌린지 INSERT 문")
    print("=" * 80)
    print("\n[SUCCESS] Supabase에 업로드할 준비가 완료되었습니다!")
    print("\n업로드 순서:")
    print("1. Supabase Dashboard > SQL Editor 열기")
    print("2. COMPLETE-WITH-SCHEMA.sql 파일 내용 복사")
    print("3. SQL Editor에 붙여넣기")
    print("4. Run 버튼 클릭")
    print("\n주의: 이 파일은 테이블을 새로 생성하고 데이터를 삽입합니다.")
    print("      기존 데이터가 있다면 DROP TABLE 주석을 해제하세요.")
    print("=" * 80)

if __name__ == "__main__":
    combine()

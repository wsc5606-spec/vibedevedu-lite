#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Supabase 자동 업로드 스크립트
650개 챌린지를 자동으로 업로드합니다
"""
import psycopg2
import sys

# Supabase 연결 정보
SUPABASE_URL = "trnawzpznsryozecjzvu.supabase.co"
SUPABASE_DB = "postgres"
SUPABASE_USER = "postgres"
SUPABASE_PASSWORD = "5XiUhB0mgJUJHbWE"  # Supabase Dashboard > Project Settings > Database에서 확인

def connect_to_supabase():
    """Supabase PostgreSQL 연결"""
    try:
        # Supabase는 6543 포트를 사용합니다 (connection pooling)
        # 직접 연결은 5432 포트
        conn = psycopg2.connect(
            host=f"db.{SUPABASE_URL}",
            port=5432,
            database=SUPABASE_DB,
            user=SUPABASE_USER,
            password=SUPABASE_PASSWORD,
            sslmode='require'
        )
        return conn
    except Exception as e:
        print(f"연결 실패: {e}")
        print("\nSupabase Dashboard > Settings > Database에서 비밀번호를 확인하세요.")
        print("비밀번호를 리셋해야 할 수도 있습니다.")
        return None

def execute_sql_file(conn, filename):
    """SQL 파일 실행"""
    print(f"\n실행 중: {filename}")

    with open(filename, 'r', encoding='utf-8') as f:
        sql = f.read()

    cursor = conn.cursor()
    try:
        cursor.execute(sql)
        conn.commit()
        print(f"✓ {filename} 실행 완료!")
        return True
    except Exception as e:
        conn.rollback()
        print(f"✗ 오류 발생: {e}")
        return False
    finally:
        cursor.close()

def main():
    print("=" * 80)
    print("Supabase 650개 챌린지 자동 업로드")
    print("=" * 80)

    # 1. Supabase 연결
    print("\n[1/3] Supabase 연결 중...")
    conn = connect_to_supabase()

    if not conn:
        print("\n연결 실패! 수동으로 업로드하세요:")
        print("1. Supabase Dashboard에서 Database 비밀번호 확인/리셋")
        print("2. SQL Editor에서 파일 실행:")
        print("   - 1-DELETE-OLD-DATA.sql")
        print("   - 2-CREATE-AND-INSERT.sql")
        sys.exit(1)

    print("✓ 연결 성공!")

    try:
        # 2. 기존 데이터 삭제
        print("\n[2/3] 기존 데이터 삭제 중...")
        if execute_sql_file(conn, '1-DELETE-OLD-DATA.sql'):
            print("✓ 기존 테이블 삭제 완료")
        else:
            print("! 삭제 실패 (테이블이 없을 수 있음)")

        # 3. 새 데이터 삽입
        print("\n[3/3] 테이블 생성 및 650개 챌린지 삽입 중...")
        print("(약 10-20초 소요)")

        if execute_sql_file(conn, '2-CREATE-AND-INSERT.sql'):
            print("\n" + "=" * 80)
            print("✓✓✓ 성공! 650개 챌린지 업로드 완료! ✓✓✓")
            print("=" * 80)

            # 확인 쿼리
            cursor = conn.cursor()
            cursor.execute("SELECT COUNT(*) FROM challenges;")
            count = cursor.fetchone()[0]
            cursor.close()

            print(f"\n총 챌린지 수: {count}개")

            if count == 650:
                print("✓ 모든 챌린지가 정상적으로 삽입되었습니다!")
            else:
                print(f"! 경고: 예상({650})과 실제({count})가 다릅니다.")
        else:
            print("\n✗ 삽입 실패!")
            sys.exit(1)

    finally:
        conn.close()
        print("\n연결 종료")

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Supabase 연결 및 데이터 테스트
"""
import requests

SUPABASE_URL = "https://trnawzpznsryozecjzvu.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRybmF3enB6bnNyeW96ZWNqenZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIxNTkyNDIsImV4cCI6MjA3NzczNTI0Mn0.PTKKZ2KHNp3oeGs3rta_4wMd6GiEIl06CfGlTmN5Kt4"

headers = {
    "apikey": ANON_KEY,
    "Authorization": f"Bearer {ANON_KEY}",
}

def test_connection():
    """Supabase 연결 테스트"""
    print("=== Supabase 연결 테스트 ===\n")

    # 1. 전체 챌린지 개수
    url = f"{SUPABASE_URL}/rest/v1/challenges"
    response = requests.get(
        url,
        headers=headers,
        params={"select": "id", "limit": 1000}
    )

    if response.status_code == 200:
        total = len(response.json())
        print(f"[OK] 총 챌린지 개수: {total}개")
    else:
        print(f"[ERROR] 연결 실패: {response.status_code}")
        print(response.text)
        return

    # 2. 언어별 챌린지 개수
    print("\n=== 언어별 챌린지 개수 ===")
    languages = ["python", "javascript", "typescript", "dart", "java", "kotlin",
                 "go", "c", "cpp", "csharp", "html", "css", "sql"]

    for lang in languages:
        response = requests.get(
            url,
            headers=headers,
            params={"select": "id", "language": f"eq.{lang}", "limit": 1000}
        )

        if response.status_code == 200:
            count = len(response.json())
            print(f"{lang:12s}: {count:3d}개")
        else:
            print(f"{lang:12s}: 조회 실패")

    # 3. 첫 5개 챌린지 샘플 조회
    print("\n=== 첫 5개 챌린지 샘플 ===")
    response = requests.get(
        url,
        headers=headers,
        params={
            "select": "slug,language,level,title",
            "order": "level.asc",
            "limit": 5
        }
    )

    if response.status_code == 200:
        challenges = response.json()
        for ch in challenges:
            print(f"[{ch['language']:10s}] Level {ch['level']:2d}: {ch['title']}")
            print(f"  slug: {ch['slug']}")

    # 4. Python Unit 1 챌린지 조회
    print("\n=== Python Unit 1 챌린지 (Level 1-5) ===")
    response = requests.get(
        url,
        headers=headers,
        params={
            "select": "slug,level,title",
            "language": "eq.python",
            "level": "gte.1",
            "level": "lte.5",
            "order": "level.asc"
        }
    )

    if response.status_code == 200:
        challenges = response.json()
        print(f"총 {len(challenges)}개 챌린지:")
        for ch in challenges:
            print(f"  Level {ch['level']}: {ch['title']}")

    print("\n=== 테스트 완료 ===")

if __name__ == "__main__":
    test_connection()

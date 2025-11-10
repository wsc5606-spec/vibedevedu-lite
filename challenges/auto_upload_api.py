#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Supabase REST API를 사용한 자동 업로드
650개 챌린지를 자동으로 업로드합니다
"""
import requests
import json
import time

# Supabase 설정
SUPABASE_URL = "https://trnawzpznsryozecjzvu.supabase.co"
SERVICE_ROLE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRybmF3enB6bnNyeW96ZWNqenZ1Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjE1OTI0MiwiZXhwIjoyMDc3NzM1MjQyfQ.0ZkBpCWBFtcGSrF_I0rkrVxiXUxTtt61_8ZJXws977g"

headers = {
    "apikey": SERVICE_ROLE_KEY,
    "Authorization": f"Bearer {SERVICE_ROLE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "return=minimal"
}

def delete_all_challenges():
    """모든 챌린지 삭제"""
    print("\n[1/2] 기존 챌린지 삭제 중...")

    url = f"{SUPABASE_URL}/rest/v1/challenges"
    headers_delete = headers.copy()
    headers_delete["Prefer"] = "return=representation"

    response = requests.delete(
        url,
        headers=headers_delete,
        params={"id": "neq.00000000-0000-0000-0000-000000000000"}  # 모든 행 선택
    )

    if response.status_code in [200, 204]:
        print("[OK] 기존 챌린지 삭제 완료")
        return True
    else:
        print(f"! 삭제 실패 또는 데이터 없음: {response.status_code}")
        return True  # 계속 진행

def parse_sql_to_json(sql_file):
    """SQL INSERT 문을 JSON으로 파싱"""
    print("\n[2/2] SQL 파일 파싱 중...")

    with open(sql_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # INSERT 문 추출
    import re
    pattern = r'INSERT INTO challenges[^V]+VALUES\s*\((.*?)\);'
    matches = re.findall(pattern, content, re.DOTALL)

    print(f"[OK] {len(matches)}개의 INSERT 문 발견")

    challenges = []
    for match in matches:
        # $$...$$로 둘러싸인 값들 추출
        values = re.findall(r'\$\$([^\$]*)\$\$', match)

        if len(values) >= 17:
            challenge = {
                "slug": values[0],
                "language": values[1],
                "kind": values[2],
                "level": int(values[3]),
                "title": values[4],
                "description": values[5],
                "category": values[6],
                "difficulty": int(values[7]),
                "problem_description": values[8],
                "constraints": values[9],
                "examples": json.loads(values[10]) if values[10] else [],
                "initial_code": values[11],
                "solution_code": values[12],
                "test_cases": json.loads(values[13]) if values[13] else [],
                "hints": json.loads(values[14]) if values[14] else [],
                "tags": json.loads(values[15]) if values[15] else [],
                "estimated_time": int(values[16])
            }
            challenges.append(challenge)

    return challenges

def upload_in_batches(challenges, batch_size=50):
    """배치 단위로 업로드"""
    print(f"\n챌린지 업로드 시작 (총 {len(challenges)}개)")
    print(f"배치 크기: {batch_size}개씩")

    url = f"{SUPABASE_URL}/rest/v1/challenges"
    total = len(challenges)
    uploaded = 0

    for i in range(0, total, batch_size):
        batch = challenges[i:i+batch_size]
        batch_num = i // batch_size + 1
        total_batches = (total + batch_size - 1) // batch_size

        print(f"\n배치 {batch_num}/{total_batches} 업로드 중... ({len(batch)}개)")

        try:
            response = requests.post(
                url,
                headers=headers,
                json=batch,
                timeout=30
            )

            if response.status_code in [200, 201]:
                uploaded += len(batch)
                print(f"[OK] 성공: {uploaded}/{total} ({uploaded*100//total}%)")
            else:
                print(f"[ERROR] 오류: {response.status_code}")
                print(f"응답: {response.text[:200]}")
                # 하나씩 시도
                print("개별 업로드로 전환...")
                for challenge in batch:
                    resp = requests.post(url, headers=headers, json=challenge)
                    if resp.status_code in [200, 201]:
                        uploaded += 1
                    else:
                        print(f"실패: {challenge['slug']}")

            time.sleep(0.5)  # Rate limiting 방지

        except Exception as e:
            print(f"[ERROR] 예외 발생: {e}")

    return uploaded

def verify_upload():
    """업로드 확인"""
    print("\n업로드 확인 중...")

    url = f"{SUPABASE_URL}/rest/v1/challenges"
    response = requests.get(
        url,
        headers=headers,
        params={"select": "id", "limit": 1000}
    )

    if response.status_code == 200:
        count = len(response.json())
        print(f"\n현재 데이터베이스에 {count}개의 챌린지가 있습니다.")
        return count
    else:
        print(f"확인 실패: {response.status_code}")
        return 0

def main():
    print("=" * 80)
    print("Supabase REST API를 통한 자동 업로드")
    print("=" * 80)

    try:
        # 1. 기존 데이터 삭제
        delete_all_challenges()

        # 2. SQL 파싱
        challenges = parse_sql_to_json('ALL-CHALLENGES-650-CLEAN.sql')

        if not challenges:
            print("[ERROR] 챌린지를 파싱하지 못했습니다.")
            return

        print(f"[OK] {len(challenges)}개 챌린지 파싱 완료")

        # 3. 업로드
        uploaded = upload_in_batches(challenges, batch_size=25)

        # 4. 확인
        final_count = verify_upload()

        print("\n" + "=" * 80)
        if final_count >= 640:  # 약간의 여유
            print(f"[OK][OK][OK] 성공! {final_count}개 챌린지 업로드 완료! [OK][OK][OK]")
        else:
            print(f"! 주의: 예상보다 적게 업로드됨 ({final_count}/650)")
        print("=" * 80)

    except Exception as e:
        print(f"\n[ERROR] 오류 발생: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()

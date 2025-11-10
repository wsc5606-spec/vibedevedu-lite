#!/usr/bin/env python3
"""
챌린지 파일 병합 스크립트
각 언어의 메인, part1, part2 파일을 병합하여 10개 단원에 고르게 배치
"""

import os
import re

# 13개 언어 목록
LANGUAGES = [
    'html', 'css', 'javascript', 'typescript', 'python',
    'dart', 'kotlin', 'csharp', 'java', 'go',
    'c', 'cpp', 'sql'
]

def extract_challenges(filepath):
    """SQL 파일에서 INSERT 문들을 추출"""
    if not os.path.exists(filepath):
        print(f"Warning: {filepath} not found")
        return []

    with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()

    # INSERT INTO challenges로 시작하는 문장들을 찾기
    pattern = r"INSERT INTO challenges[^;]+;"
    matches = re.findall(pattern, content, re.DOTALL)

    return matches

def get_unit_from_challenge(challenge_text):
    """챌린지 텍스트에서 단원 번호 추출 (level 필드 사용)"""
    # level 필드를 찾아서 단원 번호 추정
    # level 1-10 = Unit 1, level 11-20 = Unit 2, ...
    level_match = re.search(r"'syntax',\s*(\d+),", challenge_text)
    if level_match:
        level = int(level_match.group(1))
        # level을 10개 단원으로 나누기 (1-10 -> Unit 1, 11-20 -> Unit 2, etc.)
        unit = ((level - 1) // 10) + 1
        if unit > 10:
            unit = 10
        return unit
    return 1  # 기본값

def merge_language_challenges(language):
    """특정 언어의 챌린지 파일들을 병합"""
    print(f"\nProcessing {language}...")

    # 파일 경로
    main_file = f"{language}-challenges.sql"
    part1_file = f"{language}-part1.sql"
    part2_file = f"{language}-part2.sql"
    output_file = f"{language}-challenges-merged.sql"

    # 모든 챌린지 수집
    all_challenges = []
    all_challenges.extend(extract_challenges(main_file))
    all_challenges.extend(extract_challenges(part1_file))
    all_challenges.extend(extract_challenges(part2_file))

    print(f"  Total challenges found: {len(all_challenges)}")

    if len(all_challenges) == 0:
        print(f"  No challenges found for {language}")
        return

    # 단원별로 분류
    units = {i: [] for i in range(1, 11)}  # Unit 1-10

    for idx, challenge in enumerate(all_challenges):
        # 단원 번호 계산 (40문제를 10개 단원에 균등 배분)
        unit = (idx % 10) + 1
        units[unit].append(challenge)

    # 결과 파일 생성
    header = f"""-- ============================================================================
-- {language.upper()} Language Challenges (Merged)
-- ============================================================================
-- Total: {len(all_challenges)} challenges
-- Distribution: {len(all_challenges) // 10} challenges per unit (10 units)
-- ============================================================================

"""

    output_content = header

    for unit_num in range(1, 11):
        if units[unit_num]:
            output_content += f"\n-- ============================================================================\n"
            output_content += f"-- Unit {unit_num} - {len(units[unit_num])} challenges\n"
            output_content += f"-- ============================================================================\n\n"

            for challenge in units[unit_num]:
                output_content += challenge + "\n\n"

    # 파일 저장
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(output_content)

    print(f"  OK Created {output_file}")
    print(f"  Distribution: ", end="")
    for unit_num in range(1, 11):
        print(f"Unit{unit_num}={len(units[unit_num])} ", end="")
    print()

def main():
    """메인 함수"""
    print("=" * 80)
    print("Challenge Merger - Distributing challenges across 10 units")
    print("=" * 80)

    # challenges 디렉토리로 이동
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    # 각 언어별로 처리
    for language in LANGUAGES:
        merge_language_challenges(language)

    print("\n" + "=" * 80)
    print("OK All languages processed!")
    print("=" * 80)
    print("\nNext steps:")
    print("1. Review the merged files (*-challenges-merged.sql)")
    print("2. Backup original files if needed")
    print("3. Replace original files with merged versions")
    print("4. Upload to Supabase")

if __name__ == "__main__":
    main()

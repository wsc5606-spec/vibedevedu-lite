#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
중복 slug 제거
"""
import re

def remove_duplicates():
    with open('ALL-CHALLENGES-650-CLEAN.sql', 'r', encoding='utf-8') as f:
        content = f.read()

    # INSERT 문을 개별적으로 분리
    lines = content.split('\n')

    seen_slugs = set()
    clean_lines = []
    skip_until_semicolon = False
    current_slug = None

    for line in lines:
        # INSERT 문 시작 확인
        if 'INSERT INTO challenges' in line:
            skip_until_semicolon = False
            clean_lines.append(line)
            continue

        # slug 추출
        slug_match = re.search(r'\(\$\$([^$]+)\$\$,', line)
        if slug_match and not skip_until_semicolon:
            slug = slug_match.group(1)

            if slug in seen_slugs:
                print(f"중복 발견: {slug} - 제거")
                skip_until_semicolon = True
                # 이전에 추가한 INSERT 라인도 제거
                if clean_lines and 'INSERT INTO challenges' in clean_lines[-1]:
                    clean_lines.pop()
                continue
            else:
                seen_slugs.add(slug)
                current_slug = slug

        # 스킵 모드
        if skip_until_semicolon:
            if line.strip().endswith(');'):
                skip_until_semicolon = False
                print(f"  -> 라인까지 스킵")
            continue

        clean_lines.append(line)

    # 결과 저장
    result = '\n'.join(clean_lines)

    with open('ALL-CHALLENGES-CLEAN-NO-DUP.sql', 'w', encoding='utf-8') as f:
        f.write(result)

    # 통계
    insert_count = result.count('INSERT INTO challenges')
    print(f"\n최종 결과:")
    print(f"  총 고유 slug: {len(seen_slugs)}개")
    print(f"  INSERT 문: {insert_count}개")
    print(f"  파일: ALL-CHALLENGES-CLEAN-NO-DUP.sql")

if __name__ == "__main__":
    remove_duplicates()

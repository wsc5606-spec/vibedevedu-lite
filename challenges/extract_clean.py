#!/usr/bin/env python3
"""
깨끗한 $$...$$ 버전만 추출
"""

def extract_clean_version():
    """작은따옴표 버전을 제거하고 $$...$$ 버전만 추출"""

    with open('ALL-CHALLENGES-FINAL.sql', 'r', encoding='utf-8') as f:
        lines = f.readlines()

    clean_lines = []
    in_quote_version = False
    in_dollar_version = False
    skip_until_semicolon = False

    for i, line in enumerate(lines, 1):
        # INSERT 문 시작 확인
        if line.strip().startswith('INSERT INTO challenges'):
            # 다음 몇 줄을 확인해서 $$인지 '인지 판단
            lookahead = ''.join(lines[i:min(i+5, len(lines))])

            if '($$' in lookahead:
                # $$...$$ 버전 - 유지
                in_dollar_version = True
                in_quote_version = False
                skip_until_semicolon = False
                clean_lines.append(line)
            elif "('" in lookahead:
                # 작은따옴표 버전 - 스킵
                in_quote_version = True
                in_dollar_version = False
                skip_until_semicolon = True
                print(f"Skipping broken version starting at line {i}")
            else:
                clean_lines.append(line)

        elif skip_until_semicolon:
            # 세미콜론을 만나면 스킵 종료
            if ');' in line:
                skip_until_semicolon = False
                in_quote_version = False
                print(f"Skipped until line {i}")
            continue

        else:
            # 일반 라인은 스킵 중이 아니면 추가
            if not skip_until_semicolon:
                clean_lines.append(line)

    # 결과 저장
    with open('ALL-CHALLENGES-CLEAN.sql', 'w', encoding='utf-8') as f:
        f.writelines(clean_lines)

    print(f"\n완료!")
    print(f"원본 라인 수: {len(lines)}")
    print(f"정리된 라인 수: {len(clean_lines)}")
    print(f"제거된 라인 수: {len(lines) - len(clean_lines)}")

if __name__ == "__main__":
    extract_clean_version()

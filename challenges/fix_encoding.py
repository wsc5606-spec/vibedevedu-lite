#!/usr/bin/env python3
"""
인코딩 문제 수정 스크립트
깨진 한글을 복구하고 올바른 UTF-8로 저장
"""

import os
import re

def fix_encoding(input_file, output_file):
    """파일 인코딩 문제 수정"""

    # 여러 인코딩으로 시도
    encodings = ['utf-8', 'cp949', 'euc-kr', 'utf-8-sig']

    content = None
    for encoding in encodings:
        try:
            with open(input_file, 'r', encoding=encoding, errors='replace') as f:
                content = f.read()
            print(f"Successfully read with encoding: {encoding}")
            break
        except Exception as e:
            print(f"Failed with {encoding}: {e}")
            continue

    if content is None:
        print(f"Failed to read {input_file}")
        return False

    # UTF-8로 저장
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"OK Saved {output_file} as UTF-8")
    return True

def main():
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    input_file = 'ALL-CHALLENGES-COMBINED.sql'
    output_file = 'ALL-CHALLENGES-COMBINED-UTF8.sql'

    print(f"Converting {input_file} to UTF-8...")
    fix_encoding(input_file, output_file)

    print("\nDone! Use ALL-CHALLENGES-COMBINED-UTF8.sql")

if __name__ == "__main__":
    main()

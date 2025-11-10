#!/usr/bin/env python3
"""
모든 SQL 파일의 상태 점검
"""
import os
import glob

def check_file(filepath):
    """파일의 상태 점검"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        inserts = content.count('INSERT INTO challenges')
        semicolons = content.count(');')
        dollars = content.count('$$')
        funcs = content.count('$func$')
        single_quotes = content.count("('")  # 작은따옴표 버전

        return {
            'inserts': inserts,
            'semicolons': semicolons,
            'dollars': dollars,
            'funcs': funcs,
            'single_quotes': single_quotes,
            'balanced': inserts == semicolons,
            'size': len(content)
        }
    except Exception as e:
        return {'error': str(e)}

# 언어 파일들 점검
languages = ['html', 'css', 'javascript', 'typescript', 'python', 'dart', 'kotlin', 'csharp', 'java', 'go', 'c', 'cpp', 'sql']

print("=" * 80)
print("개별 언어 파일 점검")
print("=" * 80)

for lang in languages:
    filepath = f'{lang}-challenges.sql'
    if os.path.exists(filepath):
        result = check_file(filepath)
        if 'error' in result:
            print(f"{lang:12s}: ERROR - {result['error']}")
        else:
            status = "[OK]" if result['balanced'] else "[ERROR]"
            print(f"{lang:12s}: {status} INSERT={result['inserts']:3d}, Semicolons={result['semicolons']:3d}, Dollars={result['dollars']:4d}, SingleQuotes={result['single_quotes']:3d}")

print("\n" + "=" * 80)
print("통합 파일 점검")
print("=" * 80)

combined_files = [
    'ALL-CHALLENGES-COMBINED.sql',
    'ALL-CHALLENGES-CLEAN.sql',
    'ALL-CHALLENGES-FINAL.sql',
    'ALL-CHALLENGES-READY.sql'
]

for filepath in combined_files:
    if os.path.exists(filepath):
        result = check_file(filepath)
        if 'error' in result:
            print(f"{filepath:30s}: ERROR - {result['error']}")
        else:
            status = "[OK]" if result['balanced'] else "[ERROR]"
            print(f"{filepath:30s}: {status} INSERT={result['inserts']:3d}, Semicolons={result['semicolons']:3d}, Dollars={result['dollars']:5d}")

print("\n" + "=" * 80)
print("권장 사항:")
print("=" * 80)

# 가장 깨끗한 개별 파일들을 찾기
clean_files = []
for lang in languages:
    filepath = f'{lang}-challenges.sql'
    if os.path.exists(filepath):
        result = check_file(filepath)
        if not 'error' in result and result['balanced'] and result['dollars'] > 0:
            clean_files.append(lang)

if clean_files:
    print(f"\n[OK] 다음 언어들은 깨끗합니다: {', '.join(clean_files)}")
    print("이 파일들을 합쳐서 새로운 통합 파일을 만드는 것을 권장합니다.")
else:
    print("\n[WARNING] 모든 파일에 문제가 있습니다. part1/part2 파일들을 확인해야 합니다.")

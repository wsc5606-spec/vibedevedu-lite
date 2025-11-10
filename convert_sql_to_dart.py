#!/usr/bin/env python3
"""
SQL 챌린지 파일을 Dart 데이터 파일로 변환
"""

import os
import re
import json

def parse_sql_value(value):
    """SQL 값을 Dart 값으로 변환"""
    value = value.strip()

    # NULL
    if value.upper() == 'NULL':
        return 'null'

    # 숫자
    if value.isdigit():
        return value

    # $$로 감싼 문자열 -> r''' ''' (raw string)
    if value.startswith('$$') and value.endswith('$$'):
        content = value[2:-2]
        # Dart raw string으로 변환 (이스케이프 불필요)
        return f"r'''{content}'''"

    # $func$로 감싼 코드 -> r''' ''' (raw string)
    if value.startswith('$func$') and value.endswith('$func$'):
        content = value[6:-6].strip()
        # Dart raw string으로 변환 (이스케이프 불필요)
        return f"r'''{content}'''"

    # 일반 문자열
    if value.startswith("'") and value.endswith("'"):
        content = value[1:-1]
        content = content.replace("'", "\\'")
        content = content.replace("\\", "\\\\")
        return f"'{content}'"

    # 기타
    return f"r'''{value}'''"

def parse_insert_statement(sql):
    """INSERT 문을 파싱하여 딕셔너리 리스트로 변환"""
    challenges = []

    # INSERT INTO challenges 구문 전체를 찾기
    insert_pattern = r'INSERT INTO challenges[^;]+;'
    inserts = re.findall(insert_pattern, sql, re.DOTALL | re.IGNORECASE)

    print(f"  Found {len(inserts)} INSERT statements")

    for insert_stmt in inserts:
        # VALUES 뒤의 모든 값 쌍 찾기
        values_match = re.search(r'VALUES\s*(.*)', insert_stmt, re.DOTALL | re.IGNORECASE)
        if not values_match:
            continue

        values_section = values_match.group(1).rstrip(';').strip()

        # 각 (...)를 개별적으로 파싱
        # 최상위 레벨 괄호만 찾기
        matches = []
        depth = 0
        in_func = False
        in_dollar = False
        current_start = None

        i = 0
        while i < len(values_section):
            # $func$ 처리
            if values_section[i:i+6] == '$func$':
                in_func = not in_func
                i += 6
                continue

            # $$ 처리
            if values_section[i:i+2] == '$$':
                in_dollar = not in_dollar
                i += 2
                continue

            char = values_section[i]

            if not (in_func or in_dollar):
                if char == '(':
                    if depth == 0:
                        current_start = i + 1
                    depth += 1
                elif char == ')':
                    depth -= 1
                    if depth == 0 and current_start is not None:
                        matches.append(values_section[current_start:i])
                        current_start = None

            i += 1

        print(f"    INSERT statement has {len(matches)} value clauses")

        for match in matches:
            # 값들을 파싱
            values = []
            current = ""
            in_func = False
            in_dollar = False
            paren_count = 0
            bracket_count = 0

            i = 0
            while i < len(match):
                char = match[i]

                # $func$ 처리
                if match[i:i+6] == '$func$':
                    in_func = not in_func
                    current += '$func$'
                    i += 6
                    continue

                # $$ 처리
                if match[i:i+2] == '$$':
                    in_dollar = not in_dollar
                    current += '$$'
                    i += 2
                    continue

                # 괄호 카운트
                if char == '(' and not (in_func or in_dollar):
                    paren_count += 1
                elif char == ')' and not (in_func or in_dollar):
                    paren_count -= 1
                elif char == '[' and not (in_func or in_dollar):
                    bracket_count += 1
                elif char == ']' and not (in_func or in_dollar):
                    bracket_count -= 1

                # 쉼표로 값 분리
                if char == ',' and not (in_func or in_dollar) and paren_count == 0 and bracket_count == 0:
                    values.append(current.strip())
                    current = ""
                    i += 1
                    continue

                current += char
                i += 1

            if current.strip():
                values.append(current.strip())

            # 13개 필드 확인
            print(f"      Parsed {len(values)} values from this clause")
            if len(values) >= 13:
                challenge = {
                    'slug': parse_sql_value(values[0]),
                    'language': parse_sql_value(values[1]),
                    'kind': parse_sql_value(values[2]),
                    'level': parse_sql_value(values[3]),
                    'title': parse_sql_value(values[4]),
                    'description': parse_sql_value(values[5]),
                    'category': parse_sql_value(values[6]),
                    'difficulty': parse_sql_value(values[7]),
                    'problem_description': parse_sql_value(values[8]),
                    'constraints': parse_sql_value(values[9]),
                    'examples': parse_sql_value(values[10]),
                    'initial_code': parse_sql_value(values[11]),
                    'solution_code': parse_sql_value(values[12]),
                }

                # 추가 필드들
                if len(values) > 13:
                    challenge['test_cases'] = parse_sql_value(values[13])
                if len(values) > 14:
                    challenge['hints'] = parse_sql_value(values[14])
                if len(values) > 15:
                    challenge['tags'] = parse_sql_value(values[15])
                if len(values) > 16:
                    challenge['estimated_time'] = parse_sql_value(values[16])

                challenges.append(challenge)

    return challenges

def convert_sql_to_dart(sql_file, language):
    """SQL 파일을 Dart 파일로 변환"""
    with open(sql_file, 'r', encoding='utf-8') as f:
        sql_content = f.read()

    challenges = parse_insert_statement(sql_content)

    if not challenges:
        print(f"Warning: No challenges found in {sql_file}")
        return None

    # Dart 코드 생성
    dart_code = f"""/// {language.upper()} 챌린지 데이터 (총 {len(challenges)}개)
/// SQL에서 자동 변환됨

class {language.capitalize()}Challenges {{
  static List<Map<String, dynamic>> getChallenges() {{
    return [
"""

    for challenge in challenges:
        dart_code += "      {\n"
        for key, value in challenge.items():
            dart_code += f"        '{key}': {value},\n"
        dart_code += "      },\n"

    dart_code += """    ];
  }
}
"""

    return dart_code

# 메인 실행
if __name__ == '__main__':
    challenges_dir = 'challenges'
    data_dir = 'lib/data'

    # 데이터 디렉토리 생성
    os.makedirs(data_dir, exist_ok=True)

    languages = [
        'python', 'dart', 'go', 'java', 'typescript',
        'javascript', 'sql', 'c', 'cpp', 'csharp',
        'kotlin', 'html', 'css'
    ]

    for lang in languages:
        sql_file = os.path.join(challenges_dir, f'{lang}-challenges.sql')

        if not os.path.exists(sql_file):
            print(f"Skipping {lang}: {sql_file} not found")
            continue

        print(f"Converting {lang}...")
        dart_content = convert_sql_to_dart(sql_file, lang)

        if dart_content:
            output_file = os.path.join(data_dir, f'{lang}_challenges.dart')
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(dart_content)
            print(f"  [OK] Created {output_file}")
        else:
            print(f"  [ERROR] Failed to convert {lang}")

    print("\n[OK] Conversion complete!")

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
650개 챌린지 자동 생성 - 간단 버전
각 챌린지를 독립적인 INSERT 문으로 생성
"""

# 언어별 50개 주제 정의
TOPICS = {
    'html': [
        'HTML 문서 구조', 'head 태그', 'body 태그', 'title 태그', 'meta charset',
        'h1 제목', 'h2 제목', 'p 단락', 'strong 굵게', 'em 기울임',
        'a 링크', 'href 속성', 'img 이미지', 'alt 속성', 'target 속성',
        'ul 목록', 'ol 목록', 'li 항목', 'dl 정의', 'nested list',
        'table 테이블', 'tr 행', 'td 셀', 'th 헤더', 'colspan',
        'form 폼', 'input 입력', 'label 라벨', 'button 버튼', 'select 선택',
        'header 헤더', 'nav 네비', 'main 메인', 'footer 푸터', 'article 아티클',
        'video 비디오', 'audio 오디오', 'iframe 프레임', 'canvas 캔버스', 'svg 벡터',
        'meta viewport', 'meta description', 'link stylesheet', 'script 태그', 'div container',
        'details 상세', 'summary 요약', 'progress 진행', 'meter 측정', 'template 템플릿'
    ],
    'css': [
        '요소 선택자', 'class 선택자', 'id 선택자', '자손 선택자', '속성 선택자',
        'color 색상', 'font-size 크기', 'font-weight 굵기', 'text-align 정렬', 'line-height 행간',
        'width 너비', 'height 높이', 'padding 안쪽', 'margin 바깥', 'border 테두리',
        'background-color', 'background-image', 'background-size', 'background-position', 'gradient',
        'display 속성', 'position 위치', 'float 플로트', 'clear 클리어', 'z-index',
        'display flex', 'flex-direction', 'justify-content', 'align-items', 'flex-wrap',
        'display grid', 'grid-template', 'grid-gap', 'grid-area', 'fr 단위',
        'transition', 'transform', 'animation', 'keyframes', '@keyframes',
        'media query', 'breakpoint', 'viewport 단위', 'rem 단위', 'em 단위',
        'CSS 변수', 'calc() 계산', 'filter 필터', 'backdrop-filter', 'custom property'
    ],
    'javascript': [
        'var 변수', 'let 변수', 'const 상수', 'string 타입', 'number 타입',
        'if 조건', 'else 조건', 'switch 문', 'for 반복', 'while 반복',
        'function 함수', '화살표 함수', '매개변수', '반환값', '콜백 함수',
        '배열 생성', 'push 추가', 'pop 제거', 'map 변환', 'filter 필터',
        '객체 생성', '속성 접근', '메서드', '구조분해', 'spread 연산자',
        'querySelector', 'innerHTML', 'addEventListener', 'classList', 'createElement',
        'setTimeout', 'Promise', 'async', 'await', 'fetch',
        '템플릿 리터럴', '기본 매개변수', 'rest 파라미터', '옵셔널 체이닝', 'nullish 병합',
        'try-catch', 'throw', 'Error 객체', 'finally', '커스텀 에러',
        '클로저', 'this 키워드', 'prototype', 'class 문법', 'extends 상속'
    ],
    'typescript': [
        'string 타입', 'number 타입', 'boolean 타입', 'any 타입', 'unknown 타입',
        '변수 타입', '함수 타입', '배열 타입', '튜플 타입', 'enum 열거형',
        'interface 정의', '옵셔널 속성', 'readonly', '인덱스 시그니처', 'extends',
        'type 선언', '유니온 타입', '인터섹션 타입', '리터럴 타입', 'typeof',
        '제네릭 함수', '제네릭 인터페이스', '제네릭 클래스', '타입 제약', '기본 타입',
        'class 선언', 'constructor', 'public', 'private', 'protected',
        '조건부 타입', 'Mapped Types', 'Utility Types', 'keyof', 'infer',
        'import', 'export', 'namespace', '선언 파일', 'tsconfig',
        '클래스 데코레이터', '메서드 데코레이터', '속성 데코레이터', '매개변수 데코레이터', '메타데이터',
        'Partial', 'Required', 'Pick', 'Omit', 'Record'
    ],
    'python': [
        '변수 선언', 'print 출력', 'input 입력', '데이터 타입', '연산자',
        'if 조건', 'elif', 'else', 'for 반복', 'while 반복',
        'def 함수', '매개변수', 'return', '람다 함수', '기본값',
        'list 리스트', 'tuple 튜플', 'dict 딕셔너리', 'set 세트', '리스트 컴프리헨션',
        '문자열 연산', '슬라이싱', 'format', 'f-string', '문자열 메서드',
        'import', 'from import', '표준 라이브러리', '__name__', 'pip',
        'open 파일', 'read 읽기', 'write 쓰기', 'with 문', 'json',
        'class 정의', '__init__', '메서드', '상속', '__str__',
        'try', 'except', 'raise', 'finally', 'else',
        '데코레이터', '제너레이터', 'yield', 'itertools', 'collections'
    ],
    'dart': [
        'var 변수', 'final', 'const', 'int 타입', 'String 타입',
        'if-else', 'switch', 'for 반복', 'while 반복', 'break',
        '함수 선언', '화살표 함수', '선택적 매개변수', '명명된 매개변수', '익명 함수',
        'List', 'Set', 'Map', 'spread', 'collection if',
        'class 정의', 'constructor', 'getter', 'setter', 'extends',
        'Future', 'async', 'await', 'then', 'Stream',
        'nullable 타입', '?? 연산자', '?. 연산자', 'late', '!',
        '제네릭 클래스', '제네릭 함수', '타입 제약', 'extends', 'covariance',
        'enum', 'extension', 'enhanced enum', 'typedef', 'call',
        'isolate', 'metadata', 'library', 'part', 'cascade'
    ],
    'kotlin': [
        'val 변수', 'var 변수', 'Int 타입', 'String 타입', '타입 추론',
        'if 표현식', 'when 표현식', 'for 반복', 'while 반복', 'range',
        'fun 함수', '단일 표현식', '기본 인자', '명명된 인자', '확장 함수',
        'List', 'Set', 'Map', 'filter', 'map',
        'class', 'constructor', 'data class', 'open', 'companion',
        'nullable', '?. 안전', '?: Elvis', '!!', 'let',
        '람다', '고차 함수', 'it', 'with', 'apply',
        'suspend', 'launch', 'async', 'CoroutineScope', 'withContext',
        '제네릭', 'in', 'out', 'reified', '타입 프로젝션',
        'sealed class', 'inline class', 'by 위임', '연산자 오버로딩', 'DSL'
    ],
    'csharp': [
        'var 변수', 'int 타입', 'string 타입', 'bool 타입', 'Console.WriteLine',
        'if-else', 'switch', 'for 반복', 'while 반복', 'foreach',
        '메서드 정의', '매개변수', 'return', 'out', 'ref',
        '배열', 'List<T>', 'Dictionary', 'Where', 'Select',
        'class', 'constructor', 'property', '상속', 'override',
        'interface', '구현', '다중 인터페이스', '명시적 구현', '기본 구현',
        'try-catch', 'throw', 'finally', 'Exception', 'custom exception',
        'async', 'await', 'Task', 'Task<T>', 'ConfigureAwait',
        'delegate', 'Action', 'Func', 'event', 'lambda',
        '제네릭', 'nullable', 'pattern matching', 'record', 'init'
    ],
    'java': [
        'int 변수', 'String 변수', 'boolean 변수', 'System.out', '주석',
        'if-else', 'switch', 'for 반복', 'while 반복', 'enhanced for',
        '메서드', 'static', '매개변수', 'return', '오버로딩',
        '배열', 'ArrayList', 'HashMap', 'for-each', 'Stream',
        'class', 'constructor', 'getter', 'setter', 'extends',
        'interface', 'implements', '다중 인터페이스', 'default', 'static',
        'try-catch', 'throw', 'throws', 'Exception', 'try-with-resources',
        '제네릭 클래스', '제네릭 메서드', 'bounded', 'wildcard', 'erasure',
        '람다', 'functional interface', 'method reference', 'Stream', 'Optional',
        'Annotation', 'Reflection', 'Thread', 'CompletableFuture', 'var'
    ],
    'go': [
        'var 변수', ':= 연산자', 'int 타입', 'string 타입', 'fmt.Println',
        'if', 'switch', 'for', 'range', 'defer',
        'func', '다중 반환', '가변 인자', '익명 함수', '클로저',
        'array', 'slice', 'map', 'struct', 'pointer',
        '메서드', '리시버', '포인터 리시버', '값 리시버', '메서드 체이닝',
        'interface', '암묵적 구현', '빈 인터페이스', '타입 단언', '타입 스위치',
        'goroutine', 'channel', 'select', 'buffered', 'WaitGroup',
        'error', 'errors.New', 'fmt.Errorf', 'panic', 'recover',
        'package', 'import', 'init', 'internal', 'go mod',
        'context', 'reflection', 'generic', 'embedding', 'build tags'
    ],
    'c': [
        'int 변수', 'char 변수', 'float 변수', 'printf', 'scanf',
        'if-else', 'switch', 'for', 'while', 'do-while',
        '함수 정의', '함수 선언', '매개변수', 'return', '재귀',
        '배열 선언', '배열 초기화', '2차원 배열', '배열 포인터', 'sizeof',
        '포인터', '주소', '역참조', '포인터 산술', '이중 포인터',
        '문자 배열', 'string.h', 'strcpy', 'strlen', 'strcmp',
        'struct', '구조체 변수', '구조체 포인터', 'typedef', '구조체 배열',
        'malloc', 'calloc', 'realloc', 'free', '메모리 누수',
        'fopen', 'fclose', 'fread', 'fwrite', 'fprintf',
        '#define', 'enum', 'union', '함수 포인터', 'const pointer'
    ],
    'cpp': [
        'int 변수', 'string 변수', 'bool 변수', 'cout', 'cin',
        'if-else', 'switch', 'for', 'while', 'range-for',
        '함수', '오버로딩', '기본 매개변수', 'inline', 'auto',
        'vector', 'string', 'map', 'set', 'pair',
        'class', 'constructor', 'destructor', '상속', 'virtual',
        '+ 연산자', '== 연산자', '[] 연산자', '<< 연산자', 'friend',
        '함수 템플릿', '클래스 템플릿', '템플릿 특수화', 'variadic', 'SFINAE',
        'unique_ptr', 'shared_ptr', 'weak_ptr', 'make_unique', 'make_shared',
        '람다', 'algorithm', 'transform', 'find_if', 'sort',
        'auto', 'move', 'rvalue', 'constexpr', 'structured binding'
    ],
    'sql': [
        'SELECT', 'WHERE', 'ORDER BY', 'LIMIT', 'DISTINCT',
        'COUNT', 'SUM', 'AVG', 'MAX', 'MIN',
        'GROUP BY', 'HAVING', '집계 조건', '다중 그룹', 'ROLLUP',
        'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL JOIN', 'CROSS JOIN',
        '스칼라 서브쿼리', 'IN 서브쿼리', 'EXISTS', 'ANY', 'ALL',
        'INSERT', 'UPDATE', 'DELETE', 'UPSERT', 'RETURNING',
        'CREATE TABLE', 'ALTER TABLE', 'DROP TABLE', 'TRUNCATE', 'CONSTRAINTS',
        'CREATE INDEX', 'DROP INDEX', 'CREATE VIEW', 'Materialized View', '인덱스 전략',
        'BEGIN', 'COMMIT', 'ROLLBACK', 'SAVEPOINT', 'ISOLATION',
        'WINDOW 함수', 'CTE', 'RECURSIVE', 'JSON 함수', 'TRIGGER'
    ]
}

def generate_challenge(lang, topic, level):
    """단일 챌린지 생성"""
    slug = f"{lang}-{topic.lower().replace(' ', '-').replace('/', '-').replace('<', '').replace('>', '')}"

    # 난이도 (1-3)
    if level <= 17:
        difficulty = 1
    elif level <= 33:
        difficulty = 2
    else:
        difficulty = 3

    # 예상 시간
    estimated_time = 5 if difficulty == 1 else (8 if difficulty == 2 else 12)

    # kind
    kind = 'syntax' if level <= 25 else 'algorithm'

    return f"""INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($${slug}$$, $${lang}$$, $${kind}$$, {level}, $${topic}$$, $${topic} 학습$$, $$challenge$$, {difficulty},
$${topic}을(를) 사용하여 문제를 해결하세요.$$,
$$- {topic} 사용\n- 기본 문법 준수$$,
$$[{{"input": "", "output": "결과"}}]$$,
$$/* {topic} 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{{"input": "", "expected": "output"}}]$$,
$$["{topic}의 기본 사용법을 익히세요"]$$,
$$["{lang}", "basics"]$$, {estimated_time});
"""

def main():
    print("650개 챌린지 생성 중...")

    output = []

    # 헤더
    output.append("""-- ============================================================================
-- 전체 언어 챌린지 통합 파일 (완전 재생성)
-- ============================================================================
-- 13개 언어 × 50문제 = 총 650개 챌린지
-- 생성일: 2025-11-10
-- ============================================================================

-- 기존 챌린지 삭제 (필요시 주석 해제)
-- DELETE FROM challenges;

""")

    # 각 언어별 챌린지 생성
    challenge_count = 0
    for lang, topics in TOPICS.items():
        output.append(f"""-- ============================================================================
-- {lang.upper()} Language Challenges (50 challenges)
-- ============================================================================

""")

        for idx, topic in enumerate(topics):
            level = idx + 1
            challenge = generate_challenge(lang, topic, level)
            output.append(challenge)
            if idx < len(topics) - 1 or lang != 'sql':  # 마지막 챌린지가 아니면 빈 줄 추가
                output.append('\n')
            challenge_count += 1

    output.append("""-- ============================================================================
-- 전체 650개 챌린지 생성 완료!
-- ============================================================================
""")

    # 파일 저장
    content = ''.join(output)
    output_file = 'ALL-CHALLENGES-650-CLEAN.sql'

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)

    # 검증
    insert_count = content.count('INSERT INTO challenges')
    semicolon_count = content.count(');')

    print(f"\n생성 완료!")
    print(f"파일명: {output_file}")
    print(f"INSERT 문 수: {insert_count}")
    print(f"세미콜론 수: {semicolon_count}")
    print(f"균형: {'OK' if insert_count == semicolon_count else 'ERROR'}")

    if insert_count == semicolon_count == 650:
        print(f"\n[SUCCESS] 완벽한 650개 챌린지가 생성되었습니다!")
        print("Supabase에 업로드할 준비가 완료되었습니다.")
    else:
        print(f"\n[ERROR] 예상: 650, 실제 INSERT: {insert_count}, 세미콜론: {semicolon_count}")

if __name__ == "__main__":
    main()

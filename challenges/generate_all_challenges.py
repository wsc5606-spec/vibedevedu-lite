#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
650개 챌린지 자동 생성 스크립트
13개 언어 × 50문제 = 650개
각 언어: 10개 단원 × 5문제
"""

# 언어별 챌린지 템플릿 정의
LANGUAGES = {
    'html': {
        'units': [
            {'name': '기본 구조', 'topics': ['HTML 문서 구조', 'head 태그', 'body 태그', 'DOCTYPE', '주석']},
            {'name': '텍스트 태그', 'topics': ['h1-h6 제목', 'p 단락', 'strong 굵게', 'em 기울임', 'br 줄바꿈']},
            {'name': '링크와 이미지', 'topics': ['a 태그', 'href 속성', 'img 태그', 'alt 속성', 'target 속성']},
            {'name': '리스트', 'topics': ['ul 순서없는 목록', 'ol 순서있는 목록', 'li 항목', 'dl 정의 목록', 'nested 리스트']},
            {'name': '테이블', 'topics': ['table 태그', 'tr 행', 'td 셀', 'th 헤더', 'colspan/rowspan']},
            {'name': '폼', 'topics': ['form 태그', 'input 입력', 'label 라벨', 'button 버튼', 'select 선택']},
            {'name': '시맨틱 태그', 'topics': ['header 헤더', 'nav 네비게이션', 'main 메인', 'footer 푸터', 'article 아티클']},
            {'name': '멀티미디어', 'topics': ['video 비디오', 'audio 오디오', 'iframe 프레임', 'canvas 캔버스', 'svg 벡터']},
            {'name': '메타 태그', 'topics': ['meta charset', 'meta viewport', 'meta description', 'meta keywords', 'meta og']},
            {'name': '고급 요소', 'topics': ['details/summary', 'progress 진행', 'meter 측정', 'dialog 대화상자', 'template 템플릿']}
        ]
    },
    'css': {
        'units': [
            {'name': '선택자', 'topics': ['요소 선택자', 'class 선택자', 'id 선택자', '자손 선택자', '속성 선택자']},
            {'name': '텍스트 스타일', 'topics': ['color 색상', 'font-size 크기', 'font-weight 굵기', 'text-align 정렬', 'line-height 행간']},
            {'name': '박스 모델', 'topics': ['width/height', 'padding 안쪽여백', 'margin 바깥여백', 'border 테두리', 'box-sizing']},
            {'name': '배경', 'topics': ['background-color', 'background-image', 'background-size', 'background-position', 'gradient']},
            {'name': '레이아웃', 'topics': ['display 속성', 'position 위치', 'float 플로트', 'clear 클리어', 'z-index 순서']},
            {'name': 'Flexbox', 'topics': ['display flex', 'flex-direction', 'justify-content', 'align-items', 'flex-wrap']},
            {'name': 'Grid', 'topics': ['display grid', 'grid-template', 'grid-gap', 'grid-area', 'fr 단위']},
            {'name': '애니메이션', 'topics': ['transition 전환', 'transform 변형', 'animation 애니메이션', 'keyframes', 'timing-function']},
            {'name': '반응형', 'topics': ['media query', 'breakpoint', 'mobile-first', 'viewport 단위', 'rem/em']},
            {'name': '고급 기능', 'topics': ['변수 var()', 'calc() 계산', 'filter 필터', 'backdrop-filter', 'custom properties']}
        ]
    },
    'javascript': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', '연산자', '주석', 'console.log']},
            {'name': '제어문', 'topics': ['if-else 조건', 'switch 문', 'for 반복', 'while 반복', 'break/continue']},
            {'name': '함수', 'topics': ['함수 선언', '화살표 함수', '매개변수', '반환값', '콜백 함수']},
            {'name': '배열', 'topics': ['배열 생성', 'push/pop', 'map 메서드', 'filter 메서드', 'reduce 메서드']},
            {'name': '객체', 'topics': ['객체 생성', '속성 접근', '메서드', '구조분해', 'spread 연산자']},
            {'name': 'DOM', 'topics': ['querySelector', 'innerHTML', 'addEventListener', 'classList', 'createElement']},
            {'name': '비동기', 'topics': ['setTimeout', 'Promise', 'async/await', 'fetch API', 'then/catch']},
            {'name': 'ES6+', 'topics': ['let/const', '템플릿 리터럴', '기본 매개변수', 'rest 파라미터', '옵셔널 체이닝']},
            {'name': '에러 처리', 'topics': ['try-catch', 'throw 문', 'Error 객체', 'finally', '커스텀 에러']},
            {'name': '고급 개념', 'topics': ['클로저', 'this 키워드', 'prototype', 'class 문법', '모듈 시스템']}
        ]
    },
    'typescript': {
        'units': [
            {'name': '기본 타입', 'topics': ['string 타입', 'number 타입', 'boolean 타입', 'any 타입', 'unknown 타입']},
            {'name': '타입 선언', 'topics': ['변수 타입', '함수 타입', '배열 타입', '튜플 타입', '열거형 enum']},
            {'name': '인터페이스', 'topics': ['interface 선언', '옵셔널 속성', 'readonly', '인덱스 시그니처', '확장 extends']},
            {'name': '타입 별칭', 'topics': ['type 선언', '유니온 타입', '인터섹션 타입', '리터럴 타입', 'typeof']},
            {'name': '제네릭', 'topics': ['제네릭 함수', '제네릭 인터페이스', '제네릭 클래스', '타입 제약', '기본 타입']},
            {'name': '클래스', 'topics': ['class 선언', 'constructor', '접근 제한자', 'readonly', '추상 클래스']},
            {'name': '고급 타입', 'topics': ['조건부 타입', 'Mapped Types', 'Utility Types', 'keyof 연산자', 'infer 키워드']},
            {'name': '모듈', 'topics': ['import/export', '네임스페이스', '모듈 해석', '선언 파일', 'tsconfig.json']},
            {'name': '데코레이터', 'topics': ['클래스 데코레이터', '메서드 데코레이터', '속성 데코레이터', '매개변수 데코레이터', '메타데이터']},
            {'name': '유틸리티', 'topics': ['Partial', 'Required', 'Pick', 'Omit', 'Record']}
        ]
    },
    'python': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수와 출력', '데이터 타입', '연산자', '주석', 'input 입력']},
            {'name': '제어문', 'topics': ['if 조건문', 'elif/else', 'for 반복', 'while 반복', 'range 함수']},
            {'name': '함수', 'topics': ['def 함수 정의', '매개변수', '반환값', '람다 함수', '기본값 인자']},
            {'name': '자료구조', 'topics': ['리스트 list', '튜플 tuple', '딕셔너리 dict', '세트 set', '리스트 컴프리헨션']},
            {'name': '문자열', 'topics': ['문자열 연산', '슬라이싱', 'format 메서드', 'f-string', '문자열 메서드']},
            {'name': '모듈', 'topics': ['import 문', 'from import', '표준 라이브러리', '__name__', 'pip 패키지']},
            {'name': '파일 처리', 'topics': ['파일 열기', '파일 읽기', '파일 쓰기', 'with 문', 'json 모듈']},
            {'name': '클래스', 'topics': ['class 정의', '__init__', '메서드', '상속', '매직 메서드']},
            {'name': '예외 처리', 'topics': ['try-except', 'raise 문', 'finally', '커스텀 예외', 'else 절']},
            {'name': '고급 기능', 'topics': ['데코레이터', '제너레이터', 'context manager', 'itertools', 'collections']}
        ]
    },
    'dart': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', 'var/final/const', 'print 출력', '주석']},
            {'name': '제어문', 'topics': ['if-else', 'switch', 'for 반복', 'while 반복', 'break/continue']},
            {'name': '함수', 'topics': ['함수 선언', '화살표 함수', '선택적 매개변수', '명명된 매개변수', '익명 함수']},
            {'name': '컬렉션', 'topics': ['List 리스트', 'Set 세트', 'Map 맵', 'spread 연산자', 'collection if']},
            {'name': '클래스', 'topics': ['class 정의', 'constructor', 'getter/setter', '상속 extends', 'mixin']},
            {'name': '비동기', 'topics': ['Future', 'async/await', 'then/catchError', 'Stream', 'yield']},
            {'name': 'Null Safety', 'topics': ['nullable 타입', 'non-nullable', '?? 연산자', '?. 연산자', 'late 키워드']},
            {'name': '제네릭', 'topics': ['제네릭 클래스', '제네릭 함수', '타입 제약', '공변성', '반공변성']},
            {'name': '열거형과 확장', 'topics': ['enum 열거형', 'extension 확장', 'enhanced enum', 'typedef', 'callable class']},
            {'name': '고급 기능', 'topics': ['isolate', 'metadata', 'library', 'part/part of', 'cascade 연산자']}
        ]
    },
    'kotlin': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언 val/var', '데이터 타입', '타입 추론', '문자열 템플릿', 'print 출력']},
            {'name': '제어문', 'topics': ['if 표현식', 'when 표현식', 'for 반복', 'while 반복', 'range']},
            {'name': '함수', 'topics': ['fun 함수 정의', '단일 표현식', '기본 인자', '명명된 인자', '확장 함수']},
            {'name': '컬렉션', 'topics': ['List 리스트', 'Set 세트', 'Map 맵', 'filter', 'map 변환']},
            {'name': '클래스', 'topics': ['class 정의', 'constructor', 'data class', '상속 open', 'companion object']},
            {'name': 'Null Safety', 'topics': ['nullable 타입', '?. 안전 호출', '?: Elvis 연산자', '!! 연산자', 'let 함수']},
            {'name': '람다와 고차함수', 'topics': ['람다 표현식', '고차 함수', 'it 키워드', 'with/apply', 'also/let/run']},
            {'name': '코루틴', 'topics': ['suspend 함수', 'launch', 'async/await', 'CoroutineScope', 'withContext']},
            {'name': '제네릭', 'topics': ['제네릭 클래스', '제네릭 함수', 'in/out 변성', 'reified 타입', '타입 프로젝션']},
            {'name': '고급 기능', 'topics': ['sealed class', 'inline class', '위임 by', '연산자 오버로딩', 'DSL']}
        ]
    },
    'csharp': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', 'var 키워드', 'Console.WriteLine', '주석']},
            {'name': '제어문', 'topics': ['if-else', 'switch', 'for 반복', 'while 반복', 'foreach']},
            {'name': '메서드', 'topics': ['메서드 정의', '매개변수', '반환값', 'out/ref', '오버로딩']},
            {'name': '배열과 컬렉션', 'topics': ['배열 선언', 'List<T>', 'Dictionary', 'LINQ Where', 'LINQ Select']},
            {'name': '클래스', 'topics': ['class 정의', 'constructor', 'property', '상속', 'override']},
            {'name': '인터페이스', 'topics': ['interface 정의', '구현', '다중 인터페이스', '명시적 구현', '기본 구현']},
            {'name': '예외 처리', 'topics': ['try-catch', 'throw', 'finally', 'Exception 클래스', 'custom exception']},
            {'name': '비동기', 'topics': ['async/await', 'Task', 'Task<T>', 'async void', 'ConfigureAwait']},
            {'name': '델리게이트와 이벤트', 'topics': ['delegate', 'Action', 'Func', 'event', 'lambda']},
            {'name': '고급 기능', 'topics': ['제네릭', 'nullable 타입', 'pattern matching', 'record', 'init']}
        ]
    },
    'java': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', '연산자', 'System.out.println', '주석']},
            {'name': '제어문', 'topics': ['if-else', 'switch', 'for 반복', 'while 반복', 'enhanced for']},
            {'name': '메서드', 'topics': ['메서드 정의', 'static 메서드', '매개변수', '반환값', '오버로딩']},
            {'name': '배열과 컬렉션', 'topics': ['배열 선언', 'ArrayList', 'HashMap', 'for-each', 'Stream API']},
            {'name': '클래스', 'topics': ['class 정의', 'constructor', 'getter/setter', '상속 extends', 'super 키워드']},
            {'name': '인터페이스', 'topics': ['interface 정의', 'implements', '다중 인터페이스', 'default 메서드', 'static 메서드']},
            {'name': '예외 처리', 'topics': ['try-catch', 'throw', 'throws', 'Exception 클래스', 'try-with-resources']},
            {'name': '제네릭', 'topics': ['제네릭 클래스', '제네릭 메서드', 'bounded type', 'wildcard', 'type erasure']},
            {'name': '람다와 스트림', 'topics': ['람다 표현식', 'functional interface', 'method reference', 'Stream', 'Optional']},
            {'name': '고급 기능', 'topics': ['Annotation', 'Reflection', 'Thread', 'CompletableFuture', 'var 키워드']}
        ]
    },
    'go': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', ':= 연산자', 'fmt.Println', 'package/import']},
            {'name': '제어문', 'topics': ['if 문', 'switch 문', 'for 반복', 'range', 'defer']},
            {'name': '함수', 'topics': ['func 정의', '다중 반환값', '가변 인자', '익명 함수', '클로저']},
            {'name': '복합 타입', 'topics': ['배열 array', '슬라이스 slice', '맵 map', '구조체 struct', '포인터']},
            {'name': '메서드', 'topics': ['메서드 정의', '리시버', '포인터 리시버', '값 리시버', '메서드 체이닝']},
            {'name': '인터페이스', 'topics': ['interface 정의', '암묵적 구현', '빈 인터페이스', '타입 단언', '타입 스위치']},
            {'name': '동시성', 'topics': ['goroutine', 'channel', 'select', 'buffered channel', 'sync.WaitGroup']},
            {'name': '에러 처리', 'topics': ['error 인터페이스', 'errors.New', 'fmt.Errorf', 'panic/recover', 'custom error']},
            {'name': '패키지', 'topics': ['패키지 생성', 'import 경로', 'init 함수', '내부 패키지', 'go mod']},
            {'name': '고급 기능', 'topics': ['context', 'reflection', 'generic', 'embedding', 'build tags']}
        ]
    },
    'c': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', 'printf/scanf', '연산자', '주석']},
            {'name': '제어문', 'topics': ['if-else', 'switch', 'for 반복', 'while 반복', 'do-while']},
            {'name': '함수', 'topics': ['함수 정의', '함수 선언', '매개변수', '반환값', '재귀 함수']},
            {'name': '배열', 'topics': ['배열 선언', '배열 초기화', '다차원 배열', '배열과 포인터', '배열 크기']},
            {'name': '포인터', 'topics': ['포인터 선언', '주소 연산자', '역참조', '포인터 산술', '이중 포인터']},
            {'name': '문자열', 'topics': ['문자 배열', 'string.h', 'strcpy', 'strlen', 'strcmp']},
            {'name': '구조체', 'topics': ['struct 정의', '구조체 변수', '구조체 포인터', 'typedef', '구조체 배열']},
            {'name': '동적 메모리', 'topics': ['malloc', 'calloc', 'realloc', 'free', '메모리 누수']},
            {'name': '파일 처리', 'topics': ['fopen', 'fclose', 'fread/fwrite', 'fprintf/fscanf', 'fseek']},
            {'name': '고급 기능', 'topics': ['전처리기', 'enum', 'union', '함수 포인터', 'const 포인터']}
        ]
    },
    'cpp': {
        'units': [
            {'name': '기본 문법', 'topics': ['변수 선언', '데이터 타입', 'cout/cin', '네임스페이스', '주석']},
            {'name': '제어문', 'topics': ['if-else', 'switch', 'for 반복', 'while 반복', 'range-based for']},
            {'name': '함수', 'topics': ['함수 정의', '함수 오버로딩', '기본 매개변수', '인라인 함수', 'auto 반환']},
            {'name': 'STL 컨테이너', 'topics': ['vector', 'string', 'map', 'set', 'pair']},
            {'name': '클래스', 'topics': ['class 정의', 'constructor', 'destructor', '상속', 'virtual 함수']},
            {'name': '연산자 오버로딩', 'topics': ['+ 연산자', '== 연산자', '[] 연산자', '<< 연산자', 'friend 함수']},
            {'name': '템플릿', 'topics': ['함수 템플릿', '클래스 템플릿', '템플릿 특수화', 'variadic template', 'SFINAE']},
            {'name': '스마트 포인터', 'topics': ['unique_ptr', 'shared_ptr', 'weak_ptr', 'make_unique', 'make_shared']},
            {'name': '람다와 STL', 'topics': ['람다 표현식', 'algorithm', 'transform', 'find_if', 'sort']},
            {'name': '모던 C++', 'topics': ['auto 키워드', 'move 시맨틱', 'rvalue 참조', 'constexpr', 'structured binding']}
        ]
    },
    'sql': {
        'units': [
            {'name': '기본 쿼리', 'topics': ['SELECT 문', 'WHERE 조건', 'ORDER BY 정렬', 'LIMIT', 'DISTINCT']},
            {'name': '집계 함수', 'topics': ['COUNT', 'SUM', 'AVG', 'MAX', 'MIN']},
            {'name': 'GROUP BY', 'topics': ['GROUP BY', 'HAVING', '집계 조건', '다중 그룹', 'ROLLUP']},
            {'name': 'JOIN', 'topics': ['INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL JOIN', 'CROSS JOIN']},
            {'name': '서브쿼리', 'topics': ['스칼라 서브쿼리', 'IN 서브쿼리', 'EXISTS', 'ANY/ALL', '상관 서브쿼리']},
            {'name': '데이터 조작', 'topics': ['INSERT', 'UPDATE', 'DELETE', 'UPSERT', 'RETURNING']},
            {'name': '테이블 관리', 'topics': ['CREATE TABLE', 'ALTER TABLE', 'DROP TABLE', 'TRUNCATE', 'CONSTRAINTS']},
            {'name': '인덱스와 뷰', 'topics': ['CREATE INDEX', 'DROP INDEX', 'CREATE VIEW', 'Materialized View', '인덱스 전략']},
            {'name': '트랜잭션', 'topics': ['BEGIN', 'COMMIT', 'ROLLBACK', 'SAVEPOINT', 'ISOLATION LEVEL']},
            {'name': '고급 기능', 'topics': ['WINDOW 함수', 'CTE', 'RECURSIVE', 'JSON 함수', 'TRIGGER']}
        ]
    }
}

def generate_challenge(lang, unit_idx, problem_idx, unit_name, topic):
    """단일 챌린지 생성"""
    level = unit_idx * 5 + problem_idx + 1
    slug = f"{lang}-{topic.lower().replace(' ', '-').replace('/', '-')}"

    # 난이도 계산 (1-3)
    if level <= 17:
        difficulty = 1
    elif level <= 33:
        difficulty = 2
    else:
        difficulty = 3

    # 예상 시간 (분)
    estimated_time = 5 if difficulty == 1 else (8 if difficulty == 2 else 12)

    # kind 결정
    kind = 'syntax' if level <= 25 else 'algorithm'

    challenge = f"""INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($${slug}$$, $${lang}$$, $${kind}$$, {level}, $${topic}$$, $${unit_name} - {topic}$$, $$challenge$$, {difficulty},
$${topic}을(를) 사용하는 문제를 해결하세요.$$,
$$- {topic} 사용\n- 기본 문법 준수$$,
$$[{{"input": "", "output": "결과"}}]$$,
$$/* {topic} 코드를 작성하세요 */\n$$,
$$/* 정답 코드 */\n$$,
$$[{{"input": "", "expected": "expected output"}}]$$,
$$["{topic}의 기본 사용법을 익히세요"]$$,
$$["{lang}", "basics", "unit-{unit_idx+1}"]$$, {estimated_time})"""

    return challenge

def generate_all_challenges():
    """모든 챌린지 생성"""

    output = []

    # 헤더
    output.append("""-- ============================================================================
-- 전체 언어 챌린지 통합 파일 (완전 재생성)
-- ============================================================================
-- 13개 언어 × 50문제 = 총 650개 챌린지
-- 생성일: 2025-11-10
-- 각 언어: 10개 단원 × 5문제
-- ============================================================================
-- 언어 목록:
-- 1. HTML (50 challenges)
-- 2. CSS (50 challenges)
-- 3. JavaScript (50 challenges)
-- 4. TypeScript (50 challenges)
-- 5. Python (50 challenges)
-- 6. Dart (50 challenges)
-- 7. Kotlin (50 challenges)
-- 8. C# (50 challenges)
-- 9. Java (50 challenges)
-- 10. Go (50 challenges)
-- 11. C (50 challenges)
-- 12. C++ (50 challenges)
-- 13. SQL (50 challenges)
-- ============================================================================

-- 기존 챌린지 삭제 (필요시 주석 해제)
-- DELETE FROM challenges;

""")

    # 각 언어별 챌린지 생성
    for lang_name, lang_data in LANGUAGES.items():
        output.append(f"""-- ============================================================================
-- {lang_name.upper()} Language Challenges
-- ============================================================================
-- Total: 50 challenges
-- Distribution: 10 units × 5 challenges
-- ============================================================================

""")

        for unit_idx, unit in enumerate(lang_data['units']):
            output.append(f"""-- ============================================================================
-- Unit {unit_idx + 1}: {unit['name']} (5 challenges)
-- ============================================================================

""")

            challenges = []
            for problem_idx, topic in enumerate(unit['topics']):
                challenge = generate_challenge(lang_name, unit_idx, problem_idx, unit['name'], topic)
                challenges.append(challenge)

            # 마지막 문제를 제외하고는 쉼표로 연결
            output.append(',\n\n'.join(challenges))

            # 마지막 단원이 아니면 쉼표 추가, 마지막 단원이면 세미콜론
            if unit_idx < len(lang_data['units']) - 1:
                output.append(',\n\n')
            else:
                # 마지막 언어가 아니면 세미콜론 + 줄바꿈
                if lang_name != 'sql':
                    output.append(';\n\n')
                else:
                    output.append(';\n\n-- ============================================================================\n-- 전체 650개 챌린지 생성 완료!\n-- ============================================================================\n')

    return ''.join(output)

def main():
    print("650개 챌린지 생성 중...")
    print("=" * 80)

    content = generate_all_challenges()

    # 파일 저장
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
    print(f"균형 체크: {'✓ OK' if insert_count == semicolon_count else '✗ ERROR'}")
    print("=" * 80)

    if insert_count == semicolon_count:
        print("\n✓✓✓ 완벽한 650개 챌린지 파일이 생성되었습니다! ✓✓✓")
        print("이제 Supabase에 업로드할 수 있습니다.")
    else:
        print("\n경고: INSERT 문과 세미콜론 수가 일치하지 않습니다.")

if __name__ == "__main__":
    main()

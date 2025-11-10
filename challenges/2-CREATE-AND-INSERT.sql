-- ============================================================================
-- STEP 2: 테이블 생성 및 데이터 삽입
-- ============================================================================
-- 1-DELETE-OLD-DATA.sql을 먼저 실행한 후 이 파일을 실행하세요!
-- ============================================================================

-- 기존 테이블 완전 삭제 (중복 키 오류 방지)
DROP TABLE IF EXISTS challenges CASCADE;

-- challenges 테이블 생성
CREATE TABLE challenges (
    -- 기본 식별자
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- 고유 식별자 (URL-friendly)
    slug TEXT UNIQUE NOT NULL,

    -- 언어 정보
    language TEXT NOT NULL,

    -- 문제 유형 (syntax, algorithm, project 등)
    kind TEXT NOT NULL,

    -- 난이도 레벨 (1-50)
    level INTEGER NOT NULL,

    -- 제목과 설명
    title TEXT NOT NULL,
    description TEXT NOT NULL,

    -- 카테고리 (challenge, tutorial, quiz 등)
    category TEXT NOT NULL DEFAULT 'challenge',

    -- 난이도 (1: 쉬움, 2: 보통, 3: 어려움)
    difficulty INTEGER NOT NULL DEFAULT 1,

    -- 문제 설명
    problem_description TEXT NOT NULL,

    -- 제약 조건
    constraints TEXT,

    -- 예제
    examples JSONB,

    -- 초기 코드 (사용자에게 제공되는 시작 코드)
    initial_code TEXT,

    -- 정답 코드
    solution_code TEXT NOT NULL,

    -- 테스트 케이스
    test_cases JSONB,

    -- 힌트
    hints JSONB,

    -- 태그 (검색 및 필터링용)
    tags JSONB,

    -- 예상 소요 시간 (분)
    estimated_time INTEGER DEFAULT 5,

    -- 메타데이터
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 인덱스 생성 (검색 성능 향상)
CREATE INDEX idx_challenges_language ON challenges(language);
CREATE INDEX idx_challenges_level ON challenges(level);
CREATE INDEX idx_challenges_difficulty ON challenges(difficulty);
CREATE INDEX idx_challenges_kind ON challenges(kind);
CREATE INDEX idx_challenges_category ON challenges(category);
CREATE INDEX idx_challenges_tags ON challenges USING GIN(tags);

-- 제약 조건 추가
ALTER TABLE challenges
ADD CONSTRAINT check_difficulty CHECK (difficulty BETWEEN 1 AND 3),
ADD CONSTRAINT check_level CHECK (level BETWEEN 1 AND 100),
ADD CONSTRAINT check_estimated_time CHECK (estimated_time > 0);

-- RLS (Row Level Security) 활성화
ALTER TABLE challenges ENABLE ROW LEVEL SECURITY;

-- 모든 사용자가 읽을 수 있도록 정책 추가
CREATE POLICY "Anyone can read challenges" ON challenges
    FOR SELECT USING (true);

-- 확인 메시지
DO $$
BEGIN
    RAISE NOTICE '테이블이 성공적으로 생성되었습니다.';
    RAISE NOTICE '이제 데이터를 삽입합니다...';
END $$;


-- ============================================================================
-- 전체 언어 챌린지 통합 파일 (완전 재생성)
-- ============================================================================
-- 13개 언어 × 50문제 = 총 650개 챌린지
-- 생성일: 2025-11-10
-- ============================================================================

-- 기존 챌린지 삭제 (필요시 주석 해제)
-- DELETE FROM challenges;

-- ============================================================================
-- HTML Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-html-문서-구조$$, $$html$$, $$syntax$$, 1, $$HTML 문서 구조$$, $$HTML 문서 구조 학습$$, $$challenge$$, 1,
$$HTML 문서 구조을(를) 사용하여 문제를 해결하세요.$$,
$$- HTML 문서 구조 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* HTML 문서 구조 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["HTML 문서 구조의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-head-태그$$, $$html$$, $$syntax$$, 2, $$head 태그$$, $$head 태그 학습$$, $$challenge$$, 1,
$$head 태그을(를) 사용하여 문제를 해결하세요.$$,
$$- head 태그 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* head 태그 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["head 태그의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-body-태그$$, $$html$$, $$syntax$$, 3, $$body 태그$$, $$body 태그 학습$$, $$challenge$$, 1,
$$body 태그을(를) 사용하여 문제를 해결하세요.$$,
$$- body 태그 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* body 태그 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["body 태그의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-title-태그$$, $$html$$, $$syntax$$, 4, $$title 태그$$, $$title 태그 학습$$, $$challenge$$, 1,
$$title 태그을(를) 사용하여 문제를 해결하세요.$$,
$$- title 태그 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* title 태그 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["title 태그의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-meta-charset$$, $$html$$, $$syntax$$, 5, $$meta charset$$, $$meta charset 학습$$, $$challenge$$, 1,
$$meta charset을(를) 사용하여 문제를 해결하세요.$$,
$$- meta charset 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* meta charset 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["meta charset의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-h1-제목$$, $$html$$, $$syntax$$, 6, $$h1 제목$$, $$h1 제목 학습$$, $$challenge$$, 1,
$$h1 제목을(를) 사용하여 문제를 해결하세요.$$,
$$- h1 제목 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* h1 제목 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["h1 제목의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-h2-제목$$, $$html$$, $$syntax$$, 7, $$h2 제목$$, $$h2 제목 학습$$, $$challenge$$, 1,
$$h2 제목을(를) 사용하여 문제를 해결하세요.$$,
$$- h2 제목 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* h2 제목 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["h2 제목의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-p-단락$$, $$html$$, $$syntax$$, 8, $$p 단락$$, $$p 단락 학습$$, $$challenge$$, 1,
$$p 단락을(를) 사용하여 문제를 해결하세요.$$,
$$- p 단락 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* p 단락 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["p 단락의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-strong-굵게$$, $$html$$, $$syntax$$, 9, $$strong 굵게$$, $$strong 굵게 학습$$, $$challenge$$, 1,
$$strong 굵게을(를) 사용하여 문제를 해결하세요.$$,
$$- strong 굵게 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* strong 굵게 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["strong 굵게의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-em-기울임$$, $$html$$, $$syntax$$, 10, $$em 기울임$$, $$em 기울임 학습$$, $$challenge$$, 1,
$$em 기울임을(를) 사용하여 문제를 해결하세요.$$,
$$- em 기울임 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* em 기울임 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["em 기울임의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-a-링크$$, $$html$$, $$syntax$$, 11, $$a 링크$$, $$a 링크 학습$$, $$challenge$$, 1,
$$a 링크을(를) 사용하여 문제를 해결하세요.$$,
$$- a 링크 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* a 링크 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["a 링크의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-href-속성$$, $$html$$, $$syntax$$, 12, $$href 속성$$, $$href 속성 학습$$, $$challenge$$, 1,
$$href 속성을(를) 사용하여 문제를 해결하세요.$$,
$$- href 속성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* href 속성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["href 속성의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-img-이미지$$, $$html$$, $$syntax$$, 13, $$img 이미지$$, $$img 이미지 학습$$, $$challenge$$, 1,
$$img 이미지을(를) 사용하여 문제를 해결하세요.$$,
$$- img 이미지 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* img 이미지 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["img 이미지의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-alt-속성$$, $$html$$, $$syntax$$, 14, $$alt 속성$$, $$alt 속성 학습$$, $$challenge$$, 1,
$$alt 속성을(를) 사용하여 문제를 해결하세요.$$,
$$- alt 속성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* alt 속성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["alt 속성의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-target-속성$$, $$html$$, $$syntax$$, 15, $$target 속성$$, $$target 속성 학습$$, $$challenge$$, 1,
$$target 속성을(를) 사용하여 문제를 해결하세요.$$,
$$- target 속성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* target 속성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["target 속성의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-ul-목록$$, $$html$$, $$syntax$$, 16, $$ul 목록$$, $$ul 목록 학습$$, $$challenge$$, 1,
$$ul 목록을(를) 사용하여 문제를 해결하세요.$$,
$$- ul 목록 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ul 목록 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ul 목록의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-ol-목록$$, $$html$$, $$syntax$$, 17, $$ol 목록$$, $$ol 목록 학습$$, $$challenge$$, 1,
$$ol 목록을(를) 사용하여 문제를 해결하세요.$$,
$$- ol 목록 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ol 목록 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ol 목록의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-li-항목$$, $$html$$, $$syntax$$, 18, $$li 항목$$, $$li 항목 학습$$, $$challenge$$, 2,
$$li 항목을(를) 사용하여 문제를 해결하세요.$$,
$$- li 항목 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* li 항목 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["li 항목의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-dl-정의$$, $$html$$, $$syntax$$, 19, $$dl 정의$$, $$dl 정의 학습$$, $$challenge$$, 2,
$$dl 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- dl 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* dl 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["dl 정의의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-nested-list$$, $$html$$, $$syntax$$, 20, $$nested list$$, $$nested list 학습$$, $$challenge$$, 2,
$$nested list을(를) 사용하여 문제를 해결하세요.$$,
$$- nested list 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nested list 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nested list의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-table-테이블$$, $$html$$, $$syntax$$, 21, $$table 테이블$$, $$table 테이블 학습$$, $$challenge$$, 2,
$$table 테이블을(를) 사용하여 문제를 해결하세요.$$,
$$- table 테이블 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* table 테이블 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["table 테이블의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-tr-행$$, $$html$$, $$syntax$$, 22, $$tr 행$$, $$tr 행 학습$$, $$challenge$$, 2,
$$tr 행을(를) 사용하여 문제를 해결하세요.$$,
$$- tr 행 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* tr 행 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["tr 행의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-td-셀$$, $$html$$, $$syntax$$, 23, $$td 셀$$, $$td 셀 학습$$, $$challenge$$, 2,
$$td 셀을(를) 사용하여 문제를 해결하세요.$$,
$$- td 셀 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* td 셀 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["td 셀의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-th-헤더$$, $$html$$, $$syntax$$, 24, $$th 헤더$$, $$th 헤더 학습$$, $$challenge$$, 2,
$$th 헤더을(를) 사용하여 문제를 해결하세요.$$,
$$- th 헤더 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* th 헤더 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["th 헤더의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-colspan$$, $$html$$, $$syntax$$, 25, $$colspan$$, $$colspan 학습$$, $$challenge$$, 2,
$$colspan을(를) 사용하여 문제를 해결하세요.$$,
$$- colspan 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* colspan 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["colspan의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-form-폼$$, $$html$$, $$algorithm$$, 26, $$form 폼$$, $$form 폼 학습$$, $$challenge$$, 2,
$$form 폼을(를) 사용하여 문제를 해결하세요.$$,
$$- form 폼 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* form 폼 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["form 폼의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-input-입력$$, $$html$$, $$algorithm$$, 27, $$input 입력$$, $$input 입력 학습$$, $$challenge$$, 2,
$$input 입력을(를) 사용하여 문제를 해결하세요.$$,
$$- input 입력 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* input 입력 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["input 입력의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-label-라벨$$, $$html$$, $$algorithm$$, 28, $$label 라벨$$, $$label 라벨 학습$$, $$challenge$$, 2,
$$label 라벨을(를) 사용하여 문제를 해결하세요.$$,
$$- label 라벨 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* label 라벨 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["label 라벨의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-button-버튼$$, $$html$$, $$algorithm$$, 29, $$button 버튼$$, $$button 버튼 학습$$, $$challenge$$, 2,
$$button 버튼을(를) 사용하여 문제를 해결하세요.$$,
$$- button 버튼 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* button 버튼 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["button 버튼의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-select-선택$$, $$html$$, $$algorithm$$, 30, $$select 선택$$, $$select 선택 학습$$, $$challenge$$, 2,
$$select 선택을(를) 사용하여 문제를 해결하세요.$$,
$$- select 선택 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* select 선택 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["select 선택의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-header-헤더$$, $$html$$, $$algorithm$$, 31, $$header 헤더$$, $$header 헤더 학습$$, $$challenge$$, 2,
$$header 헤더을(를) 사용하여 문제를 해결하세요.$$,
$$- header 헤더 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* header 헤더 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["header 헤더의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-nav-네비$$, $$html$$, $$algorithm$$, 32, $$nav 네비$$, $$nav 네비 학습$$, $$challenge$$, 2,
$$nav 네비을(를) 사용하여 문제를 해결하세요.$$,
$$- nav 네비 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nav 네비 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nav 네비의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-main-메인$$, $$html$$, $$algorithm$$, 33, $$main 메인$$, $$main 메인 학습$$, $$challenge$$, 2,
$$main 메인을(를) 사용하여 문제를 해결하세요.$$,
$$- main 메인 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* main 메인 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["main 메인의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-footer-푸터$$, $$html$$, $$algorithm$$, 34, $$footer 푸터$$, $$footer 푸터 학습$$, $$challenge$$, 3,
$$footer 푸터을(를) 사용하여 문제를 해결하세요.$$,
$$- footer 푸터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* footer 푸터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["footer 푸터의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-article-아티클$$, $$html$$, $$algorithm$$, 35, $$article 아티클$$, $$article 아티클 학습$$, $$challenge$$, 3,
$$article 아티클을(를) 사용하여 문제를 해결하세요.$$,
$$- article 아티클 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* article 아티클 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["article 아티클의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-video-비디오$$, $$html$$, $$algorithm$$, 36, $$video 비디오$$, $$video 비디오 학습$$, $$challenge$$, 3,
$$video 비디오을(를) 사용하여 문제를 해결하세요.$$,
$$- video 비디오 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* video 비디오 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["video 비디오의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-audio-오디오$$, $$html$$, $$algorithm$$, 37, $$audio 오디오$$, $$audio 오디오 학습$$, $$challenge$$, 3,
$$audio 오디오을(를) 사용하여 문제를 해결하세요.$$,
$$- audio 오디오 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* audio 오디오 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["audio 오디오의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-iframe-프레임$$, $$html$$, $$algorithm$$, 38, $$iframe 프레임$$, $$iframe 프레임 학습$$, $$challenge$$, 3,
$$iframe 프레임을(를) 사용하여 문제를 해결하세요.$$,
$$- iframe 프레임 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* iframe 프레임 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["iframe 프레임의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-canvas-캔버스$$, $$html$$, $$algorithm$$, 39, $$canvas 캔버스$$, $$canvas 캔버스 학습$$, $$challenge$$, 3,
$$canvas 캔버스을(를) 사용하여 문제를 해결하세요.$$,
$$- canvas 캔버스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* canvas 캔버스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["canvas 캔버스의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-svg-벡터$$, $$html$$, $$algorithm$$, 40, $$svg 벡터$$, $$svg 벡터 학습$$, $$challenge$$, 3,
$$svg 벡터을(를) 사용하여 문제를 해결하세요.$$,
$$- svg 벡터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* svg 벡터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["svg 벡터의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-meta-viewport$$, $$html$$, $$algorithm$$, 41, $$meta viewport$$, $$meta viewport 학습$$, $$challenge$$, 3,
$$meta viewport을(를) 사용하여 문제를 해결하세요.$$,
$$- meta viewport 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* meta viewport 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["meta viewport의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-meta-description$$, $$html$$, $$algorithm$$, 42, $$meta description$$, $$meta description 학습$$, $$challenge$$, 3,
$$meta description을(를) 사용하여 문제를 해결하세요.$$,
$$- meta description 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* meta description 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["meta description의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-link-stylesheet$$, $$html$$, $$algorithm$$, 43, $$link stylesheet$$, $$link stylesheet 학습$$, $$challenge$$, 3,
$$link stylesheet을(를) 사용하여 문제를 해결하세요.$$,
$$- link stylesheet 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* link stylesheet 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["link stylesheet의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-script-태그$$, $$html$$, $$algorithm$$, 44, $$script 태그$$, $$script 태그 학습$$, $$challenge$$, 3,
$$script 태그을(를) 사용하여 문제를 해결하세요.$$,
$$- script 태그 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* script 태그 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["script 태그의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-div-container$$, $$html$$, $$algorithm$$, 45, $$div container$$, $$div container 학습$$, $$challenge$$, 3,
$$div container을(를) 사용하여 문제를 해결하세요.$$,
$$- div container 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* div container 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["div container의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-details-상세$$, $$html$$, $$algorithm$$, 46, $$details 상세$$, $$details 상세 학습$$, $$challenge$$, 3,
$$details 상세을(를) 사용하여 문제를 해결하세요.$$,
$$- details 상세 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* details 상세 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["details 상세의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-summary-요약$$, $$html$$, $$algorithm$$, 47, $$summary 요약$$, $$summary 요약 학습$$, $$challenge$$, 3,
$$summary 요약을(를) 사용하여 문제를 해결하세요.$$,
$$- summary 요약 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* summary 요약 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["summary 요약의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-progress-진행$$, $$html$$, $$algorithm$$, 48, $$progress 진행$$, $$progress 진행 학습$$, $$challenge$$, 3,
$$progress 진행을(를) 사용하여 문제를 해결하세요.$$,
$$- progress 진행 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* progress 진행 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["progress 진행의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-meter-측정$$, $$html$$, $$algorithm$$, 49, $$meter 측정$$, $$meter 측정 학습$$, $$challenge$$, 3,
$$meter 측정을(를) 사용하여 문제를 해결하세요.$$,
$$- meter 측정 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* meter 측정 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["meter 측정의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$html-template-템플릿$$, $$html$$, $$algorithm$$, 50, $$template 템플릿$$, $$template 템플릿 학습$$, $$challenge$$, 3,
$$template 템플릿을(를) 사용하여 문제를 해결하세요.$$,
$$- template 템플릿 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* template 템플릿 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["template 템플릿의 기본 사용법을 익히세요"]$$,
$$["html", "basics"]$$, 12);

-- ============================================================================
-- CSS Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-요소-선택자$$, $$css$$, $$syntax$$, 1, $$요소 선택자$$, $$요소 선택자 학습$$, $$challenge$$, 1,
$$요소 선택자을(를) 사용하여 문제를 해결하세요.$$,
$$- 요소 선택자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 요소 선택자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["요소 선택자의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-class-선택자$$, $$css$$, $$syntax$$, 2, $$class 선택자$$, $$class 선택자 학습$$, $$challenge$$, 1,
$$class 선택자을(를) 사용하여 문제를 해결하세요.$$,
$$- class 선택자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 선택자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class 선택자의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-id-선택자$$, $$css$$, $$syntax$$, 3, $$id 선택자$$, $$id 선택자 학습$$, $$challenge$$, 1,
$$id 선택자을(를) 사용하여 문제를 해결하세요.$$,
$$- id 선택자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* id 선택자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["id 선택자의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-자손-선택자$$, $$css$$, $$syntax$$, 4, $$자손 선택자$$, $$자손 선택자 학습$$, $$challenge$$, 1,
$$자손 선택자을(를) 사용하여 문제를 해결하세요.$$,
$$- 자손 선택자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 자손 선택자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["자손 선택자의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-속성-선택자$$, $$css$$, $$syntax$$, 5, $$속성 선택자$$, $$속성 선택자 학습$$, $$challenge$$, 1,
$$속성 선택자을(를) 사용하여 문제를 해결하세요.$$,
$$- 속성 선택자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 속성 선택자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["속성 선택자의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-color-색상$$, $$css$$, $$syntax$$, 6, $$color 색상$$, $$color 색상 학습$$, $$challenge$$, 1,
$$color 색상을(를) 사용하여 문제를 해결하세요.$$,
$$- color 색상 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* color 색상 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["color 색상의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-font-size-크기$$, $$css$$, $$syntax$$, 7, $$font-size 크기$$, $$font-size 크기 학습$$, $$challenge$$, 1,
$$font-size 크기을(를) 사용하여 문제를 해결하세요.$$,
$$- font-size 크기 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* font-size 크기 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["font-size 크기의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-font-weight-굵기$$, $$css$$, $$syntax$$, 8, $$font-weight 굵기$$, $$font-weight 굵기 학습$$, $$challenge$$, 1,
$$font-weight 굵기을(를) 사용하여 문제를 해결하세요.$$,
$$- font-weight 굵기 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* font-weight 굵기 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["font-weight 굵기의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-text-align-정렬$$, $$css$$, $$syntax$$, 9, $$text-align 정렬$$, $$text-align 정렬 학습$$, $$challenge$$, 1,
$$text-align 정렬을(를) 사용하여 문제를 해결하세요.$$,
$$- text-align 정렬 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* text-align 정렬 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["text-align 정렬의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-line-height-행간$$, $$css$$, $$syntax$$, 10, $$line-height 행간$$, $$line-height 행간 학습$$, $$challenge$$, 1,
$$line-height 행간을(를) 사용하여 문제를 해결하세요.$$,
$$- line-height 행간 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* line-height 행간 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["line-height 행간의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-width-너비$$, $$css$$, $$syntax$$, 11, $$width 너비$$, $$width 너비 학습$$, $$challenge$$, 1,
$$width 너비을(를) 사용하여 문제를 해결하세요.$$,
$$- width 너비 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* width 너비 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["width 너비의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-height-높이$$, $$css$$, $$syntax$$, 12, $$height 높이$$, $$height 높이 학습$$, $$challenge$$, 1,
$$height 높이을(를) 사용하여 문제를 해결하세요.$$,
$$- height 높이 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* height 높이 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["height 높이의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-padding-안쪽$$, $$css$$, $$syntax$$, 13, $$padding 안쪽$$, $$padding 안쪽 학습$$, $$challenge$$, 1,
$$padding 안쪽을(를) 사용하여 문제를 해결하세요.$$,
$$- padding 안쪽 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* padding 안쪽 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["padding 안쪽의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-margin-바깥$$, $$css$$, $$syntax$$, 14, $$margin 바깥$$, $$margin 바깥 학습$$, $$challenge$$, 1,
$$margin 바깥을(를) 사용하여 문제를 해결하세요.$$,
$$- margin 바깥 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* margin 바깥 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["margin 바깥의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-border-테두리$$, $$css$$, $$syntax$$, 15, $$border 테두리$$, $$border 테두리 학습$$, $$challenge$$, 1,
$$border 테두리을(를) 사용하여 문제를 해결하세요.$$,
$$- border 테두리 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* border 테두리 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["border 테두리의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-background-color$$, $$css$$, $$syntax$$, 16, $$background-color$$, $$background-color 학습$$, $$challenge$$, 1,
$$background-color을(를) 사용하여 문제를 해결하세요.$$,
$$- background-color 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* background-color 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["background-color의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-background-image$$, $$css$$, $$syntax$$, 17, $$background-image$$, $$background-image 학습$$, $$challenge$$, 1,
$$background-image을(를) 사용하여 문제를 해결하세요.$$,
$$- background-image 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* background-image 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["background-image의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-background-size$$, $$css$$, $$syntax$$, 18, $$background-size$$, $$background-size 학습$$, $$challenge$$, 2,
$$background-size을(를) 사용하여 문제를 해결하세요.$$,
$$- background-size 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* background-size 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["background-size의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-background-position$$, $$css$$, $$syntax$$, 19, $$background-position$$, $$background-position 학습$$, $$challenge$$, 2,
$$background-position을(를) 사용하여 문제를 해결하세요.$$,
$$- background-position 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* background-position 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["background-position의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-gradient$$, $$css$$, $$syntax$$, 20, $$gradient$$, $$gradient 학습$$, $$challenge$$, 2,
$$gradient을(를) 사용하여 문제를 해결하세요.$$,
$$- gradient 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* gradient 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["gradient의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-display-속성$$, $$css$$, $$syntax$$, 21, $$display 속성$$, $$display 속성 학습$$, $$challenge$$, 2,
$$display 속성을(를) 사용하여 문제를 해결하세요.$$,
$$- display 속성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* display 속성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["display 속성의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-position-위치$$, $$css$$, $$syntax$$, 22, $$position 위치$$, $$position 위치 학습$$, $$challenge$$, 2,
$$position 위치을(를) 사용하여 문제를 해결하세요.$$,
$$- position 위치 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* position 위치 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["position 위치의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-float-플로트$$, $$css$$, $$syntax$$, 23, $$float 플로트$$, $$float 플로트 학습$$, $$challenge$$, 2,
$$float 플로트을(를) 사용하여 문제를 해결하세요.$$,
$$- float 플로트 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* float 플로트 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["float 플로트의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-clear-클리어$$, $$css$$, $$syntax$$, 24, $$clear 클리어$$, $$clear 클리어 학습$$, $$challenge$$, 2,
$$clear 클리어을(를) 사용하여 문제를 해결하세요.$$,
$$- clear 클리어 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* clear 클리어 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["clear 클리어의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-z-index$$, $$css$$, $$syntax$$, 25, $$z-index$$, $$z-index 학습$$, $$challenge$$, 2,
$$z-index을(를) 사용하여 문제를 해결하세요.$$,
$$- z-index 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* z-index 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["z-index의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-display-flex$$, $$css$$, $$algorithm$$, 26, $$display flex$$, $$display flex 학습$$, $$challenge$$, 2,
$$display flex을(를) 사용하여 문제를 해결하세요.$$,
$$- display flex 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* display flex 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["display flex의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-direction$$, $$css$$, $$algorithm$$, 27, $$flex-direction$$, $$flex-direction 학습$$, $$challenge$$, 2,
$$flex-direction을(를) 사용하여 문제를 해결하세요.$$,
$$- flex-direction 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* flex-direction 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["flex-direction의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-justify-content$$, $$css$$, $$algorithm$$, 28, $$justify-content$$, $$justify-content 학습$$, $$challenge$$, 2,
$$justify-content을(를) 사용하여 문제를 해결하세요.$$,
$$- justify-content 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* justify-content 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["justify-content의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-align-items$$, $$css$$, $$algorithm$$, 29, $$align-items$$, $$align-items 학습$$, $$challenge$$, 2,
$$align-items을(를) 사용하여 문제를 해결하세요.$$,
$$- align-items 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* align-items 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["align-items의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-flex-wrap$$, $$css$$, $$algorithm$$, 30, $$flex-wrap$$, $$flex-wrap 학습$$, $$challenge$$, 2,
$$flex-wrap을(를) 사용하여 문제를 해결하세요.$$,
$$- flex-wrap 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* flex-wrap 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["flex-wrap의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-display-grid$$, $$css$$, $$algorithm$$, 31, $$display grid$$, $$display grid 학습$$, $$challenge$$, 2,
$$display grid을(를) 사용하여 문제를 해결하세요.$$,
$$- display grid 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* display grid 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["display grid의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-grid-template$$, $$css$$, $$algorithm$$, 32, $$grid-template$$, $$grid-template 학습$$, $$challenge$$, 2,
$$grid-template을(를) 사용하여 문제를 해결하세요.$$,
$$- grid-template 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* grid-template 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["grid-template의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-grid-gap$$, $$css$$, $$algorithm$$, 33, $$grid-gap$$, $$grid-gap 학습$$, $$challenge$$, 2,
$$grid-gap을(를) 사용하여 문제를 해결하세요.$$,
$$- grid-gap 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* grid-gap 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["grid-gap의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-grid-area$$, $$css$$, $$algorithm$$, 34, $$grid-area$$, $$grid-area 학습$$, $$challenge$$, 3,
$$grid-area을(를) 사용하여 문제를 해결하세요.$$,
$$- grid-area 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* grid-area 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["grid-area의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-fr-단위$$, $$css$$, $$algorithm$$, 35, $$fr 단위$$, $$fr 단위 학습$$, $$challenge$$, 3,
$$fr 단위을(를) 사용하여 문제를 해결하세요.$$,
$$- fr 단위 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fr 단위 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fr 단위의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-transition$$, $$css$$, $$algorithm$$, 36, $$transition$$, $$transition 학습$$, $$challenge$$, 3,
$$transition을(를) 사용하여 문제를 해결하세요.$$,
$$- transition 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* transition 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["transition의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-transform$$, $$css$$, $$algorithm$$, 37, $$transform$$, $$transform 학습$$, $$challenge$$, 3,
$$transform을(를) 사용하여 문제를 해결하세요.$$,
$$- transform 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* transform 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["transform의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-animation$$, $$css$$, $$algorithm$$, 38, $$animation$$, $$animation 학습$$, $$challenge$$, 3,
$$animation을(를) 사용하여 문제를 해결하세요.$$,
$$- animation 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* animation 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["animation의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-keyframes$$, $$css$$, $$algorithm$$, 39, $$keyframes$$, $$keyframes 학습$$, $$challenge$$, 3,
$$keyframes을(를) 사용하여 문제를 해결하세요.$$,
$$- keyframes 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* keyframes 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["keyframes의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-@keyframes$$, $$css$$, $$algorithm$$, 40, $$@keyframes$$, $$@keyframes 학습$$, $$challenge$$, 3,
$$@keyframes을(를) 사용하여 문제를 해결하세요.$$,
$$- @keyframes 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* @keyframes 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["@keyframes의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-media-query$$, $$css$$, $$algorithm$$, 41, $$media query$$, $$media query 학습$$, $$challenge$$, 3,
$$media query을(를) 사용하여 문제를 해결하세요.$$,
$$- media query 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* media query 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["media query의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-breakpoint$$, $$css$$, $$algorithm$$, 42, $$breakpoint$$, $$breakpoint 학습$$, $$challenge$$, 3,
$$breakpoint을(를) 사용하여 문제를 해결하세요.$$,
$$- breakpoint 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* breakpoint 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["breakpoint의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-viewport-단위$$, $$css$$, $$algorithm$$, 43, $$viewport 단위$$, $$viewport 단위 학습$$, $$challenge$$, 3,
$$viewport 단위을(를) 사용하여 문제를 해결하세요.$$,
$$- viewport 단위 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* viewport 단위 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["viewport 단위의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-rem-단위$$, $$css$$, $$algorithm$$, 44, $$rem 단위$$, $$rem 단위 학습$$, $$challenge$$, 3,
$$rem 단위을(를) 사용하여 문제를 해결하세요.$$,
$$- rem 단위 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* rem 단위 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["rem 단위의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-em-단위$$, $$css$$, $$algorithm$$, 45, $$em 단위$$, $$em 단위 학습$$, $$challenge$$, 3,
$$em 단위을(를) 사용하여 문제를 해결하세요.$$,
$$- em 단위 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* em 단위 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["em 단위의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-css-변수$$, $$css$$, $$algorithm$$, 46, $$CSS 변수$$, $$CSS 변수 학습$$, $$challenge$$, 3,
$$CSS 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- CSS 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CSS 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CSS 변수의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-calc()-계산$$, $$css$$, $$algorithm$$, 47, $$calc() 계산$$, $$calc() 계산 학습$$, $$challenge$$, 3,
$$calc() 계산을(를) 사용하여 문제를 해결하세요.$$,
$$- calc() 계산 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* calc() 계산 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["calc() 계산의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-filter-필터$$, $$css$$, $$algorithm$$, 48, $$filter 필터$$, $$filter 필터 학습$$, $$challenge$$, 3,
$$filter 필터을(를) 사용하여 문제를 해결하세요.$$,
$$- filter 필터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* filter 필터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["filter 필터의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-backdrop-filter$$, $$css$$, $$algorithm$$, 49, $$backdrop-filter$$, $$backdrop-filter 학습$$, $$challenge$$, 3,
$$backdrop-filter을(를) 사용하여 문제를 해결하세요.$$,
$$- backdrop-filter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* backdrop-filter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["backdrop-filter의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$css-custom-property$$, $$css$$, $$algorithm$$, 50, $$custom property$$, $$custom property 학습$$, $$challenge$$, 3,
$$custom property을(를) 사용하여 문제를 해결하세요.$$,
$$- custom property 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* custom property 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["custom property의 기본 사용법을 익히세요"]$$,
$$["css", "basics"]$$, 12);

-- ============================================================================
-- JAVASCRIPT Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-var-변수$$, $$javascript$$, $$syntax$$, 1, $$var 변수$$, $$var 변수 학습$$, $$challenge$$, 1,
$$var 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- var 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var 변수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-let-변수$$, $$javascript$$, $$syntax$$, 2, $$let 변수$$, $$let 변수 학습$$, $$challenge$$, 1,
$$let 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- let 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* let 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["let 변수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-const-상수$$, $$javascript$$, $$syntax$$, 3, $$const 상수$$, $$const 상수 학습$$, $$challenge$$, 1,
$$const 상수을(를) 사용하여 문제를 해결하세요.$$,
$$- const 상수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* const 상수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["const 상수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-string-타입$$, $$javascript$$, $$syntax$$, 4, $$string 타입$$, $$string 타입 학습$$, $$challenge$$, 1,
$$string 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- string 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string 타입의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-number-타입$$, $$javascript$$, $$syntax$$, 5, $$number 타입$$, $$number 타입 학습$$, $$challenge$$, 1,
$$number 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- number 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* number 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["number 타입의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-if-조건$$, $$javascript$$, $$syntax$$, 6, $$if 조건$$, $$if 조건 학습$$, $$challenge$$, 1,
$$if 조건을(를) 사용하여 문제를 해결하세요.$$,
$$- if 조건 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if 조건 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if 조건의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-else-조건$$, $$javascript$$, $$syntax$$, 7, $$else 조건$$, $$else 조건 학습$$, $$challenge$$, 1,
$$else 조건을(를) 사용하여 문제를 해결하세요.$$,
$$- else 조건 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* else 조건 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["else 조건의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-switch-문$$, $$javascript$$, $$syntax$$, 8, $$switch 문$$, $$switch 문 학습$$, $$challenge$$, 1,
$$switch 문을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 문 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 문 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch 문의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-for-반복$$, $$javascript$$, $$syntax$$, 9, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-while-반복$$, $$javascript$$, $$syntax$$, 10, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-function-함수$$, $$javascript$$, $$syntax$$, 11, $$function 함수$$, $$function 함수 학습$$, $$challenge$$, 1,
$$function 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- function 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* function 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["function 함수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-화살표-함수$$, $$javascript$$, $$syntax$$, 12, $$화살표 함수$$, $$화살표 함수 학습$$, $$challenge$$, 1,
$$화살표 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 화살표 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 화살표 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["화살표 함수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-매개변수$$, $$javascript$$, $$syntax$$, 13, $$매개변수$$, $$매개변수 학습$$, $$challenge$$, 1,
$$매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-반환값$$, $$javascript$$, $$syntax$$, 14, $$반환값$$, $$반환값 학습$$, $$challenge$$, 1,
$$반환값을(를) 사용하여 문제를 해결하세요.$$,
$$- 반환값 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 반환값 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["반환값의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-콜백-함수$$, $$javascript$$, $$syntax$$, 15, $$콜백 함수$$, $$콜백 함수 학습$$, $$challenge$$, 1,
$$콜백 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 콜백 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 콜백 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["콜백 함수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-배열-생성$$, $$javascript$$, $$syntax$$, 16, $$배열 생성$$, $$배열 생성 학습$$, $$challenge$$, 1,
$$배열 생성을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 생성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 생성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열 생성의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-push-추가$$, $$javascript$$, $$syntax$$, 17, $$push 추가$$, $$push 추가 학습$$, $$challenge$$, 1,
$$push 추가을(를) 사용하여 문제를 해결하세요.$$,
$$- push 추가 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* push 추가 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["push 추가의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-pop-제거$$, $$javascript$$, $$syntax$$, 18, $$pop 제거$$, $$pop 제거 학습$$, $$challenge$$, 2,
$$pop 제거을(를) 사용하여 문제를 해결하세요.$$,
$$- pop 제거 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* pop 제거 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["pop 제거의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-map-변환$$, $$javascript$$, $$syntax$$, 19, $$map 변환$$, $$map 변환 학습$$, $$challenge$$, 2,
$$map 변환을(를) 사용하여 문제를 해결하세요.$$,
$$- map 변환 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* map 변환 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["map 변환의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-filter-필터$$, $$javascript$$, $$syntax$$, 20, $$filter 필터$$, $$filter 필터 학습$$, $$challenge$$, 2,
$$filter 필터을(를) 사용하여 문제를 해결하세요.$$,
$$- filter 필터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* filter 필터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["filter 필터의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-객체-생성$$, $$javascript$$, $$syntax$$, 21, $$객체 생성$$, $$객체 생성 학습$$, $$challenge$$, 2,
$$객체 생성을(를) 사용하여 문제를 해결하세요.$$,
$$- 객체 생성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 객체 생성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["객체 생성의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-속성-접근$$, $$javascript$$, $$syntax$$, 22, $$속성 접근$$, $$속성 접근 학습$$, $$challenge$$, 2,
$$속성 접근을(를) 사용하여 문제를 해결하세요.$$,
$$- 속성 접근 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 속성 접근 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["속성 접근의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-메서드$$, $$javascript$$, $$syntax$$, 23, $$메서드$$, $$메서드 학습$$, $$challenge$$, 2,
$$메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-구조분해$$, $$javascript$$, $$syntax$$, 24, $$구조분해$$, $$구조분해 학습$$, $$challenge$$, 2,
$$구조분해을(를) 사용하여 문제를 해결하세요.$$,
$$- 구조분해 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 구조분해 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["구조분해의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-spread-연산자$$, $$javascript$$, $$syntax$$, 25, $$spread 연산자$$, $$spread 연산자 학습$$, $$challenge$$, 2,
$$spread 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- spread 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* spread 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["spread 연산자의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-queryselector$$, $$javascript$$, $$algorithm$$, 26, $$querySelector$$, $$querySelector 학습$$, $$challenge$$, 2,
$$querySelector을(를) 사용하여 문제를 해결하세요.$$,
$$- querySelector 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* querySelector 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["querySelector의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-innerhtml$$, $$javascript$$, $$algorithm$$, 27, $$innerHTML$$, $$innerHTML 학습$$, $$challenge$$, 2,
$$innerHTML을(를) 사용하여 문제를 해결하세요.$$,
$$- innerHTML 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* innerHTML 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["innerHTML의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-addeventlistener$$, $$javascript$$, $$algorithm$$, 28, $$addEventListener$$, $$addEventListener 학습$$, $$challenge$$, 2,
$$addEventListener을(를) 사용하여 문제를 해결하세요.$$,
$$- addEventListener 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* addEventListener 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["addEventListener의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-classlist$$, $$javascript$$, $$algorithm$$, 29, $$classList$$, $$classList 학습$$, $$challenge$$, 2,
$$classList을(를) 사용하여 문제를 해결하세요.$$,
$$- classList 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* classList 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["classList의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-createelement$$, $$javascript$$, $$algorithm$$, 30, $$createElement$$, $$createElement 학습$$, $$challenge$$, 2,
$$createElement을(를) 사용하여 문제를 해결하세요.$$,
$$- createElement 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* createElement 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["createElement의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-settimeout$$, $$javascript$$, $$algorithm$$, 31, $$setTimeout$$, $$setTimeout 학습$$, $$challenge$$, 2,
$$setTimeout을(를) 사용하여 문제를 해결하세요.$$,
$$- setTimeout 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* setTimeout 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["setTimeout의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-promise$$, $$javascript$$, $$algorithm$$, 32, $$Promise$$, $$Promise 학습$$, $$challenge$$, 2,
$$Promise을(를) 사용하여 문제를 해결하세요.$$,
$$- Promise 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Promise 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Promise의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-async$$, $$javascript$$, $$algorithm$$, 33, $$async$$, $$async 학습$$, $$challenge$$, 2,
$$async을(를) 사용하여 문제를 해결하세요.$$,
$$- async 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* async 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["async의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-await$$, $$javascript$$, $$algorithm$$, 34, $$await$$, $$await 학습$$, $$challenge$$, 3,
$$await을(를) 사용하여 문제를 해결하세요.$$,
$$- await 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* await 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["await의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-fetch$$, $$javascript$$, $$algorithm$$, 35, $$fetch$$, $$fetch 학습$$, $$challenge$$, 3,
$$fetch을(를) 사용하여 문제를 해결하세요.$$,
$$- fetch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fetch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fetch의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-템플릿-리터럴$$, $$javascript$$, $$algorithm$$, 36, $$템플릿 리터럴$$, $$템플릿 리터럴 학습$$, $$challenge$$, 3,
$$템플릿 리터럴을(를) 사용하여 문제를 해결하세요.$$,
$$- 템플릿 리터럴 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 템플릿 리터럴 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["템플릿 리터럴의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-기본-매개변수$$, $$javascript$$, $$algorithm$$, 37, $$기본 매개변수$$, $$기본 매개변수 학습$$, $$challenge$$, 3,
$$기본 매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본 매개변수의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-rest-파라미터$$, $$javascript$$, $$algorithm$$, 38, $$rest 파라미터$$, $$rest 파라미터 학습$$, $$challenge$$, 3,
$$rest 파라미터을(를) 사용하여 문제를 해결하세요.$$,
$$- rest 파라미터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* rest 파라미터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["rest 파라미터의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-옵셔널-체이닝$$, $$javascript$$, $$algorithm$$, 39, $$옵셔널 체이닝$$, $$옵셔널 체이닝 학습$$, $$challenge$$, 3,
$$옵셔널 체이닝을(를) 사용하여 문제를 해결하세요.$$,
$$- 옵셔널 체이닝 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 옵셔널 체이닝 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["옵셔널 체이닝의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-nullish-병합$$, $$javascript$$, $$algorithm$$, 40, $$nullish 병합$$, $$nullish 병합 학습$$, $$challenge$$, 3,
$$nullish 병합을(를) 사용하여 문제를 해결하세요.$$,
$$- nullish 병합 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nullish 병합 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nullish 병합의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-try-catch$$, $$javascript$$, $$algorithm$$, 41, $$try-catch$$, $$try-catch 학습$$, $$challenge$$, 3,
$$try-catch을(를) 사용하여 문제를 해결하세요.$$,
$$- try-catch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* try-catch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["try-catch의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-throw$$, $$javascript$$, $$algorithm$$, 42, $$throw$$, $$throw 학습$$, $$challenge$$, 3,
$$throw을(를) 사용하여 문제를 해결하세요.$$,
$$- throw 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* throw 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["throw의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-error-객체$$, $$javascript$$, $$algorithm$$, 43, $$Error 객체$$, $$Error 객체 학습$$, $$challenge$$, 3,
$$Error 객체을(를) 사용하여 문제를 해결하세요.$$,
$$- Error 객체 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Error 객체 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Error 객체의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-finally$$, $$javascript$$, $$algorithm$$, 44, $$finally$$, $$finally 학습$$, $$challenge$$, 3,
$$finally을(를) 사용하여 문제를 해결하세요.$$,
$$- finally 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* finally 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["finally의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-커스텀-에러$$, $$javascript$$, $$algorithm$$, 45, $$커스텀 에러$$, $$커스텀 에러 학습$$, $$challenge$$, 3,
$$커스텀 에러을(를) 사용하여 문제를 해결하세요.$$,
$$- 커스텀 에러 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 커스텀 에러 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["커스텀 에러의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-클로저$$, $$javascript$$, $$algorithm$$, 46, $$클로저$$, $$클로저 학습$$, $$challenge$$, 3,
$$클로저을(를) 사용하여 문제를 해결하세요.$$,
$$- 클로저 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 클로저 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["클로저의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-this-키워드$$, $$javascript$$, $$algorithm$$, 47, $$this 키워드$$, $$this 키워드 학습$$, $$challenge$$, 3,
$$this 키워드을(를) 사용하여 문제를 해결하세요.$$,
$$- this 키워드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* this 키워드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["this 키워드의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-prototype$$, $$javascript$$, $$algorithm$$, 48, $$prototype$$, $$prototype 학습$$, $$challenge$$, 3,
$$prototype을(를) 사용하여 문제를 해결하세요.$$,
$$- prototype 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* prototype 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["prototype의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-class-문법$$, $$javascript$$, $$algorithm$$, 49, $$class 문법$$, $$class 문법 학습$$, $$challenge$$, 3,
$$class 문법을(를) 사용하여 문제를 해결하세요.$$,
$$- class 문법 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 문법 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class 문법의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$javascript-extends-상속$$, $$javascript$$, $$algorithm$$, 50, $$extends 상속$$, $$extends 상속 학습$$, $$challenge$$, 3,
$$extends 상속을(를) 사용하여 문제를 해결하세요.$$,
$$- extends 상속 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extends 상속 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extends 상속의 기본 사용법을 익히세요"]$$,
$$["javascript", "basics"]$$, 12);

-- ============================================================================
-- TYPESCRIPT Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-string-타입$$, $$typescript$$, $$syntax$$, 1, $$string 타입$$, $$string 타입 학습$$, $$challenge$$, 1,
$$string 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- string 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-number-타입$$, $$typescript$$, $$syntax$$, 2, $$number 타입$$, $$number 타입 학습$$, $$challenge$$, 1,
$$number 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- number 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* number 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["number 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-boolean-타입$$, $$typescript$$, $$syntax$$, 3, $$boolean 타입$$, $$boolean 타입 학습$$, $$challenge$$, 1,
$$boolean 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- boolean 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* boolean 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["boolean 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-any-타입$$, $$typescript$$, $$syntax$$, 4, $$any 타입$$, $$any 타입 학습$$, $$challenge$$, 1,
$$any 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- any 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* any 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["any 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-unknown-타입$$, $$typescript$$, $$syntax$$, 5, $$unknown 타입$$, $$unknown 타입 학습$$, $$challenge$$, 1,
$$unknown 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- unknown 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* unknown 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["unknown 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-변수-타입$$, $$typescript$$, $$syntax$$, 6, $$변수 타입$$, $$변수 타입 학습$$, $$challenge$$, 1,
$$변수 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 변수 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 변수 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["변수 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-함수-타입$$, $$typescript$$, $$syntax$$, 7, $$함수 타입$$, $$함수 타입 학습$$, $$challenge$$, 1,
$$함수 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-배열-타입$$, $$typescript$$, $$syntax$$, 8, $$배열 타입$$, $$배열 타입 학습$$, $$challenge$$, 1,
$$배열 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-튜플-타입$$, $$typescript$$, $$syntax$$, 9, $$튜플 타입$$, $$튜플 타입 학습$$, $$challenge$$, 1,
$$튜플 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 튜플 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 튜플 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["튜플 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-enum-열거형$$, $$typescript$$, $$syntax$$, 10, $$enum 열거형$$, $$enum 열거형 학습$$, $$challenge$$, 1,
$$enum 열거형을(를) 사용하여 문제를 해결하세요.$$,
$$- enum 열거형 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* enum 열거형 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["enum 열거형의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-interface-정의$$, $$typescript$$, $$syntax$$, 11, $$interface 정의$$, $$interface 정의 학습$$, $$challenge$$, 1,
$$interface 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- interface 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* interface 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["interface 정의의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-옵셔널-속성$$, $$typescript$$, $$syntax$$, 12, $$옵셔널 속성$$, $$옵셔널 속성 학습$$, $$challenge$$, 1,
$$옵셔널 속성을(를) 사용하여 문제를 해결하세요.$$,
$$- 옵셔널 속성 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 옵셔널 속성 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["옵셔널 속성의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-readonly$$, $$typescript$$, $$syntax$$, 13, $$readonly$$, $$readonly 학습$$, $$challenge$$, 1,
$$readonly을(를) 사용하여 문제를 해결하세요.$$,
$$- readonly 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* readonly 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["readonly의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-인덱스-시그니처$$, $$typescript$$, $$syntax$$, 14, $$인덱스 시그니처$$, $$인덱스 시그니처 학습$$, $$challenge$$, 1,
$$인덱스 시그니처을(를) 사용하여 문제를 해결하세요.$$,
$$- 인덱스 시그니처 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 인덱스 시그니처 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["인덱스 시그니처의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-extends$$, $$typescript$$, $$syntax$$, 15, $$extends$$, $$extends 학습$$, $$challenge$$, 1,
$$extends을(를) 사용하여 문제를 해결하세요.$$,
$$- extends 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extends 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extends의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-type-선언$$, $$typescript$$, $$syntax$$, 16, $$type 선언$$, $$type 선언 학습$$, $$challenge$$, 1,
$$type 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- type 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* type 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["type 선언의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-유니온-타입$$, $$typescript$$, $$syntax$$, 17, $$유니온 타입$$, $$유니온 타입 학습$$, $$challenge$$, 1,
$$유니온 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 유니온 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 유니온 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["유니온 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-인터섹션-타입$$, $$typescript$$, $$syntax$$, 18, $$인터섹션 타입$$, $$인터섹션 타입 학습$$, $$challenge$$, 2,
$$인터섹션 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 인터섹션 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 인터섹션 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["인터섹션 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-리터럴-타입$$, $$typescript$$, $$syntax$$, 19, $$리터럴 타입$$, $$리터럴 타입 학습$$, $$challenge$$, 2,
$$리터럴 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 리터럴 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 리터럴 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["리터럴 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-typeof$$, $$typescript$$, $$syntax$$, 20, $$typeof$$, $$typeof 학습$$, $$challenge$$, 2,
$$typeof을(를) 사용하여 문제를 해결하세요.$$,
$$- typeof 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* typeof 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["typeof의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-제네릭-함수$$, $$typescript$$, $$syntax$$, 21, $$제네릭 함수$$, $$제네릭 함수 학습$$, $$challenge$$, 2,
$$제네릭 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 함수의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-제네릭-인터페이스$$, $$typescript$$, $$syntax$$, 22, $$제네릭 인터페이스$$, $$제네릭 인터페이스 학습$$, $$challenge$$, 2,
$$제네릭 인터페이스을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 인터페이스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 인터페이스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 인터페이스의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-제네릭-클래스$$, $$typescript$$, $$syntax$$, 23, $$제네릭 클래스$$, $$제네릭 클래스 학습$$, $$challenge$$, 2,
$$제네릭 클래스을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 클래스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 클래스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 클래스의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-타입-제약$$, $$typescript$$, $$syntax$$, 24, $$타입 제약$$, $$타입 제약 학습$$, $$challenge$$, 2,
$$타입 제약을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 제약 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 제약 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 제약의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-기본-타입$$, $$typescript$$, $$syntax$$, 25, $$기본 타입$$, $$기본 타입 학습$$, $$challenge$$, 2,
$$기본 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-class-선언$$, $$typescript$$, $$algorithm$$, 26, $$class 선언$$, $$class 선언 학습$$, $$challenge$$, 2,
$$class 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- class 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class 선언의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-constructor$$, $$typescript$$, $$algorithm$$, 27, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-public$$, $$typescript$$, $$algorithm$$, 28, $$public$$, $$public 학습$$, $$challenge$$, 2,
$$public을(를) 사용하여 문제를 해결하세요.$$,
$$- public 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* public 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["public의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-private$$, $$typescript$$, $$algorithm$$, 29, $$private$$, $$private 학습$$, $$challenge$$, 2,
$$private을(를) 사용하여 문제를 해결하세요.$$,
$$- private 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* private 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["private의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-protected$$, $$typescript$$, $$algorithm$$, 30, $$protected$$, $$protected 학습$$, $$challenge$$, 2,
$$protected을(를) 사용하여 문제를 해결하세요.$$,
$$- protected 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* protected 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["protected의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-조건부-타입$$, $$typescript$$, $$algorithm$$, 31, $$조건부 타입$$, $$조건부 타입 학습$$, $$challenge$$, 2,
$$조건부 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 조건부 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 조건부 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["조건부 타입의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-mapped-types$$, $$typescript$$, $$algorithm$$, 32, $$Mapped Types$$, $$Mapped Types 학습$$, $$challenge$$, 2,
$$Mapped Types을(를) 사용하여 문제를 해결하세요.$$,
$$- Mapped Types 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Mapped Types 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Mapped Types의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-utility-types$$, $$typescript$$, $$algorithm$$, 33, $$Utility Types$$, $$Utility Types 학습$$, $$challenge$$, 2,
$$Utility Types을(를) 사용하여 문제를 해결하세요.$$,
$$- Utility Types 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Utility Types 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Utility Types의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-keyof$$, $$typescript$$, $$algorithm$$, 34, $$keyof$$, $$keyof 학습$$, $$challenge$$, 3,
$$keyof을(를) 사용하여 문제를 해결하세요.$$,
$$- keyof 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* keyof 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["keyof의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-infer$$, $$typescript$$, $$algorithm$$, 35, $$infer$$, $$infer 학습$$, $$challenge$$, 3,
$$infer을(를) 사용하여 문제를 해결하세요.$$,
$$- infer 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* infer 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["infer의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-import$$, $$typescript$$, $$algorithm$$, 36, $$import$$, $$import 학습$$, $$challenge$$, 3,
$$import을(를) 사용하여 문제를 해결하세요.$$,
$$- import 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* import 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["import의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-export$$, $$typescript$$, $$algorithm$$, 37, $$export$$, $$export 학습$$, $$challenge$$, 3,
$$export을(를) 사용하여 문제를 해결하세요.$$,
$$- export 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* export 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["export의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-namespace$$, $$typescript$$, $$algorithm$$, 38, $$namespace$$, $$namespace 학습$$, $$challenge$$, 3,
$$namespace을(를) 사용하여 문제를 해결하세요.$$,
$$- namespace 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* namespace 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["namespace의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-선언-파일$$, $$typescript$$, $$algorithm$$, 39, $$선언 파일$$, $$선언 파일 학습$$, $$challenge$$, 3,
$$선언 파일을(를) 사용하여 문제를 해결하세요.$$,
$$- 선언 파일 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 선언 파일 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["선언 파일의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-tsconfig$$, $$typescript$$, $$algorithm$$, 40, $$tsconfig$$, $$tsconfig 학습$$, $$challenge$$, 3,
$$tsconfig을(를) 사용하여 문제를 해결하세요.$$,
$$- tsconfig 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* tsconfig 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["tsconfig의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-클래스-데코레이터$$, $$typescript$$, $$algorithm$$, 41, $$클래스 데코레이터$$, $$클래스 데코레이터 학습$$, $$challenge$$, 3,
$$클래스 데코레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 클래스 데코레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 클래스 데코레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["클래스 데코레이터의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-메서드-데코레이터$$, $$typescript$$, $$algorithm$$, 42, $$메서드 데코레이터$$, $$메서드 데코레이터 학습$$, $$challenge$$, 3,
$$메서드 데코레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 데코레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 데코레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드 데코레이터의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-속성-데코레이터$$, $$typescript$$, $$algorithm$$, 43, $$속성 데코레이터$$, $$속성 데코레이터 학습$$, $$challenge$$, 3,
$$속성 데코레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 속성 데코레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 속성 데코레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["속성 데코레이터의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-매개변수-데코레이터$$, $$typescript$$, $$algorithm$$, 44, $$매개변수 데코레이터$$, $$매개변수 데코레이터 학습$$, $$challenge$$, 3,
$$매개변수 데코레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 데코레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 데코레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수 데코레이터의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-메타데이터$$, $$typescript$$, $$algorithm$$, 45, $$메타데이터$$, $$메타데이터 학습$$, $$challenge$$, 3,
$$메타데이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 메타데이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메타데이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메타데이터의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-partial$$, $$typescript$$, $$algorithm$$, 46, $$Partial$$, $$Partial 학습$$, $$challenge$$, 3,
$$Partial을(를) 사용하여 문제를 해결하세요.$$,
$$- Partial 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Partial 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Partial의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-required$$, $$typescript$$, $$algorithm$$, 47, $$Required$$, $$Required 학습$$, $$challenge$$, 3,
$$Required을(를) 사용하여 문제를 해결하세요.$$,
$$- Required 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Required 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Required의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-pick$$, $$typescript$$, $$algorithm$$, 48, $$Pick$$, $$Pick 학습$$, $$challenge$$, 3,
$$Pick을(를) 사용하여 문제를 해결하세요.$$,
$$- Pick 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Pick 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Pick의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-omit$$, $$typescript$$, $$algorithm$$, 49, $$Omit$$, $$Omit 학습$$, $$challenge$$, 3,
$$Omit을(를) 사용하여 문제를 해결하세요.$$,
$$- Omit 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Omit 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Omit의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$typescript-record$$, $$typescript$$, $$algorithm$$, 50, $$Record$$, $$Record 학습$$, $$challenge$$, 3,
$$Record을(를) 사용하여 문제를 해결하세요.$$,
$$- Record 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Record 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Record의 기본 사용법을 익히세요"]$$,
$$["typescript", "basics"]$$, 12);

-- ============================================================================
-- PYTHON Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-변수-선언$$, $$python$$, $$syntax$$, 1, $$변수 선언$$, $$변수 선언 학습$$, $$challenge$$, 1,
$$변수 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- 변수 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 변수 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["변수 선언의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-print-출력$$, $$python$$, $$syntax$$, 2, $$print 출력$$, $$print 출력 학습$$, $$challenge$$, 1,
$$print 출력을(를) 사용하여 문제를 해결하세요.$$,
$$- print 출력 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* print 출력 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["print 출력의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-input-입력$$, $$python$$, $$syntax$$, 3, $$input 입력$$, $$input 입력 학습$$, $$challenge$$, 1,
$$input 입력을(를) 사용하여 문제를 해결하세요.$$,
$$- input 입력 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* input 입력 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["input 입력의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-데이터-타입$$, $$python$$, $$syntax$$, 4, $$데이터 타입$$, $$데이터 타입 학습$$, $$challenge$$, 1,
$$데이터 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- 데이터 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 데이터 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["데이터 타입의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-연산자$$, $$python$$, $$syntax$$, 5, $$연산자$$, $$연산자 학습$$, $$challenge$$, 1,
$$연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["연산자의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-if-조건$$, $$python$$, $$syntax$$, 6, $$if 조건$$, $$if 조건 학습$$, $$challenge$$, 1,
$$if 조건을(를) 사용하여 문제를 해결하세요.$$,
$$- if 조건 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if 조건 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if 조건의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-elif$$, $$python$$, $$syntax$$, 7, $$elif$$, $$elif 학습$$, $$challenge$$, 1,
$$elif을(를) 사용하여 문제를 해결하세요.$$,
$$- elif 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* elif 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["elif의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-else$$, $$python$$, $$syntax$$, 8, $$else$$, $$else 학습$$, $$challenge$$, 1,
$$else을(를) 사용하여 문제를 해결하세요.$$,
$$- else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["else의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-for-반복$$, $$python$$, $$syntax$$, 9, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-while-반복$$, $$python$$, $$syntax$$, 10, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-def-함수$$, $$python$$, $$syntax$$, 11, $$def 함수$$, $$def 함수 학습$$, $$challenge$$, 1,
$$def 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- def 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* def 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["def 함수의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-매개변수$$, $$python$$, $$syntax$$, 12, $$매개변수$$, $$매개변수 학습$$, $$challenge$$, 1,
$$매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-return$$, $$python$$, $$syntax$$, 13, $$return$$, $$return 학습$$, $$challenge$$, 1,
$$return을(를) 사용하여 문제를 해결하세요.$$,
$$- return 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* return 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["return의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-람다-함수$$, $$python$$, $$syntax$$, 14, $$람다 함수$$, $$람다 함수 학습$$, $$challenge$$, 1,
$$람다 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 람다 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 람다 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["람다 함수의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-기본값$$, $$python$$, $$syntax$$, 15, $$기본값$$, $$기본값 학습$$, $$challenge$$, 1,
$$기본값을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본값 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본값 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본값의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-list-리스트$$, $$python$$, $$syntax$$, 16, $$list 리스트$$, $$list 리스트 학습$$, $$challenge$$, 1,
$$list 리스트을(를) 사용하여 문제를 해결하세요.$$,
$$- list 리스트 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* list 리스트 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["list 리스트의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-tuple-튜플$$, $$python$$, $$syntax$$, 17, $$tuple 튜플$$, $$tuple 튜플 학습$$, $$challenge$$, 1,
$$tuple 튜플을(를) 사용하여 문제를 해결하세요.$$,
$$- tuple 튜플 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* tuple 튜플 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["tuple 튜플의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-dict-딕셔너리$$, $$python$$, $$syntax$$, 18, $$dict 딕셔너리$$, $$dict 딕셔너리 학습$$, $$challenge$$, 2,
$$dict 딕셔너리을(를) 사용하여 문제를 해결하세요.$$,
$$- dict 딕셔너리 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* dict 딕셔너리 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["dict 딕셔너리의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-set-세트$$, $$python$$, $$syntax$$, 19, $$set 세트$$, $$set 세트 학습$$, $$challenge$$, 2,
$$set 세트을(를) 사용하여 문제를 해결하세요.$$,
$$- set 세트 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* set 세트 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["set 세트의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-리스트-컴프리헨션$$, $$python$$, $$syntax$$, 20, $$리스트 컴프리헨션$$, $$리스트 컴프리헨션 학습$$, $$challenge$$, 2,
$$리스트 컴프리헨션을(를) 사용하여 문제를 해결하세요.$$,
$$- 리스트 컴프리헨션 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 리스트 컴프리헨션 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["리스트 컴프리헨션의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-문자열-연산$$, $$python$$, $$syntax$$, 21, $$문자열 연산$$, $$문자열 연산 학습$$, $$challenge$$, 2,
$$문자열 연산을(를) 사용하여 문제를 해결하세요.$$,
$$- 문자열 연산 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 문자열 연산 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["문자열 연산의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-슬라이싱$$, $$python$$, $$syntax$$, 22, $$슬라이싱$$, $$슬라이싱 학습$$, $$challenge$$, 2,
$$슬라이싱을(를) 사용하여 문제를 해결하세요.$$,
$$- 슬라이싱 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 슬라이싱 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["슬라이싱의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-format$$, $$python$$, $$syntax$$, 23, $$format$$, $$format 학습$$, $$challenge$$, 2,
$$format을(를) 사용하여 문제를 해결하세요.$$,
$$- format 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* format 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["format의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-f-string$$, $$python$$, $$syntax$$, 24, $$f-string$$, $$f-string 학습$$, $$challenge$$, 2,
$$f-string을(를) 사용하여 문제를 해결하세요.$$,
$$- f-string 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* f-string 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["f-string의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-문자열-메서드$$, $$python$$, $$syntax$$, 25, $$문자열 메서드$$, $$문자열 메서드 학습$$, $$challenge$$, 2,
$$문자열 메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 문자열 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 문자열 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["문자열 메서드의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-import$$, $$python$$, $$algorithm$$, 26, $$import$$, $$import 학습$$, $$challenge$$, 2,
$$import을(를) 사용하여 문제를 해결하세요.$$,
$$- import 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* import 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["import의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-from-import$$, $$python$$, $$algorithm$$, 27, $$from import$$, $$from import 학습$$, $$challenge$$, 2,
$$from import을(를) 사용하여 문제를 해결하세요.$$,
$$- from import 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* from import 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["from import의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-표준-라이브러리$$, $$python$$, $$algorithm$$, 28, $$표준 라이브러리$$, $$표준 라이브러리 학습$$, $$challenge$$, 2,
$$표준 라이브러리을(를) 사용하여 문제를 해결하세요.$$,
$$- 표준 라이브러리 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 표준 라이브러리 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["표준 라이브러리의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-__name__$$, $$python$$, $$algorithm$$, 29, $$__name__$$, $$__name__ 학습$$, $$challenge$$, 2,
$$__name__을(를) 사용하여 문제를 해결하세요.$$,
$$- __name__ 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* __name__ 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["__name__의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-pip$$, $$python$$, $$algorithm$$, 30, $$pip$$, $$pip 학습$$, $$challenge$$, 2,
$$pip을(를) 사용하여 문제를 해결하세요.$$,
$$- pip 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* pip 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["pip의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-open-파일$$, $$python$$, $$algorithm$$, 31, $$open 파일$$, $$open 파일 학습$$, $$challenge$$, 2,
$$open 파일을(를) 사용하여 문제를 해결하세요.$$,
$$- open 파일 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* open 파일 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["open 파일의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-read-읽기$$, $$python$$, $$algorithm$$, 32, $$read 읽기$$, $$read 읽기 학습$$, $$challenge$$, 2,
$$read 읽기을(를) 사용하여 문제를 해결하세요.$$,
$$- read 읽기 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* read 읽기 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["read 읽기의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-write-쓰기$$, $$python$$, $$algorithm$$, 33, $$write 쓰기$$, $$write 쓰기 학습$$, $$challenge$$, 2,
$$write 쓰기을(를) 사용하여 문제를 해결하세요.$$,
$$- write 쓰기 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* write 쓰기 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["write 쓰기의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-with-문$$, $$python$$, $$algorithm$$, 34, $$with 문$$, $$with 문 학습$$, $$challenge$$, 3,
$$with 문을(를) 사용하여 문제를 해결하세요.$$,
$$- with 문 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* with 문 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["with 문의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-json$$, $$python$$, $$algorithm$$, 35, $$json$$, $$json 학습$$, $$challenge$$, 3,
$$json을(를) 사용하여 문제를 해결하세요.$$,
$$- json 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* json 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["json의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-class-정의$$, $$python$$, $$algorithm$$, 36, $$class 정의$$, $$class 정의 학습$$, $$challenge$$, 3,
$$class 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- class 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class 정의의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-__init__$$, $$python$$, $$algorithm$$, 37, $$__init__$$, $$__init__ 학습$$, $$challenge$$, 3,
$$__init__을(를) 사용하여 문제를 해결하세요.$$,
$$- __init__ 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* __init__ 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["__init__의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-메서드$$, $$python$$, $$algorithm$$, 38, $$메서드$$, $$메서드 학습$$, $$challenge$$, 3,
$$메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-상속$$, $$python$$, $$algorithm$$, 39, $$상속$$, $$상속 학습$$, $$challenge$$, 3,
$$상속을(를) 사용하여 문제를 해결하세요.$$,
$$- 상속 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 상속 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["상속의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-__str__$$, $$python$$, $$algorithm$$, 40, $$__str__$$, $$__str__ 학습$$, $$challenge$$, 3,
$$__str__을(를) 사용하여 문제를 해결하세요.$$,
$$- __str__ 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* __str__ 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["__str__의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-try$$, $$python$$, $$algorithm$$, 41, $$try$$, $$try 학습$$, $$challenge$$, 3,
$$try을(를) 사용하여 문제를 해결하세요.$$,
$$- try 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* try 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["try의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-except$$, $$python$$, $$algorithm$$, 42, $$except$$, $$except 학습$$, $$challenge$$, 3,
$$except을(를) 사용하여 문제를 해결하세요.$$,
$$- except 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* except 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["except의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-raise$$, $$python$$, $$algorithm$$, 43, $$raise$$, $$raise 학습$$, $$challenge$$, 3,
$$raise을(를) 사용하여 문제를 해결하세요.$$,
$$- raise 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* raise 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["raise의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-finally$$, $$python$$, $$algorithm$$, 44, $$finally$$, $$finally 학습$$, $$challenge$$, 3,
$$finally을(를) 사용하여 문제를 해결하세요.$$,
$$- finally 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* finally 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["finally의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-else$$, $$python$$, $$algorithm$$, 45, $$else$$, $$else 학습$$, $$challenge$$, 3,
$$else을(를) 사용하여 문제를 해결하세요.$$,
$$- else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["else의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-데코레이터$$, $$python$$, $$algorithm$$, 46, $$데코레이터$$, $$데코레이터 학습$$, $$challenge$$, 3,
$$데코레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 데코레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 데코레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["데코레이터의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-제너레이터$$, $$python$$, $$algorithm$$, 47, $$제너레이터$$, $$제너레이터 학습$$, $$challenge$$, 3,
$$제너레이터을(를) 사용하여 문제를 해결하세요.$$,
$$- 제너레이터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제너레이터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제너레이터의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-yield$$, $$python$$, $$algorithm$$, 48, $$yield$$, $$yield 학습$$, $$challenge$$, 3,
$$yield을(를) 사용하여 문제를 해결하세요.$$,
$$- yield 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* yield 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["yield의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-itertools$$, $$python$$, $$algorithm$$, 49, $$itertools$$, $$itertools 학습$$, $$challenge$$, 3,
$$itertools을(를) 사용하여 문제를 해결하세요.$$,
$$- itertools 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* itertools 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["itertools의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$python-collections$$, $$python$$, $$algorithm$$, 50, $$collections$$, $$collections 학습$$, $$challenge$$, 3,
$$collections을(를) 사용하여 문제를 해결하세요.$$,
$$- collections 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* collections 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["collections의 기본 사용법을 익히세요"]$$,
$$["python", "basics"]$$, 12);

-- ============================================================================
-- DART Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-var-변수$$, $$dart$$, $$syntax$$, 1, $$var 변수$$, $$var 변수 학습$$, $$challenge$$, 1,
$$var 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- var 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var 변수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-final$$, $$dart$$, $$syntax$$, 2, $$final$$, $$final 학습$$, $$challenge$$, 1,
$$final을(를) 사용하여 문제를 해결하세요.$$,
$$- final 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* final 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["final의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-const$$, $$dart$$, $$syntax$$, 3, $$const$$, $$const 학습$$, $$challenge$$, 1,
$$const을(를) 사용하여 문제를 해결하세요.$$,
$$- const 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* const 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["const의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-int-타입$$, $$dart$$, $$syntax$$, 4, $$int 타입$$, $$int 타입 학습$$, $$challenge$$, 1,
$$int 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- int 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 타입의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-string-타입$$, $$dart$$, $$syntax$$, 5, $$String 타입$$, $$String 타입 학습$$, $$challenge$$, 1,
$$String 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- String 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* String 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["String 타입의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-if-else$$, $$dart$$, $$syntax$$, 6, $$if-else$$, $$if-else 학습$$, $$challenge$$, 1,
$$if-else을(를) 사용하여 문제를 해결하세요.$$,
$$- if-else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if-else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if-else의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-switch$$, $$dart$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-for-반복$$, $$dart$$, $$syntax$$, 8, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-while-반복$$, $$dart$$, $$syntax$$, 9, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-break$$, $$dart$$, $$syntax$$, 10, $$break$$, $$break 학습$$, $$challenge$$, 1,
$$break을(를) 사용하여 문제를 해결하세요.$$,
$$- break 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* break 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["break의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-함수-선언$$, $$dart$$, $$syntax$$, 11, $$함수 선언$$, $$함수 선언 학습$$, $$challenge$$, 1,
$$함수 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 선언의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-화살표-함수$$, $$dart$$, $$syntax$$, 12, $$화살표 함수$$, $$화살표 함수 학습$$, $$challenge$$, 1,
$$화살표 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 화살표 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 화살표 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["화살표 함수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-선택적-매개변수$$, $$dart$$, $$syntax$$, 13, $$선택적 매개변수$$, $$선택적 매개변수 학습$$, $$challenge$$, 1,
$$선택적 매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 선택적 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 선택적 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["선택적 매개변수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-명명된-매개변수$$, $$dart$$, $$syntax$$, 14, $$명명된 매개변수$$, $$명명된 매개변수 학습$$, $$challenge$$, 1,
$$명명된 매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 명명된 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 명명된 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["명명된 매개변수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-익명-함수$$, $$dart$$, $$syntax$$, 15, $$익명 함수$$, $$익명 함수 학습$$, $$challenge$$, 1,
$$익명 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 익명 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 익명 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["익명 함수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-list$$, $$dart$$, $$syntax$$, 16, $$List$$, $$List 학습$$, $$challenge$$, 1,
$$List을(를) 사용하여 문제를 해결하세요.$$,
$$- List 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* List 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["List의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-set$$, $$dart$$, $$syntax$$, 17, $$Set$$, $$Set 학습$$, $$challenge$$, 1,
$$Set을(를) 사용하여 문제를 해결하세요.$$,
$$- Set 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Set 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Set의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-map$$, $$dart$$, $$syntax$$, 18, $$Map$$, $$Map 학습$$, $$challenge$$, 2,
$$Map을(를) 사용하여 문제를 해결하세요.$$,
$$- Map 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Map 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Map의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-spread$$, $$dart$$, $$syntax$$, 19, $$spread$$, $$spread 학습$$, $$challenge$$, 2,
$$spread을(를) 사용하여 문제를 해결하세요.$$,
$$- spread 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* spread 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["spread의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-collection-if$$, $$dart$$, $$syntax$$, 20, $$collection if$$, $$collection if 학습$$, $$challenge$$, 2,
$$collection if을(를) 사용하여 문제를 해결하세요.$$,
$$- collection if 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* collection if 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["collection if의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-class-정의$$, $$dart$$, $$syntax$$, 21, $$class 정의$$, $$class 정의 학습$$, $$challenge$$, 2,
$$class 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- class 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class 정의의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-constructor$$, $$dart$$, $$syntax$$, 22, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-getter$$, $$dart$$, $$syntax$$, 23, $$getter$$, $$getter 학습$$, $$challenge$$, 2,
$$getter을(를) 사용하여 문제를 해결하세요.$$,
$$- getter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* getter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["getter의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-setter$$, $$dart$$, $$syntax$$, 24, $$setter$$, $$setter 학습$$, $$challenge$$, 2,
$$setter을(를) 사용하여 문제를 해결하세요.$$,
$$- setter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* setter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["setter의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-extends$$, $$dart$$, $$syntax$$, 25, $$extends$$, $$extends 학습$$, $$challenge$$, 2,
$$extends을(를) 사용하여 문제를 해결하세요.$$,
$$- extends 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extends 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extends의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-future$$, $$dart$$, $$algorithm$$, 26, $$Future$$, $$Future 학습$$, $$challenge$$, 2,
$$Future을(를) 사용하여 문제를 해결하세요.$$,
$$- Future 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Future 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Future의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-async$$, $$dart$$, $$algorithm$$, 27, $$async$$, $$async 학습$$, $$challenge$$, 2,
$$async을(를) 사용하여 문제를 해결하세요.$$,
$$- async 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* async 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["async의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-await$$, $$dart$$, $$algorithm$$, 28, $$await$$, $$await 학습$$, $$challenge$$, 2,
$$await을(를) 사용하여 문제를 해결하세요.$$,
$$- await 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* await 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["await의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-then$$, $$dart$$, $$algorithm$$, 29, $$then$$, $$then 학습$$, $$challenge$$, 2,
$$then을(를) 사용하여 문제를 해결하세요.$$,
$$- then 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* then 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["then의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-stream$$, $$dart$$, $$algorithm$$, 30, $$Stream$$, $$Stream 학습$$, $$challenge$$, 2,
$$Stream을(를) 사용하여 문제를 해결하세요.$$,
$$- Stream 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Stream 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Stream의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-nullable-타입$$, $$dart$$, $$algorithm$$, 31, $$nullable 타입$$, $$nullable 타입 학습$$, $$challenge$$, 2,
$$nullable 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- nullable 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nullable 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nullable 타입의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-??-연산자$$, $$dart$$, $$algorithm$$, 32, $$?? 연산자$$, $$?? 연산자 학습$$, $$challenge$$, 2,
$$?? 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- ?? 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ?? 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["?? 연산자의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-?.-연산자$$, $$dart$$, $$algorithm$$, 33, $$?. 연산자$$, $$?. 연산자 학습$$, $$challenge$$, 2,
$$?. 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- ?. 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ?. 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["?. 연산자의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-late$$, $$dart$$, $$algorithm$$, 34, $$late$$, $$late 학습$$, $$challenge$$, 3,
$$late을(를) 사용하여 문제를 해결하세요.$$,
$$- late 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* late 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["late의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-!$$, $$dart$$, $$algorithm$$, 35, $$!$$, $$! 학습$$, $$challenge$$, 3,
$$!을(를) 사용하여 문제를 해결하세요.$$,
$$- ! 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ! 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["!의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-제네릭-클래스$$, $$dart$$, $$algorithm$$, 36, $$제네릭 클래스$$, $$제네릭 클래스 학습$$, $$challenge$$, 3,
$$제네릭 클래스을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 클래스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 클래스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 클래스의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-제네릭-함수$$, $$dart$$, $$algorithm$$, 37, $$제네릭 함수$$, $$제네릭 함수 학습$$, $$challenge$$, 3,
$$제네릭 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 함수의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-타입-제약$$, $$dart$$, $$algorithm$$, 38, $$타입 제약$$, $$타입 제약 학습$$, $$challenge$$, 3,
$$타입 제약을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 제약 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 제약 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 제약의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-extends$$, $$dart$$, $$algorithm$$, 39, $$extends$$, $$extends 학습$$, $$challenge$$, 3,
$$extends을(를) 사용하여 문제를 해결하세요.$$,
$$- extends 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extends 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extends의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-covariance$$, $$dart$$, $$algorithm$$, 40, $$covariance$$, $$covariance 학습$$, $$challenge$$, 3,
$$covariance을(를) 사용하여 문제를 해결하세요.$$,
$$- covariance 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* covariance 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["covariance의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-enum$$, $$dart$$, $$algorithm$$, 41, $$enum$$, $$enum 학습$$, $$challenge$$, 3,
$$enum을(를) 사용하여 문제를 해결하세요.$$,
$$- enum 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* enum 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["enum의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-extension$$, $$dart$$, $$algorithm$$, 42, $$extension$$, $$extension 학습$$, $$challenge$$, 3,
$$extension을(를) 사용하여 문제를 해결하세요.$$,
$$- extension 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extension 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extension의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-enhanced-enum$$, $$dart$$, $$algorithm$$, 43, $$enhanced enum$$, $$enhanced enum 학습$$, $$challenge$$, 3,
$$enhanced enum을(를) 사용하여 문제를 해결하세요.$$,
$$- enhanced enum 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* enhanced enum 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["enhanced enum의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-typedef$$, $$dart$$, $$algorithm$$, 44, $$typedef$$, $$typedef 학습$$, $$challenge$$, 3,
$$typedef을(를) 사용하여 문제를 해결하세요.$$,
$$- typedef 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* typedef 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["typedef의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-call$$, $$dart$$, $$algorithm$$, 45, $$call$$, $$call 학습$$, $$challenge$$, 3,
$$call을(를) 사용하여 문제를 해결하세요.$$,
$$- call 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* call 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["call의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-isolate$$, $$dart$$, $$algorithm$$, 46, $$isolate$$, $$isolate 학습$$, $$challenge$$, 3,
$$isolate을(를) 사용하여 문제를 해결하세요.$$,
$$- isolate 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* isolate 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["isolate의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-metadata$$, $$dart$$, $$algorithm$$, 47, $$metadata$$, $$metadata 학습$$, $$challenge$$, 3,
$$metadata을(를) 사용하여 문제를 해결하세요.$$,
$$- metadata 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* metadata 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["metadata의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-library$$, $$dart$$, $$algorithm$$, 48, $$library$$, $$library 학습$$, $$challenge$$, 3,
$$library을(를) 사용하여 문제를 해결하세요.$$,
$$- library 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* library 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["library의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-part$$, $$dart$$, $$algorithm$$, 49, $$part$$, $$part 학습$$, $$challenge$$, 3,
$$part을(를) 사용하여 문제를 해결하세요.$$,
$$- part 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* part 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["part의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$dart-cascade$$, $$dart$$, $$algorithm$$, 50, $$cascade$$, $$cascade 학습$$, $$challenge$$, 3,
$$cascade을(를) 사용하여 문제를 해결하세요.$$,
$$- cascade 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* cascade 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["cascade의 기본 사용법을 익히세요"]$$,
$$["dart", "basics"]$$, 12);

-- ============================================================================
-- KOTLIN Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-val-변수$$, $$kotlin$$, $$syntax$$, 1, $$val 변수$$, $$val 변수 학습$$, $$challenge$$, 1,
$$val 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- val 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* val 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["val 변수의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-var-변수$$, $$kotlin$$, $$syntax$$, 2, $$var 변수$$, $$var 변수 학습$$, $$challenge$$, 1,
$$var 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- var 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var 변수의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-int-타입$$, $$kotlin$$, $$syntax$$, 3, $$Int 타입$$, $$Int 타입 학습$$, $$challenge$$, 1,
$$Int 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- Int 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Int 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Int 타입의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-string-타입$$, $$kotlin$$, $$syntax$$, 4, $$String 타입$$, $$String 타입 학습$$, $$challenge$$, 1,
$$String 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- String 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* String 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["String 타입의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-타입-추론$$, $$kotlin$$, $$syntax$$, 5, $$타입 추론$$, $$타입 추론 학습$$, $$challenge$$, 1,
$$타입 추론을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 추론 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 추론 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 추론의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-if-표현식$$, $$kotlin$$, $$syntax$$, 6, $$if 표현식$$, $$if 표현식 학습$$, $$challenge$$, 1,
$$if 표현식을(를) 사용하여 문제를 해결하세요.$$,
$$- if 표현식 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if 표현식 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if 표현식의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-when-표현식$$, $$kotlin$$, $$syntax$$, 7, $$when 표현식$$, $$when 표현식 학습$$, $$challenge$$, 1,
$$when 표현식을(를) 사용하여 문제를 해결하세요.$$,
$$- when 표현식 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* when 표현식 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["when 표현식의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-for-반복$$, $$kotlin$$, $$syntax$$, 8, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-while-반복$$, $$kotlin$$, $$syntax$$, 9, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-range$$, $$kotlin$$, $$syntax$$, 10, $$range$$, $$range 학습$$, $$challenge$$, 1,
$$range을(를) 사용하여 문제를 해결하세요.$$,
$$- range 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* range 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["range의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-fun-함수$$, $$kotlin$$, $$syntax$$, 11, $$fun 함수$$, $$fun 함수 학습$$, $$challenge$$, 1,
$$fun 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- fun 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fun 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fun 함수의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-단일-표현식$$, $$kotlin$$, $$syntax$$, 12, $$단일 표현식$$, $$단일 표현식 학습$$, $$challenge$$, 1,
$$단일 표현식을(를) 사용하여 문제를 해결하세요.$$,
$$- 단일 표현식 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 단일 표현식 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["단일 표현식의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-기본-인자$$, $$kotlin$$, $$syntax$$, 13, $$기본 인자$$, $$기본 인자 학습$$, $$challenge$$, 1,
$$기본 인자을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본 인자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본 인자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본 인자의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-명명된-인자$$, $$kotlin$$, $$syntax$$, 14, $$명명된 인자$$, $$명명된 인자 학습$$, $$challenge$$, 1,
$$명명된 인자을(를) 사용하여 문제를 해결하세요.$$,
$$- 명명된 인자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 명명된 인자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["명명된 인자의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-확장-함수$$, $$kotlin$$, $$syntax$$, 15, $$확장 함수$$, $$확장 함수 학습$$, $$challenge$$, 1,
$$확장 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 확장 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 확장 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["확장 함수의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-list$$, $$kotlin$$, $$syntax$$, 16, $$List$$, $$List 학습$$, $$challenge$$, 1,
$$List을(를) 사용하여 문제를 해결하세요.$$,
$$- List 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* List 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["List의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-set$$, $$kotlin$$, $$syntax$$, 17, $$Set$$, $$Set 학습$$, $$challenge$$, 1,
$$Set을(를) 사용하여 문제를 해결하세요.$$,
$$- Set 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Set 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Set의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-map$$, $$kotlin$$, $$syntax$$, 18, $$Map$$, $$Map 학습$$, $$challenge$$, 2,
$$Map을(를) 사용하여 문제를 해결하세요.$$,
$$- Map 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Map 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Map의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-filter$$, $$kotlin$$, $$syntax$$, 19, $$filter$$, $$filter 학습$$, $$challenge$$, 2,
$$filter을(를) 사용하여 문제를 해결하세요.$$,
$$- filter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* filter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["filter의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-map$$, $$kotlin$$, $$syntax$$, 20, $$map$$, $$map 학습$$, $$challenge$$, 2,
$$map을(를) 사용하여 문제를 해결하세요.$$,
$$- map 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* map 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["map의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-class$$, $$kotlin$$, $$syntax$$, 21, $$class$$, $$class 학습$$, $$challenge$$, 2,
$$class을(를) 사용하여 문제를 해결하세요.$$,
$$- class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-constructor$$, $$kotlin$$, $$syntax$$, 22, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-data-class$$, $$kotlin$$, $$syntax$$, 23, $$data class$$, $$data class 학습$$, $$challenge$$, 2,
$$data class을(를) 사용하여 문제를 해결하세요.$$,
$$- data class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* data class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["data class의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-open$$, $$kotlin$$, $$syntax$$, 24, $$open$$, $$open 학습$$, $$challenge$$, 2,
$$open을(를) 사용하여 문제를 해결하세요.$$,
$$- open 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* open 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["open의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-companion$$, $$kotlin$$, $$syntax$$, 25, $$companion$$, $$companion 학습$$, $$challenge$$, 2,
$$companion을(를) 사용하여 문제를 해결하세요.$$,
$$- companion 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* companion 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["companion의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-nullable$$, $$kotlin$$, $$algorithm$$, 26, $$nullable$$, $$nullable 학습$$, $$challenge$$, 2,
$$nullable을(를) 사용하여 문제를 해결하세요.$$,
$$- nullable 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nullable 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nullable의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-?.-안전$$, $$kotlin$$, $$algorithm$$, 27, $$?. 안전$$, $$?. 안전 학습$$, $$challenge$$, 2,
$$?. 안전을(를) 사용하여 문제를 해결하세요.$$,
$$- ?. 안전 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ?. 안전 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["?. 안전의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-?:-elvis$$, $$kotlin$$, $$algorithm$$, 28, $$?: Elvis$$, $$?: Elvis 학습$$, $$challenge$$, 2,
$$?: Elvis을(를) 사용하여 문제를 해결하세요.$$,
$$- ?: Elvis 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ?: Elvis 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["?: Elvis의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-!!$$, $$kotlin$$, $$algorithm$$, 29, $$!!$$, $$!! 학습$$, $$challenge$$, 2,
$$!!을(를) 사용하여 문제를 해결하세요.$$,
$$- !! 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* !! 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["!!의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-let$$, $$kotlin$$, $$algorithm$$, 30, $$let$$, $$let 학습$$, $$challenge$$, 2,
$$let을(를) 사용하여 문제를 해결하세요.$$,
$$- let 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* let 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["let의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-람다$$, $$kotlin$$, $$algorithm$$, 31, $$람다$$, $$람다 학습$$, $$challenge$$, 2,
$$람다을(를) 사용하여 문제를 해결하세요.$$,
$$- 람다 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 람다 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["람다의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-고차-함수$$, $$kotlin$$, $$algorithm$$, 32, $$고차 함수$$, $$고차 함수 학습$$, $$challenge$$, 2,
$$고차 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 고차 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 고차 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["고차 함수의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-it$$, $$kotlin$$, $$algorithm$$, 33, $$it$$, $$it 학습$$, $$challenge$$, 2,
$$it을(를) 사용하여 문제를 해결하세요.$$,
$$- it 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* it 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["it의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-with$$, $$kotlin$$, $$algorithm$$, 34, $$with$$, $$with 학습$$, $$challenge$$, 3,
$$with을(를) 사용하여 문제를 해결하세요.$$,
$$- with 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* with 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["with의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-apply$$, $$kotlin$$, $$algorithm$$, 35, $$apply$$, $$apply 학습$$, $$challenge$$, 3,
$$apply을(를) 사용하여 문제를 해결하세요.$$,
$$- apply 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* apply 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["apply의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-suspend$$, $$kotlin$$, $$algorithm$$, 36, $$suspend$$, $$suspend 학습$$, $$challenge$$, 3,
$$suspend을(를) 사용하여 문제를 해결하세요.$$,
$$- suspend 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* suspend 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["suspend의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-launch$$, $$kotlin$$, $$algorithm$$, 37, $$launch$$, $$launch 학습$$, $$challenge$$, 3,
$$launch을(를) 사용하여 문제를 해결하세요.$$,
$$- launch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* launch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["launch의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-async$$, $$kotlin$$, $$algorithm$$, 38, $$async$$, $$async 학습$$, $$challenge$$, 3,
$$async을(를) 사용하여 문제를 해결하세요.$$,
$$- async 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* async 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["async의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-coroutinescope$$, $$kotlin$$, $$algorithm$$, 39, $$CoroutineScope$$, $$CoroutineScope 학습$$, $$challenge$$, 3,
$$CoroutineScope을(를) 사용하여 문제를 해결하세요.$$,
$$- CoroutineScope 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CoroutineScope 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CoroutineScope의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-withcontext$$, $$kotlin$$, $$algorithm$$, 40, $$withContext$$, $$withContext 학습$$, $$challenge$$, 3,
$$withContext을(를) 사용하여 문제를 해결하세요.$$,
$$- withContext 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* withContext 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["withContext의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-제네릭$$, $$kotlin$$, $$algorithm$$, 41, $$제네릭$$, $$제네릭 학습$$, $$challenge$$, 3,
$$제네릭을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-in$$, $$kotlin$$, $$algorithm$$, 42, $$in$$, $$in 학습$$, $$challenge$$, 3,
$$in을(를) 사용하여 문제를 해결하세요.$$,
$$- in 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* in 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["in의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-out$$, $$kotlin$$, $$algorithm$$, 43, $$out$$, $$out 학습$$, $$challenge$$, 3,
$$out을(를) 사용하여 문제를 해결하세요.$$,
$$- out 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* out 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["out의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-reified$$, $$kotlin$$, $$algorithm$$, 44, $$reified$$, $$reified 학습$$, $$challenge$$, 3,
$$reified을(를) 사용하여 문제를 해결하세요.$$,
$$- reified 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* reified 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["reified의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-타입-프로젝션$$, $$kotlin$$, $$algorithm$$, 45, $$타입 프로젝션$$, $$타입 프로젝션 학습$$, $$challenge$$, 3,
$$타입 프로젝션을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 프로젝션 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 프로젝션 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 프로젝션의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-sealed-class$$, $$kotlin$$, $$algorithm$$, 46, $$sealed class$$, $$sealed class 학습$$, $$challenge$$, 3,
$$sealed class을(를) 사용하여 문제를 해결하세요.$$,
$$- sealed class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* sealed class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["sealed class의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-inline-class$$, $$kotlin$$, $$algorithm$$, 47, $$inline class$$, $$inline class 학습$$, $$challenge$$, 3,
$$inline class을(를) 사용하여 문제를 해결하세요.$$,
$$- inline class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* inline class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["inline class의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-by-위임$$, $$kotlin$$, $$algorithm$$, 48, $$by 위임$$, $$by 위임 학습$$, $$challenge$$, 3,
$$by 위임을(를) 사용하여 문제를 해결하세요.$$,
$$- by 위임 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* by 위임 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["by 위임의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-연산자-오버로딩$$, $$kotlin$$, $$algorithm$$, 49, $$연산자 오버로딩$$, $$연산자 오버로딩 학습$$, $$challenge$$, 3,
$$연산자 오버로딩을(를) 사용하여 문제를 해결하세요.$$,
$$- 연산자 오버로딩 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 연산자 오버로딩 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["연산자 오버로딩의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$kotlin-dsl$$, $$kotlin$$, $$algorithm$$, 50, $$DSL$$, $$DSL 학습$$, $$challenge$$, 3,
$$DSL을(를) 사용하여 문제를 해결하세요.$$,
$$- DSL 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* DSL 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["DSL의 기본 사용법을 익히세요"]$$,
$$["kotlin", "basics"]$$, 12);

-- ============================================================================
-- CSHARP Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-var-변수$$, $$csharp$$, $$syntax$$, 1, $$var 변수$$, $$var 변수 학습$$, $$challenge$$, 1,
$$var 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- var 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var 변수의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-int-타입$$, $$csharp$$, $$syntax$$, 2, $$int 타입$$, $$int 타입 학습$$, $$challenge$$, 1,
$$int 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- int 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 타입의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-string-타입$$, $$csharp$$, $$syntax$$, 3, $$string 타입$$, $$string 타입 학습$$, $$challenge$$, 1,
$$string 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- string 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string 타입의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-bool-타입$$, $$csharp$$, $$syntax$$, 4, $$bool 타입$$, $$bool 타입 학습$$, $$challenge$$, 1,
$$bool 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- bool 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* bool 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["bool 타입의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-console.writeline$$, $$csharp$$, $$syntax$$, 5, $$Console.WriteLine$$, $$Console.WriteLine 학습$$, $$challenge$$, 1,
$$Console.WriteLine을(를) 사용하여 문제를 해결하세요.$$,
$$- Console.WriteLine 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Console.WriteLine 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Console.WriteLine의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-if-else$$, $$csharp$$, $$syntax$$, 6, $$if-else$$, $$if-else 학습$$, $$challenge$$, 1,
$$if-else을(를) 사용하여 문제를 해결하세요.$$,
$$- if-else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if-else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if-else의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-switch$$, $$csharp$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-for-반복$$, $$csharp$$, $$syntax$$, 8, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-while-반복$$, $$csharp$$, $$syntax$$, 9, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-foreach$$, $$csharp$$, $$syntax$$, 10, $$foreach$$, $$foreach 학습$$, $$challenge$$, 1,
$$foreach을(를) 사용하여 문제를 해결하세요.$$,
$$- foreach 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* foreach 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["foreach의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-메서드-정의$$, $$csharp$$, $$syntax$$, 11, $$메서드 정의$$, $$메서드 정의 학습$$, $$challenge$$, 1,
$$메서드 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드 정의의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-매개변수$$, $$csharp$$, $$syntax$$, 12, $$매개변수$$, $$매개변수 학습$$, $$challenge$$, 1,
$$매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-return$$, $$csharp$$, $$syntax$$, 13, $$return$$, $$return 학습$$, $$challenge$$, 1,
$$return을(를) 사용하여 문제를 해결하세요.$$,
$$- return 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* return 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["return의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-out$$, $$csharp$$, $$syntax$$, 14, $$out$$, $$out 학습$$, $$challenge$$, 1,
$$out을(를) 사용하여 문제를 해결하세요.$$,
$$- out 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* out 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["out의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-ref$$, $$csharp$$, $$syntax$$, 15, $$ref$$, $$ref 학습$$, $$challenge$$, 1,
$$ref을(를) 사용하여 문제를 해결하세요.$$,
$$- ref 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ref 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ref의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-배열$$, $$csharp$$, $$syntax$$, 16, $$배열$$, $$배열 학습$$, $$challenge$$, 1,
$$배열을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-listt$$, $$csharp$$, $$syntax$$, 17, $$List<T>$$, $$List<T> 학습$$, $$challenge$$, 1,
$$List<T>을(를) 사용하여 문제를 해결하세요.$$,
$$- List<T> 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* List<T> 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["List<T>의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-dictionary$$, $$csharp$$, $$syntax$$, 18, $$Dictionary$$, $$Dictionary 학습$$, $$challenge$$, 2,
$$Dictionary을(를) 사용하여 문제를 해결하세요.$$,
$$- Dictionary 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Dictionary 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Dictionary의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-where$$, $$csharp$$, $$syntax$$, 19, $$Where$$, $$Where 학습$$, $$challenge$$, 2,
$$Where을(를) 사용하여 문제를 해결하세요.$$,
$$- Where 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Where 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Where의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-select$$, $$csharp$$, $$syntax$$, 20, $$Select$$, $$Select 학습$$, $$challenge$$, 2,
$$Select을(를) 사용하여 문제를 해결하세요.$$,
$$- Select 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Select 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Select의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-class$$, $$csharp$$, $$syntax$$, 21, $$class$$, $$class 학습$$, $$challenge$$, 2,
$$class을(를) 사용하여 문제를 해결하세요.$$,
$$- class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-constructor$$, $$csharp$$, $$syntax$$, 22, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-property$$, $$csharp$$, $$syntax$$, 23, $$property$$, $$property 학습$$, $$challenge$$, 2,
$$property을(를) 사용하여 문제를 해결하세요.$$,
$$- property 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* property 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["property의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-상속$$, $$csharp$$, $$syntax$$, 24, $$상속$$, $$상속 학습$$, $$challenge$$, 2,
$$상속을(를) 사용하여 문제를 해결하세요.$$,
$$- 상속 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 상속 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["상속의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-override$$, $$csharp$$, $$syntax$$, 25, $$override$$, $$override 학습$$, $$challenge$$, 2,
$$override을(를) 사용하여 문제를 해결하세요.$$,
$$- override 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* override 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["override의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-interface$$, $$csharp$$, $$algorithm$$, 26, $$interface$$, $$interface 학습$$, $$challenge$$, 2,
$$interface을(를) 사용하여 문제를 해결하세요.$$,
$$- interface 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* interface 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["interface의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-구현$$, $$csharp$$, $$algorithm$$, 27, $$구현$$, $$구현 학습$$, $$challenge$$, 2,
$$구현을(를) 사용하여 문제를 해결하세요.$$,
$$- 구현 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 구현 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["구현의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-다중-인터페이스$$, $$csharp$$, $$algorithm$$, 28, $$다중 인터페이스$$, $$다중 인터페이스 학습$$, $$challenge$$, 2,
$$다중 인터페이스을(를) 사용하여 문제를 해결하세요.$$,
$$- 다중 인터페이스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 다중 인터페이스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["다중 인터페이스의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-명시적-구현$$, $$csharp$$, $$algorithm$$, 29, $$명시적 구현$$, $$명시적 구현 학습$$, $$challenge$$, 2,
$$명시적 구현을(를) 사용하여 문제를 해결하세요.$$,
$$- 명시적 구현 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 명시적 구현 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["명시적 구현의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-기본-구현$$, $$csharp$$, $$algorithm$$, 30, $$기본 구현$$, $$기본 구현 학습$$, $$challenge$$, 2,
$$기본 구현을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본 구현 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본 구현 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본 구현의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-try-catch$$, $$csharp$$, $$algorithm$$, 31, $$try-catch$$, $$try-catch 학습$$, $$challenge$$, 2,
$$try-catch을(를) 사용하여 문제를 해결하세요.$$,
$$- try-catch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* try-catch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["try-catch의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-throw$$, $$csharp$$, $$algorithm$$, 32, $$throw$$, $$throw 학습$$, $$challenge$$, 2,
$$throw을(를) 사용하여 문제를 해결하세요.$$,
$$- throw 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* throw 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["throw의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-finally$$, $$csharp$$, $$algorithm$$, 33, $$finally$$, $$finally 학습$$, $$challenge$$, 2,
$$finally을(를) 사용하여 문제를 해결하세요.$$,
$$- finally 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* finally 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["finally의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-exception$$, $$csharp$$, $$algorithm$$, 34, $$Exception$$, $$Exception 학습$$, $$challenge$$, 3,
$$Exception을(를) 사용하여 문제를 해결하세요.$$,
$$- Exception 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Exception 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Exception의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-custom-exception$$, $$csharp$$, $$algorithm$$, 35, $$custom exception$$, $$custom exception 학습$$, $$challenge$$, 3,
$$custom exception을(를) 사용하여 문제를 해결하세요.$$,
$$- custom exception 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* custom exception 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["custom exception의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-async$$, $$csharp$$, $$algorithm$$, 36, $$async$$, $$async 학습$$, $$challenge$$, 3,
$$async을(를) 사용하여 문제를 해결하세요.$$,
$$- async 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* async 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["async의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-await$$, $$csharp$$, $$algorithm$$, 37, $$await$$, $$await 학습$$, $$challenge$$, 3,
$$await을(를) 사용하여 문제를 해결하세요.$$,
$$- await 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* await 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["await의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-task$$, $$csharp$$, $$algorithm$$, 38, $$Task$$, $$Task 학습$$, $$challenge$$, 3,
$$Task을(를) 사용하여 문제를 해결하세요.$$,
$$- Task 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Task 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Task의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-taskt$$, $$csharp$$, $$algorithm$$, 39, $$Task<T>$$, $$Task<T> 학습$$, $$challenge$$, 3,
$$Task<T>을(를) 사용하여 문제를 해결하세요.$$,
$$- Task<T> 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Task<T> 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Task<T>의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-configureawait$$, $$csharp$$, $$algorithm$$, 40, $$ConfigureAwait$$, $$ConfigureAwait 학습$$, $$challenge$$, 3,
$$ConfigureAwait을(를) 사용하여 문제를 해결하세요.$$,
$$- ConfigureAwait 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ConfigureAwait 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ConfigureAwait의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-delegate$$, $$csharp$$, $$algorithm$$, 41, $$delegate$$, $$delegate 학습$$, $$challenge$$, 3,
$$delegate을(를) 사용하여 문제를 해결하세요.$$,
$$- delegate 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* delegate 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["delegate의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-action$$, $$csharp$$, $$algorithm$$, 42, $$Action$$, $$Action 학습$$, $$challenge$$, 3,
$$Action을(를) 사용하여 문제를 해결하세요.$$,
$$- Action 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Action 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Action의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-func$$, $$csharp$$, $$algorithm$$, 43, $$Func$$, $$Func 학습$$, $$challenge$$, 3,
$$Func을(를) 사용하여 문제를 해결하세요.$$,
$$- Func 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Func 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Func의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-event$$, $$csharp$$, $$algorithm$$, 44, $$event$$, $$event 학습$$, $$challenge$$, 3,
$$event을(를) 사용하여 문제를 해결하세요.$$,
$$- event 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* event 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["event의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-lambda$$, $$csharp$$, $$algorithm$$, 45, $$lambda$$, $$lambda 학습$$, $$challenge$$, 3,
$$lambda을(를) 사용하여 문제를 해결하세요.$$,
$$- lambda 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* lambda 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["lambda의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-제네릭$$, $$csharp$$, $$algorithm$$, 46, $$제네릭$$, $$제네릭 학습$$, $$challenge$$, 3,
$$제네릭을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-nullable$$, $$csharp$$, $$algorithm$$, 47, $$nullable$$, $$nullable 학습$$, $$challenge$$, 3,
$$nullable을(를) 사용하여 문제를 해결하세요.$$,
$$- nullable 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* nullable 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["nullable의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-pattern-matching$$, $$csharp$$, $$algorithm$$, 48, $$pattern matching$$, $$pattern matching 학습$$, $$challenge$$, 3,
$$pattern matching을(를) 사용하여 문제를 해결하세요.$$,
$$- pattern matching 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* pattern matching 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["pattern matching의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-record$$, $$csharp$$, $$algorithm$$, 49, $$record$$, $$record 학습$$, $$challenge$$, 3,
$$record을(를) 사용하여 문제를 해결하세요.$$,
$$- record 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* record 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["record의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$csharp-init$$, $$csharp$$, $$algorithm$$, 50, $$init$$, $$init 학습$$, $$challenge$$, 3,
$$init을(를) 사용하여 문제를 해결하세요.$$,
$$- init 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* init 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["init의 기본 사용법을 익히세요"]$$,
$$["csharp", "basics"]$$, 12);

-- ============================================================================
-- JAVA Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-int-변수$$, $$java$$, $$syntax$$, 1, $$int 변수$$, $$int 변수 학습$$, $$challenge$$, 1,
$$int 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- int 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 변수의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-string-변수$$, $$java$$, $$syntax$$, 2, $$String 변수$$, $$String 변수 학습$$, $$challenge$$, 1,
$$String 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- String 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* String 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["String 변수의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-boolean-변수$$, $$java$$, $$syntax$$, 3, $$boolean 변수$$, $$boolean 변수 학습$$, $$challenge$$, 1,
$$boolean 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- boolean 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* boolean 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["boolean 변수의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-system.out$$, $$java$$, $$syntax$$, 4, $$System.out$$, $$System.out 학습$$, $$challenge$$, 1,
$$System.out을(를) 사용하여 문제를 해결하세요.$$,
$$- System.out 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* System.out 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["System.out의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-주석$$, $$java$$, $$syntax$$, 5, $$주석$$, $$주석 학습$$, $$challenge$$, 1,
$$주석을(를) 사용하여 문제를 해결하세요.$$,
$$- 주석 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 주석 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["주석의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-if-else$$, $$java$$, $$syntax$$, 6, $$if-else$$, $$if-else 학습$$, $$challenge$$, 1,
$$if-else을(를) 사용하여 문제를 해결하세요.$$,
$$- if-else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if-else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if-else의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-switch$$, $$java$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-for-반복$$, $$java$$, $$syntax$$, 8, $$for 반복$$, $$for 반복 학습$$, $$challenge$$, 1,
$$for 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- for 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for 반복의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-while-반복$$, $$java$$, $$syntax$$, 9, $$while 반복$$, $$while 반복 학습$$, $$challenge$$, 1,
$$while 반복을(를) 사용하여 문제를 해결하세요.$$,
$$- while 반복 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 반복 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while 반복의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-enhanced-for$$, $$java$$, $$syntax$$, 10, $$enhanced for$$, $$enhanced for 학습$$, $$challenge$$, 1,
$$enhanced for을(를) 사용하여 문제를 해결하세요.$$,
$$- enhanced for 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* enhanced for 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["enhanced for의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-메서드$$, $$java$$, $$syntax$$, 11, $$메서드$$, $$메서드 학습$$, $$challenge$$, 1,
$$메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-static$$, $$java$$, $$syntax$$, 12, $$static$$, $$static 학습$$, $$challenge$$, 1,
$$static을(를) 사용하여 문제를 해결하세요.$$,
$$- static 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* static 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["static의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-매개변수$$, $$java$$, $$syntax$$, 13, $$매개변수$$, $$매개변수 학습$$, $$challenge$$, 1,
$$매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-return$$, $$java$$, $$syntax$$, 14, $$return$$, $$return 학습$$, $$challenge$$, 1,
$$return을(를) 사용하여 문제를 해결하세요.$$,
$$- return 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* return 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["return의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-오버로딩$$, $$java$$, $$syntax$$, 15, $$오버로딩$$, $$오버로딩 학습$$, $$challenge$$, 1,
$$오버로딩을(를) 사용하여 문제를 해결하세요.$$,
$$- 오버로딩 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 오버로딩 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["오버로딩의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-배열$$, $$java$$, $$syntax$$, 16, $$배열$$, $$배열 학습$$, $$challenge$$, 1,
$$배열을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-arraylist$$, $$java$$, $$syntax$$, 17, $$ArrayList$$, $$ArrayList 학습$$, $$challenge$$, 1,
$$ArrayList을(를) 사용하여 문제를 해결하세요.$$,
$$- ArrayList 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ArrayList 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ArrayList의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-hashmap$$, $$java$$, $$syntax$$, 18, $$HashMap$$, $$HashMap 학습$$, $$challenge$$, 2,
$$HashMap을(를) 사용하여 문제를 해결하세요.$$,
$$- HashMap 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* HashMap 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["HashMap의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-for-each$$, $$java$$, $$syntax$$, 19, $$for-each$$, $$for-each 학습$$, $$challenge$$, 2,
$$for-each을(를) 사용하여 문제를 해결하세요.$$,
$$- for-each 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for-each 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for-each의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-stream$$, $$java$$, $$syntax$$, 20, $$Stream$$, $$Stream 학습$$, $$challenge$$, 2,
$$Stream을(를) 사용하여 문제를 해결하세요.$$,
$$- Stream 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Stream 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Stream의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-class$$, $$java$$, $$syntax$$, 21, $$class$$, $$class 학습$$, $$challenge$$, 2,
$$class을(를) 사용하여 문제를 해결하세요.$$,
$$- class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-constructor$$, $$java$$, $$syntax$$, 22, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-getter$$, $$java$$, $$syntax$$, 23, $$getter$$, $$getter 학습$$, $$challenge$$, 2,
$$getter을(를) 사용하여 문제를 해결하세요.$$,
$$- getter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* getter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["getter의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-setter$$, $$java$$, $$syntax$$, 24, $$setter$$, $$setter 학습$$, $$challenge$$, 2,
$$setter을(를) 사용하여 문제를 해결하세요.$$,
$$- setter 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* setter 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["setter의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-extends$$, $$java$$, $$syntax$$, 25, $$extends$$, $$extends 학습$$, $$challenge$$, 2,
$$extends을(를) 사용하여 문제를 해결하세요.$$,
$$- extends 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* extends 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["extends의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-interface$$, $$java$$, $$algorithm$$, 26, $$interface$$, $$interface 학습$$, $$challenge$$, 2,
$$interface을(를) 사용하여 문제를 해결하세요.$$,
$$- interface 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* interface 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["interface의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-implements$$, $$java$$, $$algorithm$$, 27, $$implements$$, $$implements 학습$$, $$challenge$$, 2,
$$implements을(를) 사용하여 문제를 해결하세요.$$,
$$- implements 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* implements 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["implements의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-다중-인터페이스$$, $$java$$, $$algorithm$$, 28, $$다중 인터페이스$$, $$다중 인터페이스 학습$$, $$challenge$$, 2,
$$다중 인터페이스을(를) 사용하여 문제를 해결하세요.$$,
$$- 다중 인터페이스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 다중 인터페이스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["다중 인터페이스의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-default$$, $$java$$, $$algorithm$$, 29, $$default$$, $$default 학습$$, $$challenge$$, 2,
$$default을(를) 사용하여 문제를 해결하세요.$$,
$$- default 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* default 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["default의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-static$$, $$java$$, $$algorithm$$, 30, $$static$$, $$static 학습$$, $$challenge$$, 2,
$$static을(를) 사용하여 문제를 해결하세요.$$,
$$- static 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* static 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["static의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-try-catch$$, $$java$$, $$algorithm$$, 31, $$try-catch$$, $$try-catch 학습$$, $$challenge$$, 2,
$$try-catch을(를) 사용하여 문제를 해결하세요.$$,
$$- try-catch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* try-catch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["try-catch의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-throw$$, $$java$$, $$algorithm$$, 32, $$throw$$, $$throw 학습$$, $$challenge$$, 2,
$$throw을(를) 사용하여 문제를 해결하세요.$$,
$$- throw 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* throw 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["throw의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-throws$$, $$java$$, $$algorithm$$, 33, $$throws$$, $$throws 학습$$, $$challenge$$, 2,
$$throws을(를) 사용하여 문제를 해결하세요.$$,
$$- throws 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* throws 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["throws의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-exception$$, $$java$$, $$algorithm$$, 34, $$Exception$$, $$Exception 학습$$, $$challenge$$, 3,
$$Exception을(를) 사용하여 문제를 해결하세요.$$,
$$- Exception 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Exception 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Exception의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-try-with-resources$$, $$java$$, $$algorithm$$, 35, $$try-with-resources$$, $$try-with-resources 학습$$, $$challenge$$, 3,
$$try-with-resources을(를) 사용하여 문제를 해결하세요.$$,
$$- try-with-resources 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* try-with-resources 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["try-with-resources의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-제네릭-클래스$$, $$java$$, $$algorithm$$, 36, $$제네릭 클래스$$, $$제네릭 클래스 학습$$, $$challenge$$, 3,
$$제네릭 클래스을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 클래스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 클래스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 클래스의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-제네릭-메서드$$, $$java$$, $$algorithm$$, 37, $$제네릭 메서드$$, $$제네릭 메서드 학습$$, $$challenge$$, 3,
$$제네릭 메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 제네릭 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 제네릭 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["제네릭 메서드의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-bounded$$, $$java$$, $$algorithm$$, 38, $$bounded$$, $$bounded 학습$$, $$challenge$$, 3,
$$bounded을(를) 사용하여 문제를 해결하세요.$$,
$$- bounded 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* bounded 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["bounded의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-wildcard$$, $$java$$, $$algorithm$$, 39, $$wildcard$$, $$wildcard 학습$$, $$challenge$$, 3,
$$wildcard을(를) 사용하여 문제를 해결하세요.$$,
$$- wildcard 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* wildcard 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["wildcard의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-erasure$$, $$java$$, $$algorithm$$, 40, $$erasure$$, $$erasure 학습$$, $$challenge$$, 3,
$$erasure을(를) 사용하여 문제를 해결하세요.$$,
$$- erasure 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* erasure 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["erasure의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-람다$$, $$java$$, $$algorithm$$, 41, $$람다$$, $$람다 학습$$, $$challenge$$, 3,
$$람다을(를) 사용하여 문제를 해결하세요.$$,
$$- 람다 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 람다 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["람다의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-functional-interface$$, $$java$$, $$algorithm$$, 42, $$functional interface$$, $$functional interface 학습$$, $$challenge$$, 3,
$$functional interface을(를) 사용하여 문제를 해결하세요.$$,
$$- functional interface 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* functional interface 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["functional interface의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-method-reference$$, $$java$$, $$algorithm$$, 43, $$method reference$$, $$method reference 학습$$, $$challenge$$, 3,
$$method reference을(를) 사용하여 문제를 해결하세요.$$,
$$- method reference 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* method reference 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["method reference의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-stream$$, $$java$$, $$algorithm$$, 44, $$Stream$$, $$Stream 학습$$, $$challenge$$, 3,
$$Stream을(를) 사용하여 문제를 해결하세요.$$,
$$- Stream 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Stream 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Stream의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-optional$$, $$java$$, $$algorithm$$, 45, $$Optional$$, $$Optional 학습$$, $$challenge$$, 3,
$$Optional을(를) 사용하여 문제를 해결하세요.$$,
$$- Optional 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Optional 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Optional의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-annotation$$, $$java$$, $$algorithm$$, 46, $$Annotation$$, $$Annotation 학습$$, $$challenge$$, 3,
$$Annotation을(를) 사용하여 문제를 해결하세요.$$,
$$- Annotation 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Annotation 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Annotation의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-reflection$$, $$java$$, $$algorithm$$, 47, $$Reflection$$, $$Reflection 학습$$, $$challenge$$, 3,
$$Reflection을(를) 사용하여 문제를 해결하세요.$$,
$$- Reflection 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Reflection 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Reflection의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-thread$$, $$java$$, $$algorithm$$, 48, $$Thread$$, $$Thread 학습$$, $$challenge$$, 3,
$$Thread을(를) 사용하여 문제를 해결하세요.$$,
$$- Thread 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Thread 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Thread의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-completablefuture$$, $$java$$, $$algorithm$$, 49, $$CompletableFuture$$, $$CompletableFuture 학습$$, $$challenge$$, 3,
$$CompletableFuture을(를) 사용하여 문제를 해결하세요.$$,
$$- CompletableFuture 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CompletableFuture 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CompletableFuture의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$java-var$$, $$java$$, $$algorithm$$, 50, $$var$$, $$var 학습$$, $$challenge$$, 3,
$$var을(를) 사용하여 문제를 해결하세요.$$,
$$- var 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var의 기본 사용법을 익히세요"]$$,
$$["java", "basics"]$$, 12);

-- ============================================================================
-- GO Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-var-변수$$, $$go$$, $$syntax$$, 1, $$var 변수$$, $$var 변수 학습$$, $$challenge$$, 1,
$$var 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- var 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* var 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["var 변수의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-:=-연산자$$, $$go$$, $$syntax$$, 2, $$:= 연산자$$, $$:= 연산자 학습$$, $$challenge$$, 1,
$$:= 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- := 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* := 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$[":= 연산자의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-int-타입$$, $$go$$, $$syntax$$, 3, $$int 타입$$, $$int 타입 학습$$, $$challenge$$, 1,
$$int 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- int 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 타입의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-string-타입$$, $$go$$, $$syntax$$, 4, $$string 타입$$, $$string 타입 학습$$, $$challenge$$, 1,
$$string 타입을(를) 사용하여 문제를 해결하세요.$$,
$$- string 타입 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 타입 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string 타입의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-fmt.println$$, $$go$$, $$syntax$$, 5, $$fmt.Println$$, $$fmt.Println 학습$$, $$challenge$$, 1,
$$fmt.Println을(를) 사용하여 문제를 해결하세요.$$,
$$- fmt.Println 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fmt.Println 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fmt.Println의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-if$$, $$go$$, $$syntax$$, 6, $$if$$, $$if 학습$$, $$challenge$$, 1,
$$if을(를) 사용하여 문제를 해결하세요.$$,
$$- if 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-switch$$, $$go$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-for$$, $$go$$, $$syntax$$, 8, $$for$$, $$for 학습$$, $$challenge$$, 1,
$$for을(를) 사용하여 문제를 해결하세요.$$,
$$- for 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-range$$, $$go$$, $$syntax$$, 9, $$range$$, $$range 학습$$, $$challenge$$, 1,
$$range을(를) 사용하여 문제를 해결하세요.$$,
$$- range 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* range 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["range의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-defer$$, $$go$$, $$syntax$$, 10, $$defer$$, $$defer 학습$$, $$challenge$$, 1,
$$defer을(를) 사용하여 문제를 해결하세요.$$,
$$- defer 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* defer 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["defer의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-func$$, $$go$$, $$syntax$$, 11, $$func$$, $$func 학습$$, $$challenge$$, 1,
$$func을(를) 사용하여 문제를 해결하세요.$$,
$$- func 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* func 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["func의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-다중-반환$$, $$go$$, $$syntax$$, 12, $$다중 반환$$, $$다중 반환 학습$$, $$challenge$$, 1,
$$다중 반환을(를) 사용하여 문제를 해결하세요.$$,
$$- 다중 반환 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 다중 반환 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["다중 반환의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-가변-인자$$, $$go$$, $$syntax$$, 13, $$가변 인자$$, $$가변 인자 학습$$, $$challenge$$, 1,
$$가변 인자을(를) 사용하여 문제를 해결하세요.$$,
$$- 가변 인자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 가변 인자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["가변 인자의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-익명-함수$$, $$go$$, $$syntax$$, 14, $$익명 함수$$, $$익명 함수 학습$$, $$challenge$$, 1,
$$익명 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 익명 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 익명 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["익명 함수의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-클로저$$, $$go$$, $$syntax$$, 15, $$클로저$$, $$클로저 학습$$, $$challenge$$, 1,
$$클로저을(를) 사용하여 문제를 해결하세요.$$,
$$- 클로저 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 클로저 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["클로저의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-array$$, $$go$$, $$syntax$$, 16, $$array$$, $$array 학습$$, $$challenge$$, 1,
$$array을(를) 사용하여 문제를 해결하세요.$$,
$$- array 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* array 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["array의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-slice$$, $$go$$, $$syntax$$, 17, $$slice$$, $$slice 학습$$, $$challenge$$, 1,
$$slice을(를) 사용하여 문제를 해결하세요.$$,
$$- slice 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* slice 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["slice의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-map$$, $$go$$, $$syntax$$, 18, $$map$$, $$map 학습$$, $$challenge$$, 2,
$$map을(를) 사용하여 문제를 해결하세요.$$,
$$- map 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* map 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["map의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-struct$$, $$go$$, $$syntax$$, 19, $$struct$$, $$struct 학습$$, $$challenge$$, 2,
$$struct을(를) 사용하여 문제를 해결하세요.$$,
$$- struct 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* struct 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["struct의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-pointer$$, $$go$$, $$syntax$$, 20, $$pointer$$, $$pointer 학습$$, $$challenge$$, 2,
$$pointer을(를) 사용하여 문제를 해결하세요.$$,
$$- pointer 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* pointer 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["pointer의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-메서드$$, $$go$$, $$syntax$$, 21, $$메서드$$, $$메서드 학습$$, $$challenge$$, 2,
$$메서드을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-리시버$$, $$go$$, $$syntax$$, 22, $$리시버$$, $$리시버 학습$$, $$challenge$$, 2,
$$리시버을(를) 사용하여 문제를 해결하세요.$$,
$$- 리시버 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 리시버 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["리시버의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-포인터-리시버$$, $$go$$, $$syntax$$, 23, $$포인터 리시버$$, $$포인터 리시버 학습$$, $$challenge$$, 2,
$$포인터 리시버을(를) 사용하여 문제를 해결하세요.$$,
$$- 포인터 리시버 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 포인터 리시버 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["포인터 리시버의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-값-리시버$$, $$go$$, $$syntax$$, 24, $$값 리시버$$, $$값 리시버 학습$$, $$challenge$$, 2,
$$값 리시버을(를) 사용하여 문제를 해결하세요.$$,
$$- 값 리시버 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 값 리시버 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["값 리시버의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-메서드-체이닝$$, $$go$$, $$syntax$$, 25, $$메서드 체이닝$$, $$메서드 체이닝 학습$$, $$challenge$$, 2,
$$메서드 체이닝을(를) 사용하여 문제를 해결하세요.$$,
$$- 메서드 체이닝 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메서드 체이닝 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메서드 체이닝의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-interface$$, $$go$$, $$algorithm$$, 26, $$interface$$, $$interface 학습$$, $$challenge$$, 2,
$$interface을(를) 사용하여 문제를 해결하세요.$$,
$$- interface 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* interface 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["interface의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-암묵적-구현$$, $$go$$, $$algorithm$$, 27, $$암묵적 구현$$, $$암묵적 구현 학습$$, $$challenge$$, 2,
$$암묵적 구현을(를) 사용하여 문제를 해결하세요.$$,
$$- 암묵적 구현 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 암묵적 구현 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["암묵적 구현의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-빈-인터페이스$$, $$go$$, $$algorithm$$, 28, $$빈 인터페이스$$, $$빈 인터페이스 학습$$, $$challenge$$, 2,
$$빈 인터페이스을(를) 사용하여 문제를 해결하세요.$$,
$$- 빈 인터페이스 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 빈 인터페이스 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["빈 인터페이스의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-타입-단언$$, $$go$$, $$algorithm$$, 29, $$타입 단언$$, $$타입 단언 학습$$, $$challenge$$, 2,
$$타입 단언을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 단언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 단언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 단언의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-타입-스위치$$, $$go$$, $$algorithm$$, 30, $$타입 스위치$$, $$타입 스위치 학습$$, $$challenge$$, 2,
$$타입 스위치을(를) 사용하여 문제를 해결하세요.$$,
$$- 타입 스위치 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 타입 스위치 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["타입 스위치의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-goroutine$$, $$go$$, $$algorithm$$, 31, $$goroutine$$, $$goroutine 학습$$, $$challenge$$, 2,
$$goroutine을(를) 사용하여 문제를 해결하세요.$$,
$$- goroutine 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* goroutine 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["goroutine의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-channel$$, $$go$$, $$algorithm$$, 32, $$channel$$, $$channel 학습$$, $$challenge$$, 2,
$$channel을(를) 사용하여 문제를 해결하세요.$$,
$$- channel 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* channel 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["channel의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-select$$, $$go$$, $$algorithm$$, 33, $$select$$, $$select 학습$$, $$challenge$$, 2,
$$select을(를) 사용하여 문제를 해결하세요.$$,
$$- select 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* select 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["select의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-buffered$$, $$go$$, $$algorithm$$, 34, $$buffered$$, $$buffered 학습$$, $$challenge$$, 3,
$$buffered을(를) 사용하여 문제를 해결하세요.$$,
$$- buffered 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* buffered 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["buffered의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-waitgroup$$, $$go$$, $$algorithm$$, 35, $$WaitGroup$$, $$WaitGroup 학습$$, $$challenge$$, 3,
$$WaitGroup을(를) 사용하여 문제를 해결하세요.$$,
$$- WaitGroup 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* WaitGroup 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["WaitGroup의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-error$$, $$go$$, $$algorithm$$, 36, $$error$$, $$error 학습$$, $$challenge$$, 3,
$$error을(를) 사용하여 문제를 해결하세요.$$,
$$- error 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* error 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["error의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-errors.new$$, $$go$$, $$algorithm$$, 37, $$errors.New$$, $$errors.New 학습$$, $$challenge$$, 3,
$$errors.New을(를) 사용하여 문제를 해결하세요.$$,
$$- errors.New 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* errors.New 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["errors.New의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-fmt.errorf$$, $$go$$, $$algorithm$$, 38, $$fmt.Errorf$$, $$fmt.Errorf 학습$$, $$challenge$$, 3,
$$fmt.Errorf을(를) 사용하여 문제를 해결하세요.$$,
$$- fmt.Errorf 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fmt.Errorf 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fmt.Errorf의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-panic$$, $$go$$, $$algorithm$$, 39, $$panic$$, $$panic 학습$$, $$challenge$$, 3,
$$panic을(를) 사용하여 문제를 해결하세요.$$,
$$- panic 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* panic 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["panic의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-recover$$, $$go$$, $$algorithm$$, 40, $$recover$$, $$recover 학습$$, $$challenge$$, 3,
$$recover을(를) 사용하여 문제를 해결하세요.$$,
$$- recover 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* recover 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["recover의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-package$$, $$go$$, $$algorithm$$, 41, $$package$$, $$package 학습$$, $$challenge$$, 3,
$$package을(를) 사용하여 문제를 해결하세요.$$,
$$- package 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* package 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["package의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-import$$, $$go$$, $$algorithm$$, 42, $$import$$, $$import 학습$$, $$challenge$$, 3,
$$import을(를) 사용하여 문제를 해결하세요.$$,
$$- import 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* import 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["import의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-init$$, $$go$$, $$algorithm$$, 43, $$init$$, $$init 학습$$, $$challenge$$, 3,
$$init을(를) 사용하여 문제를 해결하세요.$$,
$$- init 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* init 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["init의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-internal$$, $$go$$, $$algorithm$$, 44, $$internal$$, $$internal 학습$$, $$challenge$$, 3,
$$internal을(를) 사용하여 문제를 해결하세요.$$,
$$- internal 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* internal 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["internal의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-go-mod$$, $$go$$, $$algorithm$$, 45, $$go mod$$, $$go mod 학습$$, $$challenge$$, 3,
$$go mod을(를) 사용하여 문제를 해결하세요.$$,
$$- go mod 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* go mod 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["go mod의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-context$$, $$go$$, $$algorithm$$, 46, $$context$$, $$context 학습$$, $$challenge$$, 3,
$$context을(를) 사용하여 문제를 해결하세요.$$,
$$- context 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* context 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["context의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-reflection$$, $$go$$, $$algorithm$$, 47, $$reflection$$, $$reflection 학습$$, $$challenge$$, 3,
$$reflection을(를) 사용하여 문제를 해결하세요.$$,
$$- reflection 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* reflection 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["reflection의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-generic$$, $$go$$, $$algorithm$$, 48, $$generic$$, $$generic 학습$$, $$challenge$$, 3,
$$generic을(를) 사용하여 문제를 해결하세요.$$,
$$- generic 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* generic 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["generic의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-embedding$$, $$go$$, $$algorithm$$, 49, $$embedding$$, $$embedding 학습$$, $$challenge$$, 3,
$$embedding을(를) 사용하여 문제를 해결하세요.$$,
$$- embedding 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* embedding 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["embedding의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$go-build-tags$$, $$go$$, $$algorithm$$, 50, $$build tags$$, $$build tags 학습$$, $$challenge$$, 3,
$$build tags을(를) 사용하여 문제를 해결하세요.$$,
$$- build tags 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* build tags 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["build tags의 기본 사용법을 익히세요"]$$,
$$["go", "basics"]$$, 12);

-- ============================================================================
-- C Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-int-변수$$, $$c$$, $$syntax$$, 1, $$int 변수$$, $$int 변수 학습$$, $$challenge$$, 1,
$$int 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- int 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 변수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-char-변수$$, $$c$$, $$syntax$$, 2, $$char 변수$$, $$char 변수 학습$$, $$challenge$$, 1,
$$char 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- char 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* char 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["char 변수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-float-변수$$, $$c$$, $$syntax$$, 3, $$float 변수$$, $$float 변수 학습$$, $$challenge$$, 1,
$$float 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- float 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* float 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["float 변수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-printf$$, $$c$$, $$syntax$$, 4, $$printf$$, $$printf 학습$$, $$challenge$$, 1,
$$printf을(를) 사용하여 문제를 해결하세요.$$,
$$- printf 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* printf 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["printf의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-scanf$$, $$c$$, $$syntax$$, 5, $$scanf$$, $$scanf 학습$$, $$challenge$$, 1,
$$scanf을(를) 사용하여 문제를 해결하세요.$$,
$$- scanf 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* scanf 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["scanf의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-if-else$$, $$c$$, $$syntax$$, 6, $$if-else$$, $$if-else 학습$$, $$challenge$$, 1,
$$if-else을(를) 사용하여 문제를 해결하세요.$$,
$$- if-else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if-else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if-else의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-switch$$, $$c$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-for$$, $$c$$, $$syntax$$, 8, $$for$$, $$for 학습$$, $$challenge$$, 1,
$$for을(를) 사용하여 문제를 해결하세요.$$,
$$- for 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-while$$, $$c$$, $$syntax$$, 9, $$while$$, $$while 학습$$, $$challenge$$, 1,
$$while을(를) 사용하여 문제를 해결하세요.$$,
$$- while 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-do-while$$, $$c$$, $$syntax$$, 10, $$do-while$$, $$do-while 학습$$, $$challenge$$, 1,
$$do-while을(를) 사용하여 문제를 해결하세요.$$,
$$- do-while 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* do-while 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["do-while의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-함수-정의$$, $$c$$, $$syntax$$, 11, $$함수 정의$$, $$함수 정의 학습$$, $$challenge$$, 1,
$$함수 정의을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 정의 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 정의 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 정의의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-함수-선언$$, $$c$$, $$syntax$$, 12, $$함수 선언$$, $$함수 선언 학습$$, $$challenge$$, 1,
$$함수 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 선언의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-매개변수$$, $$c$$, $$syntax$$, 13, $$매개변수$$, $$매개변수 학습$$, $$challenge$$, 1,
$$매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["매개변수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-return$$, $$c$$, $$syntax$$, 14, $$return$$, $$return 학습$$, $$challenge$$, 1,
$$return을(를) 사용하여 문제를 해결하세요.$$,
$$- return 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* return 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["return의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-재귀$$, $$c$$, $$syntax$$, 15, $$재귀$$, $$재귀 학습$$, $$challenge$$, 1,
$$재귀을(를) 사용하여 문제를 해결하세요.$$,
$$- 재귀 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 재귀 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["재귀의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-배열-선언$$, $$c$$, $$syntax$$, 16, $$배열 선언$$, $$배열 선언 학습$$, $$challenge$$, 1,
$$배열 선언을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 선언 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 선언 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열 선언의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-배열-초기화$$, $$c$$, $$syntax$$, 17, $$배열 초기화$$, $$배열 초기화 학습$$, $$challenge$$, 1,
$$배열 초기화을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 초기화 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 초기화 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열 초기화의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-2차원-배열$$, $$c$$, $$syntax$$, 18, $$2차원 배열$$, $$2차원 배열 학습$$, $$challenge$$, 2,
$$2차원 배열을(를) 사용하여 문제를 해결하세요.$$,
$$- 2차원 배열 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 2차원 배열 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["2차원 배열의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-배열-포인터$$, $$c$$, $$syntax$$, 19, $$배열 포인터$$, $$배열 포인터 학습$$, $$challenge$$, 2,
$$배열 포인터을(를) 사용하여 문제를 해결하세요.$$,
$$- 배열 포인터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 배열 포인터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["배열 포인터의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-sizeof$$, $$c$$, $$syntax$$, 20, $$sizeof$$, $$sizeof 학습$$, $$challenge$$, 2,
$$sizeof을(를) 사용하여 문제를 해결하세요.$$,
$$- sizeof 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* sizeof 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["sizeof의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-포인터$$, $$c$$, $$syntax$$, 21, $$포인터$$, $$포인터 학습$$, $$challenge$$, 2,
$$포인터을(를) 사용하여 문제를 해결하세요.$$,
$$- 포인터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 포인터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["포인터의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-주소$$, $$c$$, $$syntax$$, 22, $$주소$$, $$주소 학습$$, $$challenge$$, 2,
$$주소을(를) 사용하여 문제를 해결하세요.$$,
$$- 주소 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 주소 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["주소의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-역참조$$, $$c$$, $$syntax$$, 23, $$역참조$$, $$역참조 학습$$, $$challenge$$, 2,
$$역참조을(를) 사용하여 문제를 해결하세요.$$,
$$- 역참조 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 역참조 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["역참조의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-포인터-산술$$, $$c$$, $$syntax$$, 24, $$포인터 산술$$, $$포인터 산술 학습$$, $$challenge$$, 2,
$$포인터 산술을(를) 사용하여 문제를 해결하세요.$$,
$$- 포인터 산술 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 포인터 산술 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["포인터 산술의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-이중-포인터$$, $$c$$, $$syntax$$, 25, $$이중 포인터$$, $$이중 포인터 학습$$, $$challenge$$, 2,
$$이중 포인터을(를) 사용하여 문제를 해결하세요.$$,
$$- 이중 포인터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 이중 포인터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["이중 포인터의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-문자-배열$$, $$c$$, $$algorithm$$, 26, $$문자 배열$$, $$문자 배열 학습$$, $$challenge$$, 2,
$$문자 배열을(를) 사용하여 문제를 해결하세요.$$,
$$- 문자 배열 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 문자 배열 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["문자 배열의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-string.h$$, $$c$$, $$algorithm$$, 27, $$string.h$$, $$string.h 학습$$, $$challenge$$, 2,
$$string.h을(를) 사용하여 문제를 해결하세요.$$,
$$- string.h 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string.h 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string.h의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-strcpy$$, $$c$$, $$algorithm$$, 28, $$strcpy$$, $$strcpy 학습$$, $$challenge$$, 2,
$$strcpy을(를) 사용하여 문제를 해결하세요.$$,
$$- strcpy 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* strcpy 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["strcpy의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-strlen$$, $$c$$, $$algorithm$$, 29, $$strlen$$, $$strlen 학습$$, $$challenge$$, 2,
$$strlen을(를) 사용하여 문제를 해결하세요.$$,
$$- strlen 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* strlen 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["strlen의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-strcmp$$, $$c$$, $$algorithm$$, 30, $$strcmp$$, $$strcmp 학습$$, $$challenge$$, 2,
$$strcmp을(를) 사용하여 문제를 해결하세요.$$,
$$- strcmp 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* strcmp 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["strcmp의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-struct$$, $$c$$, $$algorithm$$, 31, $$struct$$, $$struct 학습$$, $$challenge$$, 2,
$$struct을(를) 사용하여 문제를 해결하세요.$$,
$$- struct 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* struct 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["struct의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-구조체-변수$$, $$c$$, $$algorithm$$, 32, $$구조체 변수$$, $$구조체 변수 학습$$, $$challenge$$, 2,
$$구조체 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 구조체 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 구조체 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["구조체 변수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-구조체-포인터$$, $$c$$, $$algorithm$$, 33, $$구조체 포인터$$, $$구조체 포인터 학습$$, $$challenge$$, 2,
$$구조체 포인터을(를) 사용하여 문제를 해결하세요.$$,
$$- 구조체 포인터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 구조체 포인터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["구조체 포인터의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-typedef$$, $$c$$, $$algorithm$$, 34, $$typedef$$, $$typedef 학습$$, $$challenge$$, 3,
$$typedef을(를) 사용하여 문제를 해결하세요.$$,
$$- typedef 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* typedef 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["typedef의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-구조체-배열$$, $$c$$, $$algorithm$$, 35, $$구조체 배열$$, $$구조체 배열 학습$$, $$challenge$$, 3,
$$구조체 배열을(를) 사용하여 문제를 해결하세요.$$,
$$- 구조체 배열 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 구조체 배열 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["구조체 배열의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-malloc$$, $$c$$, $$algorithm$$, 36, $$malloc$$, $$malloc 학습$$, $$challenge$$, 3,
$$malloc을(를) 사용하여 문제를 해결하세요.$$,
$$- malloc 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* malloc 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["malloc의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-calloc$$, $$c$$, $$algorithm$$, 37, $$calloc$$, $$calloc 학습$$, $$challenge$$, 3,
$$calloc을(를) 사용하여 문제를 해결하세요.$$,
$$- calloc 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* calloc 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["calloc의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-realloc$$, $$c$$, $$algorithm$$, 38, $$realloc$$, $$realloc 학습$$, $$challenge$$, 3,
$$realloc을(를) 사용하여 문제를 해결하세요.$$,
$$- realloc 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* realloc 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["realloc의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-free$$, $$c$$, $$algorithm$$, 39, $$free$$, $$free 학습$$, $$challenge$$, 3,
$$free을(를) 사용하여 문제를 해결하세요.$$,
$$- free 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* free 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["free의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-메모리-누수$$, $$c$$, $$algorithm$$, 40, $$메모리 누수$$, $$메모리 누수 학습$$, $$challenge$$, 3,
$$메모리 누수을(를) 사용하여 문제를 해결하세요.$$,
$$- 메모리 누수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 메모리 누수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["메모리 누수의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fopen$$, $$c$$, $$algorithm$$, 41, $$fopen$$, $$fopen 학습$$, $$challenge$$, 3,
$$fopen을(를) 사용하여 문제를 해결하세요.$$,
$$- fopen 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fopen 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fopen의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fclose$$, $$c$$, $$algorithm$$, 42, $$fclose$$, $$fclose 학습$$, $$challenge$$, 3,
$$fclose을(를) 사용하여 문제를 해결하세요.$$,
$$- fclose 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fclose 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fclose의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fread$$, $$c$$, $$algorithm$$, 43, $$fread$$, $$fread 학습$$, $$challenge$$, 3,
$$fread을(를) 사용하여 문제를 해결하세요.$$,
$$- fread 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fread 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fread의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fwrite$$, $$c$$, $$algorithm$$, 44, $$fwrite$$, $$fwrite 학습$$, $$challenge$$, 3,
$$fwrite을(를) 사용하여 문제를 해결하세요.$$,
$$- fwrite 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fwrite 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fwrite의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-fprintf$$, $$c$$, $$algorithm$$, 45, $$fprintf$$, $$fprintf 학습$$, $$challenge$$, 3,
$$fprintf을(를) 사용하여 문제를 해결하세요.$$,
$$- fprintf 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* fprintf 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["fprintf의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-#define$$, $$c$$, $$algorithm$$, 46, $$#define$$, $$#define 학습$$, $$challenge$$, 3,
$$#define을(를) 사용하여 문제를 해결하세요.$$,
$$- #define 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* #define 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["#define의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-enum$$, $$c$$, $$algorithm$$, 47, $$enum$$, $$enum 학습$$, $$challenge$$, 3,
$$enum을(를) 사용하여 문제를 해결하세요.$$,
$$- enum 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* enum 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["enum의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-union$$, $$c$$, $$algorithm$$, 48, $$union$$, $$union 학습$$, $$challenge$$, 3,
$$union을(를) 사용하여 문제를 해결하세요.$$,
$$- union 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* union 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["union의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-함수-포인터$$, $$c$$, $$algorithm$$, 49, $$함수 포인터$$, $$함수 포인터 학습$$, $$challenge$$, 3,
$$함수 포인터을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 포인터 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 포인터 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 포인터의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$c-const-pointer$$, $$c$$, $$algorithm$$, 50, $$const pointer$$, $$const pointer 학습$$, $$challenge$$, 3,
$$const pointer을(를) 사용하여 문제를 해결하세요.$$,
$$- const pointer 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* const pointer 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["const pointer의 기본 사용법을 익히세요"]$$,
$$["c", "basics"]$$, 12);

-- ============================================================================
-- CPP Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-int-변수$$, $$cpp$$, $$syntax$$, 1, $$int 변수$$, $$int 변수 학습$$, $$challenge$$, 1,
$$int 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- int 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* int 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["int 변수의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-string-변수$$, $$cpp$$, $$syntax$$, 2, $$string 변수$$, $$string 변수 학습$$, $$challenge$$, 1,
$$string 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- string 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string 변수의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-bool-변수$$, $$cpp$$, $$syntax$$, 3, $$bool 변수$$, $$bool 변수 학습$$, $$challenge$$, 1,
$$bool 변수을(를) 사용하여 문제를 해결하세요.$$,
$$- bool 변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* bool 변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["bool 변수의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-cout$$, $$cpp$$, $$syntax$$, 4, $$cout$$, $$cout 학습$$, $$challenge$$, 1,
$$cout을(를) 사용하여 문제를 해결하세요.$$,
$$- cout 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* cout 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["cout의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-cin$$, $$cpp$$, $$syntax$$, 5, $$cin$$, $$cin 학습$$, $$challenge$$, 1,
$$cin을(를) 사용하여 문제를 해결하세요.$$,
$$- cin 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* cin 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["cin의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-if-else$$, $$cpp$$, $$syntax$$, 6, $$if-else$$, $$if-else 학습$$, $$challenge$$, 1,
$$if-else을(를) 사용하여 문제를 해결하세요.$$,
$$- if-else 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* if-else 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["if-else의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-switch$$, $$cpp$$, $$syntax$$, 7, $$switch$$, $$switch 학습$$, $$challenge$$, 1,
$$switch을(를) 사용하여 문제를 해결하세요.$$,
$$- switch 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* switch 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["switch의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-for$$, $$cpp$$, $$syntax$$, 8, $$for$$, $$for 학습$$, $$challenge$$, 1,
$$for을(를) 사용하여 문제를 해결하세요.$$,
$$- for 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* for 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["for의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-while$$, $$cpp$$, $$syntax$$, 9, $$while$$, $$while 학습$$, $$challenge$$, 1,
$$while을(를) 사용하여 문제를 해결하세요.$$,
$$- while 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* while 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["while의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-range-for$$, $$cpp$$, $$syntax$$, 10, $$range-for$$, $$range-for 학습$$, $$challenge$$, 1,
$$range-for을(를) 사용하여 문제를 해결하세요.$$,
$$- range-for 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* range-for 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["range-for의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-함수$$, $$cpp$$, $$syntax$$, 11, $$함수$$, $$함수 학습$$, $$challenge$$, 1,
$$함수을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-오버로딩$$, $$cpp$$, $$syntax$$, 12, $$오버로딩$$, $$오버로딩 학습$$, $$challenge$$, 1,
$$오버로딩을(를) 사용하여 문제를 해결하세요.$$,
$$- 오버로딩 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 오버로딩 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["오버로딩의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-기본-매개변수$$, $$cpp$$, $$syntax$$, 13, $$기본 매개변수$$, $$기본 매개변수 학습$$, $$challenge$$, 1,
$$기본 매개변수을(를) 사용하여 문제를 해결하세요.$$,
$$- 기본 매개변수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 기본 매개변수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["기본 매개변수의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-inline$$, $$cpp$$, $$syntax$$, 14, $$inline$$, $$inline 학습$$, $$challenge$$, 1,
$$inline을(를) 사용하여 문제를 해결하세요.$$,
$$- inline 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* inline 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["inline의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-auto$$, $$cpp$$, $$syntax$$, 15, $$auto$$, $$auto 학습$$, $$challenge$$, 1,
$$auto을(를) 사용하여 문제를 해결하세요.$$,
$$- auto 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* auto 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["auto의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-vector$$, $$cpp$$, $$syntax$$, 16, $$vector$$, $$vector 학습$$, $$challenge$$, 1,
$$vector을(를) 사용하여 문제를 해결하세요.$$,
$$- vector 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* vector 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["vector의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-string$$, $$cpp$$, $$syntax$$, 17, $$string$$, $$string 학습$$, $$challenge$$, 1,
$$string을(를) 사용하여 문제를 해결하세요.$$,
$$- string 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* string 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["string의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-map$$, $$cpp$$, $$syntax$$, 18, $$map$$, $$map 학습$$, $$challenge$$, 2,
$$map을(를) 사용하여 문제를 해결하세요.$$,
$$- map 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* map 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["map의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-set$$, $$cpp$$, $$syntax$$, 19, $$set$$, $$set 학습$$, $$challenge$$, 2,
$$set을(를) 사용하여 문제를 해결하세요.$$,
$$- set 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* set 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["set의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-pair$$, $$cpp$$, $$syntax$$, 20, $$pair$$, $$pair 학습$$, $$challenge$$, 2,
$$pair을(를) 사용하여 문제를 해결하세요.$$,
$$- pair 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* pair 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["pair의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-class$$, $$cpp$$, $$syntax$$, 21, $$class$$, $$class 학습$$, $$challenge$$, 2,
$$class을(를) 사용하여 문제를 해결하세요.$$,
$$- class 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* class 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["class의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-constructor$$, $$cpp$$, $$syntax$$, 22, $$constructor$$, $$constructor 학습$$, $$challenge$$, 2,
$$constructor을(를) 사용하여 문제를 해결하세요.$$,
$$- constructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constructor의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-destructor$$, $$cpp$$, $$syntax$$, 23, $$destructor$$, $$destructor 학습$$, $$challenge$$, 2,
$$destructor을(를) 사용하여 문제를 해결하세요.$$,
$$- destructor 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* destructor 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["destructor의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-상속$$, $$cpp$$, $$syntax$$, 24, $$상속$$, $$상속 학습$$, $$challenge$$, 2,
$$상속을(를) 사용하여 문제를 해결하세요.$$,
$$- 상속 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 상속 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["상속의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-virtual$$, $$cpp$$, $$syntax$$, 25, $$virtual$$, $$virtual 학습$$, $$challenge$$, 2,
$$virtual을(를) 사용하여 문제를 해결하세요.$$,
$$- virtual 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* virtual 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["virtual의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-+-연산자$$, $$cpp$$, $$algorithm$$, 26, $$+ 연산자$$, $$+ 연산자 학습$$, $$challenge$$, 2,
$$+ 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- + 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* + 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["+ 연산자의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-==-연산자$$, $$cpp$$, $$algorithm$$, 27, $$== 연산자$$, $$== 연산자 학습$$, $$challenge$$, 2,
$$== 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- == 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* == 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["== 연산자의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-[]-연산자$$, $$cpp$$, $$algorithm$$, 28, $$[] 연산자$$, $$[] 연산자 학습$$, $$challenge$$, 2,
$$[] 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- [] 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* [] 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["[] 연산자의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp--연산자$$, $$cpp$$, $$algorithm$$, 29, $$<< 연산자$$, $$<< 연산자 학습$$, $$challenge$$, 2,
$$<< 연산자을(를) 사용하여 문제를 해결하세요.$$,
$$- << 연산자 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* << 연산자 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["<< 연산자의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-friend$$, $$cpp$$, $$algorithm$$, 30, $$friend$$, $$friend 학습$$, $$challenge$$, 2,
$$friend을(를) 사용하여 문제를 해결하세요.$$,
$$- friend 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* friend 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["friend의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-함수-템플릿$$, $$cpp$$, $$algorithm$$, 31, $$함수 템플릿$$, $$함수 템플릿 학습$$, $$challenge$$, 2,
$$함수 템플릿을(를) 사용하여 문제를 해결하세요.$$,
$$- 함수 템플릿 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 함수 템플릿 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["함수 템플릿의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-클래스-템플릿$$, $$cpp$$, $$algorithm$$, 32, $$클래스 템플릿$$, $$클래스 템플릿 학습$$, $$challenge$$, 2,
$$클래스 템플릿을(를) 사용하여 문제를 해결하세요.$$,
$$- 클래스 템플릿 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 클래스 템플릿 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["클래스 템플릿의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-템플릿-특수화$$, $$cpp$$, $$algorithm$$, 33, $$템플릿 특수화$$, $$템플릿 특수화 학습$$, $$challenge$$, 2,
$$템플릿 특수화을(를) 사용하여 문제를 해결하세요.$$,
$$- 템플릿 특수화 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 템플릿 특수화 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["템플릿 특수화의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-variadic$$, $$cpp$$, $$algorithm$$, 34, $$variadic$$, $$variadic 학습$$, $$challenge$$, 3,
$$variadic을(를) 사용하여 문제를 해결하세요.$$,
$$- variadic 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* variadic 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["variadic의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-sfinae$$, $$cpp$$, $$algorithm$$, 35, $$SFINAE$$, $$SFINAE 학습$$, $$challenge$$, 3,
$$SFINAE을(를) 사용하여 문제를 해결하세요.$$,
$$- SFINAE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* SFINAE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["SFINAE의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-unique_ptr$$, $$cpp$$, $$algorithm$$, 36, $$unique_ptr$$, $$unique_ptr 학습$$, $$challenge$$, 3,
$$unique_ptr을(를) 사용하여 문제를 해결하세요.$$,
$$- unique_ptr 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* unique_ptr 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["unique_ptr의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-shared_ptr$$, $$cpp$$, $$algorithm$$, 37, $$shared_ptr$$, $$shared_ptr 학습$$, $$challenge$$, 3,
$$shared_ptr을(를) 사용하여 문제를 해결하세요.$$,
$$- shared_ptr 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* shared_ptr 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["shared_ptr의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-weak_ptr$$, $$cpp$$, $$algorithm$$, 38, $$weak_ptr$$, $$weak_ptr 학습$$, $$challenge$$, 3,
$$weak_ptr을(를) 사용하여 문제를 해결하세요.$$,
$$- weak_ptr 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* weak_ptr 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["weak_ptr의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-make_unique$$, $$cpp$$, $$algorithm$$, 39, $$make_unique$$, $$make_unique 학습$$, $$challenge$$, 3,
$$make_unique을(를) 사용하여 문제를 해결하세요.$$,
$$- make_unique 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* make_unique 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["make_unique의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-make_shared$$, $$cpp$$, $$algorithm$$, 40, $$make_shared$$, $$make_shared 학습$$, $$challenge$$, 3,
$$make_shared을(를) 사용하여 문제를 해결하세요.$$,
$$- make_shared 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* make_shared 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["make_shared의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-람다$$, $$cpp$$, $$algorithm$$, 41, $$람다$$, $$람다 학습$$, $$challenge$$, 3,
$$람다을(를) 사용하여 문제를 해결하세요.$$,
$$- 람다 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 람다 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["람다의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-algorithm$$, $$cpp$$, $$algorithm$$, 42, $$algorithm$$, $$algorithm 학습$$, $$challenge$$, 3,
$$algorithm을(를) 사용하여 문제를 해결하세요.$$,
$$- algorithm 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* algorithm 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["algorithm의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-transform$$, $$cpp$$, $$algorithm$$, 43, $$transform$$, $$transform 학습$$, $$challenge$$, 3,
$$transform을(를) 사용하여 문제를 해결하세요.$$,
$$- transform 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* transform 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["transform의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-find_if$$, $$cpp$$, $$algorithm$$, 44, $$find_if$$, $$find_if 학습$$, $$challenge$$, 3,
$$find_if을(를) 사용하여 문제를 해결하세요.$$,
$$- find_if 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* find_if 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["find_if의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-sort$$, $$cpp$$, $$algorithm$$, 45, $$sort$$, $$sort 학습$$, $$challenge$$, 3,
$$sort을(를) 사용하여 문제를 해결하세요.$$,
$$- sort 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* sort 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["sort의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-auto$$, $$cpp$$, $$algorithm$$, 46, $$auto$$, $$auto 학습$$, $$challenge$$, 3,
$$auto을(를) 사용하여 문제를 해결하세요.$$,
$$- auto 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* auto 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["auto의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-move$$, $$cpp$$, $$algorithm$$, 47, $$move$$, $$move 학습$$, $$challenge$$, 3,
$$move을(를) 사용하여 문제를 해결하세요.$$,
$$- move 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* move 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["move의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-rvalue$$, $$cpp$$, $$algorithm$$, 48, $$rvalue$$, $$rvalue 학습$$, $$challenge$$, 3,
$$rvalue을(를) 사용하여 문제를 해결하세요.$$,
$$- rvalue 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* rvalue 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["rvalue의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-constexpr$$, $$cpp$$, $$algorithm$$, 49, $$constexpr$$, $$constexpr 학습$$, $$challenge$$, 3,
$$constexpr을(를) 사용하여 문제를 해결하세요.$$,
$$- constexpr 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* constexpr 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["constexpr의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$cpp-structured-binding$$, $$cpp$$, $$algorithm$$, 50, $$structured binding$$, $$structured binding 학습$$, $$challenge$$, 3,
$$structured binding을(를) 사용하여 문제를 해결하세요.$$,
$$- structured binding 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* structured binding 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["structured binding의 기본 사용법을 익히세요"]$$,
$$["cpp", "basics"]$$, 12);

-- ============================================================================
-- SQL Language Challenges (50 challenges)
-- ============================================================================

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-select$$, $$sql$$, $$syntax$$, 1, $$SELECT$$, $$SELECT 학습$$, $$challenge$$, 1,
$$SELECT을(를) 사용하여 문제를 해결하세요.$$,
$$- SELECT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* SELECT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["SELECT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-where$$, $$sql$$, $$syntax$$, 2, $$WHERE$$, $$WHERE 학습$$, $$challenge$$, 1,
$$WHERE을(를) 사용하여 문제를 해결하세요.$$,
$$- WHERE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* WHERE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["WHERE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-order-by$$, $$sql$$, $$syntax$$, 3, $$ORDER BY$$, $$ORDER BY 학습$$, $$challenge$$, 1,
$$ORDER BY을(를) 사용하여 문제를 해결하세요.$$,
$$- ORDER BY 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ORDER BY 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ORDER BY의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-limit$$, $$sql$$, $$syntax$$, 4, $$LIMIT$$, $$LIMIT 학습$$, $$challenge$$, 1,
$$LIMIT을(를) 사용하여 문제를 해결하세요.$$,
$$- LIMIT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* LIMIT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["LIMIT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-distinct$$, $$sql$$, $$syntax$$, 5, $$DISTINCT$$, $$DISTINCT 학습$$, $$challenge$$, 1,
$$DISTINCT을(를) 사용하여 문제를 해결하세요.$$,
$$- DISTINCT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* DISTINCT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["DISTINCT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-count$$, $$sql$$, $$syntax$$, 6, $$COUNT$$, $$COUNT 학습$$, $$challenge$$, 1,
$$COUNT을(를) 사용하여 문제를 해결하세요.$$,
$$- COUNT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* COUNT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["COUNT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-sum$$, $$sql$$, $$syntax$$, 7, $$SUM$$, $$SUM 학습$$, $$challenge$$, 1,
$$SUM을(를) 사용하여 문제를 해결하세요.$$,
$$- SUM 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* SUM 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["SUM의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-avg$$, $$sql$$, $$syntax$$, 8, $$AVG$$, $$AVG 학습$$, $$challenge$$, 1,
$$AVG을(를) 사용하여 문제를 해결하세요.$$,
$$- AVG 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* AVG 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["AVG의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-max$$, $$sql$$, $$syntax$$, 9, $$MAX$$, $$MAX 학습$$, $$challenge$$, 1,
$$MAX을(를) 사용하여 문제를 해결하세요.$$,
$$- MAX 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* MAX 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["MAX의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-min$$, $$sql$$, $$syntax$$, 10, $$MIN$$, $$MIN 학습$$, $$challenge$$, 1,
$$MIN을(를) 사용하여 문제를 해결하세요.$$,
$$- MIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* MIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["MIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-group-by$$, $$sql$$, $$syntax$$, 11, $$GROUP BY$$, $$GROUP BY 학습$$, $$challenge$$, 1,
$$GROUP BY을(를) 사용하여 문제를 해결하세요.$$,
$$- GROUP BY 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* GROUP BY 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["GROUP BY의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-having$$, $$sql$$, $$syntax$$, 12, $$HAVING$$, $$HAVING 학습$$, $$challenge$$, 1,
$$HAVING을(를) 사용하여 문제를 해결하세요.$$,
$$- HAVING 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* HAVING 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["HAVING의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-집계-조건$$, $$sql$$, $$syntax$$, 13, $$집계 조건$$, $$집계 조건 학습$$, $$challenge$$, 1,
$$집계 조건을(를) 사용하여 문제를 해결하세요.$$,
$$- 집계 조건 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 집계 조건 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["집계 조건의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-다중-그룹$$, $$sql$$, $$syntax$$, 14, $$다중 그룹$$, $$다중 그룹 학습$$, $$challenge$$, 1,
$$다중 그룹을(를) 사용하여 문제를 해결하세요.$$,
$$- 다중 그룹 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 다중 그룹 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["다중 그룹의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-rollup$$, $$sql$$, $$syntax$$, 15, $$ROLLUP$$, $$ROLLUP 학습$$, $$challenge$$, 1,
$$ROLLUP을(를) 사용하여 문제를 해결하세요.$$,
$$- ROLLUP 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ROLLUP 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ROLLUP의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-inner-join$$, $$sql$$, $$syntax$$, 16, $$INNER JOIN$$, $$INNER JOIN 학습$$, $$challenge$$, 1,
$$INNER JOIN을(를) 사용하여 문제를 해결하세요.$$,
$$- INNER JOIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* INNER JOIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["INNER JOIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-left-join$$, $$sql$$, $$syntax$$, 17, $$LEFT JOIN$$, $$LEFT JOIN 학습$$, $$challenge$$, 1,
$$LEFT JOIN을(를) 사용하여 문제를 해결하세요.$$,
$$- LEFT JOIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* LEFT JOIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["LEFT JOIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 5);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-right-join$$, $$sql$$, $$syntax$$, 18, $$RIGHT JOIN$$, $$RIGHT JOIN 학습$$, $$challenge$$, 2,
$$RIGHT JOIN을(를) 사용하여 문제를 해결하세요.$$,
$$- RIGHT JOIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* RIGHT JOIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["RIGHT JOIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-full-join$$, $$sql$$, $$syntax$$, 19, $$FULL JOIN$$, $$FULL JOIN 학습$$, $$challenge$$, 2,
$$FULL JOIN을(를) 사용하여 문제를 해결하세요.$$,
$$- FULL JOIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* FULL JOIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["FULL JOIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-cross-join$$, $$sql$$, $$syntax$$, 20, $$CROSS JOIN$$, $$CROSS JOIN 학습$$, $$challenge$$, 2,
$$CROSS JOIN을(를) 사용하여 문제를 해결하세요.$$,
$$- CROSS JOIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CROSS JOIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CROSS JOIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-스칼라-서브쿼리$$, $$sql$$, $$syntax$$, 21, $$스칼라 서브쿼리$$, $$스칼라 서브쿼리 학습$$, $$challenge$$, 2,
$$스칼라 서브쿼리을(를) 사용하여 문제를 해결하세요.$$,
$$- 스칼라 서브쿼리 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 스칼라 서브쿼리 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["스칼라 서브쿼리의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-in-서브쿼리$$, $$sql$$, $$syntax$$, 22, $$IN 서브쿼리$$, $$IN 서브쿼리 학습$$, $$challenge$$, 2,
$$IN 서브쿼리을(를) 사용하여 문제를 해결하세요.$$,
$$- IN 서브쿼리 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* IN 서브쿼리 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["IN 서브쿼리의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-exists$$, $$sql$$, $$syntax$$, 23, $$EXISTS$$, $$EXISTS 학습$$, $$challenge$$, 2,
$$EXISTS을(를) 사용하여 문제를 해결하세요.$$,
$$- EXISTS 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* EXISTS 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["EXISTS의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-any$$, $$sql$$, $$syntax$$, 24, $$ANY$$, $$ANY 학습$$, $$challenge$$, 2,
$$ANY을(를) 사용하여 문제를 해결하세요.$$,
$$- ANY 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ANY 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ANY의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-all$$, $$sql$$, $$syntax$$, 25, $$ALL$$, $$ALL 학습$$, $$challenge$$, 2,
$$ALL을(를) 사용하여 문제를 해결하세요.$$,
$$- ALL 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ALL 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ALL의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-insert$$, $$sql$$, $$algorithm$$, 26, $$INSERT$$, $$INSERT 학습$$, $$challenge$$, 2,
$$INSERT을(를) 사용하여 문제를 해결하세요.$$,
$$- INSERT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* INSERT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["INSERT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-update$$, $$sql$$, $$algorithm$$, 27, $$UPDATE$$, $$UPDATE 학습$$, $$challenge$$, 2,
$$UPDATE을(를) 사용하여 문제를 해결하세요.$$,
$$- UPDATE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* UPDATE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["UPDATE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-delete$$, $$sql$$, $$algorithm$$, 28, $$DELETE$$, $$DELETE 학습$$, $$challenge$$, 2,
$$DELETE을(를) 사용하여 문제를 해결하세요.$$,
$$- DELETE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* DELETE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["DELETE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-upsert$$, $$sql$$, $$algorithm$$, 29, $$UPSERT$$, $$UPSERT 학습$$, $$challenge$$, 2,
$$UPSERT을(를) 사용하여 문제를 해결하세요.$$,
$$- UPSERT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* UPSERT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["UPSERT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-returning$$, $$sql$$, $$algorithm$$, 30, $$RETURNING$$, $$RETURNING 학습$$, $$challenge$$, 2,
$$RETURNING을(를) 사용하여 문제를 해결하세요.$$,
$$- RETURNING 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* RETURNING 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["RETURNING의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-create-table$$, $$sql$$, $$algorithm$$, 31, $$CREATE TABLE$$, $$CREATE TABLE 학습$$, $$challenge$$, 2,
$$CREATE TABLE을(를) 사용하여 문제를 해결하세요.$$,
$$- CREATE TABLE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CREATE TABLE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CREATE TABLE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-alter-table$$, $$sql$$, $$algorithm$$, 32, $$ALTER TABLE$$, $$ALTER TABLE 학습$$, $$challenge$$, 2,
$$ALTER TABLE을(를) 사용하여 문제를 해결하세요.$$,
$$- ALTER TABLE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ALTER TABLE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ALTER TABLE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-drop-table$$, $$sql$$, $$algorithm$$, 33, $$DROP TABLE$$, $$DROP TABLE 학습$$, $$challenge$$, 2,
$$DROP TABLE을(를) 사용하여 문제를 해결하세요.$$,
$$- DROP TABLE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* DROP TABLE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["DROP TABLE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 8);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-truncate$$, $$sql$$, $$algorithm$$, 34, $$TRUNCATE$$, $$TRUNCATE 학습$$, $$challenge$$, 3,
$$TRUNCATE을(를) 사용하여 문제를 해결하세요.$$,
$$- TRUNCATE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* TRUNCATE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["TRUNCATE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-constraints$$, $$sql$$, $$algorithm$$, 35, $$CONSTRAINTS$$, $$CONSTRAINTS 학습$$, $$challenge$$, 3,
$$CONSTRAINTS을(를) 사용하여 문제를 해결하세요.$$,
$$- CONSTRAINTS 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CONSTRAINTS 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CONSTRAINTS의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-create-index$$, $$sql$$, $$algorithm$$, 36, $$CREATE INDEX$$, $$CREATE INDEX 학습$$, $$challenge$$, 3,
$$CREATE INDEX을(를) 사용하여 문제를 해결하세요.$$,
$$- CREATE INDEX 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CREATE INDEX 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CREATE INDEX의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-drop-index$$, $$sql$$, $$algorithm$$, 37, $$DROP INDEX$$, $$DROP INDEX 학습$$, $$challenge$$, 3,
$$DROP INDEX을(를) 사용하여 문제를 해결하세요.$$,
$$- DROP INDEX 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* DROP INDEX 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["DROP INDEX의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-create-view$$, $$sql$$, $$algorithm$$, 38, $$CREATE VIEW$$, $$CREATE VIEW 학습$$, $$challenge$$, 3,
$$CREATE VIEW을(를) 사용하여 문제를 해결하세요.$$,
$$- CREATE VIEW 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CREATE VIEW 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CREATE VIEW의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-materialized-view$$, $$sql$$, $$algorithm$$, 39, $$Materialized View$$, $$Materialized View 학습$$, $$challenge$$, 3,
$$Materialized View을(를) 사용하여 문제를 해결하세요.$$,
$$- Materialized View 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* Materialized View 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["Materialized View의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-인덱스-전략$$, $$sql$$, $$algorithm$$, 40, $$인덱스 전략$$, $$인덱스 전략 학습$$, $$challenge$$, 3,
$$인덱스 전략을(를) 사용하여 문제를 해결하세요.$$,
$$- 인덱스 전략 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* 인덱스 전략 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["인덱스 전략의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-begin$$, $$sql$$, $$algorithm$$, 41, $$BEGIN$$, $$BEGIN 학습$$, $$challenge$$, 3,
$$BEGIN을(를) 사용하여 문제를 해결하세요.$$,
$$- BEGIN 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* BEGIN 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["BEGIN의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-commit$$, $$sql$$, $$algorithm$$, 42, $$COMMIT$$, $$COMMIT 학습$$, $$challenge$$, 3,
$$COMMIT을(를) 사용하여 문제를 해결하세요.$$,
$$- COMMIT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* COMMIT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["COMMIT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-rollback$$, $$sql$$, $$algorithm$$, 43, $$ROLLBACK$$, $$ROLLBACK 학습$$, $$challenge$$, 3,
$$ROLLBACK을(를) 사용하여 문제를 해결하세요.$$,
$$- ROLLBACK 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ROLLBACK 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ROLLBACK의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-savepoint$$, $$sql$$, $$algorithm$$, 44, $$SAVEPOINT$$, $$SAVEPOINT 학습$$, $$challenge$$, 3,
$$SAVEPOINT을(를) 사용하여 문제를 해결하세요.$$,
$$- SAVEPOINT 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* SAVEPOINT 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["SAVEPOINT의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-isolation$$, $$sql$$, $$algorithm$$, 45, $$ISOLATION$$, $$ISOLATION 학습$$, $$challenge$$, 3,
$$ISOLATION을(를) 사용하여 문제를 해결하세요.$$,
$$- ISOLATION 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* ISOLATION 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["ISOLATION의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-window-함수$$, $$sql$$, $$algorithm$$, 46, $$WINDOW 함수$$, $$WINDOW 함수 학습$$, $$challenge$$, 3,
$$WINDOW 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- WINDOW 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* WINDOW 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["WINDOW 함수의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-cte$$, $$sql$$, $$algorithm$$, 47, $$CTE$$, $$CTE 학습$$, $$challenge$$, 3,
$$CTE을(를) 사용하여 문제를 해결하세요.$$,
$$- CTE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* CTE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["CTE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-recursive$$, $$sql$$, $$algorithm$$, 48, $$RECURSIVE$$, $$RECURSIVE 학습$$, $$challenge$$, 3,
$$RECURSIVE을(를) 사용하여 문제를 해결하세요.$$,
$$- RECURSIVE 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* RECURSIVE 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["RECURSIVE의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-json-함수$$, $$sql$$, $$algorithm$$, 49, $$JSON 함수$$, $$JSON 함수 학습$$, $$challenge$$, 3,
$$JSON 함수을(를) 사용하여 문제를 해결하세요.$$,
$$- JSON 함수 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* JSON 함수 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["JSON 함수의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);

INSERT INTO challenges (slug, language, kind, level, title, description, category, difficulty, problem_description, constraints, examples, initial_code, solution_code, test_cases, hints, tags, estimated_time) VALUES
($$sql-trigger$$, $$sql$$, $$algorithm$$, 50, $$TRIGGER$$, $$TRIGGER 학습$$, $$challenge$$, 3,
$$TRIGGER을(를) 사용하여 문제를 해결하세요.$$,
$$- TRIGGER 사용
- 기본 문법 준수$$,
$$[{"input": "", "output": "결과"}]$$,
$$/* TRIGGER 코드를 작성하세요 */$$,
$$/* 정답 코드 */$$,
$$[{"input": "", "expected": "output"}]$$,
$$["TRIGGER의 기본 사용법을 익히세요"]$$,
$$["sql", "basics"]$$, 12);
-- ============================================================================
-- 전체 650개 챌린지 생성 완료!
-- ============================================================================

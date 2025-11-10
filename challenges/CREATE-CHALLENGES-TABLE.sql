-- ============================================================================
-- challenges 테이블 생성 스키마
-- ============================================================================

-- 기존 테이블이 있다면 삭제 (주의: 모든 데이터가 삭제됩니다!)
-- DROP TABLE IF EXISTS challenges CASCADE;

-- challenges 테이블 생성
CREATE TABLE IF NOT EXISTS challenges (
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
CREATE INDEX IF NOT EXISTS idx_challenges_language ON challenges(language);
CREATE INDEX IF NOT EXISTS idx_challenges_level ON challenges(level);
CREATE INDEX IF NOT EXISTS idx_challenges_difficulty ON challenges(difficulty);
CREATE INDEX IF NOT EXISTS idx_challenges_kind ON challenges(kind);
CREATE INDEX IF NOT EXISTS idx_challenges_category ON challenges(category);
CREATE INDEX IF NOT EXISTS idx_challenges_tags ON challenges USING GIN(tags);

-- 제약 조건 추가
ALTER TABLE challenges
ADD CONSTRAINT check_difficulty CHECK (difficulty BETWEEN 1 AND 3),
ADD CONSTRAINT check_level CHECK (level BETWEEN 1 AND 100),
ADD CONSTRAINT check_estimated_time CHECK (estimated_time > 0);

-- 주석 추가
COMMENT ON TABLE challenges IS '프로그래밍 챌린지 문제 테이블';
COMMENT ON COLUMN challenges.slug IS 'URL-friendly 고유 식별자';
COMMENT ON COLUMN challenges.language IS '프로그래밍 언어 (html, css, javascript 등)';
COMMENT ON COLUMN challenges.kind IS '문제 유형 (syntax, algorithm, project 등)';
COMMENT ON COLUMN challenges.level IS '난이도 레벨 (1-50, 숫자가 높을수록 어려움)';
COMMENT ON COLUMN challenges.difficulty IS '난이도 (1: 쉬움, 2: 보통, 3: 어려움)';
COMMENT ON COLUMN challenges.estimated_time IS '예상 소요 시간 (분)';

-- RLS (Row Level Security) 활성화 (Supabase 권장)
ALTER TABLE challenges ENABLE ROW LEVEL SECURITY;

-- 모든 사용자가 읽을 수 있도록 정책 추가
CREATE POLICY "Anyone can read challenges" ON challenges
    FOR SELECT USING (true);

-- 인증된 사용자만 생성/수정/삭제 가능 (선택사항)
-- CREATE POLICY "Authenticated users can insert challenges" ON challenges
--     FOR INSERT WITH CHECK (auth.role() = 'authenticated');
--
-- CREATE POLICY "Authenticated users can update challenges" ON challenges
--     FOR UPDATE USING (auth.role() = 'authenticated');
--
-- CREATE POLICY "Authenticated users can delete challenges" ON challenges
--     FOR DELETE USING (auth.role() = 'authenticated');

-- 완료 메시지
DO $$
BEGIN
    RAISE NOTICE 'challenges 테이블이 성공적으로 생성되었습니다!';
END $$;

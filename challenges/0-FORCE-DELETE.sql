-- ============================================================================
-- 강제 삭제 및 확인
-- ============================================================================

-- 1. 기존 정책 삭제
DROP POLICY IF EXISTS "Anyone can read challenges" ON challenges;

-- 2. 테이블 완전 삭제
DROP TABLE IF EXISTS challenges CASCADE;

-- 3. 확인
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_tables
        WHERE schemaname = 'public'
        AND tablename = 'challenges'
    ) THEN
        RAISE NOTICE 'challenges 테이블이 성공적으로 삭제되었습니다.';
    ELSE
        RAISE NOTICE 'WARNING: challenges 테이블이 여전히 존재합니다!';
    END IF;
END $$;

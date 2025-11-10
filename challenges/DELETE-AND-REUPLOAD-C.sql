-- ============================================================================
-- C 언어 챌린지 삭제 및 재업로드 스크립트
-- ============================================================================
-- 사용법:
-- 1. 이 파일을 Supabase SQL Editor에서 먼저 실행
-- 2. 그 다음 c-challenges.sql 파일을 업로드
-- ============================================================================

-- 1. 기존 C 언어 챌린지 모두 삭제
DELETE FROM challenges WHERE language = 'c';

-- 2. 삭제 결과 확인
SELECT
    CASE
        WHEN COUNT(*) = 0 THEN 'SUCCESS: C 챌린지가 모두 삭제되었습니다. 이제 c-challenges.sql을 업로드하세요.'
        ELSE 'ERROR: 아직 ' || COUNT(*) || '개의 C 챌린지가 남아있습니다.'
    END as status
FROM challenges
WHERE language = 'c';

-- ============================================================================
-- 모든 챌린지 삭제 스크립트
-- ============================================================================
-- ⚠️ 경고: 이 스크립트는 challenges 테이블의 모든 데이터를 삭제합니다!
-- 사용 전 반드시 백업을 확인하세요.
-- ============================================================================

-- 삭제 전 현재 상태 확인
SELECT '=== 삭제 전 상태 ===' as info;
SELECT language, COUNT(*) as count
FROM challenges
GROUP BY language
ORDER BY language;

-- 모든 챌린지 삭제
DELETE FROM challenges;

-- 삭제 후 확인
SELECT '=== 삭제 후 상태 ===' as info;
SELECT COUNT(*) as total_count FROM challenges;

SELECT
    CASE
        WHEN COUNT(*) = 0 THEN '✅ SUCCESS: 모든 챌린지가 삭제되었습니다. 이제 언어별 파일을 업로드하세요.'
        ELSE '⚠️ WARNING: 아직 ' || COUNT(*) || '개의 챌린지가 남아있습니다.'
    END as status
FROM challenges;

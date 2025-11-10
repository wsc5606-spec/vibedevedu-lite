-- ============================================================================
-- 모든 챌린지 삭제 및 초기화
-- ============================================================================
-- 실행 전 확인: 이 스크립트는 모든 챌린지를 삭제합니다!
-- ============================================================================

-- 현재 상태 확인
SELECT '=== 삭제 전 현황 ===' as status;
SELECT language, COUNT(*) as count
FROM challenges
GROUP BY language
ORDER BY language;

-- 모든 챌린지 삭제
DELETE FROM challenges;

-- 삭제 확인
SELECT '=== 삭제 완료 ===' as status;
SELECT COUNT(*) as remaining_challenges FROM challenges;

-- 언어별 확인
SELECT language, COUNT(*) as count
FROM challenges
GROUP BY language
ORDER BY language;

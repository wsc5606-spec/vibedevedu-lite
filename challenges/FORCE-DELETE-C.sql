-- ============================================================================
-- C 언어 챌린지 강제 삭제 스크립트
-- ============================================================================

-- 1. 현재 C 챌린지 개수 확인
SELECT
    '현재 C 챌린지 개수' as info,
    COUNT(*) as count
FROM challenges
WHERE language = 'c';

-- 2. 일부 slug 샘플 확인
SELECT
    '현재 존재하는 C 챌린지 slug 샘플' as info,
    slug
FROM challenges
WHERE language = 'c'
LIMIT 10;

-- 3. C 언어 챌린지 강제 삭제 (작은따옴표 'c'로 시도)
DELETE FROM challenges WHERE language = 'c';

-- 4. C 언어 챌린지 강제 삭제 (slug 패턴으로도 시도)
DELETE FROM challenges WHERE slug LIKE 'c-%';

-- 5. 삭제 결과 최종 확인
SELECT
    '삭제 후 C 챌린지 개수' as info,
    COUNT(*) as count
FROM challenges
WHERE language = 'c' OR slug LIKE 'c-%';

-- 6. 전체 언어별 챌린지 개수 확인
SELECT
    '전체 언어별 챌린지' as info;

SELECT
    language,
    COUNT(*) as count
FROM challenges
GROUP BY language
ORDER BY language;

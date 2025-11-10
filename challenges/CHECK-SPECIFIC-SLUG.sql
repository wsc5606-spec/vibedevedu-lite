-- ============================================================================
-- 특정 slug 존재 여부 확인 및 삭제
-- ============================================================================

-- 1. c-pattern-triangle slug가 정말 존재하는지 확인
SELECT
    'c-pattern-triangle 존재 여부' as info,
    COUNT(*) as count
FROM challenges
WHERE slug = 'c-pattern-triangle';

-- 2. 해당 slug의 전체 정보 확인
SELECT *
FROM challenges
WHERE slug = 'c-pattern-triangle';

-- 3. 존재한다면 삭제
DELETE FROM challenges WHERE slug = 'c-pattern-triangle';

-- 4. 삭제 후 재확인
SELECT
    '삭제 후 c-pattern-triangle 존재 여부' as info,
    COUNT(*) as count
FROM challenges
WHERE slug = 'c-pattern-triangle';

-- 5. c-로 시작하는 모든 slug 확인
SELECT
    'c-로 시작하는 모든 챌린지' as info;

SELECT slug, language, title
FROM challenges
WHERE slug LIKE 'c-%'
ORDER BY slug
LIMIT 20;

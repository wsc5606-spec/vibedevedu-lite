-- ============================================================================
-- 병합된 모든 챌린지 업로드 스크립트
-- ============================================================================
-- 이 스크립트는 기존 챌린지를 모두 삭제하고 새로 병합된 챌린지를 업로드합니다
-- 13개 언어 × 40문제 = 총 520개 챌린지
-- ============================================================================

-- 1단계: 기존 챌린지 삭제
DELETE FROM challenges;

SELECT '=== 기존 챌린지 삭제 완료 ===' as step;

-- 2단계: 각 언어별 챌린지 파일을 순서대로 실행하세요:
--
-- Supabase SQL Editor에서 다음 파일들을 순서대로 실행:
-- 1. html-challenges.sql
-- 2. css-challenges.sql
-- 3. javascript-challenges.sql
-- 4. typescript-challenges.sql
-- 5. python-challenges.sql
-- 6. dart-challenges.sql
-- 7. kotlin-challenges.sql
-- 8. csharp-challenges.sql
-- 9. java-challenges.sql
-- 10. go-challenges.sql
-- 11. c-challenges.sql
-- 12. cpp-challenges.sql
-- 13. sql-challenges.sql

-- 또는 PowerShell로 자동 업로드:
-- $languages = @('html', 'css', 'javascript', 'typescript', 'python', 'dart', 'kotlin', 'csharp', 'java', 'go', 'c', 'cpp', 'sql')
-- foreach ($lang in $languages) {
--     Write-Host "Uploading $lang-challenges.sql..."
--     # Supabase CLI를 사용하거나 웹 인터페이스에서 수동 업로드
-- }

SELECT '=== 업로드 안내 ===' as step;
SELECT 'Supabase SQL Editor에서 각 언어별 챌린지 파일을 업로드하세요' as instruction;

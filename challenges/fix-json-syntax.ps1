# Fix JSON syntax in all SQL files by adding ::jsonb casting

$languages = @('c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html', 'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript')

foreach ($lang in $languages) {
    foreach ($part in @(1, 2)) {
        $file = "$lang-part$part.sql"

        if (Test-Path $file) {
            Write-Host "🔧 $file 수정 중..."

            $content = Get-Content $file -Raw -Encoding UTF8

            # JSON 배열 필드에 ::jsonb 추가
            # examples 필드 (test_cases보다 먼저 나옴)
            $content = $content -replace "('\[.*?\]'),(\s*--\s*examples)", "`$1::jsonb,`$2"

            # test_cases 필드
            $content = $content -replace "('\[.*?\]'),(\s*--\s*test_cases)", "`$1::jsonb,`$2"

            # tags 필드는 ARRAY['...'] 형식이므로 그대로 유지

            Set-Content $file $content -Encoding UTF8 -NoNewline
            Write-Host "   ✅ 완료"
        }
    }
}

Write-Host "`n✅ 모든 파일 수정 완료!"
Write-Host "💡 이제 combine-all-files.ps1을 실행하여 UPLOAD-ALL-NEW.sql을 다시 생성하세요."

# 26개 SQL 파일을 하나로 통합

$outputFile = 'UPLOAD-ALL-NEW.sql'

# 언어 목록
$languages = @('c', 'cpp', 'csharp', 'css', 'dart', 'go', 'html', 'java', 'javascript', 'kotlin', 'python', 'sql', 'typescript')

foreach ($lang in $languages) {
    Write-Host "추가 중: $lang..."

    # part1 추가
    if (Test-Path "$lang-part1.sql") {
        Add-Content $outputFile "`n-- ========== $lang Part 1 ==========`n"
        Get-Content "$lang-part1.sql" | Add-Content $outputFile
    }

    # part2 추가
    if (Test-Path "$lang-part2.sql") {
        Add-Content $outputFile "`n-- ========== $lang Part 2 ==========`n"
        Get-Content "$lang-part2.sql" | Add-Content $outputFile
    }
}

Write-Host "`n✅ 통합 파일 생성 완료: UPLOAD-ALL-NEW.sql"
$size = (Get-Item $outputFile).Length / 1MB
Write-Host "📊 파일 크기: $([math]::Round($size, 2)) MB"

# SQL 파일 자동 수정 스크립트

# 언어별 테이블명 매핑
$langMap = @{
    'c' = 'challenges_c'
    'cpp' = 'challenges_cpp'
    'csharp' = 'challenges_csharp'
    'css' = 'challenges_css'
    'dart' = 'challenges_dart'
    'go' = 'challenges_go'
    'html' = 'challenges_html'
    'java' = 'challenges_java'
    'javascript' = 'challenges_javascript'
    'kotlin' = 'challenges_kotlin'
    'python' = 'challenges_python'
    'sql' = 'challenges_sql'
    'typescript' = 'challenges_typescript'
}

$count = 0
foreach ($lang in $langMap.Keys) {
    $tableName = $langMap[$lang]
    $part1 = "$lang-part1.sql"
    $part2 = "$lang-part2.sql"

    # part1 수정
    if (Test-Path $part1) {
        (Get-Content $part1 -Raw) -replace 'INSERT INTO challenges ', "INSERT INTO $tableName " | Set-Content $part1
        Write-Host "✅ $part1 수정 완료"
        $count++
    }

    # part2 수정
    if (Test-Path $part2) {
        (Get-Content $part2 -Raw) -replace 'INSERT INTO challenges ', "INSERT INTO $tableName " | Set-Content $part2
        Write-Host "✅ $part2 수정 완료"
        $count++
    }
}

Write-Host ""
Write-Host "🎉 총 $count개 파일 수정 완료!"

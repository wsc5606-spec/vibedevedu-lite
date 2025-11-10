# RAISE 블록 제거 스크립트

Get-ChildItem -Filter *.sql | Where-Object { $_.Name -notlike '*.backup' } | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace '(?s)DO \$\$.*?END \$\$;', ''
    Set-Content $_.FullName $content
}

Write-Host "✅ 모든 파일에서 RAISE 블록 제거 완료!"

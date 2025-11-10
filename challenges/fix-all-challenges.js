const fs = require('fs');
const path = require('path');

// 모든 언어 파일 리스트 (업로드 가이드 순서대로)
const languages = [
    'html',
    'css',
    'javascript',
    'typescript',
    'python',
    'dart',
    'kotlin',
    'c',
    'cpp',
    'csharp',
    'java',
    'go',
    'sql'
];

console.log('='.repeat(70));
console.log('챌린지 파일 일괄 수정 스크립트');
console.log('='.repeat(70));
console.log();

let totalFiles = 0;
let totalFixes = 0;

languages.forEach(lang => {
    const fileName = `${lang}-challenges.sql`;
    const filePath = path.join(__dirname, fileName);

    // 파일 존재 확인
    if (!fs.existsSync(filePath)) {
        console.log(`⚠️  ${fileName} - 파일 없음, 건너뜀`);
        console.log();
        return;
    }

    console.log(`📝 ${fileName} 처리 중...`);

    let content = fs.readFileSync(filePath, 'utf8');
    let fixCount = 0;

    // 1. Fix nested $func$NUMBER$func$ patterns
    const nestedNumberPattern = /\$func\$(\d+)\$func\$/g;
    content = content.replace(nestedNumberPattern, (match, num) => {
        fixCount++;
        if (num === '65') return "'A'";
        if (num === '10') return "'\\n'";
        if (num === '32') return "' '";
        if (num === '48') return "'0'";
        return num;
    });

    // 2. Fix double single quotes in character literals
    const doubleQuotePattern = /''([^']+)''/g;
    content = content.replace(doubleQuotePattern, (match, char) => {
        fixCount++;
        return `'${char}'`;
    });

    // 3. Fix case $func$'X': patterns
    const casePattern = /case \$func\$'([^']+)':/g;
    content = content.replace(casePattern, (match, char) => {
        fixCount++;
        return `case '${char}':`;
    });

    // 4. Fix putchar($func$X$func$) patterns
    const putcharPattern = /putchar\(\$func\$'([^']+)'\$func\$/g;
    content = content.replace(putcharPattern, (match, char) => {
        fixCount++;
        return `putchar('${char}')`;
    });

    // 5. Fix mixed delimiters - slug patterns
    const mixedPattern1 = /\(\$func\$([a-zA-Z0-9-]+)\$\$/g;
    content = content.replace(mixedPattern1, (match, slug) => {
        fixCount++;
        return `($$${slug}$$`;
    });

    // 6. Fix mixed delimiters - category patterns
    const mixedPattern2 = /\$\$([a-zA-Z0-9-]+)\$func\$/g;
    content = content.replace(mixedPattern2, (match, slug) => {
        fixCount++;
        return `$$${slug}$$`;
    });

    // 7. Fix hints field with wrong delimiter (critical!)
    const hintsPattern = /\$func\$\["([^"]+)"\]'/g;
    content = content.replace(hintsPattern, (match, hint) => {
        fixCount++;
        return `$$["${hint}"]$$`;
    });

    // Write back
    fs.writeFileSync(filePath, content, 'utf8');

    if (fixCount > 0) {
        console.log(`   ✅ ${fixCount}개 수정 완료`);
        totalFixes += fixCount;
        totalFiles++;
    } else {
        console.log(`   ℹ️  수정 사항 없음`);
    }
    console.log();
});

console.log('='.repeat(70));
console.log(`완료! ${totalFiles}개 파일에서 총 ${totalFixes}개 수정됨`);
console.log('='.repeat(70));

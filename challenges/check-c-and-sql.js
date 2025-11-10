const fs = require('fs');
const path = require('path');

console.log('C와 SQL 파일 상세 점검 중...\n');

['c-challenges.sql', 'sql-challenges.sql'].forEach(fileName => {
    console.log(`\n${'='.repeat(70)}`);
    console.log(`검사 중: ${fileName}`);
    console.log('='.repeat(70));

    const filePath = path.join(__dirname, fileName);
    if (!fs.existsSync(filePath)) {
        console.log('파일 없음!');
        return;
    }

    const content = fs.readFileSync(filePath, 'utf8');

    // 1. 중첩된 $func$ 패턴 찾기
    const nestedPattern = /\$func\$\d+\$func\$/g;
    const nestedMatches = content.match(nestedPattern);
    if (nestedMatches) {
        console.log(`\n⚠️  중첩된 숫자 패턴 발견: ${nestedMatches.length}개`);
        nestedMatches.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    // 2. 이중 작은따옴표 찾기
    const doubleQuotePattern = /''[^']+''/g;
    const doubleQuoteMatches = content.match(doubleQuotePattern);
    if (doubleQuoteMatches) {
        console.log(`\n⚠️  이중 작은따옴표 발견: ${doubleQuoteMatches.length}개`);
        doubleQuoteMatches.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    // 3. 혼합 구분자 찾기
    const mixedPattern1 = /\(\$func\$[a-zA-Z0-9-]+\$\$/g;
    const mixed1 = content.match(mixedPattern1);
    if (mixed1) {
        console.log(`\n⚠️  혼합 구분자 ($func$...$$): ${mixed1.length}개`);
        mixed1.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    const mixedPattern2 = /\$\$[a-zA-Z0-9-]+\$func\$/g;
    const mixed2 = content.match(mixedPattern2);
    if (mixed2) {
        console.log(`\n⚠️  혼합 구분자 ($$...$func$): ${mixed2.length}개`);
        mixed2.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    // 4. hints 필드 잘못된 구분자
    const hintsPattern = /\$func\$\["[^"]+"\]'/g;
    const hintsMatches = content.match(hintsPattern);
    if (hintsMatches) {
        console.log(`\n⚠️  hints 필드 구분자 오류: ${hintsMatches.length}개`);
        hintsMatches.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    // 5. case 문 중첩 구분자
    const casePattern = /case \$func\$'[^']+'/g;
    const caseMatches = content.match(casePattern);
    if (caseMatches) {
        console.log(`\n⚠️  case 문 중첩 구분자: ${caseMatches.length}개`);
        caseMatches.slice(0, 5).forEach(m => console.log(`   ${m}`));
    }

    console.log(`\n✅ ${fileName} 점검 완료`);
});

console.log('\n' + '='.repeat(70));
console.log('점검 완료!');
console.log('='.repeat(70));

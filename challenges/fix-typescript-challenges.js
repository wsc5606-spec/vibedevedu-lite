const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'typescript-challenges.sql');

console.log('Reading file...');
let content = fs.readFileSync(filePath, 'utf8');

let fixCount = 0;

// 1. Fix nested $func$NUMBER$func$ patterns (like $func$65$func$, $func$10$func$)
console.log('Fixing nested $func$NUMBER$func$ patterns...');
const nestedNumberPattern = /\$func\$(\d+)\$func\$/g;
content = content.replace(nestedNumberPattern, (match, num) => {
    fixCount++;
    // Convert ASCII numbers to their character equivalents
    if (num === '65') return "'A'";
    if (num === '10') return "'\\n'";
    if (num === '32') return "' '";
    if (num === '48') return "'0'";
    // Add more mappings as needed
    console.log(`  Found: ${match} -> using numeric value: ${num}`);
    return num; // fallback to just the number
});

// 2. Fix double single quotes in character literals (like ''-'', ''*'', ''/'')
console.log('Fixing double single quotes in character literals...');
const doubleQuotePattern = /''([^']+)''/g;
content = content.replace(doubleQuotePattern, (match, char) => {
    fixCount++;
    console.log(`  Fixed: ${match} -> '${char}'`);
    return `'${char}'`;
});

// 3. Fix case $func$'X': patterns
console.log("Fixing case $func$'X': patterns...");
const casePattern = /case \$func\$'([^']+)':/g;
content = content.replace(casePattern, (match, char) => {
    fixCount++;
    console.log(`  Fixed: ${match} -> case '${char}':`);
    return `case '${char}':`;
});

// 4. Fix putchar($func$X$func$) patterns
console.log('Fixing putchar($func$X$func$) patterns...');
const putcharPattern = /putchar\(\$func\$'([^']+)'\$func\$/g;
content = content.replace(putcharPattern, (match, char) => {
    fixCount++;
    console.log(`  Fixed: ${match} -> putchar('${char}')`);
    return `putchar('${char}')`;
});

// 5. Fix mixed delimiters ($$....$func$ or $func$....$$)
console.log('Fixing mixed delimiter patterns...');
const mixedPattern1 = /\(\$func\$([a-zA-Z0-9-]+)\$\$/g;
content = content.replace(mixedPattern1, (match, slug) => {
    fixCount++;
    console.log(`  Fixed: ${match} -> ($$${slug}$$`);
    return `($$${slug}$$`;
});

const mixedPattern2 = /\$\$([a-zA-Z0-9-]+)\$func\$/g;
content = content.replace(mixedPattern2, (match, slug) => {
    fixCount++;
    console.log(`  Fixed: ${match} -> $$${slug}$$`);
    return `$$${slug}$$`;
});

// 6. Look for any remaining nested $func$ patterns
console.log('\nSearching for remaining nested $func$ patterns...');
const remainingPattern = /\$func\$[^$]*?\$func\$[^$]*?\$func\$/g;
const remainingMatches = content.match(remainingPattern);
if (remainingMatches) {
    console.log('WARNING: Found potentially problematic patterns:');
    remainingMatches.slice(0, 10).forEach(match => {
        console.log(`  ${match.substring(0, 100)}...`);
    });
}

// Write the fixed content back
console.log(`\nWriting fixed content back to file...`);
console.log(`Total fixes applied: ${fixCount}`);

fs.writeFileSync(filePath, content, 'utf8');

console.log('Done! ✓');

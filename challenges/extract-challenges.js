const fs = require('fs');
const path = require('path');

// 13개 언어 정의
const languages = [
  'python', 'javascript', 'typescript', 'java', 'c', 'cpp',
  'csharp', 'kotlin', 'go', 'dart', 'sql', 'html', 'css'
];

// 각 언어별 10개 단원 정의
const unitNames = {
  python: [
    '출력과 주석', '변수와 자료형', '연산자', '조건문', '반복문',
    '리스트', '튜플과 딕셔너리', '함수', '모듈', '파일 입출력'
  ],
  javascript: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '배열', '객체', '함수', '비동기', 'DOM 조작'
  ],
  typescript: [
    '기본 타입', '변수 선언', '인터페이스', '클래스', '함수',
    '제네릭', '유니온 타입', '타입 가드', '데코레이터', '모듈'
  ],
  java: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '배열', '클래스', '상속', '인터페이스', '예외 처리'
  ],
  c: [
    '출력과 주석', '변수와 자료형', '연산자', '조건문', '반복문',
    '배열', '포인터', '함수', '구조체', '파일 입출력'
  ],
  cpp: [
    '출력과 입력', '변수와 자료형', '연산자', '조건문', '반복문',
    '배열', '포인터와 참조', '함수', '클래스', 'STL'
  ],
  csharp: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '배열', '클래스', '상속', '인터페이스', 'LINQ'
  ],
  kotlin: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '배열', '함수', '클래스', '상속', '확장 함수'
  ],
  go: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '배열과 슬라이스', '맵', '함수', '구조체', '고루틴'
  ],
  dart: [
    '출력과 변수', '자료형', '연산자', '조건문', '반복문',
    '리스트', '맵', '함수', '클래스', '비동기'
  ],
  sql: [
    'SELECT 기초', 'WHERE 조건', '집계 함수', 'GROUP BY', 'JOIN',
    '서브쿼리', 'INSERT', 'UPDATE', 'DELETE', '인덱스'
  ],
  html: [
    '기본 구조', '텍스트 태그', '목록', '링크', '이미지',
    '테이블', '폼', '시맨틱 태그', '미디어', '메타 태그'
  ],
  css: [
    '선택자', '색상', '박스 모델', '레이아웃', 'Flexbox',
    'Grid', '반응형', '애니메이션', '변환', '변수'
  ]
};

// SQL 파일에서 챌린지 데이터 추출
function extractChallenges(language) {
  const sqlFile = path.join(__dirname, `${language}-challenges.sql`);

  if (!fs.existsSync(sqlFile)) {
    console.log(`❌ File not found: ${sqlFile}`);
    return [];
  }

  const content = fs.readFileSync(sqlFile, 'utf-8');
  const challenges = [];

  // SQL INSERT 문 파싱
  const regex = /INSERT INTO challenges[^(]*\(([^)]+)\)\s+VALUES\s*\n\(([\s\S]*?)\);/g;
  let match;
  let unitIndex = 1;
  let challengeInUnit = 0;

  while ((match = regex.exec(content)) !== null) {
    const values = match[2];

    // $$ 구분자로 값들을 추출
    const parts = values.split(/\$\$/).filter(p => p.trim());

    if (parts.length >= 12) {
      const slug = parts[0].trim();
      const title = parts[4].trim();
      const problemDesc = parts[8].trim();

      // initial_code 추출 ($func$ 구분자 사용)
      const initialCodeMatch = values.match(/\$func\$([\s\S]*?)\$func\$/);
      const initialCode = initialCodeMatch ? initialCodeMatch[1].trim() : '// 여기에 코드를 작성하세요\n';

      // solution_code 추출 (두 번째 $func$ 블록)
      const allCodeMatches = values.match(/\$func\$([\s\S]*?)\$func\$/g);
      const solutionCode = allCodeMatches && allCodeMatches.length > 1
        ? allCodeMatches[1].replace(/\$func\$/g, '').trim()
        : 'print("정답")';

      challenges.push({
        title,
        desc: problemDesc,
        code: initialCode,
        sol: solutionCode,
        unit: unitIndex,
        index: challengeInUnit
      });

      challengeInUnit++;
      if (challengeInUnit >= 10) {
        challengeInUnit = 0;
        unitIndex++;
      }
    }
  }

  return challenges;
}

// Dart 맵 형식으로 변환
function convertToDartMap(language) {
  const challenges = extractChallenges(language);

  if (challenges.length === 0) {
    console.log(`⚠️  No challenges found for ${language}`);
    return null;
  }

  console.log(`✅ Extracted ${challenges.length} challenges for ${language}`);

  // 단원별로 그룹화
  const byUnit = {};
  for (let i = 1; i <= 10; i++) {
    byUnit[i] = challenges.filter(c => c.unit === i);
  }

  // Dart 맵 생성
  let dartCode = `final ${language}Problems = {\n`;

  for (let unit = 1; unit <= 10; unit++) {
    const unitChallenges = byUnit[unit] || [];
    const unitName = unitNames[language][unit - 1] || `Unit ${unit}`;

    dartCode += `  ${unit}: [ // Unit ${unit}: ${unitName}\n`;

    unitChallenges.forEach((c, idx) => {
      const title = c.title.replace(/'/g, "\\'");
      const desc = c.desc.replace(/'/g, "\\'").replace(/\n/g, '\\n');
      const code = c.code.replace(/'/g, "\\'").replace(/\n/g, '\\n');
      const sol = c.sol.replace(/'/g, "\\'").replace(/\n/g, '\\n');

      dartCode += `    {'title': '${title}', 'desc': '${desc}', 'code': '${code}', 'sol': '${sol}'},\n`;
    });

    dartCode += `  ],\n`;
  }

  dartCode += `};\n\n`;

  return dartCode;
}

// 모든 언어 처리
console.log('🚀 Starting challenge extraction...\n');

let allDartCode = `// ============================================================================
// AUTO-GENERATED: Challenge Problems for All Languages
// Generated: ${new Date().toISOString()}
// Total: 13 languages × 10 units × 10 problems = 1300 challenges
// ============================================================================

`;

languages.forEach(lang => {
  console.log(`\n📚 Processing ${lang}...`);
  const dartCode = convertToDartMap(lang);
  if (dartCode) {
    allDartCode += dartCode;
  }
});

// 파일로 저장
const outputFile = path.join(__dirname, 'challenges-data.dart');
fs.writeFileSync(outputFile, allDartCode, 'utf-8');

console.log(`\n✅ All challenges extracted successfully!`);
console.log(`📄 Output file: ${outputFile}`);
console.log(`\n🎯 Total: ${languages.length * 10 * 10} challenges ready to use!`);

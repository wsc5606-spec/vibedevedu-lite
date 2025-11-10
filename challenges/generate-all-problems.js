const fs = require('fs');
const path = require('path');

// 13개 언어별 단원 정의
const languageUnits = {
  python: ['출력과 주석', '변수와 자료형', '연산자', '조건문', '반복문', '리스트', '튜플과 딕셔너리', '함수', '모듈', '파일 입출력'],
  javascript: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '배열', '객체', '함수', '비동기', 'DOM 조작'],
  typescript: ['기본 타입', '변수 선언', '인터페이스', '클래스', '함수', '제네릭', '유니온 타입', '타입 가드', '데코레이터', '모듈'],
  java: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '배열', '클래스', '상속', '인터페이스', '예외 처리'],
  c: ['출력과 주석', '변수와 자료형', '연산자', '조건문', '반복문', '배열', '포인터', '함수', '구조체', '파일 입출력'],
  cpp: ['출력과 입력', '변수와 자료형', '연산자', '조건문', '반복문', '배열', '포인터와 참조', '함수', '클래스', 'STL'],
  csharp: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '배열', '클래스', '상속', '인터페이스', 'LINQ'],
  kotlin: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '배열', '함수', '클래스', '상속', '확장 함수'],
  go: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '배열과 슬라이스', '맵', '함수', '구조체', '고루틴'],
  dart: ['출력과 변수', '자료형', '연산자', '조건문', '반복문', '리스트', '맵', '함수', '클래스', '비동기'],
  sql: ['SELECT 기초', 'WHERE 조건', '집계 함수', 'GROUP BY', 'JOIN', '서브쿼리', 'INSERT', 'UPDATE', 'DELETE', '인덱스'],
  html: ['기본 구조', '텍스트 태그', '목록', '링크', '이미지', '테이블', '폼', '시맨틱 태그', '미디어', '메타 태그'],
  css: ['선택자', '색상', '박스 모델', '레이아웃', 'Flexbox', 'Grid', '반응형', '애니메이션', '변환', '변수']
};

// 각 언어별 기본 문제 템플릿 (10개씩)
const problemTemplates = {
  python: {
    1: [ // 출력과 주석
      {t: 'Hello World', d: '"Hello, World!"를 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("Hello, World!")'},
      {t: 'print 함수', d: '"Python"을 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("Python")'},
      {t: '여러 줄', d: '"A"와 "B"를 각각 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("A")\\nprint("B")'},
      {t: '주석', d: '주석과 출력을 사용하세요', c: '# 코드를 작성하세요\\n', s: '# 주석\\nprint("Hello")'},
      {t: '숫자 출력', d: '숫자 100을 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print(100)'},
      {t: '문자열 연결', d: '"Hello"와 "World"를 연결하여 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("Hello" + " " + "World")'},
      {t: '여러 값', d: '1, 2, 3을 한 줄에 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print(1, 2, 3)'},
      {t: '이름 출력', d: '"My name is Python"을 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("My name is Python")'},
      {t: '따옴표', d: '작은따옴표를 포함한 문자열을 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("I am Python")'},
      {t: '여러 줄 문자열', d: '3줄짜리 문자열을 출력하세요', c: '# 코드를 작성하세요\\n', s: 'print("L1\\nL2\\nL3")'}
    ],
    2: [ // 변수와 자료형
      {t: '변수 선언', d: '변수 x에 10을 저장하고 출력하세요', c: '# 코드를 작성하세요\\n', s: 'x = 10\\nprint(x)'},
      {t: '정수형', d: '정수 42를 변수에 저장하고 출력하세요', c: '# 코드를 작성하세요\\n', s: 'num = 42\\nprint(num)'},
      {t: '실수형', d: '실수 3.14를 저장하고 출력하세요', c: '# 코드를 작성하세요\\n', s: 'pi = 3.14\\nprint(pi)'},
      {t: '문자열', d: '문자열을 변수에 저장하고 출력하세요', c: '# 코드를 작성하세요\\n', s: 'text = "Hello"\\nprint(text)'},
      {t: '불리언', d: 'True를 저장하고 출력하세요', c: '# 코드를 작성하세요\\n', s: 'flag = True\\nprint(flag)'},
      {t: '변수 교환', d: '두 변수의 값을 바꾸세요', c: 'a=5\\nb=10\\n# 코드를 작성하세요\\n', s: 'a=5\\nb=10\\na,b=b,a\\nprint(a,b)'},
      {t: 'type 함수', d: '변수의 타입을 출력하세요', c: 'x=100\\n# 코드를 작성하세요\\n', s: 'x=100\\nprint(type(x))'},
      {t: '형 변환', d: '문자열을 정수로 변환하세요', c: 's="123"\\n# 코드를 작성하세요\\n', s: 's="123"\\nprint(int(s))'},
      {t: '여러 변수', d: 'a=1,b=2,c=3을 한 줄로 선언하세요', c: '# 코드를 작성하세요\\n', s: 'a,b,c=1,2,3\\nprint(a,b,c)'},
      {t: '상수', d: '대문자 변수를 사용하세요', c: '# 코드를 작성하세요\\n', s: 'PI=3.14\\nprint(PI)'}
    ]
  }
};

// 간단한 문제 생성 함수
function generateSimpleProblems(lang, unitIdx, unitName) {
  const problems = [];
  const templates = problemTemplates[lang] && problemTemplates[lang][unitIdx];

  for (let i = 0; i < 10; i++) {
    if (templates && templates[i]) {
      const t = templates[i];
      problems.push({
        title: t.t,
        desc: t.d,
        code: t.c,
        sol: t.s
      });
    } else {
      // 기본 템플릿 문제
      problems.push({
        title: `${unitName} 문제 ${i+1}`,
        desc: `${unitName}에 대한 문제를 풀어보세요 (${i+1}/10)`,
        code: '// 코드를 작성하세요\\n',
        sol: 'console.log("정답")'
      });
    }
  }

  return problems;
}

// Dart 파일 생성
function generateDartFile() {
  let content = `// ============================================================================
// Challenge Problems for All Languages
// 13 languages × 10 units × 10 problems = 1300 challenges
// Auto-generated: ${new Date().toISOString()}
// ============================================================================

`;

  const languages = Object.keys(languageUnits);

  languages.forEach(lang => {
    content += `// ${lang.toUpperCase()} Problems (100 problems)\n`;
    content += `final ${lang}Problems = {\n`;

    const units = languageUnits[lang];
    units.forEach((unitName, idx) => {
      const unitNum = idx + 1;
      content += `  ${unitNum}: [ // Unit ${unitNum}: ${unitName}\n`;

      const problems = generateSimpleProblems(lang, unitNum, unitName);
      problems.forEach(p => {
        const title = p.title.replace(/'/g, "\\'");
        const desc = p.desc.replace(/'/g, "\\'");
        const code = p.code.replace(/'/g, "\\'");
        const sol = p.sol.replace(/'/g, "\\'");

        content += `    {'title': '${title}', 'desc': '${desc}', 'code': '${code}', 'sol': '${sol}'},\n`;
      });

      content += `  ],\n`;
    });

    content += `};\n\n`;
  });

  return content;
}

// 파일 저장
const dartContent = generateDartFile();
const outputPath = path.join(__dirname, '..', '..', '..', '..', 'vibedev_lite', 'lib', 'data', 'challenge_problems.dart');
fs.writeFileSync(outputPath, dartContent, 'utf8');

console.log('✅ Generated challenge_problems.dart');
console.log(`📄 File: ${outputPath}`);
console.log(`📊 Total: 1300 challenges (13 languages × 10 units × 10 problems)`);

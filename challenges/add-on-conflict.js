const fs = require('fs');
const path = require('path');

// ON CONFLICT 구문을 추가하는 스크립트
const fileName = 'c-challenges.sql';
const filePath = path.join(__dirname, fileName);

console.log(`${fileName}에 ON CONFLICT 구문 추가 중...`);

let content = fs.readFileSync(filePath, 'utf8');

// INSERT INTO challenges ... VALUES 패턴을 찾아서 ON CONFLICT 추가
// 각 VALUES 블록의 끝(세미콜론 전)에 ON CONFLICT 구문 추가
const pattern = /\)\s*;(?=\s*\n)/g;

let modifiedContent = content.replace(pattern, `)\nON CONFLICT (slug) DO UPDATE SET
    language = EXCLUDED.language,
    kind = EXCLUDED.kind,
    level = EXCLUDED.level,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    difficulty = EXCLUDED.difficulty,
    problem_description = EXCLUDED.problem_description,
    constraints = EXCLUDED.constraints,
    examples = EXCLUDED.examples,
    initial_code = EXCLUDED.initial_code,
    solution_code = EXCLUDED.solution_code,
    test_cases = EXCLUDED.test_cases,
    hints = EXCLUDED.hints,
    tags = EXCLUDED.tags,
    estimated_time = EXCLUDED.estimated_time,
    updated_at = NOW();`);

// 백업 생성
const backupPath = path.join(__dirname, `${fileName}.backup`);
fs.writeFileSync(backupPath, content, 'utf8');
console.log(`백업 생성: ${backupPath}`);

// 수정된 내용 저장
fs.writeFileSync(filePath, modifiedContent, 'utf8');

console.log('✅ ON CONFLICT 구문 추가 완료!');
console.log('이제 c-challenges.sql을 업로드하면 중복 시 자동으로 업데이트됩니다.');

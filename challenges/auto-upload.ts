import { createClient } from '@supabase/supabase-js';
import * as fs from 'fs';
import * as path from 'path';
import * as dotenv from 'dotenv';

// .env 파일 로드
dotenv.config({ path: path.join(__dirname, '../../.env') });

const SUPABASE_URL = process.env.SUPABASE_URL!;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('❌ SUPABASE_URL 또는 SUPABASE_SERVICE_ROLE_KEY가 설정되지 않았습니다.');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// C 언어만 테스트
const LANGUAGES = [
  'c',
];

// SQL INSERT 문을 파싱해서 JSON 객체로 변환
function parseSqlInsert(sqlContent: string): any[] {
  const challenges: any[] = [];

  // INSERT INTO ... VALUES 패턴 찾기
  const insertPattern = /INSERT INTO challenges_\w+ \([^)]+\) VALUES\s*\(([^;]+)\);/gs;
  let match;

  while ((match = insertPattern.exec(sqlContent)) !== null) {
    const valuesStr = match[1];

    // VALUES 안의 데이터를 파싱 (간단한 방법)
    // 실제로는 복잡하지만, 우리 SQL 파일 구조는 일정하므로 간단히 처리

    try {
      // 정규식으로 각 필드 추출
      const slugMatch = valuesStr.match(/'([^']+)',\s*'(\w+)',/);
      if (!slugMatch) continue;

      const slug = slugMatch[1];
      const language = slugMatch[2];

      // 전체 값을 배열로 분리
      const values = parseValues(valuesStr);

      if (values.length >= 17) {
        const challenge = {
          slug: values[0],
          language: values[1],
          kind: values[2],
          level: parseInt(values[3]) || 1,
          title: values[4],
          description: values[5],
          category: values[6],
          difficulty: parseInt(values[7]) || 1,
          problem_description: values[8],
          constraints: values[9],
          examples: values[10],
          initial_code: values[11],
          solution_code: values[12],
          test_cases: values[13],
          hints: values[14],
          tags: values[15], // ARRAY['...']
          estimated_time: parseInt(values[16]) || 5,
        };

        challenges.push(challenge);
      }
    } catch (err) {
      console.error('⚠️  파싱 오류:', err);
    }
  }

  return challenges;
}

// SQL VALUES 문자열을 개별 값으로 파싱
function parseValues(valuesStr: string): string[] {
  const values: string[] = [];
  let current = '';
  let inString = false;
  let escapeNext = false;
  let parenDepth = 0;

  for (let i = 0; i < valuesStr.length; i++) {
    const char = valuesStr[i];

    if (escapeNext) {
      current += char;
      escapeNext = false;
      continue;
    }

    if (char === '\\') {
      escapeNext = true;
      current += char;
      continue;
    }

    if (char === "'") {
      inString = !inString;
      continue;
    }

    if (!inString) {
      if (char === '(') {
        parenDepth++;
      } else if (char === ')') {
        parenDepth--;
      } else if (char === ',' && parenDepth === 0) {
        values.push(current.trim());
        current = '';
        continue;
      }
    }

    current += char;
  }

  if (current.trim()) {
    values.push(current.trim());
  }

  return values.map(v => {
    // ARRAY['tag1', 'tag2'] 형태 처리
    if (v.startsWith('ARRAY[')) {
      return v; // 일단 그대로 반환
    }
    return v;
  });
}

async function clearTable(tableName: string) {
  console.log(`🗑️  ${tableName} 테이블 데이터 삭제 중...`);
  const { error } = await supabase.from(tableName).delete().neq('id', 0);
  if (error && error.code !== 'PGRST116') {
    console.error(`❌ ${tableName} 삭제 실패:`, error.message);
    return false;
  }
  console.log(`✅ ${tableName} 테이블 비움`);
  return true;
}

async function uploadFromSqlFile(language: string, partNum: number): Promise<number> {
  const tableName = 'challenges'; // 모든 언어가 하나의 challenges 테이블 사용
  const fileName = `${language}-part${partNum}.sql`;
  const filePath = path.join(__dirname, fileName);

  if (!fs.existsSync(filePath)) {
    console.log(`⚠️  파일 없음: ${fileName}`);
    return 0;
  }

  console.log(`\n📤 ${fileName} 읽는 중...`);
  const sqlContent = fs.readFileSync(filePath, 'utf-8');

  // SQL 파싱 대신 정규식으로 직접 데이터 추출
  const challenges = extractChallengesFromSql(sqlContent, language);

  if (challenges.length === 0) {
    console.log(`⚠️  ${fileName}에서 챌린지를 찾을 수 없습니다.`);
    return 0;
  }

  console.log(`   📊 ${challenges.length}개 챌린지 발견`);

  // Supabase에 배치 삽입 (10개씩)
  let successCount = 0;
  const batchSize = 10;

  for (let i = 0; i < challenges.length; i += batchSize) {
    const batch = challenges.slice(i, i + batchSize);

    const { data, error } = await supabase
      .from(tableName)
      .insert(batch)
      .select();

    if (error) {
      console.error(`   ❌ [${i + 1}-${i + batch.length}/${challenges.length}] 실패:`, error.message);
    } else {
      successCount += batch.length;
      console.log(`   ✅ [${i + 1}-${i + batch.length}/${challenges.length}] 성공`);
    }

    // Rate limiting 방지
    await new Promise(resolve => setTimeout(resolve, 100));
  }

  console.log(`   ✅ 총 ${successCount}/${challenges.length}개 업로드 성공`);
  return successCount;
}

// SQL에서 챌린지 데이터 추출 (간단한 정규식 버전)
function extractChallengesFromSql(sqlContent: string, language: string): any[] {
  const challenges: any[] = [];

  // 각 INSERT 문을 찾기 (테이블 이름은 challenges)
  const insertRegex = /INSERT INTO challenges[^V]+VALUES\s*\(([\s\S]+?)\)(?:,\s*\(|;)/g;
  let match;

  while ((match = insertRegex.exec(sqlContent)) !== null) {
    try {
      const valuesStr = match[1];
      const challenge = parseChallenge(valuesStr);
      if (challenge) {
        challenges.push(challenge);
      }
    } catch (err: any) {
      console.error('⚠️  챌린지 파싱 오류:', err.message);
    }
  }

  return challenges;
}

// 챌린지 데이터 파싱
function parseChallenge(valuesStr: string): any | null {
  // 간단한 split으로 처리 (정확하지 않을 수 있음)
  const parts: string[] = [];
  let current = '';
  let inString = false;
  let depth = 0;

  for (let i = 0; i < valuesStr.length; i++) {
    const char = valuesStr[i];
    const next = valuesStr[i + 1];

    // 문자열 처리
    if (char === "'" && (i === 0 || valuesStr[i - 1] !== '\\')) {
      inString = !inString;
      current += char;
      continue;
    }

    // 괄호 깊이
    if (!inString) {
      if (char === '[' || char === '{') depth++;
      if (char === ']' || char === '}') depth--;

      if (char === ',' && depth === 0) {
        parts.push(current.trim());
        current = '';
        continue;
      }
    }

    current += char;
  }

  if (current.trim()) {
    parts.push(current.trim());
  }

  if (parts.length < 17) {
    return null;
  }

  // 각 필드 정리
  const cleanValue = (str: string) => {
    str = str.trim();
    if (str.startsWith("'") && str.endsWith("'")) {
      return str.slice(1, -1).replace(/\\'/g, "'");
    }
    return str;
  };

  const parseArray = (str: string): string[] => {
    if (!str.startsWith('ARRAY[')) return [];
    const inner = str.slice(6, -1);
    return inner.split(',').map(s => cleanValue(s.trim()));
  };

  return {
    slug: cleanValue(parts[0]),
    language: cleanValue(parts[1]),
    kind: cleanValue(parts[2]),
    level: parseInt(cleanValue(parts[3])) || 1,
    title: cleanValue(parts[4]),
    description: cleanValue(parts[5]),
    category: cleanValue(parts[6]),
    difficulty: parseInt(cleanValue(parts[7])) || 1,
    problem_description: cleanValue(parts[8]),
    constraints: cleanValue(parts[9]),
    examples: cleanValue(parts[10]),
    initial_code: cleanValue(parts[11]),
    solution_code: cleanValue(parts[12]),
    test_cases: cleanValue(parts[13]),
    hints: cleanValue(parts[14]),
    tags: parseArray(parts[15]),
    estimated_time: parseInt(cleanValue(parts[16])) || 5,
  };
}

async function uploadLanguage(language: string): Promise<boolean> {
  const tableName = 'challenges'; // 모든 언어가 하나의 challenges 테이블 사용

  console.log(`\n${'='.repeat(60)}`);
  console.log(`📚 ${language.toUpperCase()} 챌린지 업로드 시작`);
  console.log(`${'='.repeat(60)}`);

  // 1. 해당 언어의 기존 데이터만 삭제
  console.log(`🗑️  ${language} 챌린지 삭제 중...`);
  const { error: deleteError } = await supabase
    .from(tableName)
    .delete()
    .eq('language', language);

  if (deleteError && deleteError.code !== 'PGRST116') {
    console.error(`❌ ${language} 삭제 실패:`, deleteError.message);
  } else {
    console.log(`✅ ${language} 챌린지 삭제 완료`);
  }

  // 2. Part1, Part2 업로드
  const count1 = await uploadFromSqlFile(language, 1);
  const count2 = await uploadFromSqlFile(language, 2);

  const totalCount = count1 + count2;

  // 3. 최종 확인
  const { count, error } = await supabase
    .from(tableName)
    .select('*', { count: 'exact', head: true })
    .eq('language', language);

  if (error) {
    console.error(`❌ ${language} 개수 확인 실패:`, error.message);
    return false;
  } else {
    console.log(`\n📊 ${language}: ${count}개 문제 업로드됨 (목표: ${totalCount}개)`);
    return count === totalCount;
  }
}

async function main() {
  console.log('🚀 VibeDevEdu 챌린지 자동 업로드 시작!\n');
  console.log(`📅 시작 시각: ${new Date().toLocaleString('ko-KR')}\n`);

  const results: { [key: string]: boolean } = {};

  for (const lang of LANGUAGES) {
    try {
      const success = await uploadLanguage(lang);
      results[lang] = success;
    } catch (error: any) {
      console.error(`❌ ${lang} 업로드 중 오류:`, error.message);
      results[lang] = false;
    }
  }

  // 최종 요약
  console.log('\n' + '='.repeat(60));
  console.log('📊 최종 결과');
  console.log('='.repeat(60));

  let totalSuccess = 0;
  let totalFail = 0;

  for (const [lang, success] of Object.entries(results)) {
    if (success) {
      console.log(`✅ ${lang.toUpperCase()}: 성공`);
      totalSuccess++;
    } else {
      console.log(`❌ ${lang.toUpperCase()}: 실패`);
      totalFail++;
    }
  }

  console.log('\n' + '='.repeat(60));
  console.log(`총 ${LANGUAGES.length}개 언어:`);
  console.log(`✅ 성공: ${totalSuccess}개`);
  console.log(`❌ 실패: ${totalFail}개`);
  console.log(`📅 종료 시각: ${new Date().toLocaleString('ko-KR')}`);
  console.log('='.repeat(60));

  if (totalFail === 0) {
    console.log('\n🎉 모든 챌린지 업로드 완료!');
  } else {
    console.log('\n⚠️  일부 언어 업로드 실패. 위 로그를 확인하세요.');
  }
}

main().catch(console.error);

# Chapter 3: SQL 쿼리 작성하기

## SQL 기본 이해하기

SQL (Structured Query Language)은 데이터베이스와 대화하는 언어입니다. Supabase는 JavaScript 클라이언트를 제공하지만, SQL을 이해하면 더 강력한 쿼리를 작성할 수 있습니다.

### 4가지 기본 작업 (CRUD)

- **Create** (INSERT): 데이터 생성
- **Read** (SELECT): 데이터 조회
- **Update** (UPDATE): 데이터 수정
- **Delete** (DELETE): 데이터 삭제

## SELECT: 데이터 조회하기

### 기본 SELECT 문

```sql
-- 모든 컬럼 조회
SELECT * FROM learning_records;

-- 특정 컬럼만 조회
SELECT id, subject, hours_spent FROM learning_records;

-- 조건을 추가하여 조회 (WHERE)
SELECT * FROM learning_records
WHERE subject = 'Supabase';

-- 여러 조건 조합
SELECT * FROM learning_records
WHERE subject = 'Supabase' AND hours_spent > 5;

SELECT * FROM learning_records
WHERE subject = 'Supabase' OR subject = 'PostgreSQL';
```

### JavaScript로 SELECT 실행

```javascript
import { supabase } from './supabase.js'

// 모든 데이터 조회
const { data, error } = await supabase
  .from('learning_records')
  .select('*')

// 특정 컬럼만 조회
const { data, error } = await supabase
  .from('learning_records')
  .select('id, subject, hours_spent')

// 조건을 추가하여 조회
const { data, error } = await supabase
  .from('learning_records')
  .select('*')
  .eq('subject', 'Supabase')  // equal (같음)
  .gt('hours_spent', 5)        // greater than (초과)
```

### 바데부의 실전 예제: 학습 기록 조회

```javascript
// 바데부가 오늘 학습한 기록 조회
async function getBadebuTodayRecords() {
  const today = new Date().toISOString().split('T')[0]

  const { data, error } = await supabase
    .from('learning_records')
    .select('*')
    .eq('user_id', 'badebu-user-id')
    .gte('created_at', `${today}T00:00:00`)
    .order('created_at', { ascending: false })

  if (error) {
    console.error('조회 실패:', error)
    return null
  }

  return data
}

// 완료한 학습만 조회
async function getCompletedRecords() {
  const { data, error } = await supabase
    .from('learning_records')
    .select('subject, hours_spent, created_at')
    .eq('completed', true)
    .order('hours_spent', { ascending: false })
    .limit(10)

  return data
}
```

## INSERT: 데이터 생성하기

### 기본 INSERT 문

```sql
-- 단일 행 삽입
INSERT INTO learning_records (user_id, subject, content, hours_spent)
VALUES ('user-uuid', 'Supabase 기초', 'Chapter 3 학습', 2.5);

-- 여러 행 동시 삽입
INSERT INTO learning_records (user_id, subject, hours_spent)
VALUES
  ('user-uuid', 'SQL', 3.0),
  ('user-uuid', 'PostgreSQL', 2.5),
  ('user-uuid', 'JavaScript', 4.0);

-- 삽입 후 결과 반환
INSERT INTO learning_records (user_id, subject, hours_spent)
VALUES ('user-uuid', 'Supabase', 2.0)
RETURNING *;
```

### JavaScript로 INSERT 실행

```javascript
// 단일 데이터 삽입
const { data, error } = await supabase
  .from('learning_records')
  .insert({
    user_id: 'badebu-user-id',
    subject: 'Supabase 기초',
    content: 'Chapter 3 완료',
    hours_spent: 2.5,
    completed: true
  })
  .select()

// 여러 데이터 동시 삽입
const { data, error } = await supabase
  .from('learning_records')
  .insert([
    { subject: 'SQL', hours_spent: 3.0 },
    { subject: 'PostgreSQL', hours_spent: 2.5 },
    { subject: 'JavaScript', hours_spent: 4.0 }
  ])
  .select()
```

### 바데부의 실전 예제: 학습 기록 추가

```javascript
async function addLearningRecord(subject, content, hoursSpent) {
  // 현재 로그인한 사용자 가져오기
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    console.error('로그인이 필요합니다')
    return null
  }

  const { data, error } = await supabase
    .from('learning_records')
    .insert({
      user_id: user.id,
      subject: subject,
      content: content,
      hours_spent: hoursSpent,
      completed: true
    })
    .select()
    .single()

  if (error) {
    console.error('추가 실패:', error)
    return null
  }

  console.log('바데부의 학습 기록이 추가되었습니다:', data)
  return data
}

// 사용 예시
await addLearningRecord('Supabase SQL', 'SELECT와 INSERT 학습', 3.5)
```

## UPDATE: 데이터 수정하기

### 기본 UPDATE 문

```sql
-- 특정 행 수정
UPDATE learning_records
SET hours_spent = 5.0, completed = true
WHERE id = 'record-uuid';

-- 여러 필드 동시 수정
UPDATE learning_records
SET
  content = '추가 학습 완료',
  hours_spent = hours_spent + 2.0,
  updated_at = NOW()
WHERE subject = 'Supabase';

-- 조건에 맞는 모든 행 수정
UPDATE learning_records
SET completed = true
WHERE hours_spent >= 3.0;
```

### JavaScript로 UPDATE 실행

```javascript
// 특정 행 수정
const { data, error } = await supabase
  .from('learning_records')
  .update({
    hours_spent: 5.0,
    completed: true
  })
  .eq('id', 'record-uuid')
  .select()

// 여러 조건으로 수정
const { data, error } = await supabase
  .from('learning_records')
  .update({ completed: true })
  .eq('subject', 'Supabase')
  .gte('hours_spent', 3.0)
  .select()
```

### 바데부의 실전 예제: 학습 시간 업데이트

```javascript
async function updateLearningHours(recordId, additionalHours) {
  // 기존 데이터 조회
  const { data: record, error: fetchError } = await supabase
    .from('learning_records')
    .select('hours_spent')
    .eq('id', recordId)
    .single()

  if (fetchError) {
    console.error('조회 실패:', fetchError)
    return null
  }

  // 시간 추가 업데이트
  const newHours = record.hours_spent + additionalHours

  const { data, error } = await supabase
    .from('learning_records')
    .update({
      hours_spent: newHours,
      updated_at: new Date().toISOString()
    })
    .eq('id', recordId)
    .select()
    .single()

  if (error) {
    console.error('업데이트 실패:', error)
    return null
  }

  console.log(`바데부의 학습 시간이 ${additionalHours}시간 추가되었습니다`)
  return data
}

// 완료 상태 변경
async function markAsCompleted(recordId) {
  const { data, error } = await supabase
    .from('learning_records')
    .update({
      completed: true,
      updated_at: new Date().toISOString()
    })
    .eq('id', recordId)
    .select()
    .single()

  return data
}
```

## DELETE: 데이터 삭제하기

### 기본 DELETE 문

```sql
-- 특정 행 삭제
DELETE FROM learning_records
WHERE id = 'record-uuid';

-- 조건에 맞는 모든 행 삭제
DELETE FROM learning_records
WHERE completed = false AND created_at < NOW() - INTERVAL '30 days';

-- 모든 데이터 삭제 (주의!)
DELETE FROM learning_records;

-- 삭제 후 결과 반환
DELETE FROM learning_records
WHERE id = 'record-uuid'
RETURNING *;
```

### JavaScript로 DELETE 실행

```javascript
// 특정 행 삭제
const { data, error } = await supabase
  .from('learning_records')
  .delete()
  .eq('id', 'record-uuid')

// 여러 조건으로 삭제
const { data, error } = await supabase
  .from('learning_records')
  .delete()
  .eq('completed', false)
  .lt('created_at', '2025-01-01')
```

### 바데부의 실전 예제: 안전한 삭제

```javascript
async function deleteLearningRecord(recordId) {
  // 삭제 전 확인
  const { data: record, error: fetchError } = await supabase
    .from('learning_records')
    .select('*')
    .eq('id', recordId)
    .single()

  if (fetchError || !record) {
    console.error('기록을 찾을 수 없습니다')
    return false
  }

  // 사용자 확인 (실제로는 UI에서 confirm 사용)
  console.log('삭제할 기록:', record.subject)

  const { error } = await supabase
    .from('learning_records')
    .delete()
    .eq('id', recordId)

  if (error) {
    console.error('삭제 실패:', error)
    return false
  }

  console.log('바데부의 학습 기록이 삭제되었습니다')
  return true
}

// 오래된 기록 정리
async function cleanupOldRecords(daysOld = 90) {
  const cutoffDate = new Date()
  cutoffDate.setDate(cutoffDate.getDate() - daysOld)

  const { data, error } = await supabase
    .from('learning_records')
    .delete()
    .eq('completed', false)
    .lt('created_at', cutoffDate.toISOString())

  console.log(`${daysOld}일 이전의 미완료 기록이 삭제되었습니다`)
}
```

## JOIN: 테이블 연결하기

### INNER JOIN

```sql
-- 사용자 정보와 학습 기록 연결
SELECT
  users.name,
  learning_records.subject,
  learning_records.hours_spent
FROM learning_records
INNER JOIN users ON learning_records.user_id = users.id;
```

### JavaScript로 JOIN 실행

```javascript
// Supabase는 자동으로 관계를 따라 JOIN 수행
const { data, error } = await supabase
  .from('learning_records')
  .select(`
    *,
    users (
      name,
      email
    )
  `)

// 여러 단계 JOIN
const { data, error } = await supabase
  .from('user_task_progress')
  .select(`
    *,
    users (name, email),
    learning_tasks (title, points)
  `)
  .eq('status', 'completed')
```

### 바데부의 실전 예제: 학습 통계 조회

```javascript
async function getBadebuLearningStats() {
  const { data, error } = await supabase
    .from('user_profiles')
    .select(`
      nickname,
      level,
      total_points,
      learning_records (
        subject,
        hours_spent,
        completed,
        created_at
      )
    `)
    .eq('nickname', '바데부')
    .single()

  if (error) {
    console.error('조회 실패:', error)
    return null
  }

  // 통계 계산
  const totalHours = data.learning_records.reduce(
    (sum, record) => sum + record.hours_spent, 0
  )
  const completedCount = data.learning_records.filter(
    record => record.completed
  ).length

  return {
    ...data,
    statistics: {
      totalHours,
      completedCount,
      averageHours: totalHours / data.learning_records.length
    }
  }
}
```

## 집계 함수 (Aggregate Functions)

```sql
-- COUNT: 개수 세기
SELECT COUNT(*) FROM learning_records;
SELECT COUNT(*) FROM learning_records WHERE completed = true;

-- SUM: 합계
SELECT SUM(hours_spent) FROM learning_records;

-- AVG: 평균
SELECT AVG(hours_spent) FROM learning_records;

-- MAX, MIN: 최대값, 최소값
SELECT MAX(hours_spent), MIN(hours_spent) FROM learning_records;

-- GROUP BY: 그룹별 집계
SELECT subject, COUNT(*), SUM(hours_spent)
FROM learning_records
GROUP BY subject;
```

### JavaScript로 집계 함수 사용

```javascript
// 총 학습 시간 계산
async function getTotalHours(userId) {
  const { data, error } = await supabase
    .from('learning_records')
    .select('hours_spent')
    .eq('user_id', userId)

  if (error) return 0

  return data.reduce((sum, record) => sum + record.hours_spent, 0)
}

// 과목별 통계
async function getSubjectStats() {
  const { data, error } = await supabase
    .from('learning_records')
    .select('subject, hours_spent')

  // JavaScript로 그룹화
  const stats = data.reduce((acc, record) => {
    if (!acc[record.subject]) {
      acc[record.subject] = { count: 0, totalHours: 0 }
    }
    acc[record.subject].count++
    acc[record.subject].totalHours += record.hours_spent
    return acc
  }, {})

  return stats
}
```

## 일반적인 실수와 해결방법

### 실수 1: 조건 없이 UPDATE/DELETE
```sql
-- ❌ 위험! 모든 데이터가 수정됨
UPDATE learning_records SET completed = true;

-- ✅ 항상 WHERE 절 사용
UPDATE learning_records SET completed = true WHERE id = 'specific-id';
```

### 실수 2: SELECT * 남용
```javascript
// ❌ 불필요한 데이터까지 모두 가져옴
const { data } = await supabase.from('users').select('*')

// ✅ 필요한 컬럼만 선택
const { data } = await supabase.from('users').select('id, name, email')
```

### 실수 3: 에러 처리 누락
```javascript
// ❌ 에러 처리 없음
const { data } = await supabase.from('records').select('*')
console.log(data.length)  // data가 null이면 에러

// ✅ 항상 에러 확인
const { data, error } = await supabase.from('records').select('*')
if (error) {
  console.error('조회 실패:', error)
  return
}
console.log(data.length)
```

## 실습 과제

1. **CRUD 구현**: 바데부의 학습 노트를 생성, 조회, 수정, 삭제하는 함수 작성
2. **통계 쿼리**: 과목별 총 학습 시간과 평균을 계산하는 쿼리 작성
3. **JOIN 활용**: 사용자 정보와 학습 기록을 함께 조회하는 쿼리 작성
4. **필터링**: 최근 7일간 3시간 이상 학습한 기록만 조회

## 다음 장 미리보기

다음 장에서는 Row Level Security (RLS)를 배웁니다. RLS는 데이터베이스 수준에서 보안을 강화하여 사용자가 자신의 데이터만 접근할 수 있도록 합니다.

## 핵심 요약

- CRUD: SELECT, INSERT, UPDATE, DELETE
- JavaScript 클라이언트로 SQL 작업 수행
- JOIN으로 여러 테이블의 데이터 연결
- 집계 함수로 통계 계산
- 항상 에러 처리와 조건절 확인
- 필요한 컬럼만 선택하여 성능 향상

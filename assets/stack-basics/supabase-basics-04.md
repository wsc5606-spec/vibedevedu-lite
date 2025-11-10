# Chapter 4: Row Level Security (RLS)

## RLS란 무엇인가?

Row Level Security (RLS)는 PostgreSQL의 강력한 보안 기능으로, 테이블의 각 행에 대한 접근 권한을 세밀하게 제어합니다. Supabase에서는 RLS를 통해 사용자가 자신의 데이터만 접근할 수 있도록 보장합니다.

### RLS가 없으면 어떻게 될까?

```javascript
// RLS 없이는 모든 사용자가 모든 데이터를 볼 수 있음!
const { data } = await supabase
  .from('learning_records')
  .select('*')

// 바데부의 학습 기록뿐만 아니라
// 다른 모든 사용자의 학습 기록도 조회됨 (보안 문제!)
```

### RLS를 활성화하면

```javascript
// RLS 활성화 후에는 자동으로 현재 사용자의 데이터만 조회
const { data } = await supabase
  .from('learning_records')
  .select('*')

// 바데부로 로그인했다면, 바데부의 학습 기록만 반환됨
```

## RLS 활성화하기

### Dashboard에서 활성화

1. Supabase Dashboard > Authentication > Policies
2. 테이블 선택
3. "Enable RLS" 버튼 클릭

### SQL로 활성화

```sql
-- RLS 활성화
ALTER TABLE learning_records ENABLE ROW LEVEL SECURITY;

-- RLS 비활성화 (주의: 보안 취약)
ALTER TABLE learning_records DISABLE ROW LEVEL SECURITY;

-- RLS 상태 확인
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public';
```

## RLS 정책 (Policy) 작성하기

### 기본 정책 구조

```sql
CREATE POLICY "정책 이름"
ON 테이블명
FOR 작업타입  -- SELECT, INSERT, UPDATE, DELETE, ALL
TO 역할      -- public, authenticated, service_role 등
USING (조건문)  -- SELECT, UPDATE, DELETE에 적용
WITH CHECK (조건문);  -- INSERT, UPDATE에 적용
```

### 바데부의 첫 번째 정책: 자신의 데이터만 조회

```sql
-- 사용자는 자신의 학습 기록만 조회 가능
CREATE POLICY "사용자는 자신의 학습 기록만 조회 가능"
ON learning_records
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);
```

### auth.uid() 함수

```sql
-- auth.uid(): 현재 로그인한 사용자의 ID를 반환
-- authenticated: 로그인한 모든 사용자
-- public: 로그인하지 않은 사용자 포함 모든 사용자
```

## 완전한 CRUD 정책 세트

### 바데부의 학습 기록 테이블 정책

```sql
-- 1. RLS 활성화
ALTER TABLE learning_records ENABLE ROW LEVEL SECURITY;

-- 2. SELECT 정책: 자신의 데이터만 조회
CREATE POLICY "사용자는 자신의 학습 기록만 조회"
ON learning_records
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- 3. INSERT 정책: 자신의 데이터만 생성
CREATE POLICY "사용자는 자신의 학습 기록만 생성"
ON learning_records
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- 4. UPDATE 정책: 자신의 데이터만 수정
CREATE POLICY "사용자는 자신의 학습 기록만 수정"
ON learning_records
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- 5. DELETE 정책: 자신의 데이터만 삭제
CREATE POLICY "사용자는 자신의 학습 기록만 삭제"
ON learning_records
FOR DELETE
TO authenticated
USING (auth.uid() = user_id);
```

### JavaScript에서 RLS 정책 동작 확인

```javascript
// 바데부가 로그인한 상태에서
const { data: { user } } = await supabase.auth.getUser()

// 학습 기록 추가 (자동으로 user_id가 확인됨)
const { data, error } = await supabase
  .from('learning_records')
  .insert({
    subject: 'RLS 학습',
    hours_spent: 2.0
    // user_id를 명시하지 않아도 RLS 정책이 확인
  })

// 만약 다른 사용자의 user_id를 사용하려고 하면?
const { data, error } = await supabase
  .from('learning_records')
  .insert({
    user_id: 'other-user-id',  // 바데부의 ID가 아님
    subject: 'RLS 테스트',
    hours_spent: 1.0
  })
// error: new row violates row-level security policy
```

## 고급 RLS 정책

### 공개/비공개 설정이 있는 정책

```sql
-- 학습 기록에 is_public 컬럼 추가
ALTER TABLE learning_records ADD COLUMN is_public BOOLEAN DEFAULT FALSE;

-- 자신의 모든 기록 + 다른 사람의 공개 기록 조회 가능
CREATE POLICY "자신의 모든 기록과 공개 기록 조회"
ON learning_records
FOR SELECT
TO authenticated
USING (
  auth.uid() = user_id OR is_public = TRUE
);
```

### 시간 기반 정책

```sql
-- 생성 후 24시간 이내에만 수정 가능
CREATE POLICY "24시간 이내 수정 가능"
ON learning_records
FOR UPDATE
TO authenticated
USING (
  auth.uid() = user_id AND
  created_at > NOW() - INTERVAL '24 hours'
);
```

### 역할 기반 정책

```sql
-- 관리자는 모든 데이터 조회 가능
CREATE POLICY "관리자는 모든 데이터 조회"
ON learning_records
FOR SELECT
TO authenticated
USING (
  auth.uid() = user_id OR
  (SELECT role FROM user_profiles WHERE user_id = auth.uid()) = 'admin'
);
```

## 바데부의 실전 예제: 학습 그룹 시스템

```sql
-- 1. 학습 그룹 테이블
CREATE TABLE learning_groups (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  owner_id UUID REFERENCES auth.users(id) NOT NULL,
  is_public BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. 그룹 멤버 테이블
CREATE TABLE group_members (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  group_id UUID REFERENCES learning_groups(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  role VARCHAR(20) DEFAULT 'member', -- owner, admin, member
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(group_id, user_id)
);

-- 3. 그룹 학습 기록 테이블
CREATE TABLE group_learning_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  group_id UUID REFERENCES learning_groups(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id),
  subject VARCHAR(100) NOT NULL,
  content TEXT,
  hours_spent DECIMAL(5, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. RLS 활성화
ALTER TABLE learning_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE group_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE group_learning_records ENABLE ROW LEVEL SECURITY;

-- 5. 그룹 정책: 멤버이거나 공개 그룹이면 조회 가능
CREATE POLICY "그룹 조회 정책"
ON learning_groups
FOR SELECT
TO authenticated
USING (
  is_public = TRUE OR
  owner_id = auth.uid() OR
  EXISTS (
    SELECT 1 FROM group_members
    WHERE group_id = learning_groups.id
    AND user_id = auth.uid()
  )
);

-- 6. 그룹 멤버 정책: 그룹의 멤버만 조회 가능
CREATE POLICY "그룹 멤버 조회"
ON group_members
FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  EXISTS (
    SELECT 1 FROM group_members gm
    WHERE gm.group_id = group_members.group_id
    AND gm.user_id = auth.uid()
  )
);

-- 7. 그룹 학습 기록 정책: 같은 그룹 멤버만 조회 가능
CREATE POLICY "그룹 학습 기록 조회"
ON group_learning_records
FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM group_members
    WHERE group_id = group_learning_records.group_id
    AND user_id = auth.uid()
  )
);

-- 8. 그룹 학습 기록 생성: 그룹 멤버만 가능
CREATE POLICY "그룹 학습 기록 생성"
ON group_learning_records
FOR INSERT
TO authenticated
WITH CHECK (
  auth.uid() = user_id AND
  EXISTS (
    SELECT 1 FROM group_members
    WHERE group_id = group_learning_records.group_id
    AND user_id = auth.uid()
  )
);
```

### JavaScript에서 그룹 시스템 사용

```javascript
// 바데부가 학습 그룹 생성
async function createLearningGroup(name, isPublic = false) {
  const { data: { user } } = await supabase.auth.getUser()

  const { data: group, error } = await supabase
    .from('learning_groups')
    .insert({
      name: name,
      owner_id: user.id,
      is_public: isPublic
    })
    .select()
    .single()

  if (error) {
    console.error('그룹 생성 실패:', error)
    return null
  }

  // 생성자를 그룹 멤버로 추가
  await supabase
    .from('group_members')
    .insert({
      group_id: group.id,
      user_id: user.id,
      role: 'owner'
    })

  console.log('바데부의 학습 그룹이 생성되었습니다:', group.name)
  return group
}

// 그룹에 학습 기록 추가
async function addGroupRecord(groupId, subject, hoursSpent) {
  const { data: { user } } = await supabase.auth.getUser()

  // RLS가 자동으로 그룹 멤버인지 확인
  const { data, error } = await supabase
    .from('group_learning_records')
    .insert({
      group_id: groupId,
      user_id: user.id,
      subject: subject,
      hours_spent: hoursSpent
    })
    .select()
    .single()

  if (error) {
    console.error('기록 추가 실패:', error)
    return null
  }

  return data
}

// 그룹의 모든 학습 기록 조회
async function getGroupRecords(groupId) {
  // RLS가 자동으로 권한 확인
  const { data, error } = await supabase
    .from('group_learning_records')
    .select(`
      *,
      users:user_id (
        name,
        email
      )
    `)
    .eq('group_id', groupId)
    .order('created_at', { ascending: false })

  return data
}
```

## 정책 관리

### 정책 조회

```sql
-- 테이블의 모든 정책 조회
SELECT * FROM pg_policies WHERE tablename = 'learning_records';

-- 정책 상세 정보
SELECT
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'learning_records';
```

### 정책 수정 및 삭제

```sql
-- 정책 삭제
DROP POLICY "정책이름" ON learning_records;

-- 정책 수정 (삭제 후 재생성)
DROP POLICY "기존정책" ON learning_records;
CREATE POLICY "새정책" ON learning_records FOR SELECT ...;

-- 모든 정책 삭제
DROP POLICY IF EXISTS "정책1" ON learning_records;
DROP POLICY IF EXISTS "정책2" ON learning_records;
```

## 일반적인 실수와 해결방법

### 실수 1: RLS 활성화했지만 정책이 없음

```sql
-- ❌ RLS만 활성화하고 정책이 없으면 아무도 접근 못함
ALTER TABLE learning_records ENABLE ROW LEVEL SECURITY;
-- 결과: { data: [], error: null } - 데이터 없음

-- ✅ 정책도 함께 생성
ALTER TABLE learning_records ENABLE ROW LEVEL SECURITY;
CREATE POLICY "select_policy" ON learning_records FOR SELECT ...;
```

### 실수 2: USING과 WITH CHECK 혼동

```sql
-- ❌ INSERT에 USING 사용
CREATE POLICY "insert_policy"
ON learning_records
FOR INSERT
USING (auth.uid() = user_id);  -- INSERT는 USING 무시됨

-- ✅ INSERT는 WITH CHECK 사용
CREATE POLICY "insert_policy"
ON learning_records
FOR INSERT
WITH CHECK (auth.uid() = user_id);
```

### 실수 3: 순환 참조

```sql
-- ❌ 무한 루프 가능성
CREATE POLICY "circular"
ON table_a
USING (
  EXISTS (SELECT 1 FROM table_b WHERE table_b.id = table_a.id)
);

-- table_b도 table_a를 참조하면 순환 참조 발생
```

### 실수 4: 성능 문제

```sql
-- ❌ 복잡한 서브쿼리로 성능 저하
CREATE POLICY "slow_policy"
ON learning_records
USING (
  auth.uid() IN (
    SELECT user_id FROM group_members
    WHERE group_id IN (
      SELECT id FROM learning_groups WHERE ...
    )
  )
);

-- ✅ EXISTS 사용으로 최적화
CREATE POLICY "fast_policy"
ON learning_records
USING (
  EXISTS (
    SELECT 1 FROM group_members gm
    JOIN learning_groups lg ON gm.group_id = lg.id
    WHERE gm.user_id = auth.uid()
    AND ...
  )
);
```

## 실습 과제

1. **기본 RLS 설정**: 개인 TODO 테이블에 RLS 활성화 및 CRUD 정책 생성
2. **공유 기능**: TODO를 다른 사용자와 공유할 수 있는 정책 작성
3. **시간 제한**: 생성 후 1시간 이내에만 삭제 가능한 정책 작성
4. **테스트**: 두 개의 계정으로 로그인하여 RLS가 올바르게 작동하는지 확인

## 다음 장 미리보기

다음 장에서는 Supabase의 인증 시스템을 배웁니다. 이메일/비밀번호, OAuth, 매직링크 등 다양한 인증 방식을 구현하는 방법을 알아봅니다.

## 핵심 요약

- RLS는 행 단위로 접근 권한을 제어하는 강력한 보안 기능
- auth.uid()로 현재 사용자 ID 확인
- USING은 조회/수정/삭제 조건, WITH CHECK는 생성/수정 조건
- 정책은 테이블당 여러 개 생성 가능
- 복잡한 정책은 성능에 영향을 줄 수 있으므로 최적화 필요
- RLS 없이는 보안 취약점 발생 가능

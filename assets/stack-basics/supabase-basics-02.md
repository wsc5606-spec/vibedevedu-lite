# Chapter 2: 데이터베이스 기초

## PostgreSQL 데이터베이스 이해하기

Supabase는 PostgreSQL 데이터베이스를 사용합니다. PostgreSQL은 세계에서 가장 강력한 오픈소스 관계형 데이터베이스 중 하나입니다.

### 관계형 데이터베이스의 핵심 개념

- **테이블 (Table)**: 데이터를 저장하는 구조 (엑셀의 시트와 유사)
- **행 (Row)**: 개별 데이터 항목 (엑셀의 행)
- **열 (Column)**: 데이터의 속성 (엑셀의 열)
- **기본 키 (Primary Key)**: 각 행을 고유하게 식별하는 값

## 첫 번째 테이블 만들기

바데부가 학습 기록을 저장하기 위한 테이블을 만들어봅시다.

### Dashboard에서 테이블 생성

1. Supabase Dashboard > Table Editor
2. "New table" 클릭
3. 테이블 정보 입력:

```sql
-- 테이블 이름: learning_records
-- 설명: 바데부의 학습 기록을 저장하는 테이블
```

### SQL로 테이블 생성 (추천)

```sql
-- learning_records 테이블 생성
CREATE TABLE learning_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  subject VARCHAR(100) NOT NULL,
  content TEXT,
  hours_spent DECIMAL(5, 2) NOT NULL DEFAULT 0,
  completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 인덱스 생성 (검색 속도 향상)
CREATE INDEX idx_learning_records_user_id ON learning_records(user_id);
CREATE INDEX idx_learning_records_created_at ON learning_records(created_at DESC);
```

## 데이터 타입 이해하기

### 기본 데이터 타입

```sql
-- 숫자 타입
INTEGER          -- 정수: -2147483648 ~ 2147483647
BIGINT           -- 큰 정수: -9223372036854775808 ~ 9223372036854775807
DECIMAL(10, 2)   -- 고정 소수점: 10자리, 소수점 2자리
REAL             -- 부동 소수점

-- 문자열 타입
VARCHAR(100)     -- 가변 길이 문자열 (최대 100자)
TEXT             -- 무제한 길이 문자열
CHAR(10)         -- 고정 길이 문자열 (정확히 10자)

-- 날짜/시간 타입
DATE             -- 날짜만: 2025-10-30
TIME             -- 시간만: 14:30:00
TIMESTAMP        -- 날짜와 시간: 2025-10-30 14:30:00
TIMESTAMP WITH TIME ZONE -- 타임존 포함 (추천)

-- 불린 타입
BOOLEAN          -- true 또는 false

-- UUID 타입
UUID             -- 고유 식별자: 123e4567-e89b-12d3-a456-426614174000

-- JSON 타입
JSON             -- JSON 데이터
JSONB            -- 이진 JSON (검색 빠름, 추천)
```

### 바데부의 실전 예제: 다양한 타입 사용

```sql
-- 바데부의 학습 통계 테이블
CREATE TABLE learning_statistics (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),

  -- 숫자 타입 활용
  total_hours DECIMAL(10, 2) DEFAULT 0,           -- 총 학습 시간
  completed_count INTEGER DEFAULT 0,               -- 완료한 과제 수
  average_score REAL,                              -- 평균 점수

  -- 문자열 타입 활용
  favorite_subject VARCHAR(50),                    -- 선호 과목
  notes TEXT,                                      -- 메모

  -- 날짜 타입 활용
  last_study_date DATE,                           -- 마지막 학습 날짜
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- 불린 타입 활용
  is_active BOOLEAN DEFAULT TRUE,

  -- JSON 타입 활용
  preferences JSONB DEFAULT '{}'::JSONB,          -- 사용자 설정
  weekly_stats JSONB                               -- 주간 통계
);
```

## 제약 조건 (Constraints)

제약 조건은 데이터의 무결성을 보장합니다.

### 주요 제약 조건

```sql
CREATE TABLE users_profile (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

  -- NOT NULL: 반드시 값이 있어야 함
  username VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL,

  -- UNIQUE: 중복 불가
  username VARCHAR(50) UNIQUE,
  email VARCHAR(255) UNIQUE,

  -- CHECK: 특정 조건 만족
  age INTEGER CHECK (age >= 13 AND age <= 120),
  score INTEGER CHECK (score >= 0 AND score <= 100),

  -- DEFAULT: 기본값 설정
  points INTEGER DEFAULT 0,
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- FOREIGN KEY: 다른 테이블 참조
  country_id INTEGER REFERENCES countries(id)
);
```

### 바데부의 예제: 학습 챌린지 테이블

```sql
CREATE TABLE learning_challenges (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  description TEXT,

  -- 난이도는 1, 2, 3 중 하나만 가능
  difficulty INTEGER CHECK (difficulty IN (1, 2, 3)) NOT NULL,

  -- 최소 1시간, 최대 100시간
  estimated_hours DECIMAL(5, 2) CHECK (estimated_hours >= 1 AND estimated_hours <= 100),

  -- 포인트는 양수만
  reward_points INTEGER CHECK (reward_points > 0) DEFAULT 10,

  -- 마감일은 생성일보다 미래여야 함
  deadline TIMESTAMP WITH TIME ZONE CHECK (deadline > created_at),

  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 관계 (Relationships)

테이블 간의 관계를 설정하여 데이터를 효율적으로 관리합니다.

### 일대다 (One-to-Many) 관계

```sql
-- 사용자 테이블 (One)
CREATE TABLE users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL
);

-- 학습 기록 테이블 (Many)
CREATE TABLE learning_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  subject VARCHAR(100) NOT NULL,
  hours_spent DECIMAL(5, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 한 명의 사용자는 여러 개의 학습 기록을 가질 수 있음
```

### 다대다 (Many-to-Many) 관계

```sql
-- 학생 테이블
CREATE TABLE students (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- 과목 테이블
CREATE TABLE subjects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- 중간 테이블 (Junction Table)
CREATE TABLE student_subjects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- 같은 학생이 같은 과목을 중복 등록하지 못하도록
  UNIQUE(student_id, subject_id)
);
```

## CASCADE 옵션 이해하기

```sql
-- ON DELETE CASCADE: 부모 행이 삭제되면 자식 행도 함께 삭제
user_id UUID REFERENCES users(id) ON DELETE CASCADE

-- ON DELETE SET NULL: 부모 행이 삭제되면 자식의 외래 키를 NULL로 설정
user_id UUID REFERENCES users(id) ON DELETE SET NULL

-- ON DELETE RESTRICT: 자식 행이 있으면 부모 행 삭제 불가 (기본값)
user_id UUID REFERENCES users(id) ON DELETE RESTRICT
```

## 실전 예제: 바데부의 학습 관리 시스템

```sql
-- 1. 사용자 프로필 테이블
CREATE TABLE user_profiles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  nickname VARCHAR(50) NOT NULL,
  bio TEXT,
  level INTEGER DEFAULT 1 CHECK (level >= 1),
  total_points INTEGER DEFAULT 0 CHECK (total_points >= 0),
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. 학습 카테고리 테이블
CREATE TABLE learning_categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  icon VARCHAR(50),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. 학습 과제 테이블
CREATE TABLE learning_tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  category_id UUID REFERENCES learning_categories(id) ON DELETE SET NULL,
  title VARCHAR(200) NOT NULL,
  content TEXT,
  difficulty INTEGER CHECK (difficulty BETWEEN 1 AND 5),
  points INTEGER DEFAULT 10 CHECK (points > 0),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. 사용자 과제 진행 상황 테이블
CREATE TABLE user_task_progress (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  task_id UUID REFERENCES learning_tasks(id) ON DELETE CASCADE,
  status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed')),
  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,

  -- 한 사용자가 같은 과제를 중복으로 가질 수 없음
  UNIQUE(user_id, task_id)
);
```

## 일반적인 실수와 해결방법

### 실수 1: UUID 타입을 TEXT로 저장
```sql
-- ❌ 비효율적
user_id TEXT

-- ✅ 올바른 방법
user_id UUID
```

### 실수 2: TIMESTAMP 대신 타임존 없는 시간 사용
```sql
-- ❌ 타임존 문제 발생 가능
created_at TIMESTAMP

-- ✅ 항상 타임존 포함
created_at TIMESTAMP WITH TIME ZONE
```

### 실수 3: NOT NULL을 빠뜨림
```sql
-- ❌ NULL 값이 들어갈 수 있음
email VARCHAR(255)

-- ✅ 필수 필드는 NOT NULL 지정
email VARCHAR(255) NOT NULL
```

### 실수 4: 인덱스를 만들지 않음
```sql
-- ✅ 자주 검색하는 컬럼에는 인덱스 생성
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_tasks_user_id ON learning_tasks(user_id);
```

## 실습 과제

1. **테이블 생성**: 바데부의 "학습 노트" 테이블을 만들어보세요
   - 필드: 제목, 내용, 작성자, 카테고리, 태그(JSONB), 작성일
2. **관계 설정**: 사용자와 학습 노트 간의 관계를 설정하세요
3. **제약 조건**: 제목은 최소 5자 이상, 내용은 필수로 설정
4. **인덱스 생성**: 작성자와 작성일에 인덱스를 추가하세요

## 다음 장 미리보기

다음 장에서는 SQL 쿼리를 작성하는 방법을 배웁니다. SELECT, INSERT, UPDATE, DELETE 문을 사용하여 데이터를 조작하고, JOIN을 통해 여러 테이블의 데이터를 결합하는 방법을 알아봅니다.

## 핵심 요약

- PostgreSQL은 강력한 데이터 타입과 제약 조건을 제공
- UUID는 기본 키로 사용하기 좋음
- TIMESTAMP WITH TIME ZONE을 사용하여 시간 저장
- 제약 조건으로 데이터 무결성 보장
- 관계를 통해 테이블 간 연결 설정
- CASCADE 옵션으로 참조 무결성 관리

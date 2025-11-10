# Chapter 1: Supabase 소개 및 프로젝트 설정

## Supabase란?

Supabase는 오픈소스 Firebase 대안으로, PostgreSQL 데이터베이스를 기반으로 한 백엔드 서비스입니다. 개발자가 빠르게 애플리케이션을 구축할 수 있도록 다음과 같은 기능을 제공합니다:

- **PostgreSQL 데이터베이스**: 강력한 관계형 데이터베이스
- **인증**: 이메일, OAuth, 매직링크 등 다양한 인증 방식
- **실시간 구독**: 데이터 변경사항을 실시간으로 감지
- **스토리지**: 파일 업로드 및 관리
- **Edge Functions**: 서버리스 함수 실행
- **자동 생성 API**: REST와 GraphQL API 자동 생성

## 왜 Supabase를 사용할까?

1. **빠른 개발**: 백엔드 인프라를 직접 구축할 필요 없이 빠르게 시작
2. **오픈소스**: 코드를 완전히 제어하고 자체 호스팅 가능
3. **SQL 지원**: Firebase와 달리 강력한 SQL 쿼리 사용 가능
4. **무료 티어**: 개인 프로젝트나 학습에 충분한 무료 플랜 제공

## 프로젝트 생성하기

### 1단계: Supabase 계정 만들기

1. [supabase.com](https://supabase.com)에 접속
2. "Start your project" 클릭
3. GitHub 계정으로 로그인 (추천)

### 2단계: 새 프로젝트 생성

```javascript
// 프로젝트 정보 입력 예시
프로젝트 이름: "바데부-학습앱"
데이터베이스 비밀번호: 강력한 비밀번호 설정 (꼭 저장하세요!)
리전: Northeast Asia (Seoul) - 한국 서버 선택
```

### 3단계: 프로젝트 URL과 API Key 확인

프로젝트가 생성되면 다음 정보를 확인할 수 있습니다:

```javascript
// Settings > API에서 확인
Project URL: https://your-project.supabase.co
anon public key: eyJhbGc...
service_role key: eyJhbGc... (주의: 절대 클라이언트에 노출 금지!)
```

## JavaScript 프로젝트 설정

### Supabase 클라이언트 설치

```bash
# npm 사용
npm install @supabase/supabase-js

# yarn 사용
yarn add @supabase/supabase-js
```

### 클라이언트 초기화

```javascript
// supabase.js
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://your-project.supabase.co'
const supabaseAnonKey = 'your-anon-key'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
```

### 환경 변수 설정 (권장)

```javascript
// .env 파일
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key

// supabase.js
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
```

## 첫 번째 테스트: 연결 확인

```javascript
// test-connection.js
import { supabase } from './supabase.js'

async function testConnection() {
  try {
    // Supabase 버전 확인
    const { data, error } = await supabase
      .from('_test')
      .select('*')
      .limit(1)

    if (error && error.code === 'PGRST116') {
      console.log('✅ Supabase 연결 성공! (테이블이 없는 것은 정상입니다)')
    } else {
      console.log('✅ Supabase 연결 성공!')
    }
  } catch (err) {
    console.error('❌ 연결 실패:', err.message)
  }
}

testConnection()
```

## Supabase Dashboard 둘러보기

### Table Editor (테이블 편집기)
- 데이터베이스 테이블을 시각적으로 생성하고 편집
- 스프레드시트처럼 직관적인 인터페이스

### SQL Editor (SQL 편집기)
- 직접 SQL 쿼리를 작성하고 실행
- 저장된 쿼리를 재사용 가능

### Authentication (인증)
- 사용자 관리 및 인증 설정
- OAuth 프로바이더 설정

### Storage (스토리지)
- 파일 버킷 생성 및 관리
- 파일 업로드/다운로드

### Database (데이터베이스)
- 테이블, 함수, 트리거 등 관리
- RLS 정책 설정

## 실전 예제: 바데부의 첫 프로젝트

바데부가 학습 관리 앱을 만들기로 했습니다. 먼저 프로젝트를 설정해봅시다:

```javascript
// 바데부의 Supabase 설정
// badebu-learning-app/src/lib/supabase.js

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

// Supabase 클라이언트 생성
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true
  }
})

// 연결 상태 확인 함수
export async function checkConnection() {
  const { error } = await supabase.from('_health').select('*').limit(1)
  return !error || error.code === 'PGRST116'
}
```

## 일반적인 실수와 해결방법

### 실수 1: API Key를 코드에 직접 입력
```javascript
// ❌ 잘못된 방법
const supabase = createClient(
  'https://abc.supabase.co',
  'eyJhbGc...' // 하드코딩하면 Git에 노출됨
)

// ✅ 올바른 방법
const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
)
```

### 실수 2: service_role key를 클라이언트에서 사용
```javascript
// ❌ 절대 금지!
const supabase = createClient(url, SERVICE_ROLE_KEY) // 모든 보안 우회

// ✅ 클라이언트에서는 항상 anon key 사용
const supabase = createClient(url, ANON_KEY)
```

### 실수 3: .env 파일을 Git에 커밋
```bash
# .gitignore 파일에 반드시 추가
.env
.env.local
.env.*.local
```

## 실습 과제

1. **프로젝트 생성**: Supabase에서 "바데부-연습" 프로젝트 만들기
2. **클라이언트 설정**: JavaScript 프로젝트에서 Supabase 클라이언트 초기화
3. **환경 변수**: .env 파일을 사용하여 안전하게 API 키 관리
4. **연결 테스트**: 위의 testConnection 함수를 실행하여 연결 확인

## 다음 장 미리보기

다음 장에서는 Supabase의 핵심인 PostgreSQL 데이터베이스를 다룹니다. 테이블을 생성하고, 컬럼 타입을 이해하며, 관계를 설정하는 방법을 배웁니다. 바데부와 함께 실제 학습 기록을 저장하는 테이블을 만들어봅시다!

## 핵심 요약

- Supabase는 PostgreSQL 기반의 오픈소스 백엔드 플랫폼
- 프로젝트 생성 시 URL과 anon key 획득
- 클라이언트는 `@supabase/supabase-js` 패키지로 초기화
- 환경 변수로 API 키를 안전하게 관리
- service_role key는 절대 클라이언트에 노출 금지

# Chapter 10: 프로덕션 배포 및 모범 사례

## 프로덕션 준비하기

바데부가 학습 관리 앱을 완성했습니다! 이제 실제 사용자들에게 서비스하기 위해 프로덕션 환경으로 배포할 차례입니다.

### 프로덕션 체크리스트

```markdown
- [ ] 환경 변수 설정 완료
- [ ] RLS 정책 모든 테이블에 적용
- [ ] API 키 보안 확인
- [ ] 에러 처리 구현
- [ ] 로딩 상태 처리
- [ ] 성능 최적화
- [ ] 백업 설정
- [ ] 모니터링 설정
- [ ] 사용량 제한 확인
```

## 환경 설정

### 개발/프로덕션 환경 분리

```javascript
// config.js
const isDevelopment = process.env.NODE_ENV === 'development'

export const config = {
  supabase: {
    url: isDevelopment
      ? process.env.VITE_DEV_SUPABASE_URL
      : process.env.VITE_PROD_SUPABASE_URL,
    anonKey: isDevelopment
      ? process.env.VITE_DEV_SUPABASE_ANON_KEY
      : process.env.VITE_PROD_SUPABASE_ANON_KEY
  },
  api: {
    timeout: isDevelopment ? 30000 : 10000,
    retries: isDevelopment ? 1 : 3
  }
}
```

### .env 파일 관리

```bash
# .env.development
VITE_SUPABASE_URL=https://dev-project.supabase.co
VITE_SUPABASE_ANON_KEY=dev-anon-key

# .env.production
VITE_SUPABASE_URL=https://prod-project.supabase.co
VITE_SUPABASE_ANON_KEY=prod-anon-key

# .gitignore에 추가
.env
.env.*
!.env.example
```

```bash
# .env.example (버전 관리에 포함)
VITE_SUPABASE_URL=your-project-url
VITE_SUPABASE_ANON_KEY=your-anon-key
```

## 보안 강화

### RLS 정책 완벽하게 설정

```sql
-- 모든 테이블에 RLS 활성화 확인
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND rowsecurity = false;

-- 정책이 없는 테이블 확인
SELECT t.tablename
FROM pg_tables t
LEFT JOIN pg_policies p ON t.tablename = p.tablename
WHERE t.schemaname = 'public'
  AND t.rowsecurity = true
  AND p.policyname IS NULL;
```

### API 키 보호

```javascript
// ❌ 절대 금지!
const supabase = createClient(url, SERVICE_ROLE_KEY)  // 클라이언트에 노출

// ✅ 올바른 방법
const supabase = createClient(url, ANON_KEY)  // 클라이언트에서는 항상 anon key

// ✅ service_role은 Edge Functions나 백엔드에서만
// supabase/functions/admin-task/index.ts
const supabaseAdmin = createClient(
  Deno.env.get('SUPABASE_URL'),
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')  // 서버에서만!
)
```

### Rate Limiting (속도 제한)

```javascript
// Edge Function에서 속도 제한 구현
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const RATE_LIMIT = 10  // 분당 10회
const RATE_WINDOW = 60 * 1000  // 1분

const rateLimitMap = new Map()

serve(async (req) => {
  const userId = req.headers.get('x-user-id')

  // 속도 제한 확인
  const now = Date.now()
  const userRequests = rateLimitMap.get(userId) || []
  const recentRequests = userRequests.filter(time => now - time < RATE_WINDOW)

  if (recentRequests.length >= RATE_LIMIT) {
    return new Response(
      JSON.stringify({ error: '너무 많은 요청입니다. 잠시 후 다시 시도하세요.' }),
      { status: 429 }
    )
  }

  recentRequests.push(now)
  rateLimitMap.set(userId, recentRequests)

  // 요청 처리
  // ...
})
```

## 성능 최적화

### 데이터베이스 인덱스

```sql
-- 자주 조회하는 컬럼에 인덱스 생성
CREATE INDEX idx_learning_records_user_id ON learning_records(user_id);
CREATE INDEX idx_learning_records_created_at ON learning_records(created_at DESC);
CREATE INDEX idx_learning_records_subject ON learning_records(subject);

-- 복합 인덱스
CREATE INDEX idx_learning_records_user_date ON learning_records(user_id, created_at DESC);

-- 인덱스 사용 확인
EXPLAIN ANALYZE
SELECT * FROM learning_records
WHERE user_id = 'some-uuid'
  AND created_at >= '2025-01-01'
ORDER BY created_at DESC;

-- 사용되지 않는 인덱스 찾기
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan as index_scans
FROM pg_stat_user_indexes
WHERE idx_scan = 0
  AND schemaname = 'public'
ORDER BY tablename;
```

### 쿼리 최적화

```javascript
// ❌ N+1 문제
const { data: records } = await supabase
  .from('learning_records')
  .select('*')

for (const record of records) {
  const { data: user } = await supabase
    .from('users')
    .select('name')
    .eq('id', record.user_id)
    .single()
  // 매 행마다 쿼리 실행!
}

// ✅ JOIN으로 한 번에 조회
const { data: records } = await supabase
  .from('learning_records')
  .select(`
    *,
    users (
      name,
      email
    )
  `)

// ❌ 불필요한 데이터 조회
const { data } = await supabase
  .from('learning_records')
  .select('*')  // 모든 컬럼

// ✅ 필요한 컬럼만 선택
const { data } = await supabase
  .from('learning_records')
  .select('id, subject, hours_spent')
```

### 페이지네이션

```javascript
// 바데부의 학습 기록을 페이지네이션으로 조회
async function getBadebuRecordsPage(page = 1, pageSize = 20) {
  const from = (page - 1) * pageSize
  const to = from + pageSize - 1

  const { data, error, count } = await supabase
    .from('learning_records')
    .select('*', { count: 'exact' })
    .order('created_at', { ascending: false })
    .range(from, to)

  if (error) {
    console.error('조회 실패:', error)
    return null
  }

  return {
    data,
    pagination: {
      page,
      pageSize,
      totalRecords: count,
      totalPages: Math.ceil(count / pageSize),
      hasNext: to < count - 1,
      hasPrev: page > 1
    }
  }
}

// 사용 예시
const result = await getBadebuRecordsPage(1, 20)
console.log('페이지:', result.pagination.page)
console.log('총 페이지:', result.pagination.totalPages)
console.log('데이터:', result.data)
```

### 캐싱

```javascript
// 자주 변경되지 않는 데이터 캐싱
class CachedSupabaseClient {
  constructor() {
    this.cache = new Map()
    this.cacheTTL = 5 * 60 * 1000  // 5분
  }

  async getCategoriesWithCache() {
    const cacheKey = 'categories'
    const cached = this.cache.get(cacheKey)

    if (cached && Date.now() - cached.timestamp < this.cacheTTL) {
      console.log('캐시에서 카테고리 조회')
      return cached.data
    }

    const { data, error } = await supabase
      .from('learning_categories')
      .select('*')
      .order('name')

    if (!error) {
      this.cache.set(cacheKey, {
        data,
        timestamp: Date.now()
      })
    }

    return data
  }

  clearCache() {
    this.cache.clear()
  }
}

const cachedClient = new CachedSupabaseClient()
```

## 에러 처리

### 포괄적인 에러 처리

```javascript
// error-handler.js
export class SupabaseError extends Error {
  constructor(message, code, details) {
    super(message)
    this.code = code
    this.details = details
    this.name = 'SupabaseError'
  }
}

export function handleSupabaseError(error) {
  console.error('Supabase 에러:', error)

  // 네트워크 에러
  if (!navigator.onLine) {
    return new SupabaseError(
      '인터넷 연결을 확인해주세요',
      'NETWORK_ERROR',
      error
    )
  }

  // 인증 에러
  if (error.code === 'PGRST301' || error.message?.includes('JWT')) {
    return new SupabaseError(
      '로그인이 필요합니다',
      'AUTH_ERROR',
      error
    )
  }

  // RLS 정책 위반
  if (error.code === '42501') {
    return new SupabaseError(
      '접근 권한이 없습니다',
      'PERMISSION_ERROR',
      error
    )
  }

  // 제약 조건 위반
  if (error.code === '23505') {
    return new SupabaseError(
      '중복된 데이터입니다',
      'DUPLICATE_ERROR',
      error
    )
  }

  // 기타 에러
  return new SupabaseError(
    '요청 처리 중 오류가 발생했습니다',
    'UNKNOWN_ERROR',
    error
  )
}

// 사용 예시
async function addLearningRecord(data) {
  try {
    const { data: result, error } = await supabase
      .from('learning_records')
      .insert(data)
      .select()
      .single()

    if (error) {
      throw handleSupabaseError(error)
    }

    return result
  } catch (error) {
    if (error instanceof SupabaseError) {
      // UI에 사용자 친화적인 메시지 표시
      alert(error.message)
    }
    throw error
  }
}
```

## 모니터링 및 로깅

### 사용량 모니터링

```javascript
// Supabase Dashboard > Settings > Usage에서 확인
// - Database size
// - Bandwidth
// - API requests
// - Storage size

// 프로그래밍으로 사용량 추적
class UsageTracker {
  constructor() {
    this.apiCalls = 0
    this.errors = 0
  }

  trackApiCall() {
    this.apiCalls++
  }

  trackError(error) {
    this.errors++
    console.error('에러 추적:', error)

    // 외부 로깅 서비스로 전송 (Sentry, LogRocket 등)
    // sendToLoggingService(error)
  }

  getStats() {
    return {
      apiCalls: this.apiCalls,
      errors: this.errors,
      errorRate: this.errors / this.apiCalls
    }
  }
}

const tracker = new UsageTracker()

// Supabase 클라이언트 래핑
const trackedSupabase = {
  from: (table) => {
    tracker.trackApiCall()
    return supabase.from(table)
  }
}
```

### 성능 모니터링

```javascript
// 쿼리 성능 측정
async function measureQueryPerformance(queryFn, queryName) {
  const startTime = performance.now()

  try {
    const result = await queryFn()
    const endTime = performance.now()
    const duration = endTime - startTime

    console.log(`[${queryName}] 실행 시간: ${duration.toFixed(2)}ms`)

    // 느린 쿼리 경고
    if (duration > 1000) {
      console.warn(`⚠️ 느린 쿼리 감지: ${queryName} (${duration.toFixed(2)}ms)`)
    }

    return result
  } catch (error) {
    const endTime = performance.now()
    const duration = endTime - startTime
    console.error(`[${queryName}] 에러 (${duration.toFixed(2)}ms):`, error)
    throw error
  }
}

// 사용 예시
const records = await measureQueryPerformance(
  () => supabase.from('learning_records').select('*'),
  'getBadebuRecords'
)
```

## 백업 및 복구

### 자동 백업 설정

```bash
# Supabase Dashboard > Settings > Database > Backups
# Pro 플랜: 매일 자동 백업, 7일 보관
# 수동 백업도 가능

# CLI로 백업
supabase db dump -f backup.sql

# 복구
supabase db reset
psql -h your-db-host -U postgres -d postgres -f backup.sql
```

### 중요 데이터 별도 백업

```javascript
// 정기적으로 중요 데이터 내보내기
async function exportBadebuData() {
  const { data: { user } } = await supabase.auth.getUser()

  // 모든 학습 기록 조회
  const { data: records } = await supabase
    .from('learning_records')
    .select('*')
    .eq('user_id', user.id)

  // JSON 파일로 저장
  const backup = {
    exported_at: new Date().toISOString(),
    user_id: user.id,
    records: records
  }

  const blob = new Blob([JSON.stringify(backup, null, 2)], {
    type: 'application/json'
  })

  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `badebu-backup-${Date.now()}.json`
  a.click()

  console.log('바데부의 데이터가 백업되었습니다!')
}
```

## 마이그레이션 관리

### 버전 관리된 마이그레이션

```sql
-- migrations/001_initial_schema.sql
CREATE TABLE learning_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  subject VARCHAR(100) NOT NULL,
  hours_spent DECIMAL(5, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- migrations/002_add_completed_column.sql
ALTER TABLE learning_records ADD COLUMN completed BOOLEAN DEFAULT FALSE;

-- migrations/003_add_statistics_table.sql
CREATE TABLE user_statistics (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id),
  total_hours DECIMAL(10, 2) DEFAULT 0,
  total_records INTEGER DEFAULT 0
);
```

```bash
# CLI로 마이그레이션 실행
supabase migration new add_completed_column
supabase db push

# 로컬에서 마이그레이션 테스트
supabase migration up
```

## 프로덕션 배포 체크리스트

### 최종 점검

```javascript
// deployment-checklist.js
const productionChecklist = {
  security: [
    '모든 테이블에 RLS 활성화 확인',
    'service_role key가 클라이언트에 노출되지 않는지 확인',
    '환경 변수가 안전하게 관리되는지 확인',
    'CORS 설정 확인',
    'API 속도 제한 설정'
  ],
  performance: [
    '자주 조회되는 컬럼에 인덱스 생성',
    '페이지네이션 구현',
    '불필요한 데이터 조회 최소화',
    '이미지 최적화',
    '캐싱 전략 수립'
  ],
  reliability: [
    '에러 처리 구현',
    '로딩 상태 처리',
    '재시도 로직 구현',
    '타임아웃 설정',
    '폴백 UI 제공'
  ],
  monitoring: [
    '사용량 모니터링 설정',
    '에러 로깅 설정',
    '성능 모니터링 설정',
    '알림 설정',
    '백업 자동화'
  ]
}

// 체크리스트 자동 검증
async function validateProduction() {
  const results = {
    passed: [],
    failed: []
  }

  // RLS 확인
  const { data: tables } = await supabase.rpc('check_rls_enabled')
  if (tables.every(t => t.rowsecurity)) {
    results.passed.push('RLS 활성화 ✓')
  } else {
    results.failed.push('일부 테이블에 RLS 미설정 ✗')
  }

  // 인덱스 확인
  const { data: indexes } = await supabase.rpc('check_indexes')
  if (indexes.length > 0) {
    results.passed.push(`인덱스 ${indexes.length}개 설정 ✓`)
  }

  console.log('=== 프로덕션 준비 상태 ===')
  console.log('통과:', results.passed)
  console.log('실패:', results.failed)

  return results.failed.length === 0
}
```

## 바데부의 프로덕션 배포 가이드

```javascript
// 1. 환경 설정
console.log('1. 환경 변수 확인 중...')
if (!process.env.VITE_SUPABASE_URL) {
  throw new Error('환경 변수가 설정되지 않았습니다')
}

// 2. RLS 검증
console.log('2. RLS 정책 확인 중...')
await validateRLSPolicies()

// 3. 성능 최적화 확인
console.log('3. 인덱스 확인 중...')
await checkIndexes()

// 4. 백업 설정
console.log('4. 백업 설정 확인 중...')
await verifyBackupSettings()

// 5. 모니터링 설정
console.log('5. 모니터링 설정 중...')
await setupMonitoring()

console.log('✅ 프로덕션 배포 준비 완료!')
console.log('바데부의 학습 관리 앱이 세상에 공개됩니다! 🎉')
```

## 실습 과제

1. **성능 벤치마크**: 주요 쿼리의 실행 시간을 측정하고 최적화
2. **에러 추적 시스템**: 모든 에러를 로깅하는 시스템 구축
3. **백업 자동화**: 매일 자동으로 데이터를 백업하는 스크립트 작성
4. **모니터링 대시보드**: 사용량과 성능을 보여주는 관리자 페이지 구현

## 마무리

축하합니다! 바데부와 함께 Supabase의 모든 기초를 마스터했습니다.

### 배운 내용 요약

1. **Chapter 1-3**: Supabase 기초, 데이터베이스, SQL 쿼리
2. **Chapter 4-5**: RLS 보안, 인증 시스템
3. **Chapter 6-7**: 실시간 기능, 파일 스토리지
4. **Chapter 8-9**: Edge Functions, 트리거와 함수
5. **Chapter 10**: 프로덕션 배포와 모범 사례

### 다음 단계

- Supabase 공식 문서 심화 학습
- 실제 프로젝트에 Supabase 적용
- 커뮤니티에 참여하여 경험 공유
- 고급 PostgreSQL 기능 학습
- 성능 튜닝과 스케일링 기법 연구

## 핵심 요약

- 프로덕션 배포 전 보안, 성능, 안정성 체크
- RLS 정책을 모든 테이블에 적용
- 인덱스와 쿼리 최적화로 성능 향상
- 포괄적인 에러 처리와 모니터링 필수
- 정기적인 백업과 마이그레이션 관리
- 환경별 설정 분리와 체계적인 배포

바데부처럼 꾸준히 학습하고 실천하세요! 🚀

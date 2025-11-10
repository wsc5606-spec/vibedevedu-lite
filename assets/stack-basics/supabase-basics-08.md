# Chapter 8: Edge Functions

## Edge Functions란?

Edge Functions는 Supabase에서 제공하는 서버리스 함수입니다. Deno 런타임을 사용하여 전 세계 엣지 네트워크에서 실행되며, 백엔드 로직을 작성하고 외부 API를 호출할 수 있습니다.

### Edge Functions의 특징

- **서버리스**: 서버 관리 없이 코드만 배포
- **TypeScript 지원**: 타입 안전성을 갖춘 개발
- **전역 배포**: 사용자와 가까운 위치에서 실행
- **빠른 콜드 스타트**: 밀리초 단위의 시작 시간
- **Deno 런타임**: 현대적이고 안전한 런타임 환경

### 사용 사례

- 외부 API 통합 (결제, 이메일, AI 등)
- 복잡한 데이터 처리
- 예약 작업 및 크론 작업
- Webhook 처리
- 인증 및 권한 검증
- 서버 측 로직 실행

## Edge Functions 시작하기

### CLI 설치

```bash
# Supabase CLI 설치
npm install -g supabase

# 로그인
supabase login

# 프로젝트 초기화
supabase init

# Edge Functions 생성
supabase functions new hello-badebu
```

### 첫 번째 Edge Function

```typescript
// supabase/functions/hello-badebu/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

serve(async (req) => {
  const { name } = await req.json()

  const data = {
    message: `안녕하세요, ${name || '바데부'}님!`,
    timestamp: new Date().toISOString()
  }

  return new Response(
    JSON.stringify(data),
    {
      headers: { 'Content-Type': 'application/json' },
      status: 200
    }
  )
})
```

### 로컬에서 테스트

```bash
# Edge Functions 로컬 실행
supabase start
supabase functions serve hello-badebu

# 다른 터미널에서 테스트
curl -i --location --request POST 'http://localhost:54321/functions/v1/hello-badebu' \
  --header 'Content-Type: application/json' \
  --data '{"name":"바데부"}'
```

### 배포

```bash
# Edge Function 배포
supabase functions deploy hello-badebu

# 배포된 함수의 URL 확인
# https://your-project.supabase.co/functions/v1/hello-badebu
```

## JavaScript/TypeScript에서 호출하기

### 기본 호출

```javascript
import { supabase } from './supabase.js'

// Edge Function 호출
async function callHelloBadebu(name) {
  const { data, error } = await supabase.functions.invoke('hello-badebu', {
    body: { name: name }
  })

  if (error) {
    console.error('함수 호출 실패:', error)
    return null
  }

  console.log('응답:', data)
  return data
}

// 사용 예시
await callHelloBadebu('바데부')
// 응답: { message: "안녕하세요, 바데부님!", timestamp: "..." }
```

## Supabase 클라이언트 사용하기

### Edge Function에서 데이터베이스 접근

```typescript
// supabase/functions/get-learning-stats/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  try {
    // Supabase 클라이언트 생성
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! }
        }
      }
    )

    // 현재 사용자 가져오기
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser()

    if (userError || !user) {
      throw new Error('인증이 필요합니다')
    }

    // 바데부의 학습 통계 계산
    const { data: records, error } = await supabaseClient
      .from('learning_records')
      .select('hours_spent, completed, subject')
      .eq('user_id', user.id)

    if (error) throw error

    // 통계 계산
    const stats = {
      totalRecords: records.length,
      totalHours: records.reduce((sum, r) => sum + r.hours_spent, 0),
      completedCount: records.filter(r => r.completed).length,
      subjectCounts: records.reduce((acc, r) => {
        acc[r.subject] = (acc[r.subject] || 0) + 1
        return acc
      }, {})
    }

    return new Response(
      JSON.stringify(stats),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 200
      }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 400
      }
    )
  }
})
```

### 클라이언트에서 호출

```javascript
// 인증 토큰과 함께 호출
async function getBadebuLearningStats() {
  const { data, error } = await supabase.functions.invoke('get-learning-stats', {
    headers: {
      Authorization: `Bearer ${(await supabase.auth.getSession()).data.session?.access_token}`
    }
  })

  if (error) {
    console.error('통계 조회 실패:', error)
    return null
  }

  console.log('바데부의 학습 통계:', data)
  return data
}
```

## 외부 API 호출

### OpenAI API 연동

```typescript
// supabase/functions/ai-study-helper/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

serve(async (req) => {
  try {
    const { question } = await req.json()

    // OpenAI API 호출
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${Deno.env.get('OPENAI_API_KEY')}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'gpt-4',
        messages: [
          {
            role: 'system',
            content: '당신은 바데부의 학습을 돕는 친절한 AI 튜터입니다.'
          },
          {
            role: 'user',
            content: question
          }
        ],
        max_tokens: 500
      })
    })

    const data = await response.json()
    const answer = data.choices[0].message.content

    return new Response(
      JSON.stringify({ question, answer }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 200
      }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 500
      }
    )
  }
})
```

### 환경 변수 설정

```bash
# 로컬 환경 변수
# supabase/.env
OPENAI_API_KEY=sk-...

# 프로덕션 환경 변수 (Dashboard에서 설정)
# Settings > Edge Functions > Secrets
supabase secrets set OPENAI_API_KEY=sk-...
```

### 클라이언트에서 AI 도우미 호출

```javascript
async function askBadebuAIHelper(question) {
  console.log('바데부가 AI 튜터에게 질문합니다:', question)

  const { data, error } = await supabase.functions.invoke('ai-study-helper', {
    body: { question }
  })

  if (error) {
    console.error('AI 호출 실패:', error)
    return null
  }

  console.log('AI 튜터의 답변:', data.answer)
  return data
}

// 사용 예시
await askBadebuAIHelper('Supabase의 RLS는 어떻게 작동하나요?')
```

## 바데부의 실전 예제: 학습 인증서 생성

```typescript
// supabase/functions/generate-certificate/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    const { courseId } = await req.json()

    // 인증 확인
    const authHeader = req.headers.get('Authorization')!
    const token = authHeader.replace('Bearer ', '')
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser(token)

    if (authError || !user) {
      throw new Error('인증이 필요합니다')
    }

    // 과정 완료 여부 확인
    const { data: progress, error: progressError } = await supabaseClient
      .from('course_progress')
      .select('*')
      .eq('user_id', user.id)
      .eq('course_id', courseId)
      .single()

    if (progressError) throw progressError

    if (progress.completion_percentage < 100) {
      throw new Error('과정을 완료해야 인증서를 발급받을 수 있습니다')
    }

    // 사용자 정보 조회
    const { data: profile, error: profileError } = await supabaseClient
      .from('user_profiles')
      .select('nickname')
      .eq('id', user.id)
      .single()

    if (profileError) throw profileError

    // 과정 정보 조회
    const { data: course, error: courseError } = await supabaseClient
      .from('courses')
      .select('title')
      .eq('id', courseId)
      .single()

    if (courseError) throw courseError

    // 인증서 데이터 생성
    const certificate = {
      id: crypto.randomUUID(),
      user_id: user.id,
      course_id: courseId,
      user_name: profile.nickname,
      course_title: course.title,
      issued_at: new Date().toISOString(),
      certificate_url: `https://yourapp.com/certificates/${crypto.randomUUID()}`
    }

    // 인증서 저장
    const { error: insertError } = await supabaseClient
      .from('certificates')
      .insert(certificate)

    if (insertError) throw insertError

    console.log(`바데부가 "${course.title}" 과정의 인증서를 받았습니다!`)

    return new Response(
      JSON.stringify(certificate),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 200
      }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 400
      }
    )
  }
})
```

```javascript
// 클라이언트에서 인증서 발급
async function generateBadebuCertificate(courseId) {
  const { data: { session } } = await supabase.auth.getSession()

  const { data, error } = await supabase.functions.invoke('generate-certificate', {
    body: { courseId },
    headers: {
      Authorization: `Bearer ${session.access_token}`
    }
  })

  if (error) {
    console.error('인증서 발급 실패:', error)
    alert(error.message)
    return null
  }

  console.log('축하합니다! 인증서가 발급되었습니다!')
  console.log('인증서 URL:', data.certificate_url)
  return data
}
```

## Webhook 처리

### Stripe Webhook 처리

```typescript
// supabase/functions/stripe-webhook/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import Stripe from 'https://esm.sh/stripe@13.0.0'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') || '', {
  apiVersion: '2023-10-16'
})

serve(async (req) => {
  const signature = req.headers.get('stripe-signature')!
  const body = await req.text()

  try {
    // Webhook 서명 검증
    const event = stripe.webhooks.constructEvent(
      body,
      signature,
      Deno.env.get('STRIPE_WEBHOOK_SECRET')!
    )

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // 이벤트 타입에 따라 처리
    switch (event.type) {
      case 'payment_intent.succeeded':
        const paymentIntent = event.data.object

        // 결제 성공 처리
        await supabaseClient
          .from('payments')
          .insert({
            user_id: paymentIntent.metadata.user_id,
            amount: paymentIntent.amount,
            status: 'succeeded',
            stripe_payment_id: paymentIntent.id
          })

        console.log('바데부의 결제가 성공했습니다!')
        break

      case 'customer.subscription.created':
        const subscription = event.data.object

        // 구독 생성 처리
        await supabaseClient
          .from('subscriptions')
          .insert({
            user_id: subscription.metadata.user_id,
            status: 'active',
            stripe_subscription_id: subscription.id
          })

        console.log('바데부가 구독을 시작했습니다!')
        break

      default:
        console.log(`처리되지 않은 이벤트: ${event.type}`)
    }

    return new Response(
      JSON.stringify({ received: true }),
      { status: 200 }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 400 }
    )
  }
})
```

## CORS 설정

### CORS 헤더 추가

```typescript
// supabase/functions/cors-example/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type'
}

serve(async (req) => {
  // OPTIONS 요청 처리 (preflight)
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const data = { message: 'CORS가 설정되었습니다' }

    return new Response(
      JSON.stringify(data),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200
      }
    )
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400
      }
    )
  }
})
```

## 일반적인 실수와 해결방법

### 실수 1: 환경 변수 누락

```typescript
// ❌ 환경 변수 확인 안 함
const apiKey = Deno.env.get('API_KEY')
// apiKey가 undefined일 수 있음

// ✅ 환경 변수 검증
const apiKey = Deno.env.get('API_KEY')
if (!apiKey) {
  throw new Error('API_KEY 환경 변수가 설정되지 않았습니다')
}
```

### 실수 2: CORS 설정 누락

```typescript
// ❌ CORS 헤더 없음
return new Response(JSON.stringify(data))

// ✅ CORS 헤더 포함
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type'
}
return new Response(JSON.stringify(data), { headers: corsHeaders })
```

### 실수 3: 에러 처리 부족

```typescript
// ❌ try-catch 없음
const data = await req.json()

// ✅ 항상 에러 처리
try {
  const data = await req.json()
  // 로직
} catch (error) {
  return new Response(
    JSON.stringify({ error: error.message }),
    { status: 400 }
  )
}
```

### 실수 4: 인증 검증 누락

```typescript
// ❌ 누구나 호출 가능
serve(async (req) => {
  // 중요한 작업 수행
})

// ✅ 인증 확인
serve(async (req) => {
  const authHeader = req.headers.get('Authorization')
  if (!authHeader) {
    return new Response('Unauthorized', { status: 401 })
  }
  // 작업 수행
})
```

## 실습 과제

1. **이메일 발송**: Edge Function을 사용하여 학습 완료 시 축하 이메일 발송
2. **데이터 집계**: 사용자별 학습 통계를 계산하는 함수 작성
3. **외부 API 연동**: 날씨 API를 호출하여 학습 추천 제공
4. **Webhook 처리**: GitHub webhook을 받아 학습 기록 자동 생성

## 다음 장 미리보기

다음 장에서는 데이터베이스 트리거와 함수를 배웁니다. PostgreSQL의 강력한 기능을 활용하여 자동화된 데이터 처리를 구현하는 방법을 알아봅니다.

## 핵심 요약

- Edge Functions는 서버리스 함수로 전역 배포
- Deno 런타임 사용, TypeScript 지원
- Supabase 클라이언트로 데이터베이스 접근
- 외부 API 통합 가능
- 환경 변수로 보안 정보 관리
- CORS 설정 필수
- 항상 에러 처리와 인증 검증

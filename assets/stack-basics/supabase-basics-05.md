# Chapter 5: 인증 (Authentication)

## Supabase 인증 시스템 이해하기

Supabase는 JWT (JSON Web Token) 기반의 강력한 인증 시스템을 제공합니다. 사용자 등록, 로그인, 소셜 로그인, 비밀번호 재설정 등 모든 인증 기능을 쉽게 구현할 수 있습니다.

### 인증의 핵심 개념

- **사용자 (User)**: auth.users 테이블에 저장되는 인증 정보
- **세션 (Session)**: 로그인 상태를 유지하는 토큰
- **JWT**: 암호화된 토큰으로 사용자 정보를 담고 있음
- **Refresh Token**: 만료된 JWT를 갱신하는 토큰

## 이메일/비밀번호 인증

### 회원가입 (Sign Up)

```javascript
// 기본 회원가입
async function signUp(email, password) {
  const { data, error } = await supabase.auth.signUp({
    email: email,
    password: password
  })

  if (error) {
    console.error('회원가입 실패:', error.message)
    return null
  }

  console.log('회원가입 성공!', data.user)
  return data.user
}

// 추가 정보와 함께 회원가입
async function signUpWithProfile(email, password, nickname) {
  const { data, error } = await supabase.auth.signUp({
    email: email,
    password: password,
    options: {
      data: {
        nickname: nickname,
        display_name: '바데부'
      }
    }
  })

  if (error) {
    console.error('회원가입 실패:', error.message)
    return null
  }

  console.log('바데부 계정 생성 완료!')
  return data.user
}

// 사용 예시
await signUpWithProfile('badebu@example.com', 'securePassword123!', '바데부')
```

### 이메일 인증 설정

```javascript
// Supabase Dashboard > Authentication > Settings에서 설정
// - Confirm Email: ON (이메일 인증 필수)
// - Enable Email Confirmations: ON

// 이메일 인증이 필요한 회원가입
const { data, error } = await supabase.auth.signUp({
  email: 'badebu@example.com',
  password: 'password123',
  options: {
    emailRedirectTo: 'https://yourapp.com/welcome'
  }
})

// 사용자는 이메일을 확인해야 함
// data.user.email_confirmed_at이 null이면 미인증 상태
```

### 로그인 (Sign In)

```javascript
// 이메일/비밀번호로 로그인
async function signIn(email, password) {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: email,
    password: password
  })

  if (error) {
    console.error('로그인 실패:', error.message)
    return null
  }

  console.log('바데부가 로그인했습니다!')
  console.log('사용자:', data.user.email)
  console.log('세션:', data.session)
  return data
}

// 로그인 상태 확인
async function checkLoginStatus() {
  const { data: { user } } = await supabase.auth.getUser()

  if (user) {
    console.log('로그인 중:', user.email)
    return user
  } else {
    console.log('로그인되지 않음')
    return null
  }
}
```

### 로그아웃 (Sign Out)

```javascript
async function signOut() {
  const { error } = await supabase.auth.signOut()

  if (error) {
    console.error('로그아웃 실패:', error.message)
    return false
  }

  console.log('바데부가 로그아웃했습니다')
  return true
}
```

## 비밀번호 관리

### 비밀번호 재설정 요청

```javascript
async function requestPasswordReset(email) {
  const { data, error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: 'https://yourapp.com/reset-password'
  })

  if (error) {
    console.error('비밀번호 재설정 요청 실패:', error.message)
    return false
  }

  console.log('비밀번호 재설정 이메일이 발송되었습니다')
  return true
}
```

### 비밀번호 변경

```javascript
// 로그인한 상태에서 비밀번호 변경
async function updatePassword(newPassword) {
  const { data, error } = await supabase.auth.updateUser({
    password: newPassword
  })

  if (error) {
    console.error('비밀번호 변경 실패:', error.message)
    return false
  }

  console.log('바데부의 비밀번호가 변경되었습니다')
  return true
}
```

## OAuth 소셜 로그인

### 지원하는 OAuth 제공자

- Google
- GitHub
- GitLab
- Bitbucket
- Azure
- Facebook
- Twitter
- Discord
- 그 외 다수

### Google OAuth 설정

```javascript
// 1. Supabase Dashboard > Authentication > Providers > Google
// 2. Google Cloud Console에서 OAuth 클라이언트 ID 생성
// 3. Client ID와 Client Secret를 Supabase에 입력

// Google로 로그인
async function signInWithGoogle() {
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: 'https://yourapp.com/auth/callback',
      queryParams: {
        access_type: 'offline',
        prompt: 'consent'
      }
    }
  })

  if (error) {
    console.error('Google 로그인 실패:', error.message)
    return null
  }

  // 브라우저가 Google 로그인 페이지로 리다이렉트됨
}
```

### GitHub OAuth 설정

```javascript
// GitHub로 로그인
async function signInWithGitHub() {
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider: 'github',
    options: {
      redirectTo: 'https://yourapp.com/auth/callback'
    }
  })

  if (error) {
    console.error('GitHub 로그인 실패:', error.message)
    return null
  }
}
```

### OAuth 콜백 처리

```javascript
// auth/callback 페이지에서 실행
async function handleOAuthCallback() {
  // URL에서 토큰 추출
  const hashParams = new URLSearchParams(window.location.hash.substring(1))
  const accessToken = hashParams.get('access_token')
  const refreshToken = hashParams.get('refresh_token')

  if (accessToken) {
    // Supabase가 자동으로 세션을 설정함
    const { data: { user } } = await supabase.auth.getUser()
    console.log('OAuth 로그인 성공:', user.email)

    // 홈 페이지로 리다이렉트
    window.location.href = '/home'
  }
}
```

## 매직 링크 (Passwordless Authentication)

### 매직 링크로 로그인

```javascript
// 비밀번호 없이 이메일만으로 로그인
async function signInWithMagicLink(email) {
  const { data, error } = await supabase.auth.signInWithOtp({
    email: email,
    options: {
      emailRedirectTo: 'https://yourapp.com/auth/callback'
    }
  })

  if (error) {
    console.error('매직 링크 전송 실패:', error.message)
    return false
  }

  console.log('바데부에게 매직 링크가 전송되었습니다!')
  return true
}

// 사용 예시
await signInWithMagicLink('badebu@example.com')
```

### 전화번호로 OTP 인증

```javascript
// SMS로 OTP 코드 전송
async function signInWithPhone(phone) {
  const { data, error } = await supabase.auth.signInWithOtp({
    phone: phone  // '+821012345678' 형식
  })

  if (error) {
    console.error('OTP 전송 실패:', error.message)
    return false
  }

  console.log('OTP 코드가 전송되었습니다')
  return true
}

// OTP 코드로 인증
async function verifyOTP(phone, token) {
  const { data, error } = await supabase.auth.verifyOtp({
    phone: phone,
    token: token,
    type: 'sms'
  })

  if (error) {
    console.error('OTP 인증 실패:', error.message)
    return null
  }

  console.log('인증 성공!', data.user)
  return data.user
}
```

## 세션 관리

### 세션 상태 감지

```javascript
// 인증 상태 변경 리스너
supabase.auth.onAuthStateChange((event, session) => {
  console.log('인증 이벤트:', event)

  if (event === 'SIGNED_IN') {
    console.log('바데부가 로그인했습니다')
    console.log('사용자:', session.user.email)
  }

  if (event === 'SIGNED_OUT') {
    console.log('바데부가 로그아웃했습니다')
  }

  if (event === 'TOKEN_REFRESHED') {
    console.log('토큰이 갱신되었습니다')
  }

  if (event === 'USER_UPDATED') {
    console.log('사용자 정보가 업데이트되었습니다')
  }
})
```

### 현재 세션 가져오기

```javascript
async function getCurrentSession() {
  const { data: { session }, error } = await supabase.auth.getSession()

  if (error) {
    console.error('세션 조회 실패:', error.message)
    return null
  }

  if (session) {
    console.log('활성 세션:', session)
    console.log('만료 시간:', new Date(session.expires_at * 1000))
    return session
  }

  console.log('활성 세션 없음')
  return null
}
```

### 수동 토큰 갱신

```javascript
async function refreshSession() {
  const { data, error } = await supabase.auth.refreshSession()

  if (error) {
    console.error('세션 갱신 실패:', error.message)
    return null
  }

  console.log('세션이 갱신되었습니다')
  return data.session
}
```

## 사용자 프로필 관리

### 사용자 정보 업데이트

```javascript
async function updateUserProfile(updates) {
  const { data, error } = await supabase.auth.updateUser({
    data: updates
  })

  if (error) {
    console.error('프로필 업데이트 실패:', error.message)
    return null
  }

  console.log('바데부의 프로필이 업데이트되었습니다')
  return data.user
}

// 사용 예시
await updateUserProfile({
  nickname: '바데부',
  avatar_url: 'https://example.com/avatar.png',
  learning_goal: 'Supabase 마스터하기'
})
```

### 커스텀 프로필 테이블 연동

```sql
-- 사용자 프로필 테이블 생성
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  nickname VARCHAR(50) NOT NULL,
  bio TEXT,
  avatar_url TEXT,
  level INTEGER DEFAULT 1,
  total_points INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS 설정
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "사용자는 자신의 프로필 조회 가능"
ON user_profiles FOR SELECT TO authenticated
USING (auth.uid() = id);

CREATE POLICY "사용자는 자신의 프로필 수정 가능"
ON user_profiles FOR UPDATE TO authenticated
USING (auth.uid() = id);

-- 회원가입 시 자동으로 프로필 생성하는 트리거
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, nickname)
  VALUES (new.id, COALESCE(new.raw_user_meta_data->>'nickname', '새 사용자'));
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

```javascript
// JavaScript에서 프로필 조회
async function getBadebuProfile() {
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    console.log('로그인이 필요합니다')
    return null
  }

  const { data, error } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  if (error) {
    console.error('프로필 조회 실패:', error.message)
    return null
  }

  console.log('바데부의 프로필:', data)
  return data
}
```

## 바데부의 실전 예제: 완전한 인증 시스템

```javascript
// auth.js - 인증 관련 모든 기능
import { supabase } from './supabase.js'

class AuthService {
  // 회원가입
  async signUp(email, password, nickname) {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { nickname }
      }
    })

    if (error) throw error
    return data.user
  }

  // 로그인
  async signIn(email, password) {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    })

    if (error) throw error
    return data
  }

  // 로그아웃
  async signOut() {
    const { error } = await supabase.auth.signOut()
    if (error) throw error
  }

  // 현재 사용자
  async getCurrentUser() {
    const { data: { user } } = await supabase.auth.getUser()
    return user
  }

  // 프로필 조회
  async getProfile(userId) {
    const { data, error } = await supabase
      .from('user_profiles')
      .select('*')
      .eq('id', userId)
      .single()

    if (error) throw error
    return data
  }

  // 프로필 업데이트
  async updateProfile(userId, updates) {
    const { data, error } = await supabase
      .from('user_profiles')
      .update({ ...updates, updated_at: new Date().toISOString() })
      .eq('id', userId)
      .select()
      .single()

    if (error) throw error
    return data
  }

  // 인증 상태 구독
  onAuthStateChange(callback) {
    return supabase.auth.onAuthStateChange(callback)
  }
}

export const authService = new AuthService()

// 사용 예시
async function badebuLogin() {
  try {
    const { user, session } = await authService.signIn(
      'badebu@example.com',
      'password123'
    )

    console.log('바데부 로그인 성공!')

    const profile = await authService.getProfile(user.id)
    console.log('바데부 프로필:', profile)
  } catch (error) {
    console.error('로그인 실패:', error.message)
  }
}
```

## 일반적인 실수와 해결방법

### 실수 1: getUser()와 getSession() 혼동

```javascript
// ❌ getSession()은 로컬 세션만 확인 (서버 검증 없음)
const { data: { session } } = await supabase.auth.getSession()

// ✅ getUser()는 서버에서 검증 (더 안전)
const { data: { user } } = await supabase.auth.getUser()
```

### 실수 2: 인증 상태 리스너 정리 안 함

```javascript
// ❌ 메모리 누수 가능
supabase.auth.onAuthStateChange((event, session) => {
  // 리스너 해제 안 함
})

// ✅ 컴포넌트 언마운트 시 해제
const { data: { subscription } } = supabase.auth.onAuthStateChange(callback)

// 정리 시
subscription.unsubscribe()
```

### 실수 3: 비밀번호 유효성 검사 없음

```javascript
// ❌ 약한 비밀번호 허용
await signUp('badebu@example.com', '123')

// ✅ 비밀번호 유효성 검사
function validatePassword(password) {
  if (password.length < 8) return '8자 이상 입력하세요'
  if (!/[A-Z]/.test(password)) return '대문자를 포함하세요'
  if (!/[a-z]/.test(password)) return '소문자를 포함하세요'
  if (!/[0-9]/.test(password)) return '숫자를 포함하세요'
  return null
}
```

## 실습 과제

1. **인증 시스템 구현**: 회원가입, 로그인, 로그아웃 기능 구현
2. **프로필 페이지**: 사용자 프로필을 표시하고 수정하는 페이지 작성
3. **OAuth 추가**: Google 또는 GitHub 소셜 로그인 구현
4. **보호된 라우트**: 로그인한 사용자만 접근 가능한 페이지 구현

## 다음 장 미리보기

다음 장에서는 Supabase의 실시간 기능을 배웁니다. 데이터베이스 변경사항을 실시간으로 감지하고, 채팅이나 협업 기능을 구현하는 방법을 알아봅니다.

## 핵심 요약

- Supabase는 JWT 기반 인증 시스템 제공
- 이메일/비밀번호, OAuth, 매직 링크 등 다양한 인증 방식 지원
- auth.users 테이블과 커스텀 프로필 테이블을 연동하여 사용
- onAuthStateChange로 인증 상태 변화 감지
- getUser()로 서버 측 사용자 검증
- RLS와 함께 사용하여 데이터 보안 강화

# Chapter 2: Firebase Authentication (인증)

안녕하세요! 바데부입니다! 이번에는 Firebase Authentication으로 사용자 인증을 구현해볼 거예요!

## 2.1 Firebase Authentication이란?

Firebase Authentication은 사용자 인증을 쉽게 구현할 수 있는 서비스예요. 복잡한 보안 로직 없이 안전한 인증 시스템을 만들 수 있어요!

**지원하는 인증 방법:**
- 이메일/비밀번호
- Google 로그인
- GitHub 로그인
- Facebook 로그인
- 전화번호 인증
- 익명 로그인
- 그 외 다양한 OAuth 제공업체

## 2.2 Authentication 설정하기

### 1단계: Firebase 콘솔에서 설정

1. Firebase 콘솔 접속
2. "Authentication" 메뉴 클릭
3. "시작하기" 클릭
4. "로그인 방법" 탭에서 원하는 방법 활성화

### 2단계: SDK 설치

```bash
# 웹 프로젝트
npm install firebase

# Flutter 프로젝트
flutter pub add firebase_auth
```

### 3단계: 이메일/비밀번호 로그인 활성화

Firebase 콘솔 > Authentication > Sign-in method > 이메일/비밀번호 > 사용 설정

## 2.3 이메일/비밀번호로 회원가입

### JavaScript/React

```javascript
import { getAuth, createUserWithEmailAndPassword } from 'firebase/auth';

const auth = getAuth();

async function signUp(email, password) {
  try {
    const userCredential = await createUserWithEmailAndPassword(
      auth,
      email,
      password
    );

    const user = userCredential.user;
    console.log('✅ 회원가입 성공!', user.uid);
    return user;
  } catch (error) {
    console.error('❌ 회원가입 실패:', error.message);

    // 에러 처리
    if (error.code === 'auth/email-already-in-use') {
      alert('이미 사용 중인 이메일입니다.');
    } else if (error.code === 'auth/weak-password') {
      alert('비밀번호는 최소 6자 이상이어야 합니다.');
    }
  }
}

// 사용 예시
signUp('badebu@example.com', 'password123');
```

### Flutter

```dart
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signUp(String email, String password) async {
  try {
    final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    print('✅ 회원가입 성공! ${userCredential.user?.uid}');
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print('이미 사용 중인 이메일입니다.');
    } else if (e.code == 'weak-password') {
      print('비밀번호는 최소 6자 이상이어야 합니다.');
    }
    return null;
  }
}
```

## 2.4 이메일/비밀번호로 로그인

### JavaScript/React

```javascript
import { getAuth, signInWithEmailAndPassword } from 'firebase/auth';

const auth = getAuth();

async function signIn(email, password) {
  try {
    const userCredential = await signInWithEmailAndPassword(
      auth,
      email,
      password
    );

    console.log('✅ 로그인 성공!', userCredential.user.email);
    return userCredential.user;
  } catch (error) {
    console.error('❌ 로그인 실패:', error.message);

    if (error.code === 'auth/user-not-found') {
      alert('존재하지 않는 사용자입니다.');
    } else if (error.code === 'auth/wrong-password') {
      alert('비밀번호가 올바르지 않습니다.');
    }
  }
}
```

### Flutter

```dart
Future<User?> signIn(String email, String password) async {
  try {
    final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    print('✅ 로그인 성공! ${userCredential.user?.email}');
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('존재하지 않는 사용자입니다.');
    } else if (e.code == 'wrong-password') {
      print('비밀번호가 올바르지 않습니다.');
    }
    return null;
  }
}
```

## 2.5 로그아웃

### JavaScript/React

```javascript
import { getAuth, signOut } from 'firebase/auth';

const auth = getAuth();

async function logout() {
  try {
    await signOut(auth);
    console.log('✅ 로그아웃 성공!');
  } catch (error) {
    console.error('❌ 로그아웃 실패:', error.message);
  }
}
```

### Flutter

```dart
Future<void> logout() async {
  try {
    await _auth.signOut();
    print('✅ 로그아웃 성공!');
  } catch (e) {
    print('❌ 로그아웃 실패: $e');
  }
}
```

## 2.6 현재 로그인된 사용자 확인

### JavaScript/React

```javascript
import { getAuth, onAuthStateChanged } from 'firebase/auth';

const auth = getAuth();

// 인증 상태 변화 감지
onAuthStateChanged(auth, (user) => {
  if (user) {
    console.log('✅ 로그인됨:', user.email);
    console.log('UID:', user.uid);
  } else {
    console.log('❌ 로그아웃됨');
  }
});

// 현재 사용자 가져오기
const currentUser = auth.currentUser;
if (currentUser) {
  console.log('현재 사용자:', currentUser.email);
}
```

### React 컴포넌트에서 사용

```javascript
import React, { useState, useEffect } from 'react';
import { getAuth, onAuthStateChanged } from 'firebase/auth';

function App() {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const auth = getAuth();
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
      setLoading(false);
    });

    // 클린업 함수
    return () => unsubscribe();
  }, []);

  if (loading) {
    return <div>로딩 중...</div>;
  }

  return (
    <div>
      {user ? (
        <p>환영합니다, {user.email}님!</p>
      ) : (
        <p>로그인이 필요합니다.</p>
      )}
    </div>
  );
}
```

### Flutter

```dart
// 인증 상태 스트림 감지
StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (snapshot.hasData) {
      return Text('환영합니다, ${snapshot.data?.email}님!');
    } else {
      return Text('로그인이 필요합니다.');
    }
  },
)

// 현재 사용자 가져오기
User? currentUser = FirebaseAuth.instance.currentUser;
if (currentUser != null) {
  print('현재 사용자: ${currentUser.email}');
}
```

## 2.7 Google 로그인 구현

### 1단계: Firebase 콘솔 설정

1. Authentication > Sign-in method > Google > 사용 설정
2. 프로젝트 지원 이메일 입력
3. 저장

### 2단계: JavaScript/React에서 Google 로그인

```javascript
import { getAuth, signInWithPopup, GoogleAuthProvider } from 'firebase/auth';

const auth = getAuth();
const provider = new GoogleAuthProvider();

async function signInWithGoogle() {
  try {
    const result = await signInWithPopup(auth, provider);
    const user = result.user;

    console.log('✅ Google 로그인 성공!');
    console.log('이름:', user.displayName);
    console.log('이메일:', user.email);
    console.log('프로필 사진:', user.photoURL);

    return user;
  } catch (error) {
    console.error('❌ Google 로그인 실패:', error.message);
  }
}
```

### 3단계: Flutter에서 Google 로그인

```bash
# google_sign_in 패키지 설치
flutter pub add google_sign_in
```

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signInWithGoogle() async {
  try {
    // Google 로그인 시작
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null; // 사용자가 취소함
    }

    // Google 인증 정보 가져오기
    final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

    // Firebase 인증 정보 생성
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Firebase에 로그인
    final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

    print('✅ Google 로그인 성공!');
    return userCredential.user;
  } catch (e) {
    print('❌ Google 로그인 실패: $e');
    return null;
  }
}
```

## 2.8 비밀번호 재설정

### JavaScript/React

```javascript
import { getAuth, sendPasswordResetEmail } from 'firebase/auth';

const auth = getAuth();

async function resetPassword(email) {
  try {
    await sendPasswordResetEmail(auth, email);
    console.log('✅ 비밀번호 재설정 이메일이 전송되었습니다!');
    alert('이메일을 확인하세요.');
  } catch (error) {
    console.error('❌ 전송 실패:', error.message);

    if (error.code === 'auth/user-not-found') {
      alert('존재하지 않는 이메일입니다.');
    }
  }
}
```

### Flutter

```dart
Future<void> resetPassword(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    print('✅ 비밀번호 재설정 이메일이 전송되었습니다!');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('존재하지 않는 이메일입니다.');
    }
  }
}
```

## 2.9 사용자 정보 업데이트

### 프로필 정보 업데이트

```javascript
import { getAuth, updateProfile } from 'firebase/auth';

const auth = getAuth();

async function updateUserProfile(displayName, photoURL) {
  try {
    await updateProfile(auth.currentUser, {
      displayName: displayName,
      photoURL: photoURL
    });

    console.log('✅ 프로필 업데이트 성공!');
  } catch (error) {
    console.error('❌ 업데이트 실패:', error.message);
  }
}
```

### 이메일 주소 변경

```javascript
import { getAuth, updateEmail } from 'firebase/auth';

const auth = getAuth();

async function changeEmail(newEmail) {
  try {
    await updateEmail(auth.currentUser, newEmail);
    console.log('✅ 이메일 변경 성공!');
  } catch (error) {
    if (error.code === 'auth/requires-recent-login') {
      alert('보안을 위해 다시 로그인해주세요.');
    }
  }
}
```

## 2.10 일반적인 실수와 해결방법

### 실수 1: 인증 상태를 체크하지 않음

```javascript
// ❌ 잘못된 방법
function MyComponent() {
  const auth = getAuth();
  const email = auth.currentUser.email; // currentUser가 null일 수 있음!
}

// ✅ 올바른 방법
function MyComponent() {
  const auth = getAuth();
  const email = auth.currentUser?.email || '로그인 필요';
}
```

### 실수 2: onAuthStateChanged 클린업 누락

```javascript
// ❌ 잘못된 방법
useEffect(() => {
  onAuthStateChanged(auth, (user) => {
    setUser(user);
  });
  // 클린업 없음 - 메모리 누수!
}, []);

// ✅ 올바른 방법
useEffect(() => {
  const unsubscribe = onAuthStateChanged(auth, (user) => {
    setUser(user);
  });

  return () => unsubscribe(); // 클린업!
}, []);
```

### 실수 3: 비밀번호 유효성 검사 생략

```javascript
// ✅ 올바른 방법
function validatePassword(password) {
  if (password.length < 6) {
    return '비밀번호는 최소 6자 이상이어야 합니다.';
  }
  if (!/\d/.test(password)) {
    return '비밀번호에 숫자를 포함해야 합니다.';
  }
  return null; // 유효함
}
```

## 2.11 바데부의 실전 팁

### 팁 1: 로딩 상태 관리
```javascript
const [loading, setLoading] = useState(false);

async function handleSignIn() {
  setLoading(true);
  try {
    await signIn(email, password);
  } finally {
    setLoading(false);
  }
}
```

### 팁 2: 에러 메시지 한국어로 표시
```javascript
const errorMessages = {
  'auth/email-already-in-use': '이미 사용 중인 이메일입니다.',
  'auth/weak-password': '비밀번호가 너무 약합니다.',
  'auth/user-not-found': '존재하지 않는 사용자입니다.',
  'auth/wrong-password': '비밀번호가 올바르지 않습니다.'
};

function getErrorMessage(code) {
  return errorMessages[code] || '알 수 없는 오류가 발생했습니다.';
}
```

### 팁 3: 재인증이 필요한 작업
```javascript
// 이메일 변경, 비밀번호 변경, 계정 삭제 전에 재인증
import { reauthenticateWithCredential, EmailAuthProvider } from 'firebase/auth';

async function reauthenticate(password) {
  const user = auth.currentUser;
  const credential = EmailAuthProvider.credential(user.email, password);

  await reauthenticateWithCredential(user, credential);
}
```

## 연습 문제

1. 이메일/비밀번호로 회원가입 폼을 만들어보세요
2. 로그인 상태에 따라 다른 화면을 보여주세요
3. Google 로그인 버튼을 추가해보세요
4. 비밀번호 재설정 기능을 구현해보세요

## 다음 단계

다음 챕터에서는 **Cloud Firestore**를 배워봅시다! 사용자 데이터를 저장하고 실시간으로 동기화하는 방법을 알아볼 거예요!

## 핵심 요약

- Firebase Authentication은 사용자 인증을 쉽게 구현
- 이메일/비밀번호, Google, GitHub 등 다양한 로그인 방법 지원
- createUserWithEmailAndPassword()로 회원가입
- signInWithEmailAndPassword()로 로그인
- onAuthStateChanged()로 인증 상태 감지
- signOut()으로 로그아웃
- 민감한 작업 전에는 재인증 필요

바데부와 함께 안전한 인증 시스템을 만들어봅시다! 🔐

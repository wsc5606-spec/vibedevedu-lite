# Chapter 1: Firebase 소개 및 시작하기

안녕하세요! 바데부입니다! 오늘은 Firebase에 대해 알아볼 거예요. Firebase는 구글이 제공하는 강력한 백엔드 플랫폼이에요!

## 1.1 Firebase란?

Firebase는 앱 개발을 위한 올인원 플랫폼입니다. 백엔드 서버를 직접 구축하지 않고도 다양한 기능을 사용할 수 있어요.

**Firebase가 제공하는 주요 서비스:**
- 인증 (Authentication)
- 데이터베이스 (Firestore, Realtime Database)
- 파일 저장소 (Storage)
- 호스팅 (Hosting)
- 서버리스 함수 (Cloud Functions)
- 푸시 알림 (Cloud Messaging)
- 분석 (Analytics)

## 1.2 Firebase의 장점

### 빠른 개발 속도
```javascript
// Firebase는 이렇게 간단합니다!
const db = getFirestore();
await addDoc(collection(db, 'users'), {
  name: '바데부',
  age: 3
});
```

**왜 Firebase를 선택할까요?**
- **빠른 시작**: 몇 분 만에 백엔드 구축
- **실시간 동기화**: 데이터 변경이 즉시 반영
- **확장성**: 사용자가 늘어나도 자동으로 확장
- **무료 플랜**: 소규모 프로젝트에 충분한 무료 티어
- **구글 생태계**: Google Cloud와 완벽한 통합

## 1.3 Firebase 프로젝트 생성하기

### 1단계: Firebase 콘솔 접속

1. [console.firebase.google.com](https://console.firebase.google.com) 접속
2. Google 계정으로 로그인
3. "프로젝트 추가" 클릭

### 2단계: 프로젝트 설정

```
프로젝트 이름: "바데부-학습앱"
Google 애널리틱스: 켜기 (추천)
애널리틱스 위치: 대한민국
```

### 3단계: 앱 등록

웹 앱을 만든다면:
1. 웹 아이콘 (</>) 클릭
2. 앱 닉네임 입력: "바데부 웹앱"
3. Firebase Hosting 설정 (선택사항)
4. "앱 등록" 클릭

## 1.4 Firebase SDK 설치

### 웹 프로젝트 (JavaScript/React/Vue)

```bash
# npm 사용
npm install firebase

# yarn 사용
yarn add firebase
```

### Firebase 초기화

```javascript
// firebase-config.js
import { initializeApp } from 'firebase/app';

const firebaseConfig = {
  apiKey: "AIzaSyC...",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abc123"
};

// Firebase 초기화
const app = initializeApp(firebaseConfig);

export default app;
```

## 1.5 환경 변수로 안전하게 관리하기

Firebase 설정을 코드에 직접 입력하는 것은 위험해요. 환경 변수를 사용하세요!

```javascript
// .env 파일
VITE_FIREBASE_API_KEY=AIzaSyC...
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=1:123456789:web:abc123
```

```javascript
// firebase-config.js
import { initializeApp } from 'firebase/app';

const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID
};

const app = initializeApp(firebaseConfig);

export default app;
```

## 1.6 Flutter에서 Firebase 설정

### FlutterFire CLI 설치

```bash
# Firebase CLI 설치
npm install -g firebase-tools

# FlutterFire CLI 설치
dart pub global activate flutterfire_cli

# Firebase 로그인
firebase login

# Flutter 프로젝트에서 실행
flutterfire configure
```

### pubspec.yaml 설정

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
```

### Flutter 앱 초기화

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
```

## 1.7 첫 번째 테스트: Firebase 연결 확인

```javascript
// test-firebase.js
import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs } from 'firebase/firestore';

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function testConnection() {
  try {
    // Firestore 연결 테스트
    const querySnapshot = await getDocs(collection(db, 'test'));
    console.log('✅ Firebase 연결 성공!');
    console.log('문서 개수:', querySnapshot.size);
  } catch (error) {
    console.error('❌ 연결 실패:', error.message);
  }
}

testConnection();
```

## 1.8 Firebase 콘솔 둘러보기

### Authentication (인증)
- 사용자 인증 방법 설정
- 로그인 제공업체 관리 (이메일, Google, GitHub 등)
- 사용자 목록 확인

### Firestore Database (데이터베이스)
- 문서 기반 NoSQL 데이터베이스
- 실시간 동기화 지원
- 컬렉션과 문서 구조

### Storage (저장소)
- 이미지, 동영상 등 파일 저장
- 보안 규칙 설정
- 용량 및 다운로드 통계

### Hosting (호스팅)
- 정적 웹사이트 호스팅
- SSL 인증서 자동 제공
- CDN 전송 최적화

## 1.9 일반적인 실수와 해결방법

### 실수 1: API Key를 공개 저장소에 커밋

```javascript
// ❌ 잘못된 방법
const firebaseConfig = {
  apiKey: "AIzaSyC...", // 하드코딩하면 Git에 노출됨!
  // ...
};

// ✅ 올바른 방법
const firebaseConfig = {
  apiKey: process.env.REACT_APP_FIREBASE_API_KEY,
  // ...
};
```

**중요**: .env 파일을 .gitignore에 추가하세요!

```bash
# .gitignore
.env
.env.local
.env.production
```

### 실수 2: Firebase 초기화를 여러 번 실행

```javascript
// ❌ 잘못된 방법
function MyComponent() {
  const app = initializeApp(firebaseConfig); // 매번 초기화!
  // ...
}

// ✅ 올바른 방법
const app = initializeApp(firebaseConfig); // 한 번만 초기화

function MyComponent() {
  // app을 import해서 사용
}
```

### 실수 3: Flutter에서 Firebase 초기화 누락

```dart
// ❌ 잘못된 방법
void main() {
  runApp(MyApp()); // Firebase 초기화 없이 앱 실행
}

// ✅ 올바른 방법
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 반드시 초기화!
  runApp(MyApp());
}
```

## 1.10 바데부의 실전 팁

### 팁 1: 개발/프로덕션 환경 분리
```javascript
// 개발과 프로덕션 환경을 분리하세요
const firebaseConfig = process.env.NODE_ENV === 'production'
  ? productionConfig
  : developmentConfig;
```

### 팁 2: Firebase Emulator 사용
```bash
# 로컬에서 Firebase 서비스를 에뮬레이트
firebase emulators:start
```

### 팁 3: 무료 할당량 모니터링
- Firestore: 일일 읽기 50,000건, 쓰기 20,000건
- Storage: 5GB 저장, 1GB/일 다운로드
- Cloud Functions: 월 2백만 회 호출

## 연습 문제

1. Firebase 콘솔에서 새 프로젝트를 생성해보세요
2. 웹 앱을 등록하고 설정 정보를 복사하세요
3. 환경 변수를 사용하여 Firebase를 초기화하세요
4. Firebase 연결 테스트 코드를 실행해보세요

## 다음 단계

다음 챕터에서는 **Firebase Authentication**을 배워봅시다! 이메일/비밀번호 로그인, Google 로그인 등 다양한 인증 방법을 구현해볼 거예요!

## 핵심 요약

- Firebase는 구글이 제공하는 올인원 백엔드 플랫폼
- 인증, 데이터베이스, 저장소, 호스팅 등 다양한 서비스 제공
- Firebase 콘솔에서 프로젝트를 생성하고 앱을 등록
- 환경 변수로 API Key를 안전하게 관리
- initializeApp()은 앱 시작 시 한 번만 호출
- 무료 플랜으로 충분히 시작할 수 있음

바데부와 함께 Firebase를 마스터해봅시다! 🔥

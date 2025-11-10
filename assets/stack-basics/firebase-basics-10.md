# Chapter 10: 보안 규칙 및 베스트 프랙티스

안녕하세요! 바데부입니다! 마지막 챕터에서는 Firebase를 안전하게 사용하는 방법을 배워볼 거예요!

## 10.1 보안 규칙이란?

보안 규칙은 Firebase 데이터베이스와 Storage에 대한 접근을 제어하는 설정이예요. 누가 어떤 데이터를 읽고 쓸 수 있는지 결정합니다!

**왜 중요할까요?**
- 데이터 유출 방지
- 악의적인 사용자 차단
- 개인정보 보호
- 서비스 비용 절감

## 10.2 Firestore 보안 규칙

### 기본 구조

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 규칙 작성
  }
}
```

### 기본 규칙 예시

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 모든 읽기/쓰기 허용 (위험! 테스트용만)
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

### 인증된 사용자만 허용

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 인증된 사용자만 읽기/쓰기
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### 자신의 데이터만 접근

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 사용자는 자신의 문서만 읽기/쓰기 가능
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 10.3 고급 Firestore 규칙

### 읽기와 쓰기 분리

```javascript
match /posts/{postId} {
  // 모두 읽기 가능
  allow read: if true;

  // 인증된 사용자만 생성 가능
  allow create: if request.auth != null;

  // 작성자만 수정/삭제 가능
  allow update, delete: if request.auth != null
    && request.auth.uid == resource.data.authorId;
}
```

### 데이터 유효성 검증

```javascript
match /posts/{postId} {
  allow create: if request.auth != null
    && request.resource.data.title is string
    && request.resource.data.title.size() > 0
    && request.resource.data.title.size() <= 100
    && request.resource.data.content is string
    && request.resource.data.authorId == request.auth.uid;

  allow update: if request.auth != null
    && request.auth.uid == resource.data.authorId
    && request.resource.data.title is string
    && request.resource.data.title.size() > 0;
}
```

### 함수 사용

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // 헬퍼 함수 정의
    function isSignedIn() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    function isAdmin() {
      return isSignedIn() && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }

    // 사용자 문서
    match /users/{userId} {
      allow read: if isSignedIn();
      allow write: if isOwner(userId) || isAdmin();
    }

    // 포스트
    match /posts/{postId} {
      allow read: if true;
      allow create: if isSignedIn();
      allow update, delete: if isSignedIn() && resource.data.authorId == request.auth.uid;
    }
  }
}
```

### 하위 컬렉션 규칙

```javascript
match /users/{userId} {
  allow read: if request.auth.uid == userId;

  // 하위 컬렉션
  match /private/{document=**} {
    allow read, write: if request.auth.uid == userId;
  }

  match /public/{document=**} {
    allow read: if true;
    allow write: if request.auth.uid == userId;
  }
}
```

## 10.4 Realtime Database 보안 규칙

### 기본 구조

```json
{
  "rules": {
    ".read": false,
    ".write": false
  }
}
```

### 인증된 사용자만 허용

```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

### 자신의 데이터만 접근

```json
{
  "rules": {
    "users": {
      "$userId": {
        ".read": "$userId === auth.uid",
        ".write": "$userId === auth.uid"
      }
    }
  }
}
```

### 데이터 유효성 검증

```json
{
  "rules": {
    "posts": {
      "$postId": {
        ".write": "auth != null && newData.child('title').isString() && newData.child('title').val().length > 0 && newData.child('authorId').val() === auth.uid",
        ".read": true
      }
    }
  }
}
```

## 10.5 Storage 보안 규칙

### 기본 구조

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // 규칙 작성
  }
}
```

### 인증된 사용자만 업로드

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /images/{allPaths=**} {
      allow read: if true; // 모두 읽기 가능
      allow write: if request.auth != null; // 인증된 사용자만 업로드
    }
  }
}
```

### 자신의 폴더만 접근

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 파일 크기 및 타입 제한

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /images/{userId}/{fileName} {
      allow read: if true;

      allow write: if request.auth != null
        && request.auth.uid == userId
        && request.resource.size < 5 * 1024 * 1024 // 5MB 제한
        && request.resource.contentType.matches('image/.*'); // 이미지만
    }
  }
}
```

### 메타데이터 검증

```javascript
match /images/{userId}/{fileName} {
  allow write: if request.auth != null
    && request.auth.uid == userId
    && request.resource.contentType in ['image/jpeg', 'image/png', 'image/gif']
    && request.resource.size < 5 * 1024 * 1024;
}
```

## 10.6 보안 규칙 테스트

### Firebase Emulator로 테스트

```bash
# 에뮬레이터 시작
firebase emulators:start

# Firestore 에뮬레이터
http://localhost:4000/firestore

# Rules 탭에서 규칙 테스트
```

### 규칙 시뮬레이터 사용

Firebase 콘솔 > Firestore > 규칙 > 시뮬레이터

```javascript
// 테스트 예시
// 위치: /users/user123
// 인증: user123
// 작업: get
// 결과: 허용됨
```

## 10.7 일반적인 보안 취약점

### 취약점 1: 모든 접근 허용

```javascript
// ❌ 매우 위험!
match /{document=**} {
  allow read, write: if true;
}
```

**해결:**
```javascript
// ✅ 인증 및 권한 확인
match /users/{userId} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
```

### 취약점 2: 클라이언트 데이터 신뢰

```javascript
// ❌ 클라이언트가 보낸 authorId를 그대로 사용
allow create: if request.resource.data.authorId == request.auth.uid;
```

**해결:**
```javascript
// ✅ 서버에서 authorId를 설정하도록 강제
allow create: if request.auth != null
  && !request.resource.data.keys().hasAny(['authorId'])
  && request.resource.data.title is string;

// Cloud Function에서 authorId 추가
exports.addPost = functions.https.onCall(async (data, context) => {
  await admin.firestore().collection('posts').add({
    ...data,
    authorId: context.auth.uid // 서버에서 설정
  });
});
```

### 취약점 3: 무제한 읽기 허용

```javascript
// ❌ 모든 데이터 읽기 가능
match /users/{userId} {
  allow read: if true;
}
```

**해결:**
```javascript
// ✅ 공개 필드만 노출
match /users/{userId} {
  allow read: if request.auth != null;
}

// 민감한 데이터는 별도 컬렉션에
match /users/{userId}/private/{document} {
  allow read: if request.auth.uid == userId;
}
```

## 10.8 베스트 프랙티스

### 1. 최소 권한 원칙

```javascript
// ✅ 필요한 최소한의 권한만 부여
match /posts/{postId} {
  allow read: if true; // 공개 데이터
  allow create: if request.auth != null; // 생성은 인증 필요
  allow update, delete: if request.auth.uid == resource.data.authorId; // 본인만
}
```

### 2. 데이터 구조화

```javascript
// ✅ 좋은 구조
{
  "users": {
    "user1": {
      "public": { "name": "바데부", "avatar": "..." },
      "private": { "email": "...", "phone": "..." }
    }
  }
}

// 규칙
match /users/{userId}/public {
  allow read: if true;
}

match /users/{userId}/private {
  allow read: if request.auth.uid == userId;
}
```

### 3. 인덱스 추가

```javascript
// Firestore 인덱스를 추가하여 성능 향상
// Firebase 콘솔 > Firestore > 색인
```

### 4. 보안 규칙 버전 관리

```bash
# Git에 저장
git add firestore.rules
git commit -m "Add user access control"
```

### 5. 정기적인 보안 검토

Firebase 콘솔에서 보안 규칙을 정기적으로 검토하세요!

## 10.9 환경 변수 보안

### .env 파일 보호

```bash
# .gitignore에 추가
.env
.env.local
.env.production
```

```javascript
// ✅ 환경 변수 사용
const firebaseConfig = {
  apiKey: process.env.REACT_APP_FIREBASE_API_KEY,
  authDomain: process.env.REACT_APP_FIREBASE_AUTH_DOMAIN,
  // ...
};
```

### API Key 제한

Firebase 콘솔 > Google Cloud Console > API 및 서비스 > 사용자 인증 정보

**API Key 제한 설정:**
- HTTP 리퍼러 (웹사이트): `https://yourdomain.com/*`
- Android 앱: 패키지 이름 + SHA-1 지문
- iOS 앱: 번들 ID

## 10.10 비용 최적화

### Firestore 비용 절감

```javascript
// ✅ 필요한 필드만 읽기
const docRef = doc(db, 'users', userId);
const docSnap = await getDoc(docRef);

// ❌ 전체 컬렉션 읽기 (비용 증가)
const querySnapshot = await getDocs(collection(db, 'users'));
```

### 캐싱 활용

```javascript
// ✅ 오프라인 캐싱 활성화
const db = getFirestore();
enableIndexedDbPersistence(db).catch((err) => {
  if (err.code == 'failed-precondition') {
    // 여러 탭에서 열림
  } else if (err.code == 'unimplemented') {
    // 브라우저가 지원하지 않음
  }
});
```

### Storage 비용 절감

```javascript
// ✅ 이미지 압축 후 업로드
async function uploadCompressedImage(file) {
  const compressedBlob = await compressImage(file);
  await uploadBytes(storageRef, compressedBlob);
}
```

## 10.11 모니터링 및 알림

### Firestore 사용량 모니터링

Firebase 콘솔 > Firestore > 사용량

**주요 지표:**
- 문서 읽기/쓰기/삭제 수
- 저장 용량
- 네트워크 대역폭

### 예산 알림 설정

Google Cloud Console > 결제 > 예산 및 알림

```
예산: 월 $10
알림: 50%, 90%, 100% 초과 시
```

## 10.12 실전 보안 규칙 예제

### 소셜 미디어 앱

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    // 사용자 프로필 (공개)
    match /users/{userId} {
      allow read: if true;
      allow write: if isOwner(userId);
    }

    // 포스트
    match /posts/{postId} {
      allow read: if true;
      allow create: if isSignedIn()
        && request.resource.data.title.size() > 0
        && request.resource.data.authorId == request.auth.uid;
      allow update, delete: if isSignedIn()
        && resource.data.authorId == request.auth.uid;
    }

    // 댓글
    match /posts/{postId}/comments/{commentId} {
      allow read: if true;
      allow create: if isSignedIn()
        && request.resource.data.content.size() > 0
        && request.resource.data.authorId == request.auth.uid;
      allow delete: if isSignedIn()
        && resource.data.authorId == request.auth.uid;
    }

    // 좋아요
    match /posts/{postId}/likes/{userId} {
      allow read: if true;
      allow write: if isOwner(userId);
    }

    // DM (비공개)
    match /chats/{chatId}/messages/{messageId} {
      allow read: if isSignedIn()
        && request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
      allow create: if isSignedIn()
        && request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
    }
  }
}
```

## 10.13 보안 체크리스트

**배포 전 확인사항:**

- [ ] 프로덕션 모드 보안 규칙 설정
- [ ] 테스트 모드 규칙 제거
- [ ] API Key 제한 설정
- [ ] .env 파일 .gitignore에 추가
- [ ] 사용자 입력 검증
- [ ] 파일 크기 제한
- [ ] 인증 필수 기능 확인
- [ ] 권한 분리 (읽기/쓰기)
- [ ] 보안 규칙 테스트
- [ ] 모니터링 및 알림 설정

## 10.14 바데부의 마지막 팁

### 팁 1: 보안 규칙 템플릿

```javascript
// 기본 템플릿 저장
// firestore-rules-template.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() {
      return request.auth != null;
    }
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    // ...
  }
}
```

### 팁 2: 정기적인 보안 감사

매월 보안 규칙과 사용량을 검토하세요!

### 팁 3: 커뮤니티 참여

Firebase 공식 포럼과 Stack Overflow에서 최신 보안 정보를 확인하세요!

## 연습 문제

1. Firestore 보안 규칙을 작성하여 사용자가 자신의 문서만 수정할 수 있게 하세요
2. Storage 규칙으로 5MB 이하의 이미지만 업로드되도록 제한하세요
3. 보안 규칙 시뮬레이터로 테스트하세요
4. API Key 제한을 설정하세요

## 마무리

축하합니다! Firebase 기초 학습을 모두 완료했어요! 🎉

**배운 내용 요약:**
1. Firebase 소개 및 프로젝트 설정
2. Authentication으로 사용자 인증
3. Firestore로 데이터 저장
4. Realtime Database로 실시간 동기화
5. Cloud Storage로 파일 관리
6. Cloud Functions로 서버리스 백엔드
7. Hosting으로 웹사이트 배포
8. Cloud Messaging으로 푸시 알림
9. Analytics로 사용자 분석
10. 보안 규칙으로 데이터 보호

**다음 단계:**
- 실제 프로젝트에 Firebase 적용하기
- 다른 Firebase 서비스 탐색 (Remote Config, App Check 등)
- Firebase Extensions 활용하기
- 고급 기능 학습 (Custom Claims, Security Rules 고급 등)

바데부와 함께한 Firebase 여정이 즐거웠길 바라요! 🔥

## 핵심 요약

- 보안 규칙은 데이터 접근 제어의 핵심
- 최소 권한 원칙 적용
- 인증된 사용자만 접근하도록 제한
- 데이터 유효성 검증
- 파일 크기 및 타입 제한
- 규칙 시뮬레이터로 테스트
- API Key 제한 설정
- 정기적인 보안 검토
- 비용 모니터링 및 최적화

바데부와 함께 안전한 Firebase 앱을 만들어봅시다! 🔥

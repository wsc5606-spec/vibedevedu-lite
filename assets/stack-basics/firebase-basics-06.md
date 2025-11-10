# Chapter 6: Cloud Functions

안녕하세요! 바데부입니다! 이번에는 Firebase Cloud Functions로 서버리스 백엔드를 만드는 방법을 배워볼 거예요!

## 6.1 Cloud Functions란?

Cloud Functions는 서버를 직접 관리하지 않고도 백엔드 코드를 실행할 수 있는 서버리스 플랫폼이예요!

**Cloud Functions의 장점:**
- 서버 관리 불필요
- 자동 확장
- 이벤트 기반 실행
- 다양한 트리거 지원
- 보안 로직 실행

**언제 사용할까요?**
- 데이터베이스 트리거 (문서 생성/수정/삭제 시)
- 인증 트리거 (사용자 가입/로그인 시)
- Storage 트리거 (파일 업로드 시)
- HTTP 요청 처리
- 예약된 작업 (Cron)

## 6.2 Cloud Functions 시작하기

### 1단계: Firebase CLI 설치

```bash
# Firebase CLI 설치
npm install -g firebase-tools

# Firebase 로그인
firebase login

# 프로젝트 초기화
firebase init functions
```

**초기화 옵션 선택:**
- 언어: JavaScript 또는 TypeScript
- ESLint 사용: Yes (권장)
- 종속성 설치: Yes

### 2단계: 프로젝트 구조

```
my-project/
├─ functions/
│   ├─ node_modules/
│   ├─ src/            (TypeScript 사용 시)
│   ├─ index.js        (진입점)
│   ├─ package.json
│   └─ .eslintrc.js
├─ firebase.json
└─ .firebaserc
```

### 3단계: 첫 번째 함수 작성

```javascript
// functions/index.js
const functions = require('firebase-functions');

// HTTP 함수
exports.helloWorld = functions.https.onRequest((request, response) => {
  response.send('안녕하세요, 바데부입니다!');
});
```

### 4단계: 로컬에서 테스트

```bash
# 에뮬레이터 시작
firebase emulators:start

# 브라우저에서 접속
# http://localhost:5001/your-project/us-central1/helloWorld
```

### 5단계: 배포

```bash
# 모든 함수 배포
firebase deploy --only functions

# 특정 함수만 배포
firebase deploy --only functions:helloWorld
```

## 6.3 HTTP 함수

### GET 요청 처리

```javascript
const functions = require('firebase-functions');

exports.getUser = functions.https.onRequest((req, res) => {
  const userId = req.query.userId;

  if (!userId) {
    return res.status(400).json({ error: '사용자 ID가 필요합니다.' });
  }

  // 데이터 반환
  res.json({
    userId: userId,
    name: '바데부',
    age: 3
  });
});
```

### POST 요청 처리

```javascript
exports.createUser = functions.https.onRequest(async (req, res) => {
  // CORS 설정
  res.set('Access-Control-Allow-Origin', '*');

  if (req.method === 'OPTIONS') {
    res.set('Access-Control-Allow-Methods', 'POST');
    res.set('Access-Control-Allow-Headers', 'Content-Type');
    return res.status(204).send('');
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'POST 요청만 허용됩니다.' });
  }

  const { name, email } = req.body;

  // Firestore에 저장
  const admin = require('firebase-admin');
  if (!admin.apps.length) {
    admin.initializeApp();
  }

  const db = admin.firestore();

  try {
    const docRef = await db.collection('users').add({
      name: name,
      email: email,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    res.json({
      success: true,
      userId: docRef.id
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

### Express 사용 (권장)

```javascript
const functions = require('firebase-functions');
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

// GET /api/users
app.get('/users', async (req, res) => {
  const admin = require('firebase-admin');
  const db = admin.firestore();

  const snapshot = await db.collection('users').get();
  const users = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

  res.json(users);
});

// POST /api/users
app.post('/users', async (req, res) => {
  // ...
});

// Cloud Function으로 내보내기
exports.api = functions.https.onRequest(app);
```

## 6.4 Firestore 트리거

### 문서 생성 트리거

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.onUserCreate = functions.firestore
  .document('users/{userId}')
  .onCreate(async (snap, context) => {
    const userId = context.params.userId;
    const userData = snap.data();

    console.log('새 사용자 생성:', userId);

    // 환영 이메일 보내기 (예시)
    await sendWelcomeEmail(userData.email);

    // 통계 업데이트
    const statsRef = admin.firestore().doc('stats/users');
    await statsRef.update({
      totalUsers: admin.firestore.FieldValue.increment(1)
    });

    return null;
  });
```

### 문서 업데이트 트리거

```javascript
exports.onUserUpdate = functions.firestore
  .document('users/{userId}')
  .onUpdate((change, context) => {
    const beforeData = change.before.data();
    const afterData = change.after.data();

    // 이메일이 변경되었는지 확인
    if (beforeData.email !== afterData.email) {
      console.log('이메일 변경:', beforeData.email, '->', afterData.email);
      // 이메일 변경 알림 보내기
    }

    return null;
  });
```

### 문서 삭제 트리거

```javascript
exports.onUserDelete = functions.firestore
  .document('users/{userId}')
  .onDelete(async (snap, context) => {
    const userId = context.params.userId;
    const userData = snap.data();

    console.log('사용자 삭제:', userId);

    // 관련 데이터 정리
    const db = admin.firestore();
    const batch = db.batch();

    // 사용자의 모든 포스트 삭제
    const postsSnapshot = await db.collection('posts')
      .where('authorId', '==', userId)
      .get();

    postsSnapshot.docs.forEach(doc => {
      batch.delete(doc.ref);
    });

    await batch.commit();

    return null;
  });
```

## 6.5 Authentication 트리거

### 사용자 생성 트리거

```javascript
exports.onUserSignUp = functions.auth.user().onCreate(async (user) => {
  const { uid, email, displayName } = user;

  console.log('새 사용자 가입:', email);

  // Firestore에 사용자 문서 생성
  await admin.firestore().collection('users').doc(uid).set({
    email: email,
    displayName: displayName || '익명',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    role: 'user'
  });

  // 환영 이메일 보내기
  await sendWelcomeEmail(email, displayName);

  return null;
});
```

### 사용자 삭제 트리거

```javascript
exports.onUserDelete = functions.auth.user().onDelete(async (user) => {
  const { uid } = user;

  console.log('사용자 계정 삭제:', uid);

  // Firestore에서 사용자 데이터 삭제
  await admin.firestore().collection('users').doc(uid).delete();

  return null;
});
```

## 6.6 Storage 트리거

### 파일 업로드 트리거

```javascript
const { Storage } = require('@google-cloud/storage');
const sharp = require('sharp');
const path = require('path');
const os = require('os');
const fs = require('fs');

exports.onImageUpload = functions.storage.object().onFinalize(async (object) => {
  const filePath = object.name;
  const contentType = object.contentType;

  // 이미지가 아니면 무시
  if (!contentType.startsWith('image/')) {
    return null;
  }

  // 이미 썸네일이면 무시
  if (filePath.includes('thumb_')) {
    return null;
  }

  console.log('이미지 업로드됨:', filePath);

  // 썸네일 생성
  const bucket = admin.storage().bucket(object.bucket);
  const fileName = path.basename(filePath);
  const tempFilePath = path.join(os.tmpdir(), fileName);
  const thumbFileName = `thumb_${fileName}`;
  const thumbFilePath = path.join(path.dirname(filePath), thumbFileName);

  // 원본 이미지 다운로드
  await bucket.file(filePath).download({ destination: tempFilePath });

  // 썸네일 생성 (200x200)
  const tempThumbPath = path.join(os.tmpdir(), thumbFileName);
  await sharp(tempFilePath)
    .resize(200, 200, { fit: 'cover' })
    .toFile(tempThumbPath);

  // 썸네일 업로드
  await bucket.upload(tempThumbPath, {
    destination: thumbFilePath,
    metadata: {
      contentType: contentType
    }
  });

  // 임시 파일 삭제
  fs.unlinkSync(tempFilePath);
  fs.unlinkSync(tempThumbPath);

  console.log('썸네일 생성 완료:', thumbFilePath);

  return null;
});
```

### 파일 삭제 트리거

```javascript
exports.onImageDelete = functions.storage.object().onDelete(async (object) => {
  const filePath = object.name;

  console.log('이미지 삭제됨:', filePath);

  // 썸네일도 삭제
  if (!filePath.includes('thumb_')) {
    const thumbPath = path.join(
      path.dirname(filePath),
      'thumb_' + path.basename(filePath)
    );

    try {
      await admin.storage().bucket(object.bucket).file(thumbPath).delete();
      console.log('썸네일 삭제:', thumbPath);
    } catch (error) {
      console.log('썸네일 없음:', thumbPath);
    }
  }

  return null;
});
```

## 6.7 예약된 함수 (Cron)

```javascript
exports.scheduledFunction = functions.pubsub
  .schedule('every 24 hours')
  .timeZone('Asia/Seoul')
  .onRun(async (context) => {
    console.log('매일 실행되는 함수');

    const db = admin.firestore();

    // 오래된 데이터 정리
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - 30); // 30일 전

    const snapshot = await db.collection('logs')
      .where('createdAt', '<', cutoffDate)
      .get();

    const batch = db.batch();
    snapshot.docs.forEach(doc => {
      batch.delete(doc.ref);
    });

    await batch.commit();

    console.log(`${snapshot.size}개의 오래된 로그 삭제`);

    return null;
  });

// Cron 표현식 예시:
// 'every 5 minutes' - 5분마다
// 'every day 00:00' - 매일 자정
// 'every monday 09:00' - 매주 월요일 9시
// '0 */2 * * *' - 2시간마다
```

## 6.8 Callable 함수

클라이언트에서 직접 호출할 수 있는 함수입니다.

### 서버 (Cloud Function)

```javascript
exports.addMessage = functions.https.onCall(async (data, context) => {
  // 인증 확인
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      '로그인이 필요합니다.'
    );
  }

  const text = data.text;
  const uid = context.auth.uid;

  // 입력 검증
  if (typeof text !== 'string' || text.length === 0) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      '텍스트가 필요합니다.'
    );
  }

  // Firestore에 저장
  const docRef = await admin.firestore().collection('messages').add({
    text: text,
    authorId: uid,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  return { messageId: docRef.id };
});
```

### 클라이언트 (JavaScript)

```javascript
import { getFunctions, httpsCallable } from 'firebase/functions';

const functions = getFunctions();
const addMessage = httpsCallable(functions, 'addMessage');

async function sendMessage(text) {
  try {
    const result = await addMessage({ text: text });
    console.log('메시지 ID:', result.data.messageId);
  } catch (error) {
    console.error('에러:', error.message);
  }
}
```

### 클라이언트 (Flutter)

```dart
import 'package:cloud_functions/cloud_functions.dart';

Future<void> sendMessage(String text) async {
  final callable = FirebaseFunctions.instance.httpsCallable('addMessage');

  try {
    final result = await callable.call({'text': text});
    print('메시지 ID: ${result.data['messageId']}');
  } on FirebaseFunctionsException catch (e) {
    print('에러: ${e.message}');
  }
}
```

## 6.9 일반적인 실수와 해결방법

### 실수 1: Admin SDK 초기화 누락

```javascript
// ✅ 올바른 방법
const admin = require('firebase-admin');

if (!admin.apps.length) {
  admin.initializeApp();
}
```

### 실수 2: 비동기 함수에서 return 누락

```javascript
// ❌ 잘못된 방법
exports.myFunction = functions.firestore
  .document('users/{userId}')
  .onCreate((snap, context) => {
    doSomethingAsync(); // Promise를 반환하지 않음!
  });

// ✅ 올바른 방법
exports.myFunction = functions.firestore
  .document('users/{userId}')
  .onCreate(async (snap, context) => {
    await doSomethingAsync();
    return null;
  });
```

### 실수 3: 무한 루프

```javascript
// ❌ 잘못된 방법
exports.onUserUpdate = functions.firestore
  .document('users/{userId}')
  .onUpdate(async (change, context) => {
    // 또 다시 업데이트하면 무한 루프!
    await change.after.ref.update({ updatedAt: new Date() });
  });

// ✅ 올바른 방법
exports.onUserUpdate = functions.firestore
  .document('users/{userId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    // 이미 updatedAt이 업데이트되었으면 무시
    if (before.name !== after.name && !after.updatedAt) {
      await change.after.ref.update({ updatedAt: new Date() });
    }
  });
```

## 6.10 바데부의 실전 팁

### 팁 1: 환경 변수 사용
```bash
# 환경 변수 설정
firebase functions:config:set service.api_key="YOUR_API_KEY"

# 코드에서 사용
const apiKey = functions.config().service.api_key;
```

### 팁 2: 로그 확인
```bash
# 실시간 로그
firebase functions:log

# 특정 함수 로그
firebase functions:log --only helloWorld
```

### 팁 3: 타임아웃 설정
```javascript
exports.longRunningFunction = functions
  .runWith({ timeoutSeconds: 300, memory: '1GB' })
  .https.onRequest((req, res) => {
    // 최대 5분 실행 가능
  });
```

## 연습 문제

1. HTTP 함수를 만들어 사용자 목록을 반환하세요
2. 사용자 생성 시 환영 메시지를 로그에 출력하는 트리거를 작성하세요
3. Callable 함수로 좋아요 기능을 구현하세요
4. 매일 자정에 실행되는 함수를 작성하세요

## 다음 단계

다음 챕터에서는 **Firebase Hosting**을 배워봅시다! 웹사이트를 배포하고 SSL 인증서를 자동으로 받는 방법을 알아볼 거예요!

## 핵심 요약

- Cloud Functions는 서버리스 백엔드 플랫폼
- HTTP 함수로 REST API 구현
- Firestore 트리거로 데이터 변경 감지
- Auth 트리거로 사용자 이벤트 처리
- Storage 트리거로 파일 처리
- 예약된 함수로 Cron 작업
- Callable 함수로 클라이언트에서 직접 호출
- Admin SDK 초기화 필수

바데부와 함께 Cloud Functions 마스터하기! 🔥

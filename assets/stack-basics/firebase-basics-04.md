# Chapter 4: Realtime Database

안녕하세요! 바데부입니다! 이번에는 Firebase의 또 다른 데이터베이스인 Realtime Database를 배워볼 거예요!

## 4.1 Realtime Database란?

Realtime Database는 Firebase의 원조 데이터베이스로, JSON 트리 구조로 데이터를 저장하고 실시간으로 동기화하는 데이터베이스예요.

**Realtime Database의 특징:**
- JSON 트리 구조
- 낮은 지연 시간 (매우 빠름!)
- 오프라인 지원
- 단순한 데이터 구조에 적합
- WebSocket 기반 실시간 동기화

## 4.2 Firestore vs Realtime Database

### 언제 Firestore를 사용할까?
- 복잡한 쿼리가 필요한 경우
- 대규모 컬렉션
- 트랜잭션이 중요한 경우
- 새 프로젝트 (Firebase 권장)

### 언제 Realtime Database를 사용할까?
- 매우 낮은 지연 시간이 중요한 경우 (게임, 채팅)
- 단순한 JSON 구조
- 자주 읽기/쓰기가 발생하는 경우
- 작은 데이터 패킷

**비교표:**

| 기능 | Firestore | Realtime Database |
|------|-----------|-------------------|
| 데이터 모델 | 컬렉션/문서 | JSON 트리 |
| 쿼리 | 강력함 | 제한적 |
| 실시간 | 빠름 | 매우 빠름 |
| 오프라인 | 지원 | 지원 |
| 가격 | 읽기/쓰기 횟수 | 다운로드 용량 |

## 4.3 Realtime Database 시작하기

### 1단계: 데이터베이스 만들기

Firebase 콘솔 > Realtime Database > 데이터베이스 만들기

**위치 선택:**
- asia-southeast1 (싱가포르) - 한국과 가까움

**보안 규칙:**
- 테스트 모드: 30일간 누구나 읽기/쓰기
- 잠금 모드: 모든 액세스 거부

### 2단계: SDK 설치

```bash
# npm
npm install firebase

# Flutter
flutter pub add firebase_database
```

### 3단계: 데이터베이스 초기화

```javascript
import { getDatabase } from 'firebase/database';

const database = getDatabase();
```

```dart
// Flutter
import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance;
```

## 4.4 데이터 구조 이해하기

Realtime Database는 JSON 트리로 데이터를 저장합니다.

```json
{
  "users": {
    "user1": {
      "name": "바데부",
      "age": 3,
      "email": "badebu@example.com"
    },
    "user2": {
      "name": "코딩이",
      "age": 5
    }
  },
  "posts": {
    "post1": {
      "title": "Firebase 배우기",
      "author": "user1",
      "likes": 10
    }
  }
}
```

**중요**: 깊은 중첩은 피하세요! 데이터를 읽을 때 모든 하위 데이터도 함께 읽어집니다.

```javascript
// ❌ 나쁜 구조 (깊은 중첩)
{
  "users": {
    "user1": {
      "posts": {
        "post1": { ... }, // user1을 읽으면 모든 post도 읽음
        "post2": { ... }
      }
    }
  }
}

// ✅ 좋은 구조 (평평한 구조)
{
  "users": {
    "user1": { "name": "바데부" }
  },
  "posts": {
    "post1": { "author": "user1", ... }
  }
}
```

## 4.5 데이터 쓰기

### JavaScript/React - 데이터 설정

```javascript
import { ref, set } from 'firebase/database';

// 특정 경로에 데이터 쓰기
async function writeUserData(userId, name, email, age) {
  try {
    await set(ref(database, 'users/' + userId), {
      username: name,
      email: email,
      age: age
    });

    console.log('✅ 데이터 쓰기 성공!');
  } catch (error) {
    console.error('❌ 쓰기 실패:', error);
  }
}

// 사용 예시
writeUserData('badebu', '바데부', 'badebu@example.com', 3);
```

### JavaScript/React - 새 항목 추가 (push)

```javascript
import { ref, push } from 'firebase/database';

async function addPost(title, content) {
  const postsRef = ref(database, 'posts');

  // 자동으로 고유 ID 생성
  const newPostRef = push(postsRef);

  await set(newPostRef, {
    title: title,
    content: content,
    timestamp: Date.now()
  });

  console.log('✅ 새 포스트 ID:', newPostRef.key);
}
```

### Flutter - 데이터 쓰기

```dart
Future<void> writeUserData(String userId, String name, String email, int age) async {
  final ref = database.ref('users/$userId');

  await ref.set({
    'username': name,
    'email': email,
    'age': age,
  });

  print('✅ 데이터 쓰기 성공!');
}

// 새 항목 추가
Future<void> addPost(String title, String content) async {
  final postsRef = database.ref('posts');
  final newPostRef = postsRef.push();

  await newPostRef.set({
    'title': title,
    'content': content,
    'timestamp': ServerValue.timestamp,
  });

  print('✅ 새 포스트 ID: ${newPostRef.key}');
}
```

## 4.6 데이터 읽기

### JavaScript/React - 한 번 읽기

```javascript
import { ref, get } from 'firebase/database';

async function readUserData(userId) {
  try {
    const snapshot = await get(ref(database, 'users/' + userId));

    if (snapshot.exists()) {
      console.log('사용자 데이터:', snapshot.val());
      return snapshot.val();
    } else {
      console.log('데이터가 없습니다.');
      return null;
    }
  } catch (error) {
    console.error('❌ 읽기 실패:', error);
  }
}
```

### JavaScript/React - 실시간 리스너

```javascript
import { ref, onValue } from 'firebase/database';

function listenToUser(userId, callback) {
  const userRef = ref(database, 'users/' + userId);

  // 실시간 변경 감지
  const unsubscribe = onValue(userRef, (snapshot) => {
    if (snapshot.exists()) {
      console.log('데이터 업데이트:', snapshot.val());
      callback(snapshot.val());
    }
  });

  // 리스너 해제 함수 반환
  return unsubscribe;
}

// 사용 예시
const unsubscribe = listenToUser('badebu', (data) => {
  console.log('새 데이터:', data);
});

// 리스너 해제
unsubscribe();
```

### Flutter - 데이터 읽기

```dart
// 한 번 읽기
Future<Map<dynamic, dynamic>?> readUserData(String userId) async {
  final snapshot = await database.ref('users/$userId').get();

  if (snapshot.exists) {
    return snapshot.value as Map<dynamic, dynamic>;
  } else {
    print('데이터가 없습니다.');
    return null;
  }
}

// 실시간 스트림
Stream<DatabaseEvent> listenToUser(String userId) {
  return database.ref('users/$userId').onValue;
}

// StreamBuilder에서 사용
StreamBuilder<DatabaseEvent>(
  stream: database.ref('users/badebu').onValue,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
    return Text('이름: ${data['username']}');
  },
)
```

## 4.7 데이터 업데이트

### JavaScript/React - 특정 필드 업데이트

```javascript
import { ref, update } from 'firebase/database';

async function updateUserAge(userId, newAge) {
  const updates = {};
  updates['users/' + userId + '/age'] = newAge;
  updates['users/' + userId + '/updatedAt'] = Date.now();

  await update(ref(database), updates);
  console.log('✅ 업데이트 성공!');
}
```

### JavaScript/React - 여러 경로 동시 업데이트

```javascript
async function updateMultiplePaths() {
  const updates = {};

  updates['users/user1/age'] = 4;
  updates['users/user2/age'] = 6;
  updates['stats/totalUsers'] = 2;

  // 한 번에 모두 업데이트 (원자적 연산)
  await update(ref(database), updates);
}
```

### Flutter - 업데이트

```dart
Future<void> updateUserAge(String userId, int newAge) async {
  await database.ref('users/$userId').update({
    'age': newAge,
    'updatedAt': ServerValue.timestamp,
  });
}
```

## 4.8 데이터 삭제

### JavaScript/React

```javascript
import { ref, remove } from 'firebase/database';

async function deleteUser(userId) {
  await remove(ref(database, 'users/' + userId));
  console.log('✅ 삭제 성공!');
}

// 또는 null로 설정
async function deleteUserAlt(userId) {
  await set(ref(database, 'users/' + userId), null);
}
```

### Flutter

```dart
Future<void> deleteUser(String userId) async {
  await database.ref('users/$userId').remove();
}
```

## 4.9 쿼리하기

### JavaScript/React - 정렬 및 필터링

```javascript
import { ref, query, orderByChild, equalTo, limitToFirst, get } from 'firebase/database';

// 나이순으로 정렬하여 상위 5명
async function getTopUsers() {
  const usersRef = ref(database, 'users');
  const topUsersQuery = query(
    usersRef,
    orderByChild('age'),
    limitToFirst(5)
  );

  const snapshot = await get(topUsersQuery);
  const users = [];

  snapshot.forEach((childSnapshot) => {
    users.push({
      id: childSnapshot.key,
      ...childSnapshot.val()
    });
  });

  return users;
}

// 나이가 5살인 사용자 찾기
async function getUsersByAge(age) {
  const usersRef = ref(database, 'users');
  const ageQuery = query(
    usersRef,
    orderByChild('age'),
    equalTo(age)
  );

  const snapshot = await get(ageQuery);
  // ...
}
```

### Flutter - 쿼리

```dart
Future<List<Map<String, dynamic>>> getTopUsers() async {
  final snapshot = await database
    .ref('users')
    .orderByChild('age')
    .limitToFirst(5)
    .get();

  final List<Map<String, dynamic>> users = [];

  if (snapshot.exists) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    data.forEach((key, value) {
      users.add({'id': key, ...Map<String, dynamic>.from(value)});
    });
  }

  return users;
}
```

## 4.10 트랜잭션

### JavaScript/React - 원자적 업데이트

```javascript
import { ref, runTransaction } from 'firebase/database';

async function incrementLikes(postId) {
  const postRef = ref(database, 'posts/' + postId + '/likes');

  await runTransaction(postRef, (currentLikes) => {
    // 현재 값에 1 추가
    return (currentLikes || 0) + 1;
  });

  console.log('✅ 좋아요 증가!');
}
```

### Flutter - 트랜잭션

```dart
Future<void> incrementLikes(String postId) async {
  final postRef = database.ref('posts/$postId/likes');

  await postRef.runTransaction((currentValue) {
    return Transaction.success((currentValue ?? 0) + 1);
  });
}
```

## 4.11 오프라인 기능

### JavaScript/React - 오프라인 지원

```javascript
import { ref, onDisconnect, set } from 'firebase/database';

// 연결이 끊기면 자동으로 실행
const userStatusRef = ref(database, 'users/' + userId + '/status');

onDisconnect(userStatusRef).set('offline').then(() => {
  // 현재는 온라인으로 설정
  set(userStatusRef, 'online');
});
```

### 연결 상태 감지

```javascript
import { ref, onValue } from 'firebase/database';

const connectedRef = ref(database, '.info/connected');

onValue(connectedRef, (snapshot) => {
  if (snapshot.val() === true) {
    console.log('✅ 연결됨');
  } else {
    console.log('❌ 연결 끊김');
  }
});
```

## 4.12 일반적인 실수와 해결방법

### 실수 1: 깊은 중첩 구조

```javascript
// ❌ 잘못된 구조
{
  "users": {
    "user1": {
      "profile": {
        "info": {
          "details": {
            "name": "바데부" // 너무 깊음!
          }
        }
      }
    }
  }
}

// ✅ 올바른 구조
{
  "users": {
    "user1": {
      "name": "바데부",
      "age": 3
    }
  }
}
```

### 실수 2: 배열 사용

```javascript
// ❌ 잘못된 방법 (배열)
{
  "users": [
    { "name": "바데부" }, // 인덱스 0
    { "name": "코딩이" }  // 인덱스 1
  ]
}
// 문제: 중간 항목을 삭제하면 인덱스가 꼬임!

// ✅ 올바른 방법 (객체)
{
  "users": {
    "uniqueId1": { "name": "바데부" },
    "uniqueId2": { "name": "코딩이" }
  }
}
```

### 실수 3: 리스너 클린업 누락

```javascript
// ❌ 잘못된 방법
useEffect(() => {
  onValue(ref(database, 'users'), (snapshot) => {
    // ...
  });
  // 클린업 없음!
}, []);

// ✅ 올바른 방법
useEffect(() => {
  const unsubscribe = onValue(ref(database, 'users'), (snapshot) => {
    // ...
  });

  return () => unsubscribe();
}, []);
```

## 4.13 바데부의 실전 팁

### 팁 1: 서버 타임스탬프 사용
```javascript
import { serverTimestamp } from 'firebase/database';

await set(ref(database, 'posts/' + postId), {
  title: '제목',
  createdAt: serverTimestamp() // 서버 시간 사용
});
```

### 팁 2: 존재 여부 우선 확인
```javascript
const snapshot = await get(ref(database, 'users/' + userId));

if (snapshot.exists()) {
  // 데이터 처리
} else {
  // 데이터 없음 처리
}
```

### 팁 3: 인덱스 추가 (성능 향상)
Firebase 콘솔 > Realtime Database > 규칙 탭

```json
{
  "rules": {
    "users": {
      ".indexOn": ["age", "name"]
    }
  }
}
```

## 연습 문제

1. 사용자 목록을 실시간으로 표시하는 앱을 만들어보세요
2. 좋아요 버튼을 누르면 트랜잭션으로 카운트를 증가시키세요
3. 연결 상태를 감지하여 UI에 표시하세요
4. 채팅 메시지를 push()로 추가하고 실시간으로 표시하세요

## 다음 단계

다음 챕터에서는 **Cloud Storage**를 배워봅시다! 이미지와 파일을 업로드하고 다운로드하는 방법을 알아볼 거예요!

## 핵심 요약

- Realtime Database는 JSON 트리 구조
- set()으로 데이터 쓰기, push()로 새 항목 추가
- get()으로 한 번 읽기, onValue()로 실시간 감지
- update()로 특정 필드 업데이트
- runTransaction()으로 원자적 업데이트
- 깊은 중첩 피하기, 배열 대신 객체 사용
- orderByChild(), limitToFirst()로 쿼리
- onDisconnect()로 오프라인 처리

바데부와 함께 Realtime Database 마스터하기! 🔥

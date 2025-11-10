# Chapter 3: Cloud Firestore 데이터베이스

안녕하세요! 바데부입니다! 이번에는 Firebase의 강력한 NoSQL 데이터베이스인 Cloud Firestore를 배워볼 거예요!

## 3.1 Cloud Firestore란?

Cloud Firestore는 Firebase의 최신 데이터베이스로, 실시간 동기화와 오프라인 지원을 제공하는 NoSQL 데이터베이스예요.

**Firestore의 장점:**
- 실시간 동기화
- 오프라인 지원
- 강력한 쿼리 기능
- 자동 확장성
- 보안 규칙으로 데이터 보호

## 3.2 Firestore 데이터 구조

Firestore는 **컬렉션(Collection)**과 **문서(Document)**로 구성됩니다.

```
데이터베이스
 └─ users (컬렉션)
     ├─ user1 (문서)
     │   ├─ name: "바데부"
     │   ├─ age: 3
     │   └─ email: "badebu@example.com"
     │
     └─ user2 (문서)
         ├─ name: "코딩이"
         └─ age: 5
```

### 컬렉션 (Collection)
- 문서들의 그룹
- 이름으로 식별
- 예: `users`, `posts`, `comments`

### 문서 (Document)
- JSON과 유사한 데이터 구조
- 고유한 ID로 식별
- 최대 1MB 크기

### 하위 컬렉션 (Subcollection)
```
users
 └─ user1
     └─ posts (하위 컬렉션)
         ├─ post1
         └─ post2
```

## 3.3 Firestore 시작하기

### 1단계: Firestore 활성화

Firebase 콘솔 > Firestore Database > 데이터베이스 만들기

**보안 규칙 선택:**
- 테스트 모드: 30일간 누구나 읽기/쓰기 가능 (개발용)
- 프로덕션 모드: 인증된 사용자만 접근 가능

### 2단계: SDK 초기화

```javascript
import { getFirestore } from 'firebase/firestore';

const db = getFirestore();
```

```dart
// Flutter
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;
```

## 3.4 데이터 추가하기

### JavaScript/React - 문서 추가

```javascript
import { collection, addDoc } from 'firebase/firestore';

// 자동 생성된 ID로 문서 추가
async function addUser() {
  try {
    const docRef = await addDoc(collection(db, 'users'), {
      name: '바데부',
      age: 3,
      email: 'badebu@example.com',
      createdAt: new Date()
    });

    console.log('✅ 문서 추가 성공! ID:', docRef.id);
    return docRef.id;
  } catch (error) {
    console.error('❌ 추가 실패:', error);
  }
}
```

### JavaScript/React - 특정 ID로 문서 추가

```javascript
import { doc, setDoc } from 'firebase/firestore';

async function addUserWithId() {
  try {
    await setDoc(doc(db, 'users', 'badebu'), {
      name: '바데부',
      age: 3,
      email: 'badebu@example.com'
    });

    console.log('✅ 문서 추가 성공!');
  } catch (error) {
    console.error('❌ 추가 실패:', error);
  }
}
```

### Flutter - 문서 추가

```dart
// 자동 생성된 ID로 추가
Future<String?> addUser() async {
  try {
    final docRef = await db.collection('users').add({
      'name': '바데부',
      'age': 3,
      'email': 'badebu@example.com',
      'createdAt': FieldValue.serverTimestamp(),
    });

    print('✅ 문서 추가 성공! ID: ${docRef.id}');
    return docRef.id;
  } catch (e) {
    print('❌ 추가 실패: $e');
    return null;
  }
}

// 특정 ID로 추가
Future<void> addUserWithId() async {
  await db.collection('users').doc('badebu').set({
    'name': '바데부',
    'age': 3,
    'email': 'badebu@example.com',
  });
}
```

## 3.5 데이터 읽기

### JavaScript/React - 단일 문서 읽기

```javascript
import { doc, getDoc } from 'firebase/firestore';

async function getUser(userId) {
  try {
    const docRef = doc(db, 'users', userId);
    const docSnap = await getDoc(docRef);

    if (docSnap.exists()) {
      console.log('문서 데이터:', docSnap.data());
      return docSnap.data();
    } else {
      console.log('문서가 존재하지 않습니다.');
      return null;
    }
  } catch (error) {
    console.error('❌ 읽기 실패:', error);
  }
}
```

### JavaScript/React - 모든 문서 읽기

```javascript
import { collection, getDocs } from 'firebase/firestore';

async function getAllUsers() {
  try {
    const querySnapshot = await getDocs(collection(db, 'users'));

    const users = [];
    querySnapshot.forEach((doc) => {
      users.push({
        id: doc.id,
        ...doc.data()
      });
    });

    console.log('✅ 사용자 목록:', users);
    return users;
  } catch (error) {
    console.error('❌ 읽기 실패:', error);
  }
}
```

### Flutter - 데이터 읽기

```dart
// 단일 문서 읽기
Future<Map<String, dynamic>?> getUser(String userId) async {
  try {
    final docSnap = await db.collection('users').doc(userId).get();

    if (docSnap.exists) {
      return docSnap.data();
    } else {
      print('문서가 존재하지 않습니다.');
      return null;
    }
  } catch (e) {
    print('❌ 읽기 실패: $e');
    return null;
  }
}

// 모든 문서 읽기
Future<List<Map<String, dynamic>>> getAllUsers() async {
  final querySnapshot = await db.collection('users').get();

  return querySnapshot.docs.map((doc) {
    return {'id': doc.id, ...doc.data()};
  }).toList();
}
```

## 3.6 데이터 업데이트

### JavaScript/React - 문서 업데이트

```javascript
import { doc, updateDoc } from 'firebase/firestore';

// 특정 필드만 업데이트
async function updateUser(userId, newAge) {
  try {
    const userRef = doc(db, 'users', userId);

    await updateDoc(userRef, {
      age: newAge,
      updatedAt: new Date()
    });

    console.log('✅ 업데이트 성공!');
  } catch (error) {
    console.error('❌ 업데이트 실패:', error);
  }
}
```

### JavaScript/React - 문서 전체 덮어쓰기

```javascript
import { doc, setDoc } from 'firebase/firestore';

// 문서 전체를 새 데이터로 교체
async function replaceUser(userId) {
  await setDoc(doc(db, 'users', userId), {
    name: '바데부',
    age: 4 // 이전 데이터는 모두 삭제됨
  });
}

// 기존 데이터 병합
async function mergeUser(userId) {
  await setDoc(doc(db, 'users', userId), {
    age: 4 // name 등 다른 필드는 유지됨
  }, { merge: true });
}
```

### Flutter - 업데이트

```dart
Future<void> updateUser(String userId, int newAge) async {
  await db.collection('users').doc(userId).update({
    'age': newAge,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}
```

## 3.7 데이터 삭제

### JavaScript/React - 문서 삭제

```javascript
import { doc, deleteDoc } from 'firebase/firestore';

async function deleteUser(userId) {
  try {
    await deleteDoc(doc(db, 'users', userId));
    console.log('✅ 삭제 성공!');
  } catch (error) {
    console.error('❌ 삭제 실패:', error);
  }
}
```

### JavaScript/React - 필드 삭제

```javascript
import { doc, updateDoc, deleteField } from 'firebase/firestore';

async function deleteUserEmail(userId) {
  const userRef = doc(db, 'users', userId);

  await updateDoc(userRef, {
    email: deleteField() // email 필드만 삭제
  });
}
```

### Flutter - 삭제

```dart
// 문서 삭제
Future<void> deleteUser(String userId) async {
  await db.collection('users').doc(userId).delete();
}

// 필드 삭제
Future<void> deleteUserEmail(String userId) async {
  await db.collection('users').doc(userId).update({
    'email': FieldValue.delete(),
  });
}
```

## 3.8 쿼리하기

### JavaScript/React - 조건부 쿼리

```javascript
import { collection, query, where, getDocs } from 'firebase/firestore';

// 나이가 3살인 사용자 찾기
async function getUsersByAge(age) {
  const q = query(
    collection(db, 'users'),
    where('age', '==', age)
  );

  const querySnapshot = await getDocs(q);
  const users = [];

  querySnapshot.forEach((doc) => {
    users.push({ id: doc.id, ...doc.data() });
  });

  return users;
}

// 나이가 5살 이상인 사용자 찾기
async function getOlderUsers() {
  const q = query(
    collection(db, 'users'),
    where('age', '>=', 5)
  );

  const querySnapshot = await getDocs(q);
  return querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}
```

### JavaScript/React - 정렬 및 제한

```javascript
import { collection, query, orderBy, limit, getDocs } from 'firebase/firestore';

// 나이순으로 정렬하여 상위 10명 가져오기
async function getTopUsers() {
  const q = query(
    collection(db, 'users'),
    orderBy('age', 'desc'),
    limit(10)
  );

  const querySnapshot = await getDocs(q);
  return querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
}
```

### Flutter - 쿼리

```dart
// 조건부 쿼리
Future<List<Map<String, dynamic>>> getUsersByAge(int age) async {
  final querySnapshot = await db
    .collection('users')
    .where('age', isEqualTo: age)
    .get();

  return querySnapshot.docs.map((doc) {
    return {'id': doc.id, ...doc.data()};
  }).toList();
}

// 정렬 및 제한
Future<List<Map<String, dynamic>>> getTopUsers() async {
  final querySnapshot = await db
    .collection('users')
    .orderBy('age', descending: true)
    .limit(10)
    .get();

  return querySnapshot.docs.map((doc) {
    return {'id': doc.id, ...doc.data()};
  }).toList();
}
```

## 3.9 실시간 리스너

### JavaScript/React - 실시간 업데이트 감지

```javascript
import { doc, onSnapshot } from 'firebase/firestore';

// 단일 문서 실시간 감지
function listenToUser(userId, callback) {
  const unsubscribe = onSnapshot(doc(db, 'users', userId), (doc) => {
    if (doc.exists()) {
      console.log('문서가 업데이트되었습니다:', doc.data());
      callback(doc.data());
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

### JavaScript/React - 컬렉션 실시간 감지

```javascript
import { collection, onSnapshot } from 'firebase/firestore';

function listenToUsers(callback) {
  const unsubscribe = onSnapshot(collection(db, 'users'), (snapshot) => {
    const users = [];

    snapshot.forEach((doc) => {
      users.push({ id: doc.id, ...doc.data() });
    });

    callback(users);
  });

  return unsubscribe;
}
```

### Flutter - 실시간 스트림

```dart
// 단일 문서 스트림
Stream<DocumentSnapshot> userStream(String userId) {
  return db.collection('users').doc(userId).snapshots();
}

// StreamBuilder에서 사용
StreamBuilder<DocumentSnapshot>(
  stream: db.collection('users').doc('badebu').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    final userData = snapshot.data!.data() as Map<String, dynamic>;
    return Text('이름: ${userData['name']}');
  },
)

// 컬렉션 스트림
Stream<QuerySnapshot> usersStream() {
  return db.collection('users').snapshots();
}
```

## 3.10 일반적인 실수와 해결방법

### 실수 1: 문서 존재 확인 생략

```javascript
// ❌ 잘못된 방법
const docSnap = await getDoc(docRef);
const data = docSnap.data(); // 문서가 없으면 undefined

// ✅ 올바른 방법
const docSnap = await getDoc(docRef);
if (docSnap.exists()) {
  const data = docSnap.data();
}
```

### 실수 2: 리스너 클린업 누락

```javascript
// ❌ 잘못된 방법
useEffect(() => {
  onSnapshot(collection(db, 'users'), (snapshot) => {
    // ...
  });
  // 클린업 없음 - 메모리 누수!
}, []);

// ✅ 올바른 방법
useEffect(() => {
  const unsubscribe = onSnapshot(collection(db, 'users'), (snapshot) => {
    // ...
  });

  return () => unsubscribe();
}, []);
```

### 실수 3: 너무 많은 쿼리 실행

```javascript
// ❌ 비효율적
for (let i = 0; i < userIds.length; i++) {
  await getDoc(doc(db, 'users', userIds[i])); // 100개면 100번 요청!
}

// ✅ 효율적 (최대 10개씩)
import { documentId, query, where } from 'firebase/firestore';

const q = query(
  collection(db, 'users'),
  where(documentId(), 'in', userIds.slice(0, 10))
);
```

## 3.11 바데부의 실전 팁

### 팁 1: Timestamp 사용하기
```javascript
import { serverTimestamp } from 'firebase/firestore';

await addDoc(collection(db, 'posts'), {
  title: '안녕하세요',
  createdAt: serverTimestamp() // 서버 시간 사용
});
```

### 팁 2: 배치 작업
```javascript
import { writeBatch, doc } from 'firebase/firestore';

const batch = writeBatch(db);

batch.set(doc(db, 'users', 'user1'), { name: '바데부' });
batch.update(doc(db, 'users', 'user2'), { age: 5 });
batch.delete(doc(db, 'users', 'user3'));

await batch.commit(); // 한 번에 실행
```

### 팁 3: 트랜잭션
```javascript
import { runTransaction } from 'firebase/firestore';

await runTransaction(db, async (transaction) => {
  const docRef = doc(db, 'users', 'badebu');
  const docSnap = await transaction.get(docRef);

  const newAge = docSnap.data().age + 1;
  transaction.update(docRef, { age: newAge });
});
```

## 연습 문제

1. 사용자를 추가하고 목록을 표시하는 앱을 만들어보세요
2. 나이가 5살 이상인 사용자만 필터링해보세요
3. 실시간 리스너를 사용하여 데이터 변경을 감지해보세요
4. 사용자 정보를 업데이트하고 삭제하는 기능을 추가해보세요

## 다음 단계

다음 챕터에서는 **Realtime Database**를 배워봅시다! Firestore와의 차이점과 언제 사용하는지 알아볼 거예요!

## 핵심 요약

- Firestore는 NoSQL 데이터베이스로 컬렉션과 문서로 구성
- addDoc()로 자동 ID 생성, setDoc()으로 특정 ID 지정
- getDoc()로 단일 문서, getDocs()로 여러 문서 읽기
- updateDoc()로 특정 필드 업데이트
- where(), orderBy(), limit()로 쿼리
- onSnapshot()으로 실시간 변경 감지
- 리스너는 반드시 클린업 필요

바데부와 함께 Firestore 마스터하기! 🔥

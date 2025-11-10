# Chapter 8: Cloud Messaging (푸시 알림)

안녕하세요! 바데부입니다! 이번에는 Firebase Cloud Messaging (FCM)으로 푸시 알림을 보내는 방법을 배워볼 거예요!

## 8.1 Firebase Cloud Messaging이란?

FCM은 무료로 메시지를 안정적으로 전송할 수 있는 크로스 플랫폼 메시징 솔루션이예요!

**FCM의 장점:**
- 무료 무제한 메시지
- iOS, Android, 웹 지원
- 타겟팅 및 세그먼트
- A/B 테스트
- 예약 전송
- 분석 통합

**메시지 유형:**
- **알림 메시지**: 사용자에게 보이는 알림
- **데이터 메시지**: 앱이 처리하는 데이터
- **혼합 메시지**: 알림 + 데이터

## 8.2 웹에서 FCM 시작하기

### 1단계: Firebase 설정

```javascript
// firebase-config.js
import { initializeApp } from 'firebase/app';
import { getMessaging } from 'firebase/messaging';

const firebaseConfig = {
  // ... 설정
};

const app = initializeApp(firebaseConfig);
const messaging = getMessaging(app);

export { messaging };
```

### 2단계: 서비스 워커 생성

```javascript
// public/firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "...",
  authDomain: "...",
  projectId: "...",
  storageBucket: "...",
  messagingSenderId: "...",
  appId: "..."
});

const messaging = firebase.messaging();

// 백그라운드 메시지 처리
messaging.onBackgroundMessage((payload) => {
  console.log('백그라운드 메시지:', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
```

### 3단계: 알림 권한 요청

```javascript
import { getToken, onMessage } from 'firebase/messaging';
import { messaging } from './firebase-config';

async function requestNotificationPermission() {
  try {
    // 알림 권한 요청
    const permission = await Notification.requestPermission();

    if (permission === 'granted') {
      console.log('✅ 알림 권한 허용됨');

      // FCM 토큰 가져오기
      const token = await getToken(messaging, {
        vapidKey: 'YOUR_VAPID_KEY' // Firebase 콘솔에서 생성
      });

      console.log('FCM 토큰:', token);

      // 토큰을 서버에 저장
      await saveTokenToServer(token);

      return token;
    } else {
      console.log('❌ 알림 권한 거부됨');
      return null;
    }
  } catch (error) {
    console.error('알림 권한 요청 실패:', error);
  }
}

async function saveTokenToServer(token) {
  const user = auth.currentUser;
  if (user) {
    await setDoc(doc(db, 'users', user.uid), {
      fcmToken: token
    }, { merge: true });
  }
}
```

### 4단계: 포그라운드 메시지 수신

```javascript
import { onMessage } from 'firebase/messaging';

// 앱이 포그라운드일 때 메시지 수신
onMessage(messaging, (payload) => {
  console.log('메시지 수신:', payload);

  const { title, body } = payload.notification;

  // 커스텀 알림 표시
  new Notification(title, {
    body: body,
    icon: '/firebase-logo.png'
  });
});
```

## 8.3 Flutter에서 FCM 설정

### 1단계: 패키지 설치

```bash
flutter pub add firebase_messaging
```

### 2단계: iOS 설정 (선택사항)

```swift
// ios/Runner/AppDelegate.swift
import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    // 알림 권한 요청
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        print("알림 권한: \(granted)")
      }
    }

    application.registerForRemoteNotifications()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 3단계: 알림 권한 및 토큰 획득

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _messaging = FirebaseMessaging.instance;

Future<void> initializeNotifications() async {
  // 알림 권한 요청
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ 알림 권한 허용됨');

    // FCM 토큰 가져오기
    String? token = await _messaging.getToken();
    print('FCM 토큰: $token');

    // 토큰을 Firestore에 저장
    if (token != null) {
      await saveTokenToFirestore(token);
    }

    // 토큰 갱신 리스너
    _messaging.onTokenRefresh.listen((newToken) {
      print('토큰 갱신: $newToken');
      saveTokenToFirestore(newToken);
    });
  } else {
    print('❌ 알림 권한 거부됨');
  }
}

Future<void> saveTokenToFirestore(String token) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'fcmToken': token,
    }, SetOptions(merge: true));
  }
}
```

### 4단계: 메시지 수신 리스너

```dart
void setupMessageListeners() {
  // 포그라운드 메시지
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('포그라운드 메시지: ${message.notification?.title}');

    // 로컬 알림 표시 (flutter_local_notifications 패키지 사용)
    showLocalNotification(message);
  });

  // 백그라운드 메시지 (앱이 실행 중이지만 백그라운드)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('백그라운드에서 알림 클릭: ${message.notification?.title}');

    // 특정 화면으로 이동
    navigateToScreen(message.data);
  });

  // 앱이 종료된 상태에서 알림 클릭
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      print('종료 상태에서 알림 클릭: ${message.notification?.title}');
      navigateToScreen(message.data);
    }
  });
}

// 백그라운드 메시지 핸들러 (최상위 함수)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('백그라운드 메시지: ${message.notification?.title}');
}

// main.dart에서 호출
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}
```

## 8.4 메시지 전송하기

### 방법 1: Firebase 콘솔에서 전송

1. Firebase 콘솔 > Cloud Messaging
2. "첫 번째 캠페인 만들기" 클릭
3. "Firebase 알림 메시지" 선택
4. 알림 제목 및 텍스트 입력
5. 타겟 선택 (모든 사용자, 특정 토픽 등)
6. 예약 또는 즉시 전송

### 방법 2: Cloud Functions로 전송

```javascript
const admin = require('firebase-admin');

exports.sendNotification = functions.https.onCall(async (data, context) => {
  // 인증 확인
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', '로그인 필요');
  }

  const { userId, title, body } = data;

  // 사용자의 FCM 토큰 가져오기
  const userDoc = await admin.firestore().collection('users').doc(userId).get();
  const fcmToken = userDoc.data().fcmToken;

  if (!fcmToken) {
    throw new functions.https.HttpsError('not-found', 'FCM 토큰 없음');
  }

  // 메시지 전송
  const message = {
    notification: {
      title: title,
      body: body
    },
    token: fcmToken
  };

  try {
    const response = await admin.messaging().send(message);
    console.log('✅ 메시지 전송 성공:', response);
    return { success: true, messageId: response };
  } catch (error) {
    console.error('❌ 메시지 전송 실패:', error);
    throw new functions.https.HttpsError('internal', '전송 실패');
  }
});
```

### 방법 3: Admin SDK로 전송

```javascript
const admin = require('firebase-admin');

async function sendNotificationToUser(userId, title, body) {
  // 사용자의 FCM 토큰 가져오기
  const userDoc = await admin.firestore().collection('users').doc(userId).get();
  const fcmToken = userDoc.data().fcmToken;

  const message = {
    notification: {
      title: title,
      body: body
    },
    data: {
      userId: userId,
      timestamp: Date.now().toString()
    },
    token: fcmToken
  };

  const response = await admin.messaging().send(message);
  console.log('메시지 전송:', response);
}

// 여러 사용자에게 전송
async function sendNotificationToMultipleUsers(userIds, title, body) {
  const tokens = [];

  for (const userId of userIds) {
    const userDoc = await admin.firestore().collection('users').doc(userId).get();
    const token = userDoc.data().fcmToken;
    if (token) {
      tokens.push(token);
    }
  }

  const message = {
    notification: {
      title: title,
      body: body
    },
    tokens: tokens // 최대 500개
  };

  const response = await admin.messaging().sendMulticast(message);
  console.log('성공:', response.successCount);
  console.log('실패:', response.failureCount);
}
```

## 8.5 토픽 구독

사용자를 그룹으로 나누어 메시지를 보낼 수 있어요!

### 클라이언트에서 토픽 구독

```javascript
// 웹
import { getMessaging } from 'firebase/messaging';

const messaging = getMessaging();

// 토픽 구독 (서버에서 처리해야 함)
// 클라이언트에서는 토큰을 서버로 보내고, 서버에서 구독 처리
```

```dart
// Flutter
await FirebaseMessaging.instance.subscribeToTopic('news');
print('✅ news 토픽 구독');

// 구독 해제
await FirebaseMessaging.instance.unsubscribeFromTopic('news');
```

### 서버에서 토픽에 메시지 전송

```javascript
const message = {
  notification: {
    title: '새 소식!',
    body: 'Firebase 새 기능이 출시되었습니다!'
  },
  topic: 'news'
};

await admin.messaging().send(message);
```

## 8.6 조건부 메시지

여러 토픽을 조합하여 타겟팅할 수 있어요!

```javascript
const message = {
  notification: {
    title: '특별 할인!',
    body: '안드로이드 사용자를 위한 할인'
  },
  condition: "'android' in topics && ('premium' in topics || 'vip' in topics)"
};

await admin.messaging().send(message);
```

## 8.7 데이터 메시지

알림 없이 데이터만 전송할 수 있어요!

```javascript
const message = {
  data: {
    type: 'chat',
    chatId: '12345',
    senderId: 'user1',
    message: '안녕하세요!'
  },
  token: fcmToken
};

await admin.messaging().send(message);
```

### Flutter에서 데이터 메시지 처리

```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  if (message.data.isNotEmpty) {
    print('데이터 메시지: ${message.data}');

    // 데이터 타입에 따라 처리
    if (message.data['type'] == 'chat') {
      handleChatMessage(message.data);
    }
  }
});
```

## 8.8 이미지 포함 알림

```javascript
const message = {
  notification: {
    title: '새 사진!',
    body: '바데부가 사진을 업로드했습니다.',
    imageUrl: 'https://example.com/photo.jpg'
  },
  token: fcmToken
};

await admin.messaging().send(message);
```

## 8.9 일반적인 실수와 해결방법

### 실수 1: VAPID 키 미설정 (웹)

```javascript
// ❌ 잘못된 방법
const token = await getToken(messaging);

// ✅ 올바른 방법
const token = await getToken(messaging, {
  vapidKey: 'YOUR_VAPID_KEY' // Firebase 콘솔에서 생성
});
```

**VAPID 키 생성:**
Firebase 콘솔 > 프로젝트 설정 > Cloud Messaging > 웹 푸시 인증서 > 키 페어 생성

### 실수 2: 서비스 워커 경로 오류

```javascript
// ❌ 잘못된 경로
// src/firebase-messaging-sw.js (작동 안 함!)

// ✅ 올바른 경로
// public/firebase-messaging-sw.js
```

### 실수 3: 백그라운드 핸들러 미등록 (Flutter)

```dart
// ✅ main() 함수에서 반드시 등록
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 백그라운드 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}
```

## 8.10 바데부의 실전 팁

### 팁 1: 토큰 갱신 처리

```dart
// 토큰이 갱신되면 Firestore 업데이트
FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  saveTokenToFirestore(newToken);
});
```

### 팁 2: 알림 클릭 액션

```javascript
// 웹 - 서비스 워커
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  // 특정 URL로 이동
  event.waitUntil(
    clients.openWindow('/chat/' + event.notification.data.chatId)
  );
});
```

```dart
// Flutter
FirebaseMessaging.onMessageOpenedApp.listen((message) {
  final chatId = message.data['chatId'];
  Navigator.pushNamed(context, '/chat', arguments: chatId);
});
```

### 팁 3: A/B 테스트

Firebase 콘솔에서 여러 버전의 알림을 테스트하고 효과를 측정하세요!

## 8.11 실전 예제: 새 메시지 알림

```javascript
// Cloud Function - 새 메시지 생성 시 알림 전송
exports.onNewMessage = functions.firestore
  .document('chats/{chatId}/messages/{messageId}')
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const chatId = context.params.chatId;

    // 채팅 참여자 가져오기
    const chatDoc = await admin.firestore().collection('chats').doc(chatId).get();
    const participants = chatDoc.data().participants;

    // 발신자를 제외한 참여자에게 알림
    const recipientIds = participants.filter(id => id !== message.senderId);

    for (const recipientId of recipientIds) {
      const userDoc = await admin.firestore().collection('users').doc(recipientId).get();
      const fcmToken = userDoc.data().fcmToken;

      if (fcmToken) {
        await admin.messaging().send({
          notification: {
            title: message.senderName,
            body: message.text
          },
          data: {
            chatId: chatId,
            type: 'chat'
          },
          token: fcmToken
        });
      }
    }
  });
```

## 연습 문제

1. 알림 권한을 요청하고 FCM 토큰을 Firestore에 저장하세요
2. Cloud Function으로 특정 사용자에게 알림을 보내세요
3. 토픽을 만들고 구독한 사용자에게 메시지를 전송하세요
4. 알림 클릭 시 특정 화면으로 이동하도록 구현하세요

## 다음 단계

다음 챕터에서는 **Firebase Analytics**를 배워봅시다! 사용자 행동을 분석하고 인사이트를 얻는 방법을 알아볼 거예요!

## 핵심 요약

- FCM은 무료 크로스 플랫폼 메시징 솔루션
- 알림 권한 요청 후 FCM 토큰 획득
- getToken()으로 토큰 가져오기
- onMessage()로 포그라운드 메시지 수신
- admin.messaging().send()로 메시지 전송
- 토픽으로 그룹 메시징
- 데이터 메시지로 백그라운드 처리
- 서비스 워커 필수 (웹)

바데부와 함께 FCM 마스터하기! 🔥

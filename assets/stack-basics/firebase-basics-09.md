# Chapter 9: Firebase Analytics

안녕하세요! 바데부입니다! 이번에는 Firebase Analytics로 사용자 행동을 분석하는 방법을 배워볼 거예요!

## 9.1 Firebase Analytics란?

Firebase Analytics는 무료로 제공되는 앱 분석 솔루션으로, 사용자가 앱을 어떻게 사용하는지 이해할 수 있게 해줘요!

**Firebase Analytics의 장점:**
- 완전 무료
- 무제한 이벤트 수집
- 자동으로 수집되는 이벤트
- 사용자 속성 추적
- 다른 Firebase 서비스와 통합
- BigQuery로 원시 데이터 내보내기

**분석 가능한 데이터:**
- 사용자 수 (일간/월간 활성 사용자)
- 사용자 참여도
- 화면 조회 수
- 전환율
- 사용자 유지율

## 9.2 웹에서 Analytics 설정

### 1단계: Analytics 추가

```javascript
// firebase-config.js
import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';

const firebaseConfig = {
  // ... 설정
};

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export { analytics };
```

### 2단계: 자동 이벤트 수집

Analytics를 초기화하면 자동으로 다음 이벤트가 수집됩니다:
- `page_view`: 페이지 조회
- `session_start`: 세션 시작
- `first_visit`: 첫 방문
- `user_engagement`: 사용자 참여

## 9.3 Flutter에서 Analytics 설정

### 1단계: 패키지 설치

```bash
flutter pub add firebase_analytics
```

### 2단계: Analytics 초기화

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
```

### 3단계: 네비게이터 관찰자 추가

```dart
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [observer], // 화면 추적
      home: HomePage(),
    );
  }
}
```

## 9.4 커스텀 이벤트 로깅

### JavaScript/React

```javascript
import { logEvent } from 'firebase/analytics';
import { analytics } from './firebase-config';

// 간단한 이벤트
function trackButtonClick() {
  logEvent(analytics, 'button_click', {
    button_name: '좋아요 버튼'
  });
}

// 구매 이벤트
function trackPurchase(itemName, price) {
  logEvent(analytics, 'purchase', {
    currency: 'KRW',
    value: price,
    items: [
      {
        item_name: itemName,
        item_category: '코스',
        price: price
      }
    ]
  });
}

// 페이지 조회 (SPA)
function trackPageView(pageName) {
  logEvent(analytics, 'page_view', {
    page_title: pageName,
    page_location: window.location.href,
    page_path: window.location.pathname
  });
}

// 검색 이벤트
function trackSearch(searchTerm) {
  logEvent(analytics, 'search', {
    search_term: searchTerm
  });
}

// 레벨 완료
function trackLevelComplete(level) {
  logEvent(analytics, 'level_complete', {
    level_name: level,
    character: '바데부'
  });
}
```

### Flutter

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

final analytics = FirebaseAnalytics.instance;

// 간단한 이벤트
Future<void> trackButtonClick() async {
  await analytics.logEvent(
    name: 'button_click',
    parameters: {
      'button_name': '좋아요 버튼',
    },
  );
}

// 구매 이벤트
Future<void> trackPurchase(String itemName, double price) async {
  await analytics.logPurchase(
    currency: 'KRW',
    value: price,
    items: [
      AnalyticsEventItem(
        itemName: itemName,
        itemCategory: '코스',
        price: price,
      ),
    ],
  );
}

// 화면 조회
Future<void> trackScreenView(String screenName) async {
  await analytics.logScreenView(
    screenName: screenName,
    screenClass: screenName,
  );
}

// 검색 이벤트
Future<void> trackSearch(String searchTerm) async {
  await analytics.logSearch(
    searchTerm: searchTerm,
  );
}

// 레벨 완료
Future<void> trackLevelComplete(String level) async {
  await analytics.logLevelEnd(
    levelName: level,
    success: true,
  );
}
```

## 9.5 사용자 속성 설정

사용자를 분류하고 세그먼트할 수 있어요!

### JavaScript/React

```javascript
import { setUserId, setUserProperties } from 'firebase/analytics';

// 사용자 ID 설정
function setAnalyticsUserId(userId) {
  setUserId(analytics, userId);
}

// 사용자 속성 설정
function setAnalyticsUserProperties(properties) {
  setUserProperties(analytics, {
    subscription_level: properties.level, // 'free', 'premium', 'vip'
    user_type: properties.userType, // 'student', 'teacher'
    language: properties.language, // 'ko', 'en'
    signup_method: properties.signupMethod // 'email', 'google'
  });
}

// 사용 예시
setAnalyticsUserId('user123');
setAnalyticsUserProperties({
  level: 'premium',
  userType: 'student',
  language: 'ko',
  signupMethod: 'google'
});
```

### Flutter

```dart
// 사용자 ID 설정
Future<void> setAnalyticsUserId(String userId) async {
  await analytics.setUserId(id: userId);
}

// 사용자 속성 설정
Future<void> setAnalyticsUserProperties(Map<String, String> properties) async {
  await analytics.setUserProperty(
    name: 'subscription_level',
    value: properties['level'],
  );

  await analytics.setUserProperty(
    name: 'user_type',
    value: properties['userType'],
  );

  await analytics.setUserProperty(
    name: 'language',
    value: properties['language'],
  );
}
```

## 9.6 권장 이벤트

Firebase는 다양한 권장 이벤트를 제공해요!

### 전자상거래 이벤트

```javascript
// 장바구니에 추가
logEvent(analytics, 'add_to_cart', {
  currency: 'KRW',
  value: 29000,
  items: [
    {
      item_id: 'course_001',
      item_name: 'Firebase 마스터 코스',
      price: 29000
    }
  ]
});

// 체크아웃 시작
logEvent(analytics, 'begin_checkout', {
  currency: 'KRW',
  value: 29000,
  items: [...]
});

// 구매 완료
logEvent(analytics, 'purchase', {
  transaction_id: 'T12345',
  value: 29000,
  currency: 'KRW',
  items: [...]
});
```

### 콘텐츠 이벤트

```javascript
// 콘텐츠 선택
logEvent(analytics, 'select_content', {
  content_type: 'course',
  content_id: 'firebase_basics'
});

// 콘텐츠 공유
logEvent(analytics, 'share', {
  method: 'kakao',
  content_type: 'course',
  item_id: 'firebase_basics'
});

// 비디오 시작
logEvent(analytics, 'video_start', {
  video_title: 'Firebase 소개',
  video_duration: 600
});
```

### 게임 이벤트

```javascript
// 튜토리얼 시작
logEvent(analytics, 'tutorial_begin');

// 튜토리얼 완료
logEvent(analytics, 'tutorial_complete');

// 레벨 시작
logEvent(analytics, 'level_start', {
  level_name: 'Chapter 1'
});

// 레벨 완료
logEvent(analytics, 'level_end', {
  level_name: 'Chapter 1',
  success: true
});

// 점수 획득
logEvent(analytics, 'post_score', {
  score: 100,
  level: 1,
  character: '바데부'
});
```

## 9.7 React에서 Analytics 사용

### 커스텀 Hook 만들기

```javascript
// useAnalytics.js
import { useEffect } from 'react';
import { logEvent } from 'firebase/analytics';
import { analytics } from './firebase-config';

export function usePageView(pageName) {
  useEffect(() => {
    logEvent(analytics, 'page_view', {
      page_title: pageName,
      page_location: window.location.href
    });
  }, [pageName]);
}

export function useAnalytics() {
  const trackEvent = (eventName, params) => {
    logEvent(analytics, eventName, params);
  };

  const trackButtonClick = (buttonName) => {
    trackEvent('button_click', { button_name: buttonName });
  };

  const trackPurchase = (itemName, price) => {
    trackEvent('purchase', {
      currency: 'KRW',
      value: price,
      items: [{ item_name: itemName, price }]
    });
  };

  return {
    trackEvent,
    trackButtonClick,
    trackPurchase
  };
}
```

### 컴포넌트에서 사용

```javascript
import { usePageView, useAnalytics } from './useAnalytics';

function CoursePage() {
  usePageView('Course Page');
  const { trackButtonClick, trackPurchase } = useAnalytics();

  const handleEnroll = () => {
    trackButtonClick('수강 신청 버튼');
    trackPurchase('Firebase 코스', 29000);
  };

  return (
    <div>
      <h1>Firebase 코스</h1>
      <button onClick={handleEnroll}>수강 신청</button>
    </div>
  );
}
```

## 9.8 Firebase 콘솔에서 분석 확인

### 대시보드 보기

Firebase 콘솔 > Analytics > Dashboard

**주요 지표:**
- 사용자 수
- 세션 수
- 평균 세션 시간
- 화면 조회 수
- 전환율

### 이벤트 보기

Firebase 콘솔 > Analytics > Events

- 실시간 이벤트 확인
- 이벤트별 사용자 수
- 매개변수 분석

### 사용자 속성

Firebase 콘솔 > Analytics > User Properties

- 사용자 세그먼트별 분석
- 구독 레벨별 사용자 수
- 언어별 사용자 분포

### Funnel Analysis (깔때기 분석)

```
1. 코스 페이지 조회 (100%)
2. 장바구니 추가 (70%)
3. 체크아웃 시작 (50%)
4. 구매 완료 (30%)
```

## 9.9 DebugView로 실시간 디버깅

### 웹 디버그 모드

```bash
# URL 파라미터 추가
https://your-app.com?debug_mode=true
```

또는 브라우저 확장 프로그램 "Google Analytics Debugger" 설치

### Flutter 디버그 모드

```bash
# Android
adb shell setprop debug.firebase.analytics.app <package_name>

# iOS (Xcode scheme에 추가)
-FIRAnalyticsDebugEnabled
```

Firebase 콘솔 > Analytics > DebugView에서 실시간으로 이벤트를 확인할 수 있어요!

## 9.10 A/B 테스트와 통합

Firebase Analytics는 Remote Config와 통합하여 A/B 테스트를 할 수 있어요!

```javascript
import { getValue, getString } from 'firebase/remote-config';

// Remote Config에서 값 가져오기
const buttonColor = getString(remoteConfig, 'button_color');

// 버튼 색상에 따른 전환율 분석
logEvent(analytics, 'button_click', {
  button_color: buttonColor,
  converted: true
});
```

## 9.11 BigQuery로 데이터 내보내기

Firebase 콘솔 > 프로젝트 설정 > 통합 > BigQuery > 연결

**장점:**
- 원시 이벤트 데이터 접근
- SQL 쿼리로 복잡한 분석
- 데이터 웨어하우스 구축

```sql
-- BigQuery 쿼리 예시
SELECT
  event_name,
  COUNT(*) as event_count
FROM
  `your-project.analytics_123456789.events_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20231201' AND '20231231'
GROUP BY
  event_name
ORDER BY
  event_count DESC
```

## 9.12 일반적인 실수와 해결방법

### 실수 1: 이벤트 이름에 공백 사용

```javascript
// ❌ 잘못된 방법
logEvent(analytics, 'button click'); // 공백 사용

// ✅ 올바른 방법
logEvent(analytics, 'button_click'); // 언더스코어 사용
```

### 실수 2: 너무 많은 매개변수

```javascript
// ❌ 잘못된 방법 (매개변수가 너무 많음)
logEvent(analytics, 'purchase', {
  param1: '...',
  param2: '...',
  // ... 30개 이상
});

// ✅ 올바른 방법 (최대 25개 매개변수)
logEvent(analytics, 'purchase', {
  currency: 'KRW',
  value: 29000,
  item_name: 'Firebase 코스'
});
```

### 실수 3: 사용자 ID를 이메일로 설정

```javascript
// ❌ 잘못된 방법 (개인정보 포함)
setUserId(analytics, 'user@example.com');

// ✅ 올바른 방법 (익명 ID)
setUserId(analytics, 'user_12345');
```

## 9.13 바데부의 실전 팁

### 팁 1: 이벤트 명명 규칙

```javascript
// 동사_명사 형식 사용
logEvent(analytics, 'view_course');
logEvent(analytics, 'click_button');
logEvent(analytics, 'complete_level');
```

### 팁 2: 커스텀 이벤트 관리

```javascript
// analytics-events.js
export const ANALYTICS_EVENTS = {
  BUTTON_CLICK: 'button_click',
  COURSE_VIEW: 'course_view',
  PURCHASE: 'purchase',
  LEVEL_COMPLETE: 'level_complete'
};

// 사용
import { ANALYTICS_EVENTS } from './analytics-events';
logEvent(analytics, ANALYTICS_EVENTS.BUTTON_CLICK, {...});
```

### 팁 3: 전환 이벤트 표시

Firebase 콘솔에서 중요한 이벤트를 "전환 이벤트"로 표시하면 더 쉽게 추적할 수 있어요!

## 9.14 실전 예제: 학습 앱 분석

```javascript
// 코스 시작 추적
function trackCourseStart(courseId, courseName) {
  logEvent(analytics, 'course_start', {
    course_id: courseId,
    course_name: courseName
  });
}

// 챕터 완료 추적
function trackChapterComplete(courseId, chapterNumber, timeSpent) {
  logEvent(analytics, 'chapter_complete', {
    course_id: courseId,
    chapter: chapterNumber,
    time_spent: timeSpent // 초 단위
  });
}

// 퀴즈 결과 추적
function trackQuizResult(courseId, score, totalQuestions) {
  logEvent(analytics, 'quiz_complete', {
    course_id: courseId,
    score: score,
    total_questions: totalQuestions,
    pass: score >= totalQuestions * 0.7
  });
}

// 수료증 발급
function trackCertificateEarned(courseId, courseName) {
  logEvent(analytics, 'certificate_earned', {
    course_id: courseId,
    course_name: courseName
  });
}
```

## 9.15 개인정보 보호

Firebase Analytics는 개인정보를 자동으로 보호해요!

**수집하지 않아야 할 정보:**
- 이메일 주소
- 전화번호
- 이름
- 주민등록번호
- 신용카드 번호

**대신 사용하세요:**
- 익명 사용자 ID
- 해시된 값
- 집계된 데이터

## 연습 문제

1. 버튼 클릭 이벤트를 로깅하세요
2. 사용자 속성을 설정하세요 (구독 레벨, 언어 등)
3. 구매 이벤트를 추적하세요
4. DebugView에서 실시간 이벤트를 확인하세요

## 다음 단계

다음 챕터에서는 **보안 규칙 및 베스트 프랙티스**를 배워봅시다! Firebase를 안전하게 사용하는 방법을 알아볼 거예요!

## 핵심 요약

- Firebase Analytics는 무료 무제한 분석 도구
- getAnalytics()로 초기화
- logEvent()로 커스텀 이벤트 추적
- setUserId()로 사용자 ID 설정
- setUserProperties()로 사용자 속성 설정
- 권장 이벤트 사용 (purchase, select_content 등)
- DebugView로 실시간 디버깅
- BigQuery로 고급 분석
- 개인정보는 수집하지 않기

바데부와 함께 Firebase Analytics 마스터하기! 🔥

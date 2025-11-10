# Chapter 7: Firebase Hosting

안녕하세요! 바데부입니다! 이번에는 Firebase Hosting으로 웹사이트를 배포하는 방법을 배워볼 거예요!

## 7.1 Firebase Hosting이란?

Firebase Hosting은 정적 웹사이트와 웹 앱을 위한 빠르고 안전한 호스팅 서비스예요!

**Firebase Hosting의 장점:**
- 빠른 CDN (Content Delivery Network)
- 무료 SSL 인증서 (HTTPS)
- 커스텀 도메인 지원
- 원클릭 배포
- 버전 관리 및 롤백
- GitHub Actions 통합

**무엇을 호스팅할 수 있나요?**
- React, Vue, Angular 등 SPA (Single Page Application)
- HTML, CSS, JavaScript 정적 사이트
- Next.js, Gatsby 등 정적 생성 사이트

## 7.2 Firebase Hosting 시작하기

### 1단계: Firebase CLI 설치

```bash
# Firebase CLI 설치 (이미 설치했다면 생략)
npm install -g firebase-tools

# Firebase 로그인
firebase login
```

### 2단계: 프로젝트 초기화

```bash
# 프로젝트 디렉토리로 이동
cd my-project

# Firebase 초기화
firebase init hosting
```

**초기화 옵션:**
1. 프로젝트 선택: 기존 프로젝트 선택
2. Public 디렉토리: `build` 또는 `dist` (React는 build, Vue는 dist)
3. SPA 설정: Yes (React, Vue 등 사용 시)
4. GitHub Actions 자동 배포: No (나중에 설정 가능)

### 3단계: 프로젝트 구조

```
my-project/
├─ public/              (또는 build, dist)
│   ├─ index.html
│   ├─ style.css
│   └─ app.js
├─ firebase.json
└─ .firebaserc
```

### 4단계: firebase.json 설정

```json
{
  "hosting": {
    "public": "build",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

## 7.3 배포하기

### 간단한 HTML 사이트 배포

```bash
# public 폴더에 index.html 생성
echo "<h1>안녕하세요, 바데부입니다!</h1>" > public/index.html

# 배포
firebase deploy --only hosting
```

**배포 완료!**
```
✔ Deploy complete!

Hosting URL: https://your-project.web.app
```

### React 앱 배포

```bash
# React 앱 빌드
npm run build

# Firebase 배포
firebase deploy --only hosting
```

### Vue 앱 배포

```bash
# Vue 앱 빌드
npm run build

# Firebase 배포 (dist 폴더)
firebase deploy --only hosting
```

## 7.4 배포 미리보기

배포 전에 로컬에서 테스트할 수 있어요!

```bash
# 로컬 서버 실행
firebase serve --only hosting

# 브라우저에서 접속
# http://localhost:5000
```

## 7.5 여러 사이트 호스팅

한 프로젝트에서 여러 사이트를 호스팅할 수 있어요!

### firebase.json 설정

```json
{
  "hosting": [
    {
      "target": "blog",
      "public": "blog/build",
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    },
    {
      "target": "admin",
      "public": "admin/build",
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    }
  ]
}
```

### 타겟 설정

```bash
# 타겟 추가
firebase target:apply hosting blog my-blog-site
firebase target:apply hosting admin my-admin-site

# 특정 사이트만 배포
firebase deploy --only hosting:blog
```

## 7.6 커스텀 도메인 연결

### 1단계: 도메인 추가

Firebase 콘솔 > Hosting > 도메인 추가 > 도메인 입력 (예: www.badebu.com)

### 2단계: DNS 레코드 설정

제공된 DNS 레코드를 도메인 제공업체에 추가:

```
타입: A
이름: @
값: 151.101.1.195
```

```
타입: A
이름: @
값: 151.101.65.195
```

### 3단계: SSL 인증서 자동 발급

Firebase가 자동으로 SSL 인증서를 발급합니다. 최대 24시간 소요될 수 있어요.

## 7.7 리다이렉트 설정

### URL 리다이렉트

```json
{
  "hosting": {
    "public": "build",
    "redirects": [
      {
        "source": "/old-page",
        "destination": "/new-page",
        "type": 301
      },
      {
        "source": "/blog/:post",
        "destination": "/posts/:post",
        "type": 301
      }
    ]
  }
}
```

### HTTP에서 HTTPS로 리다이렉트

기본적으로 Firebase Hosting은 자동으로 HTTPS로 리다이렉트합니다!

## 7.8 헤더 설정

### 보안 헤더 추가

```json
{
  "hosting": {
    "public": "build",
    "headers": [
      {
        "source": "**",
        "headers": [
          {
            "key": "X-Content-Type-Options",
            "value": "nosniff"
          },
          {
            "key": "X-Frame-Options",
            "value": "DENY"
          },
          {
            "key": "X-XSS-Protection",
            "value": "1; mode=block"
          }
        ]
      }
    ]
  }
}
```

### 캐시 제어

```json
{
  "hosting": {
    "public": "build",
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      },
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=604800"
          }
        ]
      }
    ]
  }
}
```

## 7.9 SPA 라우팅 설정

React Router, Vue Router 등을 사용할 때 필요해요!

```json
{
  "hosting": {
    "public": "build",
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

이렇게 설정하면 `/about`, `/contact` 등 모든 경로가 index.html로 라우팅됩니다.

## 7.10 Cloud Functions 연결

API와 Hosting을 함께 사용할 수 있어요!

```json
{
  "hosting": {
    "public": "build",
    "rewrites": [
      {
        "source": "/api/**",
        "function": "api"
      },
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

이제 `/api/users`로 접속하면 Cloud Function이 실행됩니다!

## 7.11 배포 히스토리 및 롤백

### 배포 히스토리 확인

```bash
firebase hosting:channel:list
```

Firebase 콘솔 > Hosting > 릴리스에서도 확인 가능!

### 이전 버전으로 롤백

```bash
# 콘솔에서 "이전 버전으로 롤백" 클릭
```

또는 CLI로:

```bash
firebase hosting:clone source-site-id:source-channel-id target-site-id:live
```

## 7.12 프리뷰 채널

배포 전에 미리보기 URL로 테스트할 수 있어요!

```bash
# 프리뷰 채널 생성 및 배포
firebase hosting:channel:deploy preview-branch

# 결과
✔ Deploy complete!

Preview URL: https://your-project--preview-branch-abc123.web.app
```

### GitHub Pull Request와 연동

```yaml
# .github/workflows/preview.yml
name: Deploy Preview

on:
  pull_request:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm ci && npm run build
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          projectId: your-project-id
```

## 7.13 환경 변수 설정

### React (.env 파일)

```bash
# .env.production
REACT_APP_API_URL=https://your-project.web.app/api
REACT_APP_FIREBASE_API_KEY=your-api-key
```

### Next.js (next.config.js)

```javascript
module.exports = {
  env: {
    FIREBASE_API_KEY: process.env.FIREBASE_API_KEY,
  }
}
```

## 7.14 일반적인 실수와 해결방법

### 실수 1: 빌드 폴더를 잘못 지정

```json
// ❌ 잘못된 설정
{
  "hosting": {
    "public": "src" // 소스 코드 폴더!
  }
}

// ✅ 올바른 설정
{
  "hosting": {
    "public": "build" // 또는 "dist"
  }
}
```

### 실수 2: SPA 라우팅 미설정

```json
// ❌ 라우팅 없음 - /about 접속 시 404 에러
{
  "hosting": {
    "public": "build"
  }
}

// ✅ SPA 라우팅 설정
{
  "hosting": {
    "public": "build",
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

### 실수 3: 빌드하지 않고 배포

```bash
# ❌ 잘못된 순서
firebase deploy --only hosting

# ✅ 올바른 순서
npm run build && firebase deploy --only hosting
```

## 7.15 바데부의 실전 팁

### 팁 1: 배포 스크립트 추가

```json
// package.json
{
  "scripts": {
    "build": "react-scripts build",
    "deploy": "npm run build && firebase deploy --only hosting"
  }
}
```

이제 `npm run deploy`로 빌드와 배포를 한 번에!

### 팁 2: 404 페이지 커스터마이징

```json
{
  "hosting": {
    "public": "build",
    "rewrites": [...],
    "cleanUrls": true,
    "trailingSlash": false
  }
}
```

public/404.html 파일을 만들어 커스텀 404 페이지를 추가하세요!

### 팁 3: 국제화 (i18n) 설정

```json
{
  "hosting": {
    "public": "build",
    "i18n": {
      "root": "/localized"
    }
  }
}
```

## 7.16 실전 예제: React 앱 배포

```bash
# 1. React 앱 생성
npx create-react-app my-app
cd my-app

# 2. Firebase 초기화
firebase init hosting
# - Public directory: build
# - Configure as SPA: Yes

# 3. 빌드 및 배포
npm run build
firebase deploy --only hosting

# 완료!
# Hosting URL: https://your-project.web.app
```

## 7.17 성능 최적화

### 이미지 최적화

```bash
# 이미지 압축 도구 설치
npm install --save-dev imagemin imagemin-webp
```

### Gzip 압축

Firebase Hosting은 자동으로 Gzip 압축을 적용합니다!

### 코드 스플리팅

```javascript
// React에서 코드 스플리팅
import React, { lazy, Suspense } from 'react';

const About = lazy(() => import('./About'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <About />
    </Suspense>
  );
}
```

## 연습 문제

1. 간단한 HTML 페이지를 Firebase Hosting에 배포하세요
2. React 앱을 빌드하고 배포하세요
3. 커스텀 도메인을 연결하세요 (선택사항)
4. 프리뷰 채널을 만들어 테스트 배포하세요

## 다음 단계

다음 챕터에서는 **Cloud Messaging**을 배워봅시다! 푸시 알림을 보내는 방법을 알아볼 거예요!

## 핵심 요약

- Firebase Hosting은 빠르고 안전한 정적 호스팅 서비스
- firebase init hosting으로 초기화
- firebase deploy --only hosting으로 배포
- 무료 SSL 인증서 자동 제공
- SPA는 rewrites 설정 필요
- 커스텀 도메인 연결 가능
- 프리뷰 채널로 배포 전 테스트
- 배포 히스토리로 롤백 가능

바데부와 함께 Firebase Hosting 마스터하기! 🔥

# GitHub Actions 시작하기

## GitHub Actions란?

GitHub Actions는 GitHub에 내장된 CI/CD 플랫폼입니다. 바데부가 코드를 푸시하면 자동으로 빌드, 테스트, 배포가 실행됩니다!

### GitHub Actions의 특징

```yaml
# GitHub Actions의 장점
장점:
  - 설정: 저장소에 YAML 파일만 추가하면 끝
  - 무료: 공개 저장소는 완전 무료
  - 통합: GitHub와 완벽하게 연동
  - 강력함: 리눅스, 윈도우, macOS 지원
  - 확장성: 수천 개의 미리 만들어진 액션 사용 가능
```

### 무료 사용량

```yaml
# GitHub Actions 무료 플랜
공개_저장소:
  실행_시간: 무제한
  동시_작업: 20개
  비용: $0

비공개_저장소:
  무료_플랜:
    실행_시간: 2,000분/월
    저장_공간: 500MB
  유료_플랜:
    실행_시간: 3,000분/월~
    저장_공간: 1GB~

# 바데부: "공개 저장소면 완전 무료!"
```

## 첫 번째 워크플로우 만들기

### 1. 저장소 준비

```bash
# 바데부의 프로젝트 폴더
mkdir badebu-cicd-practice
cd badebu-cicd-practice

# Git 저장소 초기화
git init

# 간단한 파일 생성
echo "# 바데부의 CI/CD 연습" > README.md

# GitHub에 푸시
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/badebu/cicd-practice.git
git push -u origin main
```

### 2. 워크플로우 디렉토리 생성

```bash
# .github/workflows 폴더 생성
mkdir -p .github/workflows

# 이 폴더에 YAML 파일을 넣으면
# GitHub Actions가 자동으로 인식합니다!
```

### 3. 첫 번째 워크플로우 파일 작성

```yaml
# .github/workflows/hello.yml

name: 바데부의 첫 워크플로우

# 언제 실행할지 정의
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

# 실행할 작업들
jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: 인사하기
        run: echo "안녕하세요, 바데부입니다! 🎉"

      - name: 날짜 출력
        run: date

      - name: 현재 디렉토리 확인
        run: pwd

      - name: 파일 목록 보기
        run: ls -la
```

### 4. 워크플로우 푸시 및 확인

```bash
# 워크플로우 파일 추가
git add .github/workflows/hello.yml
git commit -m "Add first workflow"
git push

# 이제 GitHub 저장소의 Actions 탭에서 확인!
```

## GitHub Actions UI 둘러보기

### Actions 탭 구조

```yaml
GitHub_저장소_탭:
  - Code: 코드 보기
  - Issues: 이슈 관리
  - Pull requests: PR 관리
  - Actions: 👈 여기로 가세요!
  - Projects: 프로젝트 관리
  - Settings: 설정

Actions_탭_내부:
  왼쪽:
    - All workflows: 모든 워크플로우
    - 워크플로우 목록: hello.yml
  중앙:
    - 실행 이력
    - 성공/실패 상태
    - 실행 시간
  오른쪽:
    - 필터링 옵션
```

### 워크플로우 실행 결과 보기

```yaml
# 실행 결과 확인하기
실행_목록:
  ✓ 바데부의 첫 워크플로우 #1
    - 상태: Success
    - 시작: 2분 전
    - 소요: 15초
    - 트리거: push

클릭하면:
  jobs:
    greet:
      steps:
        - ✓ 인사하기 (1초)
        - ✓ 날짜 출력 (0초)
        - ✓ 현재 디렉토리 확인 (0초)
        - ✓ 파일 목록 보기 (0초)
```

## 실용적인 예제: Node.js 프로젝트

### 프로젝트 설정

```bash
# Node.js 프로젝트 초기화
npm init -y

# Express 설치
npm install express

# 테스트 도구 설치
npm install --save-dev jest
```

### 간단한 서버 코드

```javascript
// app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({ message: '안녕하세요, 바데부입니다!' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

module.exports = app;
```

### 테스트 코드

```javascript
// app.test.js
const request = require('supertest');
const app = require('./app');

describe('바데부 API 테스트', () => {
  test('루트 경로 테스트', async () => {
    const response = await request(app).get('/');
    expect(response.status).toBe(200);
    expect(response.body.message).toContain('바데부');
  });

  test('헬스 체크 테스트', async () => {
    const response = await request(app).get('/health');
    expect(response.status).toBe(200);
    expect(response.body.status).toBe('healthy');
  });
});
```

### CI 워크플로우

```yaml
# .github/workflows/ci.yml

name: 바데부 CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    name: 테스트 실행
    runs-on: ubuntu-latest

    steps:
      # 1. 코드 체크아웃
      - name: 코드 가져오기
        uses: actions/checkout@v3

      # 2. Node.js 설정
      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      # 3. 의존성 설치
      - name: 의존성 설치
        run: npm ci

      # 4. 테스트 실행
      - name: 테스트 실행
        run: npm test

      # 5. 성공 메시지
      - name: 성공!
        run: echo "✅ 모든 테스트 통과!"
```

## 워크플로우 상태 배지 추가

### 배지 코드 생성

```markdown
# README.md에 추가

# 바데부의 프로젝트

![CI](https://github.com/badebu/cicd-practice/workflows/바데부%20CI/badge.svg)

이 배지가 ✅ 녹색이면 모든 테스트 통과!
이 배지가 ❌ 빨간색이면 뭔가 문제가 있어요!
```

### 배지 결과

```yaml
배지_상태:
  ✅ passing: 테스트 통과, 배포 가능
  ❌ failing: 테스트 실패, 수정 필요
  ⚫ no status: 아직 실행 안 됨
  🟡 pending: 실행 중
```

## 여러 Node.js 버전에서 테스트

```yaml
# .github/workflows/multi-version.yml

name: 다양한 Node.js 버전 테스트

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [16, 18, 20]

    steps:
      - uses: actions/checkout@v3

      - name: Node.js ${{ matrix.node-version }} 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}

      - name: 의존성 설치
        run: npm ci

      - name: 테스트 실행
        run: npm test

# 결과: 3개 버전에서 동시에 테스트!
```

## 디버깅 팁

### 1. 로그 확인하기

```yaml
# 상세한 로그 출력
steps:
  - name: 디버그 정보
    run: |
      echo "=== 환경 정보 ==="
      echo "Node 버전: $(node --version)"
      echo "NPM 버전: $(npm --version)"
      echo "현재 경로: $(pwd)"
      echo "파일 목록:"
      ls -la
```

### 2. 에러 발생 시 계속 실행

```yaml
steps:
  - name: 실패해도 계속 진행
    run: npm test
    continue-on-error: true

  - name: 정리 작업
    run: echo "에러가 있어도 이 단계는 실행됨"
```

### 3. 조건부 실행

```yaml
steps:
  - name: 메인 브랜치에서만 실행
    if: github.ref == 'refs/heads/main'
    run: echo "메인 브랜치입니다!"

  - name: PR에서만 실행
    if: github.event_name == 'pull_request'
    run: echo "풀 리퀘스트입니다!"
```

## 일반적인 실수와 해결법

### 1. YAML 들여쓰기 오류

```yaml
# ❌ 잘못된 예
jobs:
test:  # 들여쓰기 부족!
  runs-on: ubuntu-latest

# ✅ 올바른 예
jobs:
  test:  # 2칸 들여쓰기
    runs-on: ubuntu-latest
```

### 2. 파일 경로 오류

```yaml
# ❌ 잘못된 경로
.github/workflow/ci.yml  # workflows가 아님!

# ✅ 올바른 경로
.github/workflows/ci.yml  # workflows (복수형)
```

### 3. 의존성 캐싱 누락

```yaml
# ⚡ 캐싱 추가로 속도 향상
- name: 의존성 캐싱
  uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

## 실습: 바데부의 첫 CI 파이프라인

```yaml
# .github/workflows/badebu-first-ci.yml

name: 바데부의 첫 CI 파이프라인

on:
  push:
  pull_request:

jobs:
  build-and-test:
    name: 빌드 및 테스트
    runs-on: ubuntu-latest

    steps:
      - name: 1️⃣ 코드 체크아웃
        uses: actions/checkout@v3

      - name: 2️⃣ Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 3️⃣ 의존성 설치
        run: npm ci

      - name: 4️⃣ 린트 검사
        run: npm run lint
        continue-on-error: true

      - name: 5️⃣ 테스트 실행
        run: npm test

      - name: 6️⃣ 빌드
        run: npm run build

      - name: 7️⃣ 성공 축하!
        run: |
          echo "🎉 축하합니다, 바데부님!"
          echo "✅ 모든 단계를 성공적으로 완료했습니다!"
```

## 다음 단계

다음 장에서는 워크플로우 문법을 자세히 배웁니다:

- YAML 문법 이해하기
- 워크플로우 이벤트 종류
- Jobs와 Steps의 관계
- 환경 변수 사용하기

## 핵심 요약

- **GitHub Actions**는 GitHub에 내장된 무료 CI/CD 도구입니다
- 워크플로우 파일은 `.github/workflows/` 폴더에 저장합니다
- YAML 형식으로 작성하며 들여쓰기가 중요합니다
- Actions 탭에서 실행 결과를 실시간으로 확인할 수 있습니다
- 공개 저장소는 무제한 무료로 사용 가능합니다
- 상태 배지로 프로젝트 상태를 한눈에 볼 수 있습니다

바데부와 함께 첫 번째 워크플로우를 만들어봤습니다! 🎊

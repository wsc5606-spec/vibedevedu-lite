# Actions 마켓플레이스

## GitHub Actions 마켓플레이스란?

GitHub Actions 마켓플레이스는 미리 만들어진 수천 개의 액션을 공유하고 사용할 수 있는 공간입니다. 바데부와 함께 유용한 액션들을 찾아봅시다!

### 마켓플레이스 접근하기

```yaml
# GitHub 마켓플레이스 접근 방법
방법_1: https://github.com/marketplace?type=actions
방법_2: GitHub 저장소 → Actions 탭 → "New workflow" → "Browse marketplace"

# 바데부: "필요한 기능은 대부분 이미 만들어져 있어요!"
```

### 액션의 구조

```yaml
# 액션 사용 기본 형식
steps:
  - name: 액션 이름
    uses: 작성자/저장소명@버전
    with:
      파라미터1: 값1
      파라미터2: 값2

# 예시
steps:
  - name: 코드 체크아웃
    uses: actions/checkout@v3
    with:
      fetch-depth: 0
```

## 필수 공식 액션들

### 1. actions/checkout - 코드 가져오기

```yaml
# 기본 사용
steps:
  - name: 코드 체크아웃
    uses: actions/checkout@v3

# 전체 히스토리 가져오기
steps:
  - name: 전체 히스토리 체크아웃
    uses: actions/checkout@v3
    with:
      fetch-depth: 0  # 모든 커밋 히스토리

# 특정 브랜치 체크아웃
steps:
  - name: develop 브랜치 체크아웃
    uses: actions/checkout@v3
    with:
      ref: develop

# 서브모듈 포함
steps:
  - name: 서브모듈 포함 체크아웃
    uses: actions/checkout@v3
    with:
      submodules: true

# 바데부의 체크아웃
- uses: actions/checkout@v3
  with:
    fetch-depth: 0
    token: ${{ secrets.GITHUB_TOKEN }}
```

### 2. actions/setup-node - Node.js 설정

```yaml
# 기본 Node.js 설정
steps:
  - name: Node.js 18 설정
    uses: actions/setup-node@v3
    with:
      node-version: '18'

# 캐싱 포함
steps:
  - name: Node.js with 캐시
    uses: actions/setup-node@v3
    with:
      node-version: '18'
      cache: 'npm'

# 여러 버전 테스트
strategy:
  matrix:
    node-version: [16, 18, 20]
steps:
  - uses: actions/setup-node@v3
    with:
      node-version: ${{ matrix.node-version }}

# 바데부의 Node 설정
- uses: actions/setup-node@v3
  with:
    node-version: '18'
    cache: 'npm'
    registry-url: 'https://registry.npmjs.org'
```

### 3. actions/setup-python - Python 설정

```yaml
# Python 설정
steps:
  - name: Python 설정
    uses: actions/setup-python@v4
    with:
      python-version: '3.11'

# pip 캐싱
steps:
  - uses: actions/setup-python@v4
    with:
      python-version: '3.11'
      cache: 'pip'

# 바데부의 Python 프로젝트
- uses: actions/setup-python@v4
  with:
    python-version: '3.11'
    cache: 'pip'
- run: pip install -r requirements.txt
```

### 4. actions/cache - 의존성 캐싱

```yaml
# npm 캐싱
steps:
  - name: npm 캐시
    uses: actions/cache@v3
    with:
      path: ~/.npm
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-

# 여러 경로 캐싱
steps:
  - name: 빌드 캐시
    uses: actions/cache@v3
    with:
      path: |
        ~/.npm
        ~/.cache
        node_modules
      key: ${{ runner.os }}-build-${{ hashFiles('**/package-lock.json') }}

# 바데부의 캐싱 전략
- uses: actions/cache@v3
  with:
    path: |
      ~/.npm
      node_modules
      .next/cache
    key: ${{ runner.os }}-nextjs-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-nextjs-
```

### 5. actions/upload-artifact & download-artifact

```yaml
# 빌드 결과 업로드
steps:
  - name: 빌드 결과 업로드
    uses: actions/upload-artifact@v3
    with:
      name: dist-files
      path: dist/
      retention-days: 7

# 빌드 결과 다운로드
steps:
  - name: 빌드 결과 다운로드
    uses: actions/download-artifact@v3
    with:
      name: dist-files
      path: dist/

# 바데부의 아티팩트 활용
# Build Job
- uses: actions/upload-artifact@v3
  with:
    name: badebu-build
    path: |
      dist/
      build/
    retention-days: 30

# Deploy Job
- uses: actions/download-artifact@v3
  with:
    name: badebu-build
```

## 인기 서드파티 액션

### 1. Docker 관련 액션

```yaml
# Docker 로그인
steps:
  - name: Docker Hub 로그인
    uses: docker/login-action@v2
    with:
      username: ${{ secrets.DOCKER_USERNAME }}
      password: ${{ secrets.DOCKER_PASSWORD }}

# Docker 이미지 빌드 및 푸시
steps:
  - name: Docker 빌드 및 푸시
    uses: docker/build-push-action@v4
    with:
      context: .
      push: true
      tags: badebu/app:latest

# 바데부의 Docker 워크플로우
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Docker 메타데이터
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: badebu/app

      - name: Docker 빌드 및 푸시
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```

### 2. 배포 액션

```yaml
# Vercel 배포
steps:
  - name: Vercel 배포
    uses: amondnet/vercel-action@v20
    with:
      vercel-token: ${{ secrets.VERCEL_TOKEN }}
      vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
      vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}

# Netlify 배포
steps:
  - name: Netlify 배포
    uses: netlify/actions/cli@master
    with:
      args: deploy --prod
    env:
      NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
      NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}

# AWS S3 배포
steps:
  - name: S3 업로드
    uses: jakejarvis/s3-sync-action@master
    with:
      args: --delete
    env:
      AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

# 바데부의 Vercel 배포
- uses: actions/checkout@v3
- uses: amondnet/vercel-action@v20
  with:
    vercel-token: ${{ secrets.VERCEL_TOKEN }}
    vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
    vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
    vercel-args: '--prod'
```

### 3. 코드 품질 액션

```yaml
# ESLint
steps:
  - name: ESLint 검사
    uses: reviewdog/action-eslint@v1
    with:
      reporter: github-pr-review
      eslint_flags: 'src/**/*.js'

# Prettier
steps:
  - name: Prettier 검사
    uses: actionsx/prettier@v2
    with:
      args: --check .

# SonarCloud
steps:
  - name: SonarCloud 분석
    uses: SonarSource/sonarcloud-github-action@master
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

# 바데부의 코드 품질 체크
- uses: reviewdog/action-eslint@v1
  with:
    reporter: github-pr-review
    eslint_flags: 'src/**/*.{js,jsx,ts,tsx}'
- uses: actionsx/prettier@v2
  with:
    args: --check "src/**/*.{js,jsx,ts,tsx,json,css}"
```

### 4. 테스트 관련 액션

```yaml
# Jest 커버리지 리포트
steps:
  - name: Jest 커버리지
    uses: artiomtr/jest-coverage-report-action@v2
    with:
      github-token: ${{ secrets.GITHUB_TOKEN }}
      threshold: 80

# Cypress E2E 테스트
steps:
  - name: Cypress 테스트
    uses: cypress-io/github-action@v5
    with:
      start: npm start
      wait-on: 'http://localhost:3000'

# 바데부의 테스트 워크플로우
- uses: artiomtr/jest-coverage-report-action@v2
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
    test-script: npm test
    threshold: 80
    annotations: all
```

### 5. 알림 액션

```yaml
# Slack 알림
steps:
  - name: Slack 알림
    uses: 8398a7/action-slack@v3
    with:
      status: ${{ job.status }}
      text: '배포가 완료되었습니다!'
      webhook_url: ${{ secrets.SLACK_WEBHOOK }}

# Discord 알림
steps:
  - name: Discord 알림
    uses: sarisia/actions-status-discord@v1
    with:
      webhook: ${{ secrets.DISCORD_WEBHOOK }}
      title: "CI/CD 완료"
      description: "빌드 및 배포 성공!"

# 바데부의 Slack 알림
- name: Slack 성공 알림
  if: success()
  uses: 8398a7/action-slack@v3
  with:
    status: custom
    custom_payload: |
      {
        text: '✅ 바데부의 배포 성공!',
        attachments: [{
          color: 'good',
          text: `배포 완료: ${process.env.AS_COMMIT}`
        }]
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}

- name: Slack 실패 알림
  if: failure()
  uses: 8398a7/action-slack@v3
  with:
    status: custom
    custom_payload: |
      {
        text: '❌ 바데부의 배포 실패',
        attachments: [{
          color: 'danger',
          text: '빌드 실패. 로그를 확인하세요.'
        }]
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

## 액션 버전 관리

```yaml
# 버전 지정 방법들
steps:
  # 특정 메이저 버전 (권장)
  - uses: actions/checkout@v3

  # 특정 마이너 버전
  - uses: actions/checkout@v3.5

  # 특정 패치 버전
  - uses: actions/checkout@v3.5.2

  # 특정 커밋 SHA (가장 안전)
  - uses: actions/checkout@8e5e7e5

  # 브랜치 (권장하지 않음)
  - uses: actions/checkout@main

# 바데부의 버전 관리 전략
- uses: actions/checkout@v3  # 안정적인 메이저 버전
- uses: actions/setup-node@v3
- uses: actions/cache@v3
```

## 실전 예제: 바데부의 액션 조합

```yaml
# .github/workflows/badebu-marketplace.yml

name: 바데부의 마켓플레이스 활용

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  ci:
    name: CI 파이프라인
    runs-on: ubuntu-latest

    steps:
      # 1. 코드 체크아웃
      - name: 코드 가져오기
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      # 2. Node.js 설정
      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      # 3. 의존성 캐싱
      - name: 의존성 캐시
        uses: actions/cache@v3
        with:
          path: |
            ~/.npm
            node_modules
          key: ${{ runner.os }}-npm-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-npm-

      # 4. 의존성 설치
      - name: 의존성 설치
        run: npm ci

      # 5. 린트 검사
      - name: ESLint 검사
        uses: reviewdog/action-eslint@v1
        with:
          reporter: github-pr-review
          eslint_flags: 'src/**/*.js'

      # 6. 코드 포맷 검사
      - name: Prettier 검사
        uses: actionsx/prettier@v2
        with:
          args: --check src/

      # 7. 테스트 및 커버리지
      - name: Jest 테스트
        uses: artiomtr/jest-coverage-report-action@v2
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          threshold: 80

      # 8. 빌드
      - name: 프로덕션 빌드
        run: npm run build

      # 9. 빌드 결과 업로드
      - name: 빌드 결과 저장
        uses: actions/upload-artifact@v3
        with:
          name: production-build
          path: dist/
          retention-days: 30

  deploy:
    name: 배포
    needs: ci
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest

    steps:
      # 빌드 결과 다운로드
      - name: 빌드 결과 가져오기
        uses: actions/download-artifact@v3
        with:
          name: production-build
          path: dist/

      # Vercel 배포
      - name: Vercel 배포
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'

      # 성공 알림
      - name: Slack 알림
        if: success()
        uses: 8398a7/action-slack@v3
        with:
          status: custom
          custom_payload: |
            {
              text: '🚀 바데부의 배포 성공!',
              attachments: [{
                color: 'good',
                text: '프로덕션 배포가 완료되었습니다.'
              }]
            }
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

## 액션 찾기 팁

```yaml
# 좋은 액션 선택 기준
체크리스트:
  - ⭐ GitHub Stars 개수 (인기도)
  - 📅 최근 업데이트 날짜 (유지보수)
  - 📖 문서화 품질
  - 🔒 보안 검증
  - 💬 이슈/PR 응답 속도
  - ✅ 사용자 리뷰

# 바데부의 추천 액션 소스
신뢰할_수_있는_소스:
  - actions/*        # GitHub 공식
  - docker/*         # Docker 공식
  - aws-actions/*    # AWS 공식
  - azure/*          # Azure 공식
  - google-github-actions/*  # Google 공식
```

## 다음 단계

다음 장에서는 환경 변수와 Secrets를 다룹니다:

- 환경 변수 사용법
- GitHub Secrets 관리
- 환경별 설정 분리
- 보안 Best Practices

## 핵심 요약

- **마켓플레이스**에서 수천 개의 미리 만들어진 액션을 사용할 수 있습니다
- **actions/checkout**, **setup-node** 등은 필수 공식 액션입니다
- **uses: 작성자/저장소@버전** 형식으로 액션을 사용합니다
- **with** 파라미터로 액션의 동작을 커스터마이징합니다
- 버전은 메이저 버전(v3)을 사용하는 것이 권장됩니다
- 신뢰할 수 있는 소스의 액션을 선택해야 합니다

바데부와 함께 Actions 마켓플레이스를 마스터했습니다! 🛍️

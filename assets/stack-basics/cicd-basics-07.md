# 환경 변수와 Secrets

## 환경 변수 이해하기

환경 변수는 워크플로우에서 사용하는 동적인 값을 저장합니다. 바데부와 함께 안전하게 환경 변수를 관리하는 방법을 배워봅시다!

### 환경 변수란?

```yaml
# 환경 변수의 역할
환경_변수:
  용도:
    - API 키 저장
    - 설정 값 관리
    - 환경별 구분 (dev, staging, prod)
    - 반복되는 값 재사용

# 바데부: "비밀번호는 절대 코드에 직접 쓰면 안 돼요!"
```

## 환경 변수 사용하기

### 워크플로우 레벨

```yaml
# 워크플로우 전체에서 사용
name: 바데부의 환경 변수
on: [push]

env:
  NODE_VERSION: '18'
  APP_NAME: 'badebu-app'
  BUILD_DIR: 'dist'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}

      - name: 빌드 정보
        run: |
          echo "앱 이름: ${{ env.APP_NAME }}"
          echo "빌드 디렉토리: ${{ env.BUILD_DIR }}"
```

### Job 레벨

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    # 이 job에서만 사용
    env:
      BUILD_ENV: 'production'
      OPTIMIZE: 'true'

    steps:
      - name: 빌드
        run: |
          echo "환경: ${{ env.BUILD_ENV }}"
          echo "최적화: ${{ env.OPTIMIZE }}"
          npm run build
```

### Step 레벨

```yaml
steps:
  - name: 배포
    # 이 step에서만 사용
    env:
      DEPLOY_TARGET: 'production'
      REGION: 'ap-northeast-2'
    run: |
      echo "배포 대상: $DEPLOY_TARGET"
      echo "리전: $REGION"
      ./deploy.sh
```

### 환경 변수 우선순위

```yaml
# 우선순위: Step > Job > Workflow
name: 환경 변수 우선순위
on: [push]

env:
  LEVEL: 'workflow'  # 1순위 (가장 낮음)

jobs:
  test:
    env:
      LEVEL: 'job'     # 2순위

    runs-on: ubuntu-latest
    steps:
      - name: Step 레벨 우선
        env:
          LEVEL: 'step'  # 3순위 (가장 높음)
        run: echo "LEVEL = $LEVEL"  # 출력: step

      - name: Job 레벨
        run: echo "LEVEL = $LEVEL"  # 출력: job
```

## GitHub Secrets

### Secrets란?

```yaml
# Secrets: 민감한 정보를 안전하게 저장
저장할_것들:
  - API 키와 토큰
  - 비밀번호
  - 인증서
  - SSH 키
  - 데이터베이스 연결 정보

주의:
  - ✅ Secrets에 저장
  - ❌ 코드에 직접 작성 (절대 금지!)
```

### Secrets 생성하기

```yaml
# GitHub 웹사이트에서 설정
단계:
  1. GitHub 저장소 이동
  2. Settings 클릭
  3. Secrets and variables → Actions
  4. New repository secret 클릭
  5. Name과 Value 입력
  6. Add secret 클릭

# 바데부의 예시 Secrets
SECRETS:
  - VERCEL_TOKEN: "abc123..."
  - DATABASE_URL: "postgresql://..."
  - SLACK_WEBHOOK: "https://hooks.slack.com/..."
  - AWS_ACCESS_KEY_ID: "AKIA..."
  - AWS_SECRET_ACCESS_KEY: "xyz789..."
```

### Secrets 사용하기

```yaml
# Secrets 접근 방법
steps:
  - name: API 배포
    env:
      # ${{ secrets.SECRET_NAME }} 형식
      API_KEY: ${{ secrets.API_KEY }}
      DATABASE_URL: ${{ secrets.DATABASE_URL }}
    run: |
      echo "API 키로 인증 중..."
      ./deploy.sh

# 바데부의 Vercel 배포
- name: Vercel 배포
  env:
    VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
    VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
    VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
  run: |
    vercel --token $VERCEL_TOKEN --prod
```

### Secrets 보안 특징

```yaml
# GitHub의 Secrets 보호 기능
보안_기능:
  - 로그에서 자동 마스킹: "***"로 표시
  - 읽기 전용: 한번 저장하면 값을 볼 수 없음
  - 암호화 저장: GitHub가 암호화하여 저장
  - 포크 제한: 포크된 저장소는 접근 불가

# 로그 예시
- name: 시크릿 사용
  env:
    TOKEN: ${{ secrets.MY_TOKEN }}
  run: echo "Token: $TOKEN"

# 실제 로그 출력:
# Token: ***
```

## 기본 환경 변수

### GitHub 제공 변수

```yaml
# GitHub가 자동으로 제공하는 변수들
steps:
  - name: GitHub 정보
    run: |
      echo "저장소: ${{ github.repository }}"
      echo "브랜치: ${{ github.ref }}"
      echo "커밋 SHA: ${{ github.sha }}"
      echo "이벤트: ${{ github.event_name }}"
      echo "작성자: ${{ github.actor }}"
      echo "워크플로우: ${{ github.workflow }}"
      echo "Job: ${{ github.job }}"
      echo "실행 번호: ${{ github.run_number }}"

# 바데부의 빌드 정보
- name: 빌드 정보 출력
  run: |
    echo "🏗️  빌드 #${{ github.run_number }}"
    echo "📦 저장소: ${{ github.repository }}"
    echo "🌿 브랜치: ${{ github.ref_name }}"
    echo "👤 작성자: ${{ github.actor }}"
    echo "📝 커밋: ${{ github.sha }}"
```

### Runner 환경 변수

```yaml
steps:
  - name: Runner 정보
    run: |
      echo "OS: ${{ runner.os }}"
      echo "아키텍처: ${{ runner.arch }}"
      echo "임시 디렉토리: ${{ runner.temp }}"
      echo "작업 디렉토리: ${{ runner.workspace }}"

# 조건부 실행
- name: Linux 전용
  if: runner.os == 'Linux'
  run: sudo apt-get update

- name: macOS 전용
  if: runner.os == 'macOS'
  run: brew update
```

## 환경별 설정 관리

### 개발/스테이징/프로덕션 분리

```yaml
# .github/workflows/deploy.yml

name: 환경별 배포

on:
  push:
    branches:
      - develop      # 개발 환경
      - staging      # 스테이징 환경
      - main         # 프로덕션 환경

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # 개발 환경
      - name: 개발 환경 배포
        if: github.ref == 'refs/heads/develop'
        env:
          ENV: 'development'
          API_URL: 'https://dev-api.badebu.com'
          DATABASE_URL: ${{ secrets.DEV_DATABASE_URL }}
        run: |
          echo "🔧 개발 환경 배포"
          npm run deploy:dev

      # 스테이징 환경
      - name: 스테이징 환경 배포
        if: github.ref == 'refs/heads/staging'
        env:
          ENV: 'staging'
          API_URL: 'https://staging-api.badebu.com'
          DATABASE_URL: ${{ secrets.STAGING_DATABASE_URL }}
        run: |
          echo "🧪 스테이징 환경 배포"
          npm run deploy:staging

      # 프로덕션 환경
      - name: 프로덕션 환경 배포
        if: github.ref == 'refs/heads/main'
        env:
          ENV: 'production'
          API_URL: 'https://api.badebu.com'
          DATABASE_URL: ${{ secrets.PROD_DATABASE_URL }}
        run: |
          echo "🚀 프로덕션 환경 배포"
          npm run deploy:prod
```

### GitHub Environments 사용

```yaml
# 환경별 세밀한 제어
jobs:
  deploy-staging:
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.badebu.com

    steps:
      - uses: actions/checkout@v3
      - name: 스테이징 배포
        env:
          API_KEY: ${{ secrets.STAGING_API_KEY }}
        run: npm run deploy

  deploy-production:
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com

    steps:
      - uses: actions/checkout@v3
      - name: 프로덕션 배포
        env:
          API_KEY: ${{ secrets.PROD_API_KEY }}
        run: npm run deploy
```

## 동적 환경 변수 생성

### GITHUB_OUTPUT 사용

```yaml
steps:
  # 환경 변수 생성
  - name: 버전 정보 생성
    id: version
    run: |
      VERSION=$(node -p "require('./package.json').version")
      BUILD_DATE=$(date +'%Y%m%d')
      echo "version=$VERSION" >> $GITHUB_OUTPUT
      echo "build_date=$BUILD_DATE" >> $GITHUB_OUTPUT

  # 생성된 변수 사용
  - name: 변수 사용
    run: |
      echo "버전: ${{ steps.version.outputs.version }}"
      echo "빌드 날짜: ${{ steps.version.outputs.build_date }}"

  # 파일명에 활용
  - name: 릴리스 파일 생성
    run: |
      VERSION=${{ steps.version.outputs.version }}
      DATE=${{ steps.version.outputs.build_date }}
      zip -r "release-${VERSION}-${DATE}.zip" dist/
```

### GITHUB_ENV 사용

```yaml
steps:
  # 환경 변수 설정
  - name: 환경 변수 설정
    run: |
      echo "DEPLOY_ENV=production" >> $GITHUB_ENV
      echo "BUILD_NUMBER=${{ github.run_number }}" >> $GITHUB_ENV

  # 다음 step에서 사용 가능
  - name: 환경 변수 사용
    run: |
      echo "배포 환경: $DEPLOY_ENV"
      echo "빌드 번호: $BUILD_NUMBER"
```

## 실전 예제: 바데부의 완전한 환경 관리

```yaml
# .github/workflows/badebu-env-complete.yml

name: 바데부의 완전한 환경 관리

on:
  push:
    branches: [main, develop]
  workflow_dispatch:
    inputs:
      environment:
        description: '배포 환경'
        required: true
        type: choice
        options:
          - development
          - staging
          - production

# 워크플로우 레벨 환경 변수
env:
  NODE_VERSION: '18'
  APP_NAME: 'badebu-app'

jobs:
  build:
    name: 빌드
    runs-on: ubuntu-latest

    # Job 레벨 환경 변수
    env:
      BUILD_DIR: 'dist'

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      # 빌드 정보 생성
      - name: 빌드 정보 생성
        id: build-info
        run: |
          VERSION=$(node -p "require('./package.json').version")
          BUILD_DATE=$(date +'%Y-%m-%d %H:%M:%S')
          COMMIT_SHORT=$(git rev-parse --short HEAD)

          echo "version=$VERSION" >> $GITHUB_OUTPUT
          echo "build_date=$BUILD_DATE" >> $GITHUB_OUTPUT
          echo "commit=$COMMIT_SHORT" >> $GITHUB_OUTPUT

          echo "📦 버전: $VERSION"
          echo "📅 날짜: $BUILD_DATE"
          echo "📝 커밋: $COMMIT_SHORT"

      # 환경 정보를 파일로 생성
      - name: 빌드 정보 파일 생성
        env:
          VERSION: ${{ steps.build-info.outputs.version }}
          BUILD_DATE: ${{ steps.build-info.outputs.build_date }}
          COMMIT: ${{ steps.build-info.outputs.commit }}
        run: |
          cat > src/build-info.json << EOF
          {
            "version": "$VERSION",
            "buildDate": "$BUILD_DATE",
            "commit": "$COMMIT",
            "buildNumber": "${{ github.run_number }}"
          }
          EOF

      - name: 의존성 설치
        run: npm ci

      - name: 빌드
        run: npm run build

      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: build-${{ steps.build-info.outputs.version }}
          path: ${{ env.BUILD_DIR }}

  deploy-dev:
    name: 개발 환경 배포
    needs: build
    if: github.ref == 'refs/heads/develop' || inputs.environment == 'development'
    runs-on: ubuntu-latest
    environment:
      name: development
      url: https://dev.badebu.com

    steps:
      - name: 빌드 결과 다운로드
        uses: actions/download-artifact@v3

      - name: 개발 환경 배포
        env:
          DEPLOY_ENV: 'development'
          API_URL: 'https://dev-api.badebu.com'
          # Secrets 사용
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          DATABASE_URL: ${{ secrets.DEV_DATABASE_URL }}
        run: |
          echo "🔧 개발 환경 배포 시작"
          echo "API URL: $API_URL"
          # 실제 배포 명령어
          echo "✅ 개발 환경 배포 완료"

  deploy-staging:
    name: 스테이징 환경 배포
    needs: build
    if: github.ref == 'refs/heads/staging' || inputs.environment == 'staging'
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.badebu.com

    steps:
      - uses: actions/download-artifact@v3

      - name: 스테이징 환경 배포
        env:
          DEPLOY_ENV: 'staging'
          API_URL: 'https://staging-api.badebu.com'
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          DATABASE_URL: ${{ secrets.STAGING_DATABASE_URL }}
        run: |
          echo "🧪 스테이징 환경 배포"
          echo "✅ 스테이징 배포 완료"

  deploy-prod:
    name: 프로덕션 환경 배포
    needs: build
    if: github.ref == 'refs/heads/main' || inputs.environment == 'production'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com

    steps:
      - uses: actions/download-artifact@v3

      - name: 프로덕션 환경 배포
        env:
          DEPLOY_ENV: 'production'
          API_URL: 'https://api.badebu.com'
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          DATABASE_URL: ${{ secrets.PROD_DATABASE_URL }}
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          echo "🚀 프로덕션 환경 배포"
          echo "✅ 프로덕션 배포 완료"

      - name: Slack 알림
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
        run: |
          curl -X POST $SLACK_WEBHOOK \
            -H 'Content-Type: application/json' \
            -d '{"text":"🎉 바데부 앱이 프로덕션에 배포되었습니다!"}'
```

## 보안 Best Practices

```yaml
# 환경 변수 보안 체크리스트
보안_수칙:
  ✅ 해야_할_것:
    - Secrets에 민감 정보 저장
    - 최소 권한 원칙 적용
    - 환경별 Secrets 분리
    - 정기적으로 키 교체
    - 로그에 민감 정보 출력 금지

  ❌ 하지_말아야_할_것:
    - 코드에 직접 키 작성
    - PR에서 프로덕션 Secrets 사용
    - Secrets를 echo로 출력
    - 공개 저장소에 민감 정보
    - 너무 많은 권한 부여

# 바데부의 안전한 Secret 사용
- name: 안전한 배포
  env:
    # ✅ Good: Secret 사용
    API_KEY: ${{ secrets.API_KEY }}
  run: |
    # ✅ Good: 값을 직접 출력하지 않음
    echo "API로 배포 중..."
    deploy.sh

    # ❌ Bad: Secret 값 출력 금지!
    # echo "API Key: $API_KEY"
```

## 다음 단계

다음 장에서는 매트릭스 빌드를 배웁니다:

- 여러 버전 동시 테스트
- 크로스 플랫폼 빌드
- 매트릭스 전략 최적화

## 핵심 요약

- **환경 변수**는 워크플로우에서 동적 값을 관리합니다
- **Secrets**로 민감한 정보를 안전하게 저장합니다
- 환경 변수는 Workflow, Job, Step 레벨에서 정의 가능합니다
- **${{ secrets.NAME }}** 형식으로 Secrets에 접근합니다
- GitHub는 로그에서 Secrets를 자동으로 마스킹합니다
- 환경별(dev, staging, prod) 설정을 분리해야 합니다

바데부와 함께 안전한 환경 관리를 마스터했습니다! 🔐

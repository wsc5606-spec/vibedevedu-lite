# 모범 사례와 보안

## CI/CD 모범 사례

CI/CD를 효과적으로 활용하기 위한 모범 사례를 바데부와 함께 배워봅시다!

### 워크플로우 구성 원칙

```yaml
# 좋은 워크플로우의 특징
모범_사례:
  1. 명확성:
    - 의미 있는 이름 사용
    - 주석으로 설명 추가
    - 단계별 명확한 이름

  2. 효율성:
    - 캐싱 활용
    - 병렬 실행
    - 불필요한 작업 제거

  3. 안전성:
    - Secrets 사용
    - 권한 최소화
    - 테스트 필수

  4. 유지보수성:
    - 재사용 가능한 구조
    - 환경별 분리
    - 문서화

# 바데부: "처음부터 잘 만들면 나중이 편해요!"
```

## 워크플로우 최적화

### 1. 캐싱 전략

```yaml
# 효과적인 캐싱
name: 최적화된 빌드

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # Node.js 캐싱
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      # 추가 캐싱
      - name: 의존성 캐시
        uses: actions/cache@v3
        with:
          path: |
            ~/.npm
            node_modules
            .next/cache
          key: ${{ runner.os }}-build-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-build-
            ${{ runner.os }}-

      - name: 빌드
        run: npm ci && npm run build

# 바데부: "캐싱으로 빌드 시간 50% 단축!"
```

### 2. 조건부 실행

```yaml
# 필요한 것만 실행
jobs:
  # 빠른 체크 (항상 실행)
  quick-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm run lint

  # 전체 테스트 (메인 브랜치만)
  full-test:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test

  # E2E 테스트 (특정 파일 변경 시만)
  e2e:
    if: contains(github.event.head_commit.message, '[e2e]')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm run test:e2e

# 바데부: "불필요한 작업은 건너뛰기!"
```

### 3. 병렬 실행

```yaml
# 병렬로 빠르게
jobs:
  # 이 3개는 동시에 실행
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test

  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm run build

  # 위 3개가 모두 성공하면 배포
  deploy:
    needs: [lint, test, build]
    runs-on: ubuntu-latest
    steps:
      - run: npm run deploy

# 바데부: "병렬 실행으로 시간 절약!"
```

## 보안 모범 사례

### 1. Secrets 안전하게 관리

```yaml
# ✅ 올바른 Secrets 사용
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      # Good: Secrets를 환경 변수로
      - name: 안전한 배포
        env:
          API_KEY: ${{ secrets.API_KEY }}
          DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
        run: |
          echo "배포 중..."
          ./deploy.sh
          # ✅ 변수를 직접 출력하지 않음

# ❌ 피해야 할 패턴
bad_example:
  steps:
    - name: 위험한 사용
      run: |
        # ❌ Secret을 직접 출력
        echo "API Key: ${{ secrets.API_KEY }}"

        # ❌ Secret을 파일에 저장
        echo "${{ secrets.API_KEY }}" > api_key.txt

        # ❌ Secret을 URL에 포함
        curl https://api.com?key=${{ secrets.API_KEY }}
```

### 2. 최소 권한 원칙

```yaml
# 필요한 권한만 부여
name: 최소 권한 워크플로우

on: [push]

# 기본 권한 제한
permissions:
  contents: read  # 코드만 읽기

jobs:
  build:
    runs-on: ubuntu-latest

    # 이 job은 쓰기 권한 필요
    permissions:
      contents: read
      packages: write  # 패키지 배포용

    steps:
      - uses: actions/checkout@v3
      - run: npm run build

  release:
    runs-on: ubuntu-latest

    permissions:
      contents: write  # 릴리스 생성용
      issues: write    # 이슈 작성용

    steps:
      - uses: actions/checkout@v3
      - run: gh release create v1.0.0

# 바데부: "필요한 만큼만 권한을 주세요!"
```

### 3. 의존성 보안 검사

```yaml
# 보안 취약점 자동 검사
name: 보안 검사

on:
  push:
  schedule:
    - cron: '0 0 * * *'  # 매일 자동 검사

jobs:
  security:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # npm 취약점 검사
      - name: npm audit
        run: |
          npm audit --audit-level=moderate
          npm audit fix --dry-run

      # 의존성 보안 스캔
      - name: Dependency Review
        uses: actions/dependency-review-action@v3

      # CodeQL 보안 분석
      - name: CodeQL 분석
        uses: github/codeql-action/analyze@v2

# 바데부: "보안은 자동으로 체크!"
```

### 4. 포크된 PR 보안

```yaml
# 외부 기여자의 PR 안전하게 처리
name: PR 검사

on:
  pull_request_target:  # pull_request 대신 사용

jobs:
  test:
    runs-on: ubuntu-latest

    # 포크에서는 Secrets 접근 금지
    if: github.event.pull_request.head.repo.full_name == github.repository

    steps:
      - uses: actions/checkout@v3
        with:
          ref: ${{ github.event.pull_request.head.sha }}

      - name: 테스트
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: npm test

# 바데부: "외부 PR에서는 Secrets를 보호!"
```

## 코드 재사용

### 1. Composite Actions

```yaml
# .github/actions/setup-node-app/action.yml

name: 'Node.js 앱 설정'
description: 'Node.js 설치 및 의존성 캐싱'

inputs:
  node-version:
    description: 'Node.js 버전'
    required: true
    default: '18'

runs:
  using: 'composite'
  steps:
    - name: Node.js 설정
      uses: actions/setup-node@v3
      with:
        node-version: ${{ inputs.node-version }}
        cache: 'npm'

    - name: 의존성 캐시
      uses: actions/cache@v3
      with:
        path: |
          ~/.npm
          node_modules
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

    - name: 의존성 설치
      run: npm ci
      shell: bash

# 사용하기
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: ./.github/actions/setup-node-app
        with:
          node-version: '18'
      - run: npm run build

# 바데부: "반복되는 설정을 재사용!"
```

### 2. Reusable Workflows

```yaml
# .github/workflows/reusable-deploy.yml

name: 재사용 가능한 배포

on:
  workflow_call:
    inputs:
      environment:
        required: true
        type: string
      url:
        required: true
        type: string
    secrets:
      deploy-token:
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: ${{ inputs.environment }}
      url: ${{ inputs.url }}

    steps:
      - uses: actions/checkout@v3
      - run: npm ci && npm run build
      - name: 배포
        env:
          DEPLOY_TOKEN: ${{ secrets.deploy-token }}
        run: ./deploy.sh

# 사용하기
# .github/workflows/main.yml
jobs:
  deploy-staging:
    uses: ./.github/workflows/reusable-deploy.yml
    with:
      environment: staging
      url: https://staging.badebu.com
    secrets:
      deploy-token: ${{ secrets.STAGING_TOKEN }}

  deploy-prod:
    uses: ./.github/workflows/reusable-deploy.yml
    with:
      environment: production
      url: https://badebu.com
    secrets:
      deploy-token: ${{ secrets.PROD_TOKEN }}
```

## 모니터링과 알림

### 1. 상태 배지

```markdown
# README.md에 추가

# 바데부의 프로젝트

![CI](https://github.com/badebu/app/workflows/CI/badge.svg)
![Deploy](https://github.com/badebu/app/workflows/Deploy/badge.svg)
![Security](https://github.com/badebu/app/workflows/Security/badge.svg)

- ✅ CI: 모든 테스트 통과
- ✅ Deploy: 최신 버전 배포됨
- ✅ Security: 취약점 없음
```

### 2. Slack 통합

```yaml
# 상세한 Slack 알림
jobs:
  notify:
    runs-on: ubuntu-latest
    if: always()

    steps:
      - name: Slack 알림
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: |
            워크플로우: ${{ github.workflow }}
            이벤트: ${{ github.event_name }}
            브랜치: ${{ github.ref }}
            커밋: ${{ github.sha }}
            작성자: ${{ github.actor }}
          fields: |
            [
              {
                "title": "Repository",
                "value": "${{ github.repository }}",
                "short": true
              },
              {
                "title": "Duration",
                "value": "${{ job.status == 'success' && '✅ Success' || '❌ Failed' }}",
                "short": true
              }
            ]
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

### 3. 이메일 알림

```yaml
# 실패 시 이메일 알림
jobs:
  notify-failure:
    if: failure()
    runs-on: ubuntu-latest

    steps:
      - name: 이메일 발송
        uses: dawidd6/action-send-mail@v3
        with:
          server_address: smtp.gmail.com
          server_port: 465
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: '[CI/CD] 빌드 실패 알림'
          to: team@badebu.com
          from: ci-cd@badebu.com
          body: |
            워크플로우가 실패했습니다.

            저장소: ${{ github.repository }}
            브랜치: ${{ github.ref }}
            커밋: ${{ github.sha }}
            작성자: ${{ github.actor }}

            로그: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

## 트러블슈팅

### 1. 디버깅 팁

```yaml
# 디버그 정보 출력
jobs:
  debug:
    runs-on: ubuntu-latest

    steps:
      # GitHub 컨텍스트 전체 출력
      - name: GitHub 컨텍스트
        run: echo '${{ toJSON(github) }}'

      # 환경 변수 출력
      - name: 환경 변수
        run: env | sort

      # 파일 시스템 확인
      - name: 파일 확인
        run: |
          pwd
          ls -la
          df -h

      # 네트워크 확인
      - name: 네트워크 테스트
        run: |
          ping -c 3 github.com
          curl -I https://api.github.com

# 바데부: "문제를 빠르게 찾아요!"
```

### 2. 로그 레벨 조정

```yaml
# 상세한 로그
jobs:
  verbose:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      # npm 상세 로그
      - name: npm 상세 로그
        run: npm install --loglevel verbose

      # 디버그 모드
      - name: 디버그 실행
        run: DEBUG=* npm test

      # GitHub Actions 디버그
      - name: Actions 디버그
        env:
          ACTIONS_STEP_DEBUG: true
          ACTIONS_RUNNER_DEBUG: true
        run: npm run build
```

### 3. 실패 시 정보 수집

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm test

      # 실패 시 로그 업로드
      - name: 로그 수집
        if: failure()
        run: |
          mkdir -p logs
          cp -r ~/.npm/_logs logs/npm
          cp -r coverage logs/

      - name: 로그 업로드
        if: failure()
        uses: actions/upload-artifact@v3
        with:
          name: failure-logs
          path: logs/

# 바데부: "실패해도 정보를 남겨요!"
```

## 실전 체크리스트

```yaml
# 바데부의 CI/CD 체크리스트

배포_전_확인:
  코드_품질:
    - ✅ 린트 검사 통과
    - ✅ 코드 포맷 확인
    - ✅ 타입 체크 (TypeScript)

  테스트:
    - ✅ 단위 테스트 통과
    - ✅ 통합 테스트 통과
    - ✅ E2E 테스트 통과
    - ✅ 테스트 커버리지 80% 이상

  보안:
    - ✅ 의존성 취약점 없음
    - ✅ Secrets 안전하게 관리
    - ✅ 코드 보안 스캔 통과

  빌드:
    - ✅ 빌드 성공
    - ✅ 빌드 크기 확인
    - ✅ 환경 변수 설정

  배포:
    - ✅ 스테이징 배포 성공
    - ✅ 헬스 체크 통과
    - ✅ Smoke 테스트 완료
    - ✅ 롤백 준비됨

  모니터링:
    - ✅ 알림 설정
    - ✅ 로그 수집
    - ✅ 메트릭 모니터링
```

## 마무리: 바데부의 완전한 워크플로우

```yaml
# .github/workflows/badebu-production-ready.yml

name: 바데부의 프로덕션 레디 워크플로우

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

# 최소 권한
permissions:
  contents: read

jobs:
  # Stage 1: 코드 품질
  quality:
    name: 코드 품질 검사
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정 (캐싱 포함)
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 린트
        run: npm run lint

      - name: 포맷 검사
        run: npm run format:check

      - name: 타입 체크
        run: npm run type-check

  # Stage 2: 보안
  security:
    name: 보안 검사
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - uses: actions/checkout@v3

      - name: 의존성 취약점
        run: npm audit --audit-level=moderate

      - name: CodeQL 분석
        uses: github/codeql-action/analyze@v2

  # Stage 3: 테스트
  test:
    name: 테스트
    runs-on: ubuntu-latest
    timeout-minutes: 15

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      - name: 단위 테스트
        run: npm run test:unit

      - name: 통합 테스트
        run: npm run test:integration

      - name: 커버리지 업로드
        uses: actions/upload-artifact@v3
        with:
          name: coverage
          path: coverage/

  # Stage 4: 빌드
  build:
    name: 빌드
    needs: [quality, security, test]
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      - name: 프로덕션 빌드
        run: npm run build

      - name: 빌드 크기 확인
        run: |
          SIZE=$(du -sh dist | cut -f1)
          echo "📦 빌드 크기: $SIZE"

      - uses: actions/upload-artifact@v3
        with:
          name: build
          path: dist/

  # Stage 5: 배포 (메인 브랜치만)
  deploy:
    name: 배포
    needs: build
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com

    permissions:
      contents: read
      deployments: write

    steps:
      - uses: actions/download-artifact@v3
        with:
          name: build
          path: dist/

      - name: 배포
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
        run: |
          echo "🚀 프로덕션 배포"
          # 실제 배포 명령어

      - name: 헬스 체크
        run: curl -f https://badebu.com/health

      - name: 성공 알림
        if: success()
        uses: 8398a7/action-slack@v3
        with:
          status: success
          text: '🎉 배포 성공!'
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}

      - name: 실패 알림
        if: failure()
        uses: 8398a7/action-slack@v3
        with:
          status: failure
          text: '❌ 배포 실패!'
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

## 학습 완료!

축하합니다! 바데부와 함께 CI/CD의 모든 것을 배웠습니다! 🎉

### 배운 내용 정리

```yaml
학습_내용:
  기초:
    - CI/CD 개념과 필요성
    - GitHub Actions 시작하기
    - 워크플로우 기본 문법

  중급:
    - Jobs와 Steps 활용
    - 이벤트와 트리거
    - Actions 마켓플레이스

  고급:
    - 환경 변수와 Secrets
    - 매트릭스 빌드
    - 배포 자동화

  전문가:
    - 모범 사례
    - 보안 강화
    - 트러블슈팅

바데부: "이제 여러분도 CI/CD 전문가!"
```

## 핵심 요약

- **캐싱과 병렬 실행**으로 워크플로우를 최적화합니다
- **최소 권한 원칙**으로 보안을 강화합니다
- **Secrets를 안전하게** 관리하고 절대 노출하지 않습니다
- **재사용 가능한 구조**로 유지보수를 쉽게 합니다
- **모니터링과 알림**으로 문제를 빠르게 감지합니다
- **체크리스트**로 배포 전 모든 것을 확인합니다

바데부와 함께한 CI/CD 여정이 완료되었습니다! 이제 실전 프로젝트에 적용해보세요! 🚀

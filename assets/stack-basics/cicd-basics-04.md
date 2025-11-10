# Jobs와 Steps

## Jobs 깊이 알아보기

Jobs는 워크플로우의 핵심 실행 단위입니다. 바데부와 함께 Jobs를 완벽하게 이해해봅시다!

### Job의 기본 구조

```yaml
jobs:
  job-id:                    # Job 식별자 (고유해야 함)
    name: 표시될 이름         # 선택사항
    runs-on: ubuntu-latest   # 필수: 실행 환경
    needs: [이전-job]        # 선택사항: 의존성
    if: 조건                 # 선택사항: 실행 조건
    timeout-minutes: 30      # 선택사항: 타임아웃
    env:                     # 선택사항: 환경 변수
      KEY: value
    steps: []                # 필수: 실행 단계들
```

### 실용적인 예제

```yaml
# 바데부의 프론트엔드 CI
jobs:
  install:
    name: 의존성 설치
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci

  lint:
    name: 코드 린트
    needs: install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm run lint

  test:
    name: 테스트
    needs: install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm test
```

## Job 의존성 관리

### needs: 순차 실행

```yaml
# 순차적으로 실행되는 파이프라인
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

  test:
    needs: build  # build가 끝나야 시작
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  deploy:
    needs: test   # test가 끝나야 시작
    runs-on: ubuntu-latest
    steps:
      - run: npm run deploy

# 실행 순서: build → test → deploy
```

### 여러 Job에 의존

```yaml
# 여러 Job이 완료되어야 실행
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  security:
    runs-on: ubuntu-latest
    steps:
      - run: npm audit

  deploy:
    needs: [lint, test, security]  # 3개 모두 성공해야 배포
    runs-on: ubuntu-latest
    steps:
      - run: npm run deploy
```

### 병렬 실행

```yaml
# 동시에 실행되는 Jobs
jobs:
  # 이 3개는 동시에 실행됨
  frontend-test:
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  backend-test:
    runs-on: ubuntu-latest
    steps:
      - run: pytest

  integration-test:
    runs-on: ubuntu-latest
    steps:
      - run: npm run test:integration

# 바데부: "병렬 실행으로 시간 절약!"
```

## Artifacts: Job 간 데이터 공유

### Artifact란?

```yaml
# Artifact: 빌드 결과물, 테스트 보고서 등을 저장하고 공유
빌드_Job → 빌드_결과_업로드 → Artifact 저장
배포_Job → Artifact 다운로드 → 배포_실행

# 바데부: "Job 간에 파일을 주고받을 수 있어요!"
```

### 업로드 예제

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 빌드
        run: npm run build

      # 빌드 결과 업로드
      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: build-output      # Artifact 이름
          path: dist/             # 업로드할 경로
          retention-days: 7       # 보관 기간 (일)
```

### 다운로드 예제

```yaml
jobs:
  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      # 빌드 결과 다운로드
      - name: 빌드 결과 다운로드
        uses: actions/download-artifact@v3
        with:
          name: build-output      # Artifact 이름
          path: dist/             # 다운로드할 경로

      - name: 배포
        run: |
          ls -la dist/
          echo "빌드 결과를 사용하여 배포!"
```

### 여러 파일 업로드

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm test

      # 여러 Artifact 업로드
      - name: 테스트 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: |
            coverage/
            test-report.xml
            junit.xml

      - name: 로그 업로드
        if: failure()  # 실패 시에만
        uses: actions/upload-artifact@v3
        with:
          name: failure-logs
          path: logs/
```

## Steps 완벽 가이드

### Step의 구조

```yaml
steps:
  - name: 단계 이름              # 선택사항 (하지만 권장)
    id: step-id                 # 선택사항: 다른 step에서 참조
    uses: action/name@version   # 액션 사용 시
    run: 명령어                 # 명령어 실행 시
    with:                       # 액션 파라미터
      key: value
    env:                        # 환경 변수
      KEY: value
    if: 조건                    # 조건부 실행
    continue-on-error: true     # 실패해도 계속
    timeout-minutes: 10         # 타임아웃
```

### 명령어 실행 (run)

```yaml
steps:
  # 단일 명령어
  - name: 간단한 명령어
    run: echo "Hello, 바데부!"

  # 여러 줄 명령어
  - name: 여러 명령어
    run: |
      echo "첫 번째 명령어"
      echo "두 번째 명령어"
      npm install
      npm test

  # 명령어 체이닝
  - name: 체인 명령어
    run: npm install && npm test && npm run build

  # 쉘 지정
  - name: Bash 사용
    shell: bash
    run: |
      #!/bin/bash
      echo "Bash 스크립트"
      ls -la

  # 작업 디렉토리 지정
  - name: 특정 폴더에서 실행
    working-directory: ./frontend
    run: npm test
```

### 액션 사용 (uses)

```yaml
steps:
  # GitHub 공식 액션
  - name: 코드 체크아웃
    uses: actions/checkout@v3
    with:
      fetch-depth: 0  # 전체 히스토리

  # Node.js 설정
  - name: Node.js 설정
    uses: actions/setup-node@v3
    with:
      node-version: '18'
      cache: 'npm'

  # Python 설정
  - name: Python 설정
    uses: actions/setup-python@v4
    with:
      python-version: '3.11'

  # Docker 빌드
  - name: Docker 빌드 및 푸시
    uses: docker/build-push-action@v4
    with:
      context: .
      push: true
      tags: badebu/app:latest
```

### Step 출력 사용하기

```yaml
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      # Step 1: 출력 생성
      - name: 버전 정보 생성
        id: version
        run: |
          echo "version=1.2.3" >> $GITHUB_OUTPUT
          echo "build_date=$(date +'%Y%m%d')" >> $GITHUB_OUTPUT

      # Step 2: 이전 step 출력 사용
      - name: 버전 정보 사용
        run: |
          echo "버전: ${{ steps.version.outputs.version }}"
          echo "빌드 날짜: ${{ steps.version.outputs.build_date }}"

      # Step 3: 출력을 파일명에 사용
      - name: 파일 생성
        run: |
          touch release-${{ steps.version.outputs.version }}.zip
```

## 조건부 실행

### 기본 조건문

```yaml
steps:
  # 메인 브랜치에서만 실행
  - name: 프로덕션 배포
    if: github.ref == 'refs/heads/main'
    run: npm run deploy:prod

  # PR에서만 실행
  - name: PR 체크
    if: github.event_name == 'pull_request'
    run: npm run check:pr

  # 특정 OS에서만 실행
  - name: macOS 전용 작업
    if: runner.os == 'macOS'
    run: brew install something
```

### 상태 기반 조건

```yaml
steps:
  - name: 테스트
    id: test
    run: npm test

  # 성공 시에만 실행
  - name: 성공 알림
    if: success()
    run: echo "✅ 테스트 성공!"

  # 실패 시에만 실행
  - name: 실패 알림
    if: failure()
    run: echo "❌ 테스트 실패!"

  # 항상 실행 (정리 작업용)
  - name: 정리
    if: always()
    run: rm -rf temp/

  # 취소 시 실행
  - name: 취소 처리
    if: cancelled()
    run: echo "작업이 취소되었습니다"
```

### 복잡한 조건

```yaml
steps:
  # AND 조건
  - name: 메인 브랜치이면서 성공한 경우
    if: github.ref == 'refs/heads/main' && success()
    run: npm run deploy

  # OR 조건
  - name: 메인 또는 develop 브랜치
    if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/develop'
    run: npm run deploy:staging

  # NOT 조건
  - name: PR이 아닌 경우
    if: github.event_name != 'pull_request'
    run: npm run full-test

  # 복합 조건
  - name: 복잡한 조건
    if: |
      github.event_name == 'push' &&
      github.ref == 'refs/heads/main' &&
      !contains(github.event.head_commit.message, '[skip ci]')
    run: npm run deploy
```

## 실전 예제: 바데부의 멀티 스테이지 파이프라인

```yaml
# .github/workflows/badebu-multi-stage.yml

name: 바데부의 멀티 스테이지 파이프라인

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  # Stage 1: 준비 단계
  setup:
    name: 환경 설정 및 의존성 설치
    runs-on: ubuntu-latest
    steps:
      - name: 코드 체크아웃
        uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: node_modules 캐시
        uses: actions/cache@v3
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

  # Stage 2: 코드 품질 검사 (병렬)
  lint:
    name: 코드 린트 검사
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - name: ESLint 실행
        run: npm run lint

  format:
    name: 코드 포맷 검사
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - name: Prettier 검사
        run: npm run format:check

  # Stage 3: 테스트 (병렬)
  unit-test:
    name: 단위 테스트
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - name: 단위 테스트 실행
        run: npm run test:unit
      - name: 커버리지 업로드
        uses: actions/upload-artifact@v3
        with:
          name: unit-test-coverage
          path: coverage/unit/

  integration-test:
    name: 통합 테스트
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - name: 통합 테스트 실행
        run: npm run test:integration
      - name: 결과 업로드
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: integration-test-results
          path: test-results/

  # Stage 4: 빌드
  build:
    name: 프로덕션 빌드
    needs: [lint, format, unit-test, integration-test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci

      - name: 빌드 실행
        run: npm run build

      - name: 빌드 크기 확인
        id: build-size
        run: |
          SIZE=$(du -sh dist | cut -f1)
          echo "size=$SIZE" >> $GITHUB_OUTPUT
          echo "📦 빌드 크기: $SIZE"

      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: production-build
          path: dist/
          retention-days: 30

  # Stage 5: 배포 (조건부)
  deploy-staging:
    name: 스테이징 배포
    needs: build
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    environment:
      name: staging
      url: https://staging.badebu.com
    steps:
      - name: 빌드 결과 다운로드
        uses: actions/download-artifact@v3
        with:
          name: production-build
          path: dist/

      - name: 스테이징 배포
        run: |
          echo "🚀 스테이징 배포 중..."
          # 실제 배포 명령어
          echo "✅ 스테이징 배포 완료!"

  deploy-production:
    name: 프로덕션 배포
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    environment:
      name: production
      url: https://badebu.com
    steps:
      - name: 빌드 결과 다운로드
        uses: actions/download-artifact@v3
        with:
          name: production-build
          path: dist/

      - name: 프로덕션 배포
        run: |
          echo "🚀 프로덕션 배포 중..."
          # 실제 배포 명령어
          echo "✅ 프로덕션 배포 완료!"

      - name: Slack 알림
        if: success()
        run: |
          echo "📢 Slack으로 배포 완료 알림 전송"
```

## 다음 단계

다음 장에서는 이벤트와 트리거를 자세히 배웁니다:

- push, pull_request 이벤트 활용
- 경로 필터링
- 브랜치 패턴 매칭
- webhook 이벤트 처리

## 핵심 요약

- **Jobs**는 병렬 또는 순차적으로 실행됩니다
- **needs**로 Job 간 의존성을 정의합니다
- **Artifacts**로 Job 간에 파일을 공유합니다
- **Steps**는 run(명령어) 또는 uses(액션)로 작업을 수행합니다
- **if** 조건으로 특정 상황에서만 실행할 수 있습니다
- Step 출력을 다른 Step에서 재사용할 수 있습니다

바데부와 함께 Jobs와 Steps를 완벽히 이해했습니다! 🎯

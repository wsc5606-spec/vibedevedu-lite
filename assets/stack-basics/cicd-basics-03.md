# 워크플로우 기본 (Workflow Syntax)

## 워크플로우 구조 이해하기

워크플로우는 자동화된 프로세스를 정의하는 YAML 파일입니다. 바데부와 함께 각 요소를 자세히 알아봅시다!

### 기본 구조

```yaml
# 워크플로우의 4가지 핵심 요소

name: 워크플로우 이름       # 1. 이름 정의
on: [이벤트]              # 2. 언제 실행할지
jobs:                    # 3. 무엇을 할지
  작업이름:
    runs-on: 환경         # 4. 어디서 실행할지
    steps:               # 5. 어떻게 할지
      - name: 단계명
        run: 명령어
```

### 완전한 예제

```yaml
# .github/workflows/complete-example.yml

name: 바데부의 완전한 워크플로우

# 트리거 이벤트
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * *'  # 매일 자정

# 작업 정의
jobs:
  build:
    name: 빌드 및 테스트
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - name: 코드 체크아웃
        uses: actions/checkout@v3

      - name: 환경 설정
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: 빌드
        run: npm run build

      - name: 테스트
        run: npm test
```

## name: 워크플로우 이름

```yaml
# 워크플로우 이름 지정

# 명확하고 설명적인 이름
name: 프론트엔드 CI/CD

# 이모지로 시각적 구분
name: 🚀 배포 파이프라인

# 바데부의 스타일
name: 바데부의 자동화 워크플로우

# Actions 탭에서 이 이름으로 표시됨
```

## on: 이벤트 트리거

### 1. Push 이벤트

```yaml
# 특정 브랜치에 푸시할 때
on:
  push:
    branches:
      - main
      - develop
      - 'release/**'  # release/로 시작하는 모든 브랜치

# 특정 브랜치 제외
on:
  push:
    branches-ignore:
      - 'docs/**'

# 특정 경로의 파일이 변경될 때만
on:
  push:
    paths:
      - 'src/**'
      - 'package.json'

# 특정 경로 제외
on:
  push:
    paths-ignore:
      - 'docs/**'
      - '**.md'
```

### 2. Pull Request 이벤트

```yaml
# PR이 열리거나 업데이트될 때
on:
  pull_request:
    branches: [main]
    types:
      - opened       # PR 생성
      - synchronize  # PR 업데이트
      - reopened     # PR 재오픈

# 바데부의 PR 체크 워크플로우
on:
  pull_request:
    types: [opened, synchronize]
    paths:
      - 'src/**'
      - 'tests/**'
```

### 3. 스케줄 이벤트

```yaml
# Cron 문법으로 정기 실행
on:
  schedule:
    # 매일 오전 9시 (UTC 기준)
    - cron: '0 9 * * *'

    # 매주 월요일 오전 10시
    - cron: '0 10 * * 1'

    # 매월 1일 자정
    - cron: '0 0 1 * *'

# 바데부의 일일 백업
name: 바데부의 일일 백업
on:
  schedule:
    - cron: '0 0 * * *'  # 매일 자정

# Cron 문법: 분 시 일 월 요일
# *  *  *  *  *
# │  │  │  │  │
# │  │  │  │  └─ 요일 (0-6, 0=일요일)
# │  │  │  └──── 월 (1-12)
# │  │  └─────── 일 (1-31)
# │  └────────── 시 (0-23)
# └───────────── 분 (0-59)
```

### 4. 수동 트리거

```yaml
# workflow_dispatch로 수동 실행
on:
  workflow_dispatch:
    inputs:
      environment:
        description: '배포 환경'
        required: true
        default: 'staging'
        type: choice
        options:
          - development
          - staging
          - production

      debug:
        description: '디버그 모드'
        required: false
        type: boolean

# 사용 예제
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: 환경 출력
        run: echo "배포 환경: ${{ inputs.environment }}"

      - name: 디버그 모드 확인
        if: inputs.debug == true
        run: echo "디버그 모드 활성화"
```

### 5. 여러 이벤트 조합

```yaml
# 여러 트리거 동시 사용
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * *'
  workflow_dispatch:

# 바데부의 유연한 워크플로우
name: 바데부의 유연한 CI

on:
  # 코드 푸시 시
  push:
    branches: [main, develop]

  # PR 생성 시
  pull_request:

  # 매일 오전 9시 자동 실행
  schedule:
    - cron: '0 9 * * *'

  # 필요할 때 수동 실행
  workflow_dispatch:
```

## jobs: 작업 정의

### 기본 Job 구조

```yaml
jobs:
  # Job ID (고유 식별자)
  build:
    # Job 이름 (UI에 표시)
    name: 빌드 작업

    # 실행 환경
    runs-on: ubuntu-latest

    # 실행 단계들
    steps:
      - name: 첫 번째 단계
        run: echo "Hello"
```

### runs-on: 실행 환경

```yaml
# 사용 가능한 환경들
jobs:
  ubuntu_job:
    runs-on: ubuntu-latest     # Ubuntu (가장 많이 사용)

  windows_job:
    runs-on: windows-latest    # Windows

  macos_job:
    runs-on: macos-latest      # macOS

  specific_version:
    runs-on: ubuntu-20.04      # 특정 버전

# 바데부의 크로스 플랫폼 테스트
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    runs-on: ${{ matrix.os }}
```

### 여러 Job 정의

```yaml
# 순차적으로 실행되는 Jobs
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - run: npm test

  build:
    needs: test  # test가 성공해야 실행
    runs-on: ubuntu-latest
    steps:
      - run: npm run build

  deploy:
    needs: build  # build가 성공해야 실행
    runs-on: ubuntu-latest
    steps:
      - run: npm run deploy
```

### 병렬 실행

```yaml
# 동시에 실행되는 Jobs
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

# 세 작업이 동시에 실행됨!
```

## steps: 실행 단계

### run: 명령어 실행

```yaml
steps:
  # 단일 명령어
  - name: 간단한 명령어
    run: echo "Hello, 바데부!"

  # 여러 명령어 (파이프라인)
  - name: 여러 명령어
    run: |
      echo "첫 번째 명령어"
      echo "두 번째 명령어"
      npm install
      npm test

  # 작업 디렉토리 지정
  - name: 특정 폴더에서 실행
    run: npm test
    working-directory: ./frontend
```

### uses: 액션 사용

```yaml
steps:
  # GitHub 공식 액션
  - name: 코드 체크아웃
    uses: actions/checkout@v3

  # 버전 지정
  - name: Node.js 설정
    uses: actions/setup-node@v3
    with:
      node-version: '18'

  # 서드파티 액션
  - name: Slack 알림
    uses: 8398a7/action-slack@v3
    with:
      status: ${{ job.status }}
```

### with: 파라미터 전달

```yaml
steps:
  - name: Node.js 설정
    uses: actions/setup-node@v3
    with:
      node-version: '18'
      cache: 'npm'
      cache-dependency-path: './package-lock.json'

  - name: 캐시 설정
    uses: actions/cache@v3
    with:
      path: |
        ~/.npm
        ./node_modules
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-
```

## 조건부 실행

### if: 조건 지정

```yaml
steps:
  # 특정 브랜치에서만 실행
  - name: 프로덕션 배포
    if: github.ref == 'refs/heads/main'
    run: npm run deploy

  # PR에서만 실행
  - name: PR 체크
    if: github.event_name == 'pull_request'
    run: npm run pr-check

  # 실패 시에만 실행
  - name: 에러 알림
    if: failure()
    run: echo "작업 실패!"

  # 성공 시에만 실행
  - name: 성공 알림
    if: success()
    run: echo "작업 성공!"

  # 항상 실행
  - name: 정리 작업
    if: always()
    run: echo "항상 실행됨"
```

## 타임아웃 설정

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 30  # 30분 후 자동 취소

    steps:
      - name: 긴 작업
        run: npm run build
        timeout-minutes: 10  # 이 단계만 10분 제한
```

## 실전 예제: 바데부의 완전한 워크플로우

```yaml
# .github/workflows/badebu-complete.yml

name: 바데부의 완전한 CI/CD

on:
  push:
    branches: [main, develop]
    paths-ignore:
      - 'docs/**'
      - '**.md'
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      deploy:
        description: '배포 실행 여부'
        required: true
        type: boolean

env:
  NODE_VERSION: '18'

jobs:
  # Job 1: 코드 검사
  lint:
    name: 코드 린트 검사
    runs-on: ubuntu-latest
    timeout-minutes: 5

    steps:
      - name: 코드 체크아웃
        uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: ESLint 실행
        run: npm run lint

  # Job 2: 테스트
  test:
    name: 단위 테스트
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 테스트 실행
        run: npm test -- --coverage

      - name: 테스트 결과 업로드
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: coverage/

  # Job 3: 빌드
  build:
    name: 프로덕션 빌드
    needs: [lint, test]
    runs-on: ubuntu-latest
    timeout-minutes: 15

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 빌드
        run: npm run build

      - name: 빌드 결과 업로드
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: dist/

  # Job 4: 배포
  deploy:
    name: 배포
    needs: build
    if: github.ref == 'refs/heads/main' && (github.event_name == 'push' || inputs.deploy == true)
    runs-on: ubuntu-latest

    steps:
      - name: 빌드 결과 다운로드
        uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/

      - name: 배포 실행
        run: |
          echo "🚀 배포 중..."
          echo "✅ 배포 완료!"
```

## 다음 단계

다음 장에서는 Jobs와 Steps를 더 깊이 다룹니다:

- Job 간 데이터 공유
- Artifacts 활용
- Job 의존성 관리
- 병렬 실행 최적화

## 핵심 요약

- 워크플로우는 **name, on, jobs**로 구성됩니다
- **on**으로 트리거 이벤트를 정의합니다 (push, PR, schedule 등)
- **jobs**는 병렬 또는 순차적으로 실행됩니다
- **steps**는 명령어(run) 또는 액션(uses)을 실행합니다
- **if** 조건으로 특정 상황에서만 실행할 수 있습니다
- YAML 문법과 들여쓰기가 매우 중요합니다

바데부와 함께 워크플로우 문법을 마스터했습니다! 💪

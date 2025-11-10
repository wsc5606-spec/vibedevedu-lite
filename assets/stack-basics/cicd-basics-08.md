# 매트릭스 빌드

## 매트릭스 빌드란?

매트릭스 빌드는 여러 버전, 플랫폼, 설정을 동시에 테스트하는 강력한 기능입니다. 바데부와 함께 매트릭스 빌드를 마스터해봅시다!

### 매트릭스의 필요성

```yaml
# 문제: 여러 버전 수동 테스트
문제_상황:
  - Node 16에서 테스트
  - Node 18에서 테스트
  - Node 20에서 테스트
  → 3개의 워크플로우 필요? 너무 복잡!

# 해결: 매트릭스 빌드
해결책:
  strategy:
    matrix:
      node-version: [16, 18, 20]
  → 하나의 정의로 3개 동시 실행!

# 바데부: "한 번 작성하고 여러 번 실행!"
```

## 기본 매트릭스 빌드

### Node.js 버전 매트릭스

```yaml
name: 바데부의 Node 버전 테스트

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

      - name: 테스트
        run: |
          echo "Node ${{ matrix.node-version }}에서 테스트 중"
          npm ci
          npm test

# 결과: 3개의 Job이 병렬로 실행됨!
```

### OS 매트릭스

```yaml
# 크로스 플랫폼 테스트
jobs:
  build:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]

    steps:
      - uses: actions/checkout@v3

      - name: 빌드
        run: |
          echo "빌드 중: ${{ matrix.os }}"
          npm run build

      - name: 테스트
        run: npm test

# 바데부: "Linux, Windows, Mac에서 모두 테스트!"
```

## 다차원 매트릭스

### OS + Node 버전

```yaml
name: 바데부의 크로스 플랫폼 테스트

on: [push]

jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [16, 18, 20]

    # 총 9개의 조합 (3 OS × 3 Node)
    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}

      - name: 테스트
        run: |
          echo "OS: ${{ matrix.os }}"
          echo "Node: ${{ matrix.node-version }}"
          npm ci
          npm test
```

### 3차원 매트릭스

```yaml
# OS + Node + Database
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node-version: [18, 20]
        database: [postgres, mysql, mongodb]

    # 총 12개 조합 (2 × 2 × 3)
    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}

      - name: 데이터베이스 설정
        run: |
          echo "데이터베이스: ${{ matrix.database }}"
          ./setup-db.sh ${{ matrix.database }}

      - name: 테스트
        run: npm test
```

## 매트릭스 include/exclude

### include: 특정 조합 추가

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest]
        node-version: [18, 20]

        # 특정 조합만 추가
        include:
          # Windows에서는 Node 20만 테스트
          - os: windows-latest
            node-version: 20

          # macOS에서는 Node 20만 테스트
          - os: macos-latest
            node-version: 20

    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test

# 결과: ubuntu(18,20), windows(20), macos(20) = 4개 조합
```

### exclude: 특정 조합 제외

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [16, 18, 20]

        # 특정 조합 제외
        exclude:
          # Windows + Node 16 제외 (호환성 문제)
          - os: windows-latest
            node-version: 16

          # macOS + Node 16 제외
          - os: macos-latest
            node-version: 16

    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test

# 결과: 9개 - 2개 = 7개 조합
```

### include로 변수 추가

```yaml
# 바데부의 환경별 설정
jobs:
  deploy:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        environment: [dev, staging, prod]

        # 환경별 추가 설정
        include:
          - environment: dev
            url: https://dev.badebu.com
            require_approval: false

          - environment: staging
            url: https://staging.badebu.com
            require_approval: false

          - environment: prod
            url: https://badebu.com
            require_approval: true

    steps:
      - uses: actions/checkout@v3

      - name: 배포 정보
        run: |
          echo "환경: ${{ matrix.environment }}"
          echo "URL: ${{ matrix.url }}"
          echo "승인 필요: ${{ matrix.require_approval }}"

      - name: 배포
        run: ./deploy.sh ${{ matrix.environment }}
```

## fail-fast 전략

### fail-fast: true (기본값)

```yaml
# 하나라도 실패하면 모두 중단
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: true  # 기본값
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]

    steps:
      - run: npm test

# ubuntu 실패 → windows, macos 즉시 취소
```

### fail-fast: false

```yaml
# 실패해도 모든 조합 계속 실행
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: false  # 모두 실행
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [16, 18, 20]

    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test

# ubuntu-16 실패해도 나머지 8개 계속 실행
# 바데부: "어떤 조합이 문제인지 모두 확인 가능!"
```

## max-parallel: 동시 실행 제한

```yaml
jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      max-parallel: 2  # 최대 2개만 동시 실행
      matrix:
        node-version: [14, 16, 18, 20]

    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm test

# 실행 순서: [14, 16] → 완료 → [18, 20]
# 바데부: "리소스를 아껴쓸 수 있어요!"
```

## 조건부 매트릭스

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}

    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20]

    steps:
      - uses: actions/checkout@v3

      - name: Node.js 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}

      # Linux에서만 실행
      - name: Linux 전용 설정
        if: matrix.os == 'ubuntu-latest'
        run: sudo apt-get update

      # Windows에서만 실행
      - name: Windows 전용 설정
        if: matrix.os == 'windows-latest'
        run: choco install -y nodejs

      # macOS에서만 실행
      - name: macOS 전용 설정
        if: matrix.os == 'macos-latest'
        run: brew update

      - name: 테스트
        run: npm test
```

## 실전 예제: 바데부의 완전한 매트릭스

```yaml
# .github/workflows/badebu-matrix.yml

name: 바데부의 완전한 매트릭스 빌드

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  # Job 1: 빠른 체크 (Linux + 최신 버전만)
  quick-check:
    name: 빠른 체크
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm test

  # Job 2: 크로스 플랫폼 테스트
  matrix-test:
    name: ${{ matrix.os }} / Node ${{ matrix.node-version }}
    runs-on: ${{ matrix.os }}
    needs: quick-check

    strategy:
      fail-fast: false
      max-parallel: 4
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18, 20]

        # 특정 조합 제외
        exclude:
          # Windows + Node 18 제외 (성능 이슈)
          - os: windows-latest
            node-version: 18

        # 추가 설정
        include:
          # Ubuntu 20 LTS 추가
          - os: ubuntu-20.04
            node-version: 20
            label: 'ubuntu-20-lts'

          # 실험적 조합
          - os: ubuntu-latest
            node-version: 21
            experimental: true

    # 실험적 조합은 실패해도 OK
    continue-on-error: ${{ matrix.experimental == true }}

    steps:
      - name: 코드 체크아웃
        uses: actions/checkout@v3

      - name: Node.js ${{ matrix.node-version }} 설정
        uses: actions/setup-node@v3
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      # OS별 의존성 설치
      - name: Linux 의존성
        if: runner.os == 'Linux'
        run: |
          sudo apt-get update
          sudo apt-get install -y build-essential

      - name: Windows 의존성
        if: runner.os == 'Windows'
        run: |
          choco install -y visualstudio2019buildtools
          choco install -y visualstudio2019-workload-vctools

      - name: macOS 의존성
        if: runner.os == 'macOS'
        run: brew install pkg-config cairo pango libpng jpeg giflib

      - name: 의존성 설치
        run: npm ci

      - name: 빌드
        run: npm run build

      - name: 테스트
        run: npm test

      - name: E2E 테스트 (Linux만)
        if: matrix.os == 'ubuntu-latest'
        run: npm run test:e2e

      # 테스트 결과 업로드
      - name: 테스트 결과 업로드
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: test-results-${{ matrix.os }}-${{ matrix.node-version }}
          path: |
            coverage/
            test-results/

  # Job 3: 데이터베이스 매트릭스
  database-test:
    name: Database / ${{ matrix.database }}
    runs-on: ubuntu-latest
    needs: quick-check

    strategy:
      matrix:
        database:
          - postgres
          - mysql
          - mongodb

        include:
          - database: postgres
            port: 5432
            image: postgres:15

          - database: mysql
            port: 3306
            image: mysql:8

          - database: mongodb
            port: 27017
            image: mongo:6

    services:
      database:
        image: ${{ matrix.image }}
        ports:
          - ${{ matrix.port }}:${{ matrix.port }}

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 데이터베이스 테스트
        env:
          DB_TYPE: ${{ matrix.database }}
          DB_PORT: ${{ matrix.port }}
        run: npm run test:db

  # Job 4: 브라우저 매트릭스
  browser-test:
    name: Browser / ${{ matrix.browser }}
    runs-on: ubuntu-latest
    needs: quick-check

    strategy:
      matrix:
        browser: [chrome, firefox, safari, edge]

    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: Playwright 설치
        run: npx playwright install ${{ matrix.browser }}

      - name: 브라우저 테스트
        run: npm run test:browser -- --project=${{ matrix.browser }}

      - name: 스크린샷 업로드
        if: failure()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-screenshots-${{ matrix.browser }}
          path: test-results/

  # Job 5: 결과 요약
  summary:
    name: 테스트 요약
    needs: [matrix-test, database-test, browser-test]
    if: always()
    runs-on: ubuntu-latest

    steps:
      - name: 모든 테스트 결과 다운로드
        uses: actions/download-artifact@v3

      - name: 요약 생성
        run: |
          echo "🎉 바데부의 매트릭스 테스트 완료!"
          echo "✅ 크로스 플랫폼: ${{ needs.matrix-test.result }}"
          echo "✅ 데이터베이스: ${{ needs.database-test.result }}"
          echo "✅ 브라우저: ${{ needs.browser-test.result }}"
```

## 매트릭스 최적화 팁

```yaml
# 바데부의 최적화 전략
최적화_팁:
  1. 빠른_피드백:
    - 가장 일반적인 조합을 먼저 실행
    - quick-check job 활용

  2. 리소스_절약:
    - max-parallel로 동시 실행 제한
    - exclude로 불필요한 조합 제거

  3. 효율적인_디버깅:
    - fail-fast: false로 모든 실패 확인
    - artifact로 각 조합의 결과 저장

  4. 선택적_실행:
    - PR에서는 최소 조합만
    - main 브랜치에서 전체 매트릭스

# PR용 간소화 매트릭스
on:
  pull_request:
    strategy:
      matrix:
        os: [ubuntu-latest]  # Linux만
        node-version: [20]   # 최신만

# main 브랜치용 전체 매트릭스
on:
  push:
    branches: [main]
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [16, 18, 20]
```

## 다음 단계

다음 장에서는 배포 자동화를 배웁니다:

- 다양한 플랫폼 배포
- Blue-Green 배포
- Canary 배포
- 롤백 전략

## 핵심 요약

- **매트릭스 빌드**로 여러 환경을 동시에 테스트합니다
- **strategy.matrix**로 OS, 버전, 데이터베이스 등을 조합합니다
- **include/exclude**로 특정 조합을 추가/제외합니다
- **fail-fast**로 실패 시 동작을 제어합니다
- **max-parallel**로 동시 실행 수를 제한합니다
- 매트릭스 변수는 **${{ matrix.변수명 }}**으로 접근합니다

바데부와 함께 매트릭스 빌드를 마스터했습니다! 🎯

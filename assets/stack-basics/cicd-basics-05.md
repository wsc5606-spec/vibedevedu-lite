# 이벤트와 트리거 (on: push, pull_request)

## GitHub Events 이해하기

GitHub Actions는 다양한 이벤트에 반응하여 워크플로우를 실행합니다. 바데부와 함께 각 이벤트를 마스터해봅시다!

### 이벤트 종류

```yaml
# GitHub Actions가 지원하는 주요 이벤트들
events:
  repository:
    - push              # 코드 푸시
    - pull_request      # PR 생성/업데이트
    - pull_request_target
    - create            # 브랜치/태그 생성
    - delete            # 브랜치/태그 삭제
    - fork              # 저장소 포크

  issues:
    - issues            # 이슈 관련
    - issue_comment     # 이슈 댓글
    - label             # 라벨 관련

  releases:
    - release           # 릴리스 생성/수정

  workflow:
    - workflow_dispatch # 수동 실행
    - workflow_run      # 다른 워크플로우 완료 시
    - schedule          # 스케줄 실행
```

## push 이벤트

### 기본 사용법

```yaml
# 모든 브랜치의 push에 반응
on: push

# 특정 브랜치에만 반응
on:
  push:
    branches:
      - main
      - develop

# 바데부의 push 트리거
name: 바데부의 Push CI
on:
  push:
    branches: [main]
```

### 브랜치 필터링

```yaml
# 여러 브랜치 지정
on:
  push:
    branches:
      - main
      - develop
      - staging

# 브랜치 패턴 매칭
on:
  push:
    branches:
      - 'release/**'      # release/로 시작하는 모든 브랜치
      - 'hotfix-*'        # hotfix-로 시작하는 모든 브랜치
      - '!test-*'         # test-로 시작하는 브랜치 제외

# 정규식 패턴
on:
  push:
    branches:
      - 'releases/**'
      - 'feature/**'
      - '!feature/draft-*'  # draft로 시작하는 feature 브랜치 제외
```

### 브랜치 제외하기

```yaml
# 특정 브랜치 제외
on:
  push:
    branches-ignore:
      - 'docs/**'
      - 'experimental/**'

# 바데부의 메인 브랜치만 CI
on:
  push:
    branches:
      - main
    branches-ignore:
      - 'wip-*'  # work in progress 브랜치 제외
```

### 파일 경로 필터링

```yaml
# 특정 파일 변경 시에만 실행
on:
  push:
    paths:
      - 'src/**'           # src 폴더 내 모든 파일
      - 'package.json'     # 특정 파일
      - 'package-lock.json'
      - '**.js'            # 모든 JS 파일

# 특정 파일 제외
on:
  push:
    paths-ignore:
      - 'docs/**'
      - '**.md'
      - '.gitignore'

# 바데부의 실용 예제
name: 프론트엔드 빌드
on:
  push:
    branches: [main]
    paths:
      - 'frontend/**'
      - 'package.json'
    paths-ignore:
      - 'frontend/**.test.js'
```

### 태그 트리거

```yaml
# 태그 푸시 시 실행
on:
  push:
    tags:
      - 'v*'           # v로 시작하는 태그
      - 'v[0-9]+.*'    # v1.0, v2.1 등

# 바데부의 릴리스 배포
name: 릴리스 배포
on:
  push:
    tags:
      - 'v*.*.*'       # v1.0.0, v2.1.3 등

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: 릴리스 생성
        run: |
          TAG=${GITHUB_REF#refs/tags/}
          echo "릴리스 버전: $TAG"
```

## pull_request 이벤트

### 기본 사용법

```yaml
# 모든 PR에 반응
on: pull_request

# 특정 브랜치로의 PR만
on:
  pull_request:
    branches:
      - main
      - develop

# 바데부의 PR 체크
name: PR 체크
on:
  pull_request:
    branches: [main]
```

### PR 액티비티 타입

```yaml
# PR의 다양한 이벤트
on:
  pull_request:
    types:
      - opened          # PR 생성
      - edited          # PR 수정
      - closed          # PR 닫힘
      - reopened        # PR 재오픈
      - synchronize     # PR 업데이트 (새 커밋 푸시)
      - ready_for_review  # 리뷰 준비 완료
      - review_requested  # 리뷰 요청

# 바데부의 PR 자동 체크
name: PR 자동 검사
on:
  pull_request:
    types: [opened, synchronize, reopened]
    branches: [main]

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: 코드 검사
        run: npm run lint && npm test
```

### PR 경로 필터링

```yaml
# 특정 파일 변경된 PR만 체크
on:
  pull_request:
    paths:
      - 'src/**'
      - 'tests/**'

# 바데부의 프론트엔드 PR 체크
name: 프론트엔드 PR 체크
on:
  pull_request:
    branches: [main]
    paths:
      - 'frontend/**'
      - 'package.json'
    paths-ignore:
      - 'frontend/**.md'
```

### PR 레이블 조건

```yaml
# 특정 레이블이 있는 PR만
jobs:
  deploy-preview:
    if: contains(github.event.pull_request.labels.*.name, 'preview')
    runs-on: ubuntu-latest
    steps:
      - name: 프리뷰 배포
        run: echo "미리보기 배포 중..."

# 바데부의 레이블 기반 자동화
name: 레이블 자동화
on:
  pull_request:
    types: [labeled, unlabeled]

jobs:
  auto-test:
    if: contains(github.event.pull_request.labels.*.name, 'needs-testing')
    runs-on: ubuntu-latest
    steps:
      - name: 전체 테스트
        run: npm run test:all
```

## 이벤트 조합하기

### 여러 이벤트 동시 사용

```yaml
# push와 pull_request 모두 대응
on: [push, pull_request]

# 더 세밀한 설정
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

# 바데부의 통합 CI
name: 통합 CI
on:
  push:
    branches: [main]
    paths-ignore:
      - 'docs/**'
  pull_request:
    branches: [main]
  workflow_dispatch:  # 수동 실행도 가능
```

### 이벤트별 다른 작업 실행

```yaml
name: 이벤트별 처리
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      # Push일 때만 배포
      - name: 배포
        if: github.event_name == 'push'
        run: npm run deploy

      # PR일 때만 프리뷰
      - name: 프리뷰 생성
        if: github.event_name == 'pull_request'
        run: npm run preview
```

## workflow_dispatch: 수동 트리거

### 기본 수동 실행

```yaml
# 수동 실행 가능
on:
  workflow_dispatch:

# Actions 탭에서 "Run workflow" 버튼 표시됨
```

### 입력 파라미터

```yaml
# 바데부의 수동 배포
name: 수동 배포
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

      version:
        description: '배포 버전'
        required: true
        default: 'latest'
        type: string

      debug:
        description: '디버그 모드'
        required: false
        type: boolean
        default: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: 입력값 출력
        run: |
          echo "환경: ${{ inputs.environment }}"
          echo "버전: ${{ inputs.version }}"
          echo "디버그: ${{ inputs.debug }}"

      - name: 배포 실행
        run: |
          npm run deploy:${{ inputs.environment }}

      - name: 디버그 로그
        if: inputs.debug == true
        run: |
          echo "=== 디버그 정보 ==="
          env
```

## schedule: 정기 실행

### Cron 문법

```yaml
# 매일 실행
on:
  schedule:
    - cron: '0 0 * * *'  # 매일 자정 (UTC)

# 바데부의 일일 백업
name: 일일 백업
on:
  schedule:
    - cron: '0 2 * * *'  # 매일 오전 2시 (UTC)

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - name: 데이터베이스 백업
        run: ./scripts/backup.sh
```

### 다양한 스케줄 패턴

```yaml
on:
  schedule:
    # 매시간 실행
    - cron: '0 * * * *'

    # 매일 오전 9시
    - cron: '0 9 * * *'

    # 매주 월요일 오전 10시
    - cron: '0 10 * * 1'

    # 매월 1일 자정
    - cron: '0 0 1 * *'

    # 평일 오전 9시
    - cron: '0 9 * * 1-5'

    # 15분마다
    - cron: '*/15 * * * *'

# 바데부의 정기 작업들
name: 정기 유지보수
on:
  schedule:
    # 매일 새벽 3시: 캐시 정리
    - cron: '0 3 * * *'

jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
      - name: 캐시 정리
        run: npm run cache:clean

      - name: 오래된 로그 삭제
        run: find logs/ -mtime +30 -delete
```

## 실전 예제: 바데부의 완전한 이벤트 활용

```yaml
# .github/workflows/badebu-complete-events.yml

name: 바데부의 완전한 이벤트 처리

on:
  # 메인 브랜치에 푸시 시
  push:
    branches:
      - main
    paths:
      - 'src/**'
      - 'package.json'

  # 메인 브랜치로의 PR
  pull_request:
    branches:
      - main
    types:
      - opened
      - synchronize
      - reopened

  # 릴리스 태그 푸시
  push:
    tags:
      - 'v*.*.*'

  # 매일 오전 9시 정기 테스트
  schedule:
    - cron: '0 9 * * *'

  # 수동 실행
  workflow_dispatch:
    inputs:
      test_type:
        description: '테스트 타입'
        required: true
        type: choice
        options:
          - unit
          - integration
          - e2e
          - all

jobs:
  # Job 1: CI 테스트 (push, PR)
  ci-test:
    if: github.event_name == 'push' || github.event_name == 'pull_request'
    name: CI 테스트
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: 의존성 설치
        run: npm ci

      - name: 린트
        run: npm run lint

      - name: 테스트
        run: npm test

      - name: 빌드
        run: npm run build

  # Job 2: 배포 (push to main)
  deploy:
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    needs: ci-test
    name: 프로덕션 배포
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 배포 실행
        run: |
          echo "🚀 프로덕션 배포 중..."
          npm run deploy:prod

  # Job 3: PR 프리뷰
  pr-preview:
    if: github.event_name == 'pull_request'
    name: PR 미리보기
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 프리뷰 URL 생성
        run: |
          PR_NUMBER=${{ github.event.pull_request.number }}
          echo "미리보기: https://preview-${PR_NUMBER}.badebu.com"

  # Job 4: 릴리스 생성
  release:
    if: startsWith(github.ref, 'refs/tags/v')
    name: 릴리스 생성
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 릴리스 노트 생성
        run: |
          TAG=${GITHUB_REF#refs/tags/}
          echo "릴리스 $TAG 생성 중..."

      - name: GitHub Release 생성
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: Release ${{ github.ref }}
          draft: false
          prerelease: false

  # Job 5: 정기 테스트
  scheduled-test:
    if: github.event_name == 'schedule'
    name: 정기 전체 테스트
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 전체 테스트 스위트
        run: |
          echo "📅 정기 테스트 실행 중..."
          npm run test:all

      - name: 테스트 리포트 생성
        run: |
          npm run report:generate

  # Job 6: 수동 테스트
  manual-test:
    if: github.event_name == 'workflow_dispatch'
    name: 수동 테스트
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 선택된 테스트 실행
        run: |
          TEST_TYPE="${{ inputs.test_type }}"
          echo "🎯 $TEST_TYPE 테스트 실행 중..."

          if [ "$TEST_TYPE" = "all" ]; then
            npm run test:all
          else
            npm run test:$TEST_TYPE
          fi
```

## 이벤트 컨텍스트 활용

```yaml
jobs:
  debug:
    runs-on: ubuntu-latest
    steps:
      # 이벤트 정보 출력
      - name: 이벤트 정보
        run: |
          echo "이벤트: ${{ github.event_name }}"
          echo "브랜치: ${{ github.ref }}"
          echo "커밋: ${{ github.sha }}"
          echo "작성자: ${{ github.actor }}"

      # Push 이벤트 정보
      - name: Push 정보
        if: github.event_name == 'push'
        run: |
          echo "푸시한 사람: ${{ github.event.pusher.name }}"
          echo "커밋 메시지: ${{ github.event.head_commit.message }}"

      # PR 이벤트 정보
      - name: PR 정보
        if: github.event_name == 'pull_request'
        run: |
          echo "PR 번호: ${{ github.event.pull_request.number }}"
          echo "PR 제목: ${{ github.event.pull_request.title }}"
          echo "작성자: ${{ github.event.pull_request.user.login }}"
```

## 다음 단계

다음 장에서는 Actions 마켓플레이스를 탐험합니다:

- 유용한 액션 찾기
- 액션 사용법
- 커스텀 액션 만들기
- 액션 버전 관리

## 핵심 요약

- **push** 이벤트는 코드 푸시 시 트리거됩니다
- **pull_request** 이벤트는 PR 생성/업데이트 시 트리거됩니다
- **branches, paths** 필터로 특정 조건에서만 실행 가능합니다
- **schedule**로 정기적인 작업 자동화가 가능합니다
- **workflow_dispatch**로 수동 실행과 파라미터 입력이 가능합니다
- 여러 이벤트를 조합하여 유연한 워크플로우를 만들 수 있습니다

바데부와 함께 이벤트와 트리거를 마스터했습니다! ⚡

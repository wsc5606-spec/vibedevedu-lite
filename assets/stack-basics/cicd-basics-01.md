# CI/CD 소개 (Continuous Integration/Deployment)

## CI/CD란 무엇인가?

CI/CD는 소프트웨어 개발과 배포를 자동화하는 현대적인 개발 방법론입니다. 바데부와 함께 코드를 작성하고, 테스트하고, 배포하는 과정을 자동화하는 방법을 배워봅시다!

### CI (Continuous Integration) - 지속적 통합

**CI**는 개발자들이 코드를 자주 통합하고 자동으로 테스트하는 방식입니다.

```yaml
# CI의 핵심 개념
- 코드 푸시 → 자동 빌드 → 자동 테스트 → 결과 확인
```

### CD (Continuous Deployment/Delivery) - 지속적 배포

**CD**는 테스트를 통과한 코드를 자동으로 프로덕션 환경에 배포하는 방식입니다.

```yaml
# CD의 핵심 개념
- 테스트 통과 → 자동 배포 → 실시간 반영
```

## 왜 CI/CD가 필요할까?

### 전통적인 개발 방식의 문제점

```javascript
// 바데부의 경험: 수동 배포의 고통

// 1. 금요일 오후 5시
console.log("바데부: 이번 주 작업 완료! 배포하자!");

// 2. 수동으로 빌드
// "npm run build... 10분 대기..."

// 3. 서버에 파일 업로드
// "FTP로 파일 전송... 또 10분..."

// 4. 서버 재시작
// "서버 재시작... 5분..."

// 5. 에러 발견!
console.error("에러: 환경 변수 설정을 깜빡했다!");

// 6. 다시 처음부터...
// "아... 퇴근은 언제...? 😭"
```

### CI/CD를 사용하면?

```yaml
# 바데부의 새로운 워크플로우

name: 바데부의 자동 배포
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: 코드 가져오기
        run: echo "자동으로 코드 체크아웃!"

      - name: 테스트 실행
        run: echo "자동으로 테스트!"

      - name: 빌드
        run: echo "자동으로 빌드!"

      - name: 배포
        run: echo "자동으로 배포 완료! 🚀"

# 결과: 코드 푸시 후 5분 안에 자동 배포 완료!
```

## CI/CD의 주요 이점

### 1. 빠른 피드백

```yaml
# 코드 푸시 즉시 자동 테스트
push_code →
  ✓ 빌드 성공
  ✓ 테스트 통과
  ✓ 코드 품질 검사 완료
  → 바데부: "5분 만에 모든 확인 완료!"
```

### 2. 반복 작업 제거

```javascript
// Before CI/CD
const manualWork = [
  "코드 받기",
  "의존성 설치",
  "테스트 실행",
  "빌드 생성",
  "서버 연결",
  "파일 업로드",
  "서버 재시작",
  "동작 확인"
];

// With CI/CD
const automatedWork = [
  "git push" // 끝!
];

console.log("바데부: 시간이 8배 절약됐어요! ⚡");
```

### 3. 실수 방지

```yaml
# 자동화된 체크리스트
checks:
  - 코드 포맷 확인 ✓
  - 린트 검사 ✓
  - 단위 테스트 ✓
  - 통합 테스트 ✓
  - 보안 취약점 검사 ✓
  - 빌드 검증 ✓

# 모든 검사를 통과해야만 배포됨!
```

### 4. 팀 협업 향상

```yaml
# 팀원들의 코드가 자동으로 통합됨
team_workflow:
  바데부_branch: feature/login
  철수_branch: feature/signup
  영희_branch: feature/profile

  merge_to_main:
    - 자동 테스트로 충돌 감지
    - 자동으로 호환성 확인
    - 안전한 통합 보장
```

## CI/CD의 핵심 개념

### 1. 자동화 파이프라인

```yaml
# 바데부의 첫 번째 파이프라인
Pipeline:
  Stage 1: 소스 코드 가져오기
  Stage 2: 의존성 설치
  Stage 3: 테스트 실행
  Stage 4: 빌드
  Stage 5: 배포

# 모든 단계가 자동으로 순차 실행!
```

### 2. 버전 관리 통합

```bash
# Git과 완벽하게 통합
git push origin main
# → CI/CD가 자동으로 시작됨

git push origin develop
# → 개발 환경에 자동 배포됨

git tag v1.0.0
# → 프로덕션에 자동 배포됨
```

### 3. 환경 분리

```yaml
# 다양한 환경 관리
environments:
  development:
    url: https://dev.badebu.com
    auto_deploy: true

  staging:
    url: https://staging.badebu.com
    auto_deploy: true
    requires_approval: false

  production:
    url: https://badebu.com
    auto_deploy: true
    requires_approval: true # 승인 후 배포
```

## CI/CD 도구 소개

### GitHub Actions (이 강의의 주제!)

```yaml
# GitHub Actions의 장점
장점:
  - GitHub와 완벽 통합
  - 무료 사용 (공개 저장소)
  - 설정이 간단함
  - 마켓플레이스에 다양한 액션 제공
  - 바데부도 쉽게 배울 수 있음!
```

### 기타 인기 도구들

```yaml
다른_도구들:
  Jenkins:
    장점: 오래되고 안정적
    단점: 설정이 복잡

  GitLab CI:
    장점: GitLab과 통합
    단점: GitHub 사용자에겐 불편

  CircleCI:
    장점: 빠른 빌드
    단점: 유료 플랜 필요

  Travis CI:
    장점: 설정 간단
    단점: 최근 업데이트 느림
```

## 실제 사용 사례

### 사례 1: 웹 애플리케이션 배포

```yaml
# 바데부의 React 앱 자동 배포
name: Deploy React App

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Deploy to Netlify
        run: netlify deploy --prod
```

### 사례 2: API 서버 배포

```yaml
# 바데부의 Node.js API 자동 배포
name: Deploy API

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run tests
        run: npm test

      - name: Build Docker image
        run: docker build -t badebu-api .

      - name: Push to registry
        run: docker push badebu-api

      - name: Deploy to server
        run: ssh server "docker pull && docker restart"
```

## CI/CD 성공을 위한 원칙

### 1. 작게 자주 커밋하기

```bash
# Good - 바데부의 방식
git commit -m "Add login button"
git commit -m "Add login form validation"
git commit -m "Connect login API"

# Bad - 피해야 할 방식
git commit -m "Complete entire login feature (1000 lines changed)"
```

### 2. 자동 테스트 작성하기

```javascript
// 바데부의 테스트 코드
describe('Login Function', () => {
  test('should login with valid credentials', () => {
    const result = login('badebu', 'password123');
    expect(result.success).toBe(true);
  });

  test('should fail with invalid credentials', () => {
    const result = login('badebu', 'wrong');
    expect(result.success).toBe(false);
  });
});

// 테스트가 있으면 CI/CD가 자동으로 검증!
```

### 3. 빌드 속도 최적화

```yaml
# 캐싱으로 빌드 속도 향상
- name: Cache dependencies
  uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}

# 결과: 빌드 시간 5분 → 1분으로 단축!
```

### 4. 명확한 에러 메시지

```yaml
# 실패 시 명확한 알림
- name: Notify on failure
  if: failure()
  run: |
    echo "❌ 바데부님, 빌드가 실패했어요!"
    echo "원인: 테스트 실패"
    echo "확인 필요: tests/login.test.js"
```

## 바데부의 CI/CD 여정 시작하기

### 첫 번째 목표

```yaml
우리의_학습_목표:
  1주차: GitHub Actions 기본 이해
  2주차: 간단한 워크플로우 작성
  3주차: 테스트 자동화 추가
  4주차: 실제 프로젝트 배포

바데부_메모: "한 걸음씩 천천히 가면 돼요!"
```

### 준비물

```yaml
필요한_것들:
  - GitHub 계정 (무료)
  - 간단한 프로젝트 (React, Node.js 등)
  - 배우고자 하는 열정
  - 실패를 두려워하지 않는 마음

바데부: "모두 무료로 시작할 수 있어요! 🎉"
```

## 다음 단계

다음 장에서는 GitHub Actions를 직접 시작해봅니다:

- GitHub Actions 설정 방법
- 첫 번째 워크플로우 파일 작성
- Actions 탭에서 실행 결과 확인
- 간단한 자동화 구현

## 핵심 요약

- **CI/CD**는 소프트웨어 개발과 배포를 자동화하는 방법론입니다
- **CI**는 코드를 자주 통합하고 자동으로 테스트합니다
- **CD**는 테스트를 통과한 코드를 자동으로 배포합니다
- **GitHub Actions**는 GitHub와 완벽하게 통합된 CI/CD 도구입니다
- 수동 작업을 줄이고 개발 속도를 높일 수 있습니다
- 실수를 방지하고 코드 품질을 향상시킵니다

바데부와 함께 CI/CD의 세계로 떠나볼까요? 🚀

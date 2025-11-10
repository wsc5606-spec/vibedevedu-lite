# Chapter 9: Git 워크플로우 (Gitflow, Pull Request)

## 바데부의 팀 협업 가이드! 🤝

안녕하세요! 바데부입니다. 혼자 Git을 쓸 때와 팀과 함께 쓸 때는 많이 달라요.
오늘은 실제 회사에서 사용하는 Git 워크플로우를 배워볼게요!

## 워크플로우란?

### 개념 이해하기

**워크플로우(Workflow)**는 팀이 합의한 Git 사용 규칙입니다.

```
바데부의 경험:
"처음 팀 프로젝트에 참여했을 때
각자 마음대로 커밋하고 푸시했어요.
결과는? 대혼란!

워크플로우가 있으니 훨씬 수월해졌답니다."
```

### 왜 워크플로우가 필요한가요?

**없을 때:**
```
바데부: main에 직접 커밋
친구: main에 직접 커밋
동료: main에 직접 커밋
→ 충돌, 버그, 혼란!
```

**있을 때:**
```
바데부: feature 브랜치 → 리뷰 → main
친구: feature 브랜치 → 리뷰 → main
동료: feature 브랜치 → 리뷰 → main
→ 체계적, 안전, 명확!
```

## 주요 워크플로우 소개

### 1. Centralized Workflow (중앙 집중식)

**구조:**
```
모든 개발자 → main 브랜치
```

**장점:**
- 간단함
- 배우기 쉬움

**단점:**
- 충돌 빈번
- 불안정한 main

**언제 사용?**
- 소규모 팀 (2-3명)
- 간단한 프로젝트

### 2. Feature Branch Workflow

**구조:**
```
main (안정)
 ├── feature/login (바데부)
 ├── feature/signup (친구)
 └── feature/profile (동료)
```

**규칙:**
1. main은 항상 안정적
2. 새 기능은 feature 브랜치에서
3. 완료되면 main에 병합

**실습:**
```bash
# 1. 최신 main 가져오기
git switch main
git pull origin main

# 2. feature 브랜치 생성
git switch -c feature/user-login

# 3. 작업
echo "로그인 기능" > login.py
git add login.py
git commit -m "feat: 로그인 기능 추가"

# 4. 원격에 푸시
git push -u origin feature/user-login

# 5. Pull Request 생성 (GitHub에서)

# 6. 리뷰 후 병합

# 7. 로컬 정리
git switch main
git pull origin main
git branch -d feature/user-login
```

### 3. Gitflow Workflow (가장 인기)

**브랜치 구조:**
```
main (프로덕션)
 └── develop (개발)
      ├── feature/new-feature (새 기능)
      ├── release/v1.0 (릴리스 준비)
      └── hotfix/critical-bug (긴급 수정)
```

**브랜치 설명:**

**main:**
- 프로덕션 코드
- 항상 배포 가능
- 태그로 버전 관리

**develop:**
- 개발 중인 코드
- 다음 릴리스 준비
- feature 병합 대상

**feature/***
- 새로운 기능 개발
- develop에서 분기
- develop으로 병합

**release/***
- 릴리스 준비
- develop에서 분기
- main과 develop에 병합

**hotfix/***
- 긴급 버그 수정
- main에서 분기
- main과 develop에 병합

### Gitflow 실전 사용

```bash
# 초기 설정
git branch develop
git push origin develop

# 새 기능 개발
git switch develop
git switch -c feature/shopping-cart
# ... 작업 ...
git push origin feature/shopping-cart
# PR 생성 → develop에 병합

# 릴리스 준비
git switch develop
git switch -c release/v1.0
# 버전 번호 업데이트, 버그 수정
git switch main
git merge release/v1.0
git tag v1.0
git switch develop
git merge release/v1.0

# 긴급 수정
git switch main
git switch -c hotfix/payment-bug
# ... 수정 ...
git switch main
git merge hotfix/payment-bug
git tag v1.0.1
git switch develop
git merge hotfix/payment-bug
```

바데부의 팁:
```bash
# Gitflow 도구 사용 (선택사항)
brew install git-flow

# 초기화
git flow init

# 간단한 명령어
git flow feature start login
git flow feature finish login
```

### 4. Forking Workflow (오픈소스)

**구조:**
```
원본 저장소 (badebu/project)
    ↓ fork
내 저장소 (my-account/project)
    ↓ clone
내 로컬
    ↓ push
내 저장소
    ↓ Pull Request
원본 저장소
```

**실습:**
```bash
# 1. GitHub에서 Fork 버튼 클릭

# 2. 내 저장소 클론
git clone https://github.com/my-account/project.git
cd project

# 3. 원본 저장소 추가
git remote add upstream https://github.com/badebu/project.git

# 4. 브랜치 생성 및 작업
git switch -c fix/typo
echo "오타 수정" > README.md
git commit -am "docs: README 오타 수정"

# 5. 내 저장소에 푸시
git push origin fix/typo

# 6. GitHub에서 PR 생성
# 내 저장소 → 원본 저장소

# 7. 원본 최신 상태 유지
git fetch upstream
git switch main
git merge upstream/main
git push origin main
```

## Pull Request (PR)

### PR이란?

**Pull Request**는 "내 코드를 검토하고 병합해주세요"라는 요청입니다.

```
바데부의 첫 PR 경험:
"떨렸어요! 다른 개발자들이 제 코드를 볼 거잖아요.
하지만 리뷰 덕분에 많이 배웠답니다."
```

### 좋은 PR 만들기

**1. 작은 PR**
```
나쁜 예:
- 10개 파일 수정
- 500줄 변경
- 3개 기능 추가

좋은 예:
- 2-3개 파일
- 100줄 이내
- 1개 기능
```

**2. 명확한 제목**
```
나쁜 예:
- "수정"
- "업데이트"
- "코드 변경"

좋은 예:
- "feat: 사용자 로그인 기능 추가"
- "fix: 장바구니 가격 계산 버그 수정"
- "docs: API 문서 업데이트"
```

**3. 상세한 설명**
```markdown
## 변경 사항
- 사용자 로그인 폼 추가
- 이메일 검증 기능 구현
- 세션 관리 추가

## 이유
기존 인증 시스템이 보안 취약점이 있어 전면 개편

## 테스트
- [x] 정상 로그인
- [x] 잘못된 비밀번호
- [x] 존재하지 않는 사용자
- [x] SQL 인젝션 방어

## 스크린샷
[로그인 화면 이미지]

## 관련 이슈
Closes #123
```

### PR 프로세스

**1. PR 생성**
```bash
# 1. 브랜치 푸시
git push origin feature/new-feature

# 2. GitHub에서
# - "Compare & pull request" 클릭
# - 제목과 설명 작성
# - 리뷰어 지정
# - 라벨 추가
# - "Create pull request" 클릭
```

**2. 코드 리뷰**
```
리뷰어가:
- 코드 검토
- 댓글 작성
- 변경 요청
- 승인
```

**3. 수정 요청 대응**
```bash
# 로컬에서 수정
git switch feature/new-feature
# ... 수정 ...
git commit -am "review: 리뷰 피드백 반영"
git push origin feature/new-feature
# PR이 자동으로 업데이트됨
```

**4. 병합**
```
승인 후:
- Merge (일반 병합)
- Squash and merge (커밋 합치기)
- Rebase and merge (선형 히스토리)
```

**5. 정리**
```bash
# 로컬 정리
git switch main
git pull origin main
git branch -d feature/new-feature

# 원격 브랜치도 삭제 (GitHub에서 자동)
```

## 협업 시나리오

### 시나리오 1: 바데부의 일상 작업

```bash
# 아침
git switch main
git pull origin main

# 작업 시작
git switch -c feature/payment-integration
echo "결제 기능" > payment.py
git commit -am "feat: 결제 모듈 추가"

# 중간 저장
git push origin feature/payment-integration

# 오후 - 더 작업
echo "테스트 코드" > test_payment.py
git commit -am "test: 결제 모듈 테스트 추가"
git push

# 완료 - PR 생성
# GitHub에서 PR 생성

# 리뷰 피드백
echo "피드백 반영" >> payment.py
git commit -am "review: 에러 처리 개선"
git push

# 병합 후
git switch main
git pull origin main
git branch -d feature/payment-integration
```

### 시나리오 2: 충돌 해결

```bash
# PR 생성 후 main이 변경됨
# GitHub: "This branch has conflicts"

# 1. main 최신화
git switch main
git pull origin main

# 2. feature에 병합
git switch feature/my-feature
git merge main
# 충돌 발생!

# 3. 충돌 해결
vi conflicted-file.py
git add conflicted-file.py
git commit -m "merge: main 최신 변경사항 병합"

# 4. 푸시
git push origin feature/my-feature
# PR의 충돌 해결됨
```

### 시나리오 3: 여러 명이 같은 기능

```bash
# 바데부: 프론트엔드
git switch -c feature/login-frontend
# ... 작업 ...
git push origin feature/login-frontend

# 친구: 백엔드 (동시에)
git switch -c feature/login-backend
# ... 작업 ...
git push origin feature/login-backend

# 둘 다 PR 생성
# 둘 다 리뷰
# 하나씩 병합
```

## 코드 리뷰 문화

### 좋은 리뷰어 되기

**건설적 피드백:**
```
나쁜 예:
"이 코드 이상해요."
"왜 이렇게 했어요?"

좋은 예:
"이 부분은 함수로 분리하면 재사용할 수 있을 것 같아요."
"성능을 위해 캐싱을 고려해보면 어떨까요?"
```

**칭찬도 잊지 말기:**
```
"이 에러 처리 방식 좋네요!"
"테스트 케이스가 꼼꼼하네요 👍"
"깔끔한 코드입니다!"
```

### 좋은 PR 작성자 되기

**열린 마음:**
```
"좋은 의견 감사합니다!"
"그 방법이 더 나을 것 같네요."
"추가 설명이 필요하신가요?"
```

**적극적 소통:**
```
"이 부분은 이런 이유로 이렇게 했습니다."
"말씀하신 대로 수정했습니다."
"다른 접근법도 고려해봤는데..."
```

바데부의 리뷰 철학:
```
코드 리뷰는:
✓ 코드 품질 향상
✓ 지식 공유
✓ 팀 성장
✗ 비난
✗ 권위 과시
✗ 완벽 추구
```

## 실전 팁

### 커밋 메시지 컨벤션

```
형식: <타입>(<범위>): <제목>

<본문>

<꼬리말>

예시:
feat(auth): 소셜 로그인 추가

구글, 페이스북 로그인 지원
- OAuth 2.0 구현
- 사용자 프로필 연동

Closes #123
```

**타입:**
```
feat: 새 기능
fix: 버그 수정
docs: 문서 변경
style: 코드 스타일
refactor: 리팩토링
test: 테스트
chore: 기타
```

### 브랜치 네이밍

```
feature/기능명
fix/버그명
hotfix/긴급수정
release/버전
docs/문서명

예시:
feature/user-authentication
fix/login-validation-error
hotfix/security-patch
release/v1.2.0
docs/api-documentation
```

### PR 체크리스트

```markdown
작성자 체크리스트:
- [ ] 코드가 동작하나요?
- [ ] 테스트를 추가했나요?
- [ ] 문서를 업데이트했나요?
- [ ] 커밋 메시지가 명확한가요?
- [ ] 충돌이 없나요?
- [ ] CI가 통과했나요?

리뷰어 체크리스트:
- [ ] 코드가 요구사항을 만족하나요?
- [ ] 가독성이 좋은가요?
- [ ] 에러 처리가 적절한가요?
- [ ] 성능 문제는 없나요?
- [ ] 보안 취약점은 없나요?
- [ ] 테스트가 충분한가요?
```

## GitHub 고급 기능

### Draft PR

```
초기 피드백을 받고 싶을 때:
1. "Create pull request" 옆 화살표
2. "Create draft pull request" 선택
3. 완성되면 "Ready for review" 클릭
```

### 템플릿 사용

**.github/PULL_REQUEST_TEMPLATE.md:**
```markdown
## 변경 사항
-

## 이유
-

## 테스트
- [ ]

## 스크린샷 (있다면)

## 관련 이슈
Closes #
```

### 자동화

**GitHub Actions 예시:**
```yaml
name: PR Check
on: pull_request

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: npm test
      - name: Run linter
        run: npm run lint
```

## 실습 체크리스트

팀 프로젝트 시뮬레이션:

```bash
# 1. 저장소 준비
mkdir team-project
cd team-project
git init
echo "# Team Project" > README.md
git add README.md
git commit -m "Initial commit"

# GitHub에 저장소 생성 후
git remote add origin [URL]
git push -u origin main

# 2. develop 브랜치
git switch -c develop
git push -u origin develop

# 3. feature 작업
git switch -c feature/new-feature
echo "새 기능" > feature.txt
git commit -am "feat: 새 기능 추가"
git push -u origin feature/new-feature

# 4. GitHub에서 PR 생성
# develop ← feature/new-feature

# 5. 병합 후 정리
git switch develop
git pull origin develop
git branch -d feature/new-feature
```

**확인 사항:**
- [ ] Feature Branch 워크플로우를 이해했나요?
- [ ] Gitflow의 브랜치 구조를 아나요?
- [ ] PR을 생성할 수 있나요?
- [ ] 코드 리뷰를 할 수 있나요?
- [ ] 충돌을 해결할 수 있나요?

## 정리하며

### 워크플로우 선택 가이드

```
프로젝트 크기:
- 1-2명: Centralized
- 3-5명: Feature Branch
- 6명+: Gitflow

프로젝트 유형:
- 간단한 웹사이트: Feature Branch
- 복잡한 애플리케이션: Gitflow
- 오픈소스: Forking

팀 경험:
- 초보자: Feature Branch
- 숙련자: Gitflow
```

### 바데부의 협업 원칙

```
1. 의사소통: 자주, 명확하게
2. 작은 단위: 작은 PR, 자주 병합
3. 코드 리뷰: 진지하게, 친절하게
4. 테스트: 항상, 충분히
5. 문서화: 미래의 나를 위해
6. 존중: 다른 사람의 코드와 시간
```

---

**바데부의 한마디:**
```
"혼자 개발할 때는 Git이 버전 관리 도구였어요.
하지만 팀과 함께 일할 때는
Git이 협업 플랫폼이 되더라고요.

좋은 워크플로우는 팀의 생산성을 높이고
실수를 줄이고, 코드 품질을 향상시킵니다.

처음엔 규칙이 많아서 번거롭게 느껴질 수 있지만,
익숙해지면 이게 얼마나 효율적인지 알게 될 거예요.

팀의 상황에 맞는 워크플로우를 선택하고
꾸준히 개선해나가세요!"
```

## 다음 챕터 예고

**Chapter 10: 모범 사례와 팁**
- Git 성능 최적화
- 보안과 비밀 관리
- 유용한 도구들
- 바데부의 10가지 조언

Git 마스터로 가는 마지막 단계! 다음 챕터에서 만나요! 👋

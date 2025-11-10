# Chapter 7: Git 통합

VS Code는 Git을 완벽하게 지원합니다. 터미널 명령어 없이도 Git을 쉽게 사용할 수 있어요!

## 7.1 Git이란?

**Git**: 코드의 변경 이력을 관리하는 버전 관리 시스템

**왜 필요한가요?**
- 코드 변경 이력 추적
- 이전 버전으로 되돌리기
- 여러 명이 협업
- 백업 및 복원

```text
바데부: "Git이 없으면 파일명을 '최종.js', '진짜최종.js', '진짜진짜최종.js'로 만들게 돼..."
```

## 7.2 Git 설치 확인

**Git 설치 여부 확인:**
```bash
git --version
```

**설치 안 되어 있다면:**
- Windows: https://git-scm.com/download/win
- macOS: `brew install git`
- Linux: `sudo apt install git`

**초기 설정:**
```bash
git config --global user.name "바데부"
git config --global user.email "badebu@example.com"
```

```text
바데부: "Git 설치는 딱 한 번만 하면 돼!"
```

## 7.3 Source Control 뷰

VS Code의 Git 통합 인터페이스입니다.

**열기:**
- `Ctrl + Shift + G`
- Activity Bar의 Git 아이콘 클릭

```text
SOURCE CONTROL
┌──────────────────────────────┐
│ Initialize Repository        │  ← 저장소 초기화
└──────────────────────────────┘

또는 (저장소가 있을 때)

SOURCE CONTROL
├─ Changes (3)
│  ├─ M index.html
│  ├─ M style.css
│  └─ A script.js
└─ Staged Changes (0)
```

**파일 상태 표시:**
- `M` (Modified): 수정됨
- `A` (Added): 새로 추가됨
- `D` (Deleted): 삭제됨
- `U` (Untracked): 추적되지 않음
- `C` (Conflict): 충돌

```text
바데부: "Source Control 뷰만 보면 어떤 파일이 바뀌었는지 한눈에 알 수 있어!"
```

## 7.4 저장소 초기화

프로젝트를 Git 저장소로 만듭니다.

**방법 1: Source Control에서**
1. Source Control 뷰 열기
2. "Initialize Repository" 클릭

**방법 2: 터미널에서**
```bash
git init
```

**초기화 후:**
- `.git` 폴더 생성됨
- 모든 파일이 Untracked 상태로 표시

```text
바데부: "저장소를 초기화하면 Git으로 관리를 시작할 준비가 된 거야!"
```

## 7.5 파일 스테이징 (Staging)

커밋할 파일을 선택하는 과정입니다.

**스테이징 방법:**

**개별 파일:**
1. Changes 섹션에서 파일 찾기
2. 파일 옆의 `+` 아이콘 클릭

**모든 파일:**
- Changes 섹션의 `+` 아이콘 클릭

**단축키:**
- 파일 선택 후 `Ctrl + Enter`

```text
CHANGES (3)              STAGED CHANGES (1)
├─ M index.html     →    ├─ M index.html
├─ M style.css
└─ A script.js

    + 클릭하여 스테이징
```

**스테이징 취소:**
- Staged Changes에서 `-` 아이콘 클릭

```text
바데부: "스테이징은 커밋할 변경사항을 골라내는 과정이야!"
```

## 7.6 변경사항 확인

파일을 클릭하면 변경 내용을 볼 수 있습니다.

**Diff 뷰:**
```text
┌─────────────────┬─────────────────┐
│  index.html     │  index.html     │
│  (원본)         │  (수정본)       │
├─────────────────┼─────────────────┤
│ <h1>안녕</h1>   │ <h1>안녕</h1>   │
│                 │ <p>추가됨</p>   │ ← 초록색 (추가)
│ <p>삭제될거</p> │                 │ ← 빨간색 (삭제)
└─────────────────┴─────────────────┘
```

**색상 의미:**
- 빨간색: 삭제된 줄
- 초록색: 추가된 줄
- 노란색: 수정된 줄

**Inline Diff:**
```javascript
// 이전
const name = "홍길동";

// 현재
const name = "바데부";  // ← "홍길동"이 "바데부"로 변경됨
```

```text
📸 스크린샷 위치: Diff 뷰
   - 나란히 비교되는 파일
   - 추가/삭제/수정 부분 하이라이트
```

```text
바데부: "Diff 뷰로 내가 뭘 바꿨는지 정확히 확인할 수 있어!"
```

## 7.7 커밋 (Commit)

변경사항을 저장소에 기록합니다.

**커밋 방법:**
1. 파일 스테이징
2. 상단의 메시지 입력란에 커밋 메시지 작성
3. `Ctrl + Enter` (또는 ✓ 아이콘 클릭)

**좋은 커밋 메시지:**
```text
✅ 좋은 예:
- "로그인 기능 추가"
- "버그 수정: 로그아웃 시 에러"
- "스타일 개선: 헤더 디자인 변경"

❌ 나쁜 예:
- "수정"
- "ㅇㅇ"
- "테스트"
- "..."
```

**커밋 메시지 규칙:**
```text
첫 줄: 요약 (50자 이내)

본문: 자세한 설명 (선택사항)
- 왜 변경했는지
- 무엇을 변경했는지
```

**예시:**
```text
홈페이지 반응형 디자인 구현

- 모바일 화면에서 메뉴가 햄버거 버튼으로 변경
- 태블릿 화면에서 2열 레이아웃 적용
- 미디어 쿼리 추가
```

```text
바데부: "커밋 메시지는 나중에 내가 봐도 이해할 수 있게 명확하게 써야 해!"
```

## 7.8 커밋 히스토리 보기

이전 커밋들을 확인합니다.

**방법 1: Git History 확장 설치**
1. Extensions에서 "Git History" 검색
2. 설치
3. `Ctrl + Shift + P` → "Git: View History"

**방법 2: GitLens 확장 사용**
1. Extensions에서 "GitLens" 검색
2. 설치
3. 파일별 커밋 히스토리 자동 표시

**방법 3: 터미널**
```bash
git log
git log --oneline
git log --graph
```

```text
커밋 히스토리 예시:
commit abc123 (HEAD -> main)
Author: 바데부 <badebu@example.com>
Date: 2024-01-15

    홈페이지 반응형 디자인 구현

commit def456
Author: 바데부 <badebu@example.com>
Date: 2024-01-14

    로그인 기능 추가
```

```text
바데부: "커밋 히스토리를 보면 프로젝트가 어떻게 발전했는지 알 수 있어!"
```

## 7.9 브랜치 (Branch)

독립적인 작업 공간을 만듭니다.

**브랜치란?**
```text
main     ─●─●─●─●─●
              │
feature   ●─●─●    ← 새 기능 개발
```

**새 브랜치 만들기:**
1. Status Bar의 브랜치 이름 클릭 (보통 "main")
2. "+ Create new branch" 선택
3. 브랜치 이름 입력
4. Enter

**또는 커맨드:**
```bash
git branch feature-login
git checkout feature-login
# 또는 한 번에:
git checkout -b feature-login
```

**브랜치 전환:**
1. Status Bar의 브랜치 이름 클릭
2. 전환할 브랜치 선택

```text
바데부: "브랜치를 쓰면 메인 코드를 건드리지 않고 새 기능을 개발할 수 있어!"
```

## 7.10 브랜치 병합 (Merge)

다른 브랜치의 변경사항을 합칩니다.

**병합 방법:**

**방법 1: Source Control에서**
1. main 브랜치로 전환
2. `Ctrl + Shift + P` → "Git: Merge Branch"
3. 병합할 브랜치 선택

**방법 2: 터미널**
```bash
git checkout main
git merge feature-login
```

**병합 예시:**
```text
BEFORE:
main     ─●─●─●
              │
feature      ●─●

AFTER:
main     ─●─●─●─●  ← feature가 합쳐짐
              │ /
feature      ●─●
```

**Fast-forward vs 3-way merge:**
```text
Fast-forward: 단순히 포인터만 이동
3-way merge: 새로운 병합 커밋 생성
```

```text
바데부: "기능 개발이 끝나면 main 브랜치에 병합해서 완성!"
```

## 7.11 충돌 해결 (Conflict Resolution)

같은 부분을 다르게 수정했을 때 발생합니다.

**충돌 발생 시:**
```javascript
<<<<<<< HEAD (Current Change)
const greeting = "안녕하세요";
=======
const greeting = "Hello";
>>>>>>> feature-branch (Incoming Change)
```

**해결 방법:**

**방법 1: VS Code UI 사용**
```text
Accept Current Change      ← HEAD 버전 선택
Accept Incoming Change     ← feature 버전 선택
Accept Both Changes        ← 둘 다 유지
Compare Changes            ← 비교하기
```

**방법 2: 직접 수정**
1. 충돌 마커 제거
2. 원하는 코드만 남기기
3. 파일 저장
4. 스테이징 후 커밋

**충돌 해결 예시:**
```javascript
// 충돌 발생
<<<<<<< HEAD
const greeting = "안녕하세요";
=======
const greeting = "Hello";
>>>>>>> feature-branch

// 해결 후
const greeting = "안녕하세요, Hello!";  // 둘 다 포함
```

```text
📸 스크린샷 위치: 충돌 해결 UI
   - 충돌 마커와 옵션 버튼들
   - Accept Current/Incoming 버튼
```

```text
바데부: "충돌은 무섭지 않아! 차근차근 해결하면 돼."
```

## 7.12 원격 저장소 (Remote)

GitHub, GitLab 등의 온라인 저장소입니다.

**원격 저장소 추가:**
```bash
git remote add origin https://github.com/badebu/my-project.git
```

**원격 저장소 확인:**
```bash
git remote -v
```

**VS Code에서 확인:**
- Status Bar에 원격 저장소 표시
- Source Control 뷰에 push/pull 아이콘

```text
바데부: "원격 저장소에 코드를 올리면 어디서든 접근할 수 있고 백업도 돼!"
```

## 7.13 푸시 (Push)

로컬 커밋을 원격 저장소로 업로드합니다.

**푸시 방법:**

**방법 1: Source Control에서**
1. "..." 메뉴 클릭
2. "Push" 선택

**방법 2: Status Bar**
- 동기화 아이콘(↻) 클릭

**방법 3: 단축키**
- `Ctrl + Shift + P` → "Git: Push"

**방법 4: 터미널**
```bash
git push origin main
```

**첫 푸시:**
```bash
git push -u origin main
```

```text
바데부: "푸시하면 내 코드가 GitHub에 올라가서 다른 사람들도 볼 수 있어!"
```

## 7.14 풀 (Pull)

원격 저장소의 변경사항을 가져옵니다.

**풀 방법:**

**방법 1: Source Control에서**
1. "..." 메뉴 클릭
2. "Pull" 선택

**방법 2: Status Bar**
- 동기화 아이콘(↻) 클릭

**방법 3: 터미널**
```bash
git pull origin main
```

**Pull vs Fetch:**
- **Pull**: 가져오기 + 병합
- **Fetch**: 가져오기만 (병합 안 함)

```text
바데부: "팀원이 코드를 업데이트했으면 Pull로 최신 버전을 받아와야 해!"
```

## 7.15 .gitignore

Git이 무시할 파일을 지정합니다.

**.gitignore 만들기:**
1. 프로젝트 루트에 `.gitignore` 파일 생성
2. 무시할 패턴 작성

**예시:**
```gitignore
# 의존성
node_modules/
venv/
*.pyc

# 빌드 결과물
dist/
build/
*.min.js

# 환경 설정
.env
.env.local
config.json

# IDE 설정
.vscode/
.idea/

# OS 파일
.DS_Store
Thumbs.db

# 로그
*.log
logs/
```

**템플릿 사용:**
1. https://www.toptal.com/developers/gitignore
2. 언어/프레임워크 선택
3. 생성된 내용 복사

```text
바데부: ".gitignore를 꼭 만들어야 비밀번호나 개인 설정이 Git에 올라가지 않아!"
```

## 7.16 GitLens 확장

Git 기능을 대폭 강화하는 확장입니다.

**주요 기능:**

**1. Blame 주석**
```javascript
const name = "바데부";  // 바데부, 3일 전 - 이름 변수 추가
```

**2. File History**
- 파일의 모든 변경 이력
- 각 버전 비교

**3. Line History**
- 특정 줄의 변경 이력
- 누가, 언제, 왜 수정했는지

**4. 커밋 그래프**
- 시각적 브랜치 히스토리
- 커밋 관계 파악

**5. 사이드바 뷰**
- Repositories
- File History
- Line History
- Compare
- Search & Compare

```text
바데부: "GitLens는 Git의 슈퍼 파워업 아이템이야!"
```

## 7.17 실습: Git 워크플로우

바데부와 함께 완전한 Git 작업 흐름을 연습해봅시다!

**Step 1: 저장소 초기화**
```bash
mkdir my-project
cd my-project
code .
```

Source Control에서 "Initialize Repository" 클릭

**Step 2: 첫 커밋**
1. `index.html` 파일 생성
```html
<!DOCTYPE html>
<html>
<head>
  <title>바데부의 프로젝트</title>
</head>
<body>
  <h1>안녕하세요!</h1>
</body>
</html>
```
2. 파일 스테이징 (+)
3. 커밋 메시지: "Initial commit"
4. 커밋 (✓)

**Step 3: 기능 브랜치 생성**
1. Status Bar에서 "main" 클릭
2. "+ Create new branch" → "feature-greeting"
3. 브랜치 생성 및 전환

**Step 4: 기능 개발**
1. `index.html` 수정
```html
<body>
  <h1>안녕하세요, 바데부입니다!</h1>
  <p>Git을 배우고 있어요!</p>
</body>
```
2. 스테이징 후 커밋: "Add greeting message"

**Step 5: main 브랜치로 병합**
1. main 브랜치로 전환
2. `Ctrl + Shift + P` → "Git: Merge Branch"
3. "feature-greeting" 선택
4. 병합 완료!

**Step 6: GitHub에 푸시 (선택사항)**
1. GitHub에서 새 저장소 생성
2. 원격 저장소 추가
```bash
git remote add origin https://github.com/badebu/my-project.git
```
3. 푸시
```bash
git push -u origin main
```

```text
바데부: "완벽한 Git 워크플로우를 익혔어! 이제 실전에서도 자신있게 쓸 수 있을 거야!"
```

## 7.18 Git 단축키

자주 쓰는 Git 작업의 단축키입니다.

**기본 단축키:**
- `Ctrl + Shift + G` : Source Control 열기
- `Ctrl + Enter` : 커밋
- `Ctrl + Shift + P` → Git:
  - Push
  - Pull
  - Merge Branch
  - Create Branch

**커스텀 단축키 설정:**
1. `Ctrl + K` → `Ctrl + S` (키보드 단축키)
2. "git push" 검색
3. 원하는 단축키 할당

```text
바데부: "자주 쓰는 Git 명령어에 단축키를 설정하면 더 빨라져!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Source Control 뷰 사용법
- ✅ 스테이징, 커밋, 푸시, 풀
- ✅ 브랜치 생성과 병합
- ✅ 충돌 해결
- ✅ .gitignore와 GitLens

```text
바데부: "Git을 VS Code에서 쓰니까 훨씬 쉽고 직관적이야!
       다음 챕터에서는 통합 터미널을 활용하는 방법을 배울 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 통합 터미널 사용법
- 여러 터미널 관리
- 터미널 커스터마이징
- 자주 쓰는 명령어

**바데부와 함께 터미널 마스터하기! 다음 편도 기대해줘!**

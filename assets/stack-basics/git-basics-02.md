# Chapter 2: 저장소 초기화와 기본 명령어

## 바데부의 첫 Git 프로젝트 시작하기

안녕하세요! 바데부입니다. 이제 본격적으로 Git을 사용해볼까요?
오늘은 저장소를 만들고 첫 커밋을 해보겠습니다!

## Git 저장소 만들기

### git init - 새 저장소 초기화

바데부의 새 프로젝트를 시작해봅시다:

```bash
# 프로젝트 폴더 생성
mkdir badebu-project
cd badebu-project

# Git 저장소 초기화
git init
```

**출력 결과:**
```
Initialized empty Git repository in /Users/badebu/badebu-project/.git/
```

**무슨 일이 일어났나요?**
```
badebu-project/
└── .git/          # 숨김 폴더 생성됨!
    ├── config
    ├── objects/
    ├── refs/
    └── ...
```

바데부의 팁:
```
".git 폴더는 Git의 두뇌예요!
이 폴더를 삭제하면 모든 Git 이력이 사라져요.
절대 직접 수정하지 마세요!"
```

### .git 폴더 살펴보기

```bash
# .git 폴더 내용 보기 (macOS/Linux)
ls -la .git

# Windows
dir .git /a
```

**주요 내용물:**
- `config`: 저장소별 설정
- `HEAD`: 현재 브랜치 포인터
- `objects/`: 모든 데이터 (커밋, 파일 등)
- `refs/`: 브랜치와 태그 참조

## Git의 세 가지 영역

Git은 세 가지 영역으로 작동합니다:

```
작업 디렉토리     준비 영역        저장소
(Working Dir)  (Staging Area)  (Repository)

    파일 수정   →   git add   →   git commit

    [파일]     →    [대기실]   →    [영구 저장]
```

바데부의 비유:
```
"사진 촬영에 비유하면:
- 작업 디렉토리: 피사체 준비
- 준비 영역: 구도 잡기
- 저장소: 사진 찍기 (셔터 누르기)"
```

## 첫 번째 파일 만들기

### 파일 생성

```bash
# README 파일 생성
echo "# 바데부의 첫 프로젝트" > README.md

# 프로그램 파일 생성
echo "print('안녕하세요, 바데부입니다!')" > hello.py
```

또는 에디터로 직접 작성:

**README.md:**
```markdown
# 바데부의 첫 프로젝트

안녕하세요! 이것은 바데부가 만든 첫 번째 Git 프로젝트입니다.

## 프로젝트 소개
Git을 배우면서 만드는 실습 프로젝트입니다.

## 목표
- Git 기초 마스터하기
- 협업 능력 키우기
- 멋진 개발자 되기!
```

**hello.py:**
```python
def greet(name):
    return f"안녕하세요, {name}님!"

if __name__ == "__main__":
    print(greet("바데부"))
    print("Git을 배우는 중입니다!")
```

## git status - 현재 상태 확인

```bash
git status
```

**출력:**
```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md
        hello.py

nothing added to commit but untracked files present (use "git add" to track)
```

**상태 해석:**
- `On branch main`: main 브랜치에 있음
- `No commits yet`: 아직 커밋이 없음
- `Untracked files`: Git이 추적하지 않는 파일들

바데부의 습관:
```
"저는 작업 전후로 항상 git status를 확인해요.
현재 상태를 파악하는 것이 실수를 줄이는 비결이죠!"
```

## git add - 준비 영역에 추가

### 파일 하나씩 추가

```bash
# README.md만 추가
git add README.md

# 상태 확인
git status
```

**출력:**
```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        hello.py
```

### 여러 파일 한 번에 추가

```bash
# 나머지 파일 추가
git add hello.py

# 또는 모든 파일 추가
git add .

# 또는
git add --all
git add -A
```

**상태 다시 확인:**
```bash
git status
```

**출력:**
```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   README.md
        new file:   hello.py
```

### add의 다양한 옵션

```bash
# 현재 디렉토리의 모든 파일
git add .

# 전체 프로젝트의 모든 파일
git add -A
git add --all

# 특정 패턴의 파일들
git add *.py        # 모든 Python 파일
git add src/*.js    # src 폴더의 모든 JS 파일

# 대화형 모드
git add -i
git add --interactive

# 패치 단위로 추가 (고급)
git add -p
```

바데부의 추천:
```bash
# 처음 배울 때는 이것만!
git add .              # 모든 변경사항 추가
git add 파일명         # 특정 파일만 추가
```

## git commit - 변경사항 저장

### 첫 번째 커밋

```bash
# 커밋 메시지와 함께 커밋
git commit -m "첫 커밋: README와 hello.py 추가"
```

**출력:**
```
[main (root-commit) a1b2c3d] 첫 커밋: README와 hello.py 추가
 2 files changed, 15 insertions(+)
 create mode 100644 README.md
 create mode 100644 hello.py
```

**커밋 정보 해석:**
- `[main ...]`: main 브랜치에 커밋됨
- `(root-commit)`: 첫 번째 커밋
- `a1b2c3d`: 커밋 해시 (고유 ID)
- `2 files changed`: 2개 파일 변경
- `15 insertions(+)`: 15줄 추가

### 좋은 커밋 메시지 작성법

**나쁜 예시:**
```bash
git commit -m "수정"
git commit -m "ㅋㅋㅋ"
git commit -m "asdf"
git commit -m "버그 고침"
```

**좋은 예시:**
```bash
git commit -m "로그인 기능 추가"
git commit -m "버그 수정: null 포인터 예외 처리"
git commit -m "문서 업데이트: API 사용법 추가"
git commit -m "리팩토링: 중복 코드 제거"
```

**바데부의 커밋 메시지 규칙:**
```
형식: [타입] 간단명료한 설명

타입:
- feat: 새 기능
- fix: 버그 수정
- docs: 문서 변경
- style: 코드 스타일 (포맷팅)
- refactor: 리팩토링
- test: 테스트 추가
- chore: 기타 작업

예시:
feat: 사용자 프로필 페이지 추가
fix: 로그인 시 세션 만료 문제 해결
docs: README에 설치 방법 추가
```

### 자세한 커밋 메시지

```bash
# 에디터로 상세 메시지 작성
git commit
```

**에디터가 열리면:**
```
로그인 기능 개선

- 소셜 로그인 추가 (Google, GitHub)
- 비밀번호 찾기 기능 구현
- 이메일 인증 추가

관련 이슈: #123
```

**바데부의 템플릿:**
```
[한 줄 요약 (50자 이내)]

[상세 설명 (선택사항)]
- 무엇을 변경했나?
- 왜 변경했나?
- 어떤 영향이 있나?

[관련 정보]
- 이슈 번호
- 참고 링크
```

### 커밋과 동시에 add하기

```bash
# 추적 중인 파일만 (새 파일 제외)
git commit -am "메시지"

# 풀어쓰면
git add -u          # 수정/삭제된 파일만 추가
git commit -m "메시지"
```

**주의:** 새로 만든 파일은 반드시 `git add`를 먼저 해야 합니다!

## 실전 연습: 바데부의 블로그 프로젝트

### 1단계: 프로젝트 시작

```bash
mkdir badebu-blog
cd badebu-blog
git init
```

### 2단계: 파일 생성

**index.html:**
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>바데부의 개발 블로그</title>
</head>
<body>
    <h1>바데부의 개발 일지</h1>
    <p>Git을 배우는 여정</p>
</body>
</html>
```

**style.css:**
```css
body {
    font-family: 'Noto Sans KR', sans-serif;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    color: #2c3e50;
    border-bottom: 2px solid #3498db;
}
```

### 3단계: 첫 커밋

```bash
git add .
git status
git commit -m "feat: 블로그 초기 설정"
```

### 4단계: 내용 추가

**index.html 수정:**
```html
<body>
    <h1>바데부의 개발 일지</h1>
    <p>Git을 배우는 여정</p>

    <article>
        <h2>첫 번째 포스트</h2>
        <p>오늘 Git을 배우기 시작했습니다!</p>
        <p>커밋이라는 개념이 정말 유용하네요.</p>
    </article>
</body>
```

### 5단계: 변경사항 확인 및 커밋

```bash
git status
git add index.html
git commit -m "feat: 첫 번째 블로그 포스트 추가"
```

## git log - 커밋 히스토리 보기

### 기본 로그

```bash
git log
```

**출력:**
```
commit b4c3d2e1f0a9b8c7d6e5f4a3b2c1d0e9 (HEAD -> main)
Author: 바데부 <badebu@vibedev.com>
Date:   Mon Oct 28 14:30:00 2025 +0900

    feat: 첫 번째 블로그 포스트 추가

commit a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6
Author: 바데부 <badebu@vibedev.com>
Date:   Mon Oct 28 14:00:00 2025 +0900

    feat: 블로그 초기 설정
```

### 한 줄로 보기

```bash
git log --oneline
```

**출력:**
```
b4c3d2e (HEAD -> main) feat: 첫 번째 블로그 포스트 추가
a1b2c3d feat: 블로그 초기 설정
```

### 그래프로 보기

```bash
git log --oneline --graph --all
```

**출력:**
```
* b4c3d2e (HEAD -> main) feat: 첫 번째 블로그 포스트 추가
* a1b2c3d feat: 블로그 초기 설정
```

### 커스텀 포맷

```bash
# 바데부의 선호 포맷
git log --pretty=format:"%h - %an, %ar : %s"
```

**출력:**
```
b4c3d2e - 바데부, 2 hours ago : feat: 첫 번째 블로그 포스트 추가
a1b2c3d - 바데부, 3 hours ago : feat: 블로그 초기 설정
```

**포맷 옵션:**
- `%h`: 짧은 해시
- `%H`: 전체 해시
- `%an`: 작성자 이름
- `%ae`: 작성자 이메일
- `%ar`: 상대적 날짜
- `%ad`: 절대적 날짜
- `%s`: 커밋 메시지

바데부의 별명:
```bash
# .gitconfig에 추가하면 편리해요
git config --global alias.lg "log --oneline --graph --all --decorate"

# 이제 이렇게만 입력하면 됩니다
git lg
```

## .gitignore - 무시할 파일 지정

### .gitignore가 필요한 이유

```
바데부의 실수담:
"한번은 비밀번호가 담긴 설정 파일을 커밋했어요.
다행히 원격에 푸시하기 전에 발견했지만,
그 뒤로는 항상 .gitignore를 만들어요!"
```

### .gitignore 파일 생성

```bash
# .gitignore 파일 생성
touch .gitignore
```

**.gitignore 내용:**
```gitignore
# 운영체제 파일
.DS_Store
Thumbs.db

# 에디터 설정
.vscode/
.idea/
*.swp

# 의존성
node_modules/
venv/
__pycache__/

# 환경 변수
.env
.env.local
secrets.json

# 빌드 결과물
dist/
build/
*.pyc
*.class

# 로그 파일
*.log
logs/

# 임시 파일
*.tmp
*~
```

### 패턴 규칙

```gitignore
# 파일 이름
secret.txt              # secret.txt 무시

# 확장자
*.log                   # 모든 .log 파일

# 디렉토리
node_modules/           # node_modules 폴더 전체

# 특정 경로
/config/database.yml    # 루트의 config/database.yml만

# 예외 (무시하지 않음)
!important.log          # important.log는 추적

# 와일드카드
**/*.pyc                # 모든 하위의 .pyc 파일
```

### .gitignore 적용

```bash
# .gitignore 파일 생성 및 편집 후
git add .gitignore
git commit -m "chore: .gitignore 추가"
```

**이미 추적 중인 파일 제거:**
```bash
# 파일은 유지하되 Git에서만 제거
git rm --cached secret.txt
git commit -m "chore: secret.txt를 추적에서 제거"
```

바데부의 템플릿:
```
"GitHub에서 언어별 .gitignore 템플릿을 제공해요!
https://github.com/github/gitignore
필요한 템플릿을 다운받아 사용하세요."
```

## 실습 체크리스트

스스로 해보세요:

```bash
# 1. 새 프로젝트 시작
mkdir my-practice
cd my-practice
git init

# 2. 파일 만들기
echo "# 내 프로젝트" > README.md

# 3. 상태 확인
git status

# 4. 추가 및 커밋
git add README.md
git commit -m "첫 커밋"

# 5. 히스토리 확인
git log
```

**확인 사항:**
- [ ] Git 저장소를 만들 수 있나요?
- [ ] 파일을 추가할 수 있나요?
- [ ] 의미 있는 커밋 메시지를 작성할 수 있나요?
- [ ] 커밋 히스토리를 확인할 수 있나요?
- [ ] .gitignore를 만들 수 있나요?

## 정리하며

### 핵심 명령어 요약

```bash
git init                # 저장소 초기화
git status              # 상태 확인
git add <파일>          # 파일 추가
git add .               # 모든 파일 추가
git commit -m "메시지"  # 커밋
git log                 # 히스토리 보기
```

### 바데부의 작업 플로우

```
1. 작업 시작
   ↓
2. git status (현재 상태 확인)
   ↓
3. 파일 수정/생성
   ↓
4. git status (무엇이 바뀌었는지 확인)
   ↓
5. git add . (변경사항 추가)
   ↓
6. git status (추가가 제대로 되었는지 확인)
   ↓
7. git commit -m "의미있는 메시지"
   ↓
8. git log (커밋 확인)
```

---

**바데부의 한마디:**
```
"이번 챕터에서 가장 중요한 명령어를 배웠어요!
init, add, commit, status - 이 네 가지만 잘 써도
Git의 80%는 마스터한 거예요.

처음엔 매번 status로 확인하는 게 번거로울 수 있지만,
이것이 실수를 줄이는 최고의 습관이랍니다!"
```

## 다음 챕터 예고

**Chapter 3: 브랜치**
- 브랜치가 무엇인지 이해하기
- 브랜치 만들고 이동하기
- 브랜치 병합하기
- 바데부의 브랜치 전략

Git의 가장 강력한 기능인 브랜치를 배울 준비되셨나요? 다음 챕터에서 만나요! 👋

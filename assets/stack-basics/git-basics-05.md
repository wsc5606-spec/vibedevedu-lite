# Chapter 5: 충돌 해결 (Merge Conflicts)

## 바데부의 충돌 극복기! 💥

안녕하세요! 바데부입니다. 오늘은 많은 분들이 두려워하는 주제, **충돌(Conflict)**에 대해 배워볼게요.
하지만 걱정하지 마세요! 충돌은 무서운 게 아니라 자연스러운 현상이에요.

## 충돌이란?

### 충돌 발생 원인

**충돌(Conflict)**은 같은 파일의 같은 부분을 서로 다르게 수정했을 때 발생합니다.

```
바데부의 이야기:
"처음 충돌을 만났을 때 정말 당황했어요.
화면에 이상한 기호들이 가득하고,
Git이 무슨 말을 하는지 모르겠더라고요.

하지만 충돌은 Git이 말하는 방식일 뿐이에요.
'이 부분, 네가 결정해줘!'라고요."
```

### 충돌 시나리오

**시나리오 1: 두 사람이 같은 줄 수정**
```
원본:
print("Hello")

바데부가 수정:              친구가 수정:
print("안녕하세요")        print("Hello World")

병합 시도:
충돌 발생! (어떤 버전을 선택할까?)
```

**시나리오 2: 한 사람은 수정, 다른 사람은 삭제**
```
원본:
def calculate():
    return 42

바데부: 함수 수정          친구: 함수 삭제

병합 시도:
충돌 발생! (남길까 지울까?)
```

## 충돌 만들어보기 (실습)

### 준비: 충돌 상황 만들기

```bash
# 새 프로젝트 시작
mkdir conflict-practice
cd conflict-practice
git init

# 초기 파일 생성
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날:
셋째 날:
EOF

git add story.txt
git commit -m "feat: 이야기 시작"
```

### 1단계: main 브랜치에서 수정

```bash
# main에서 둘째 날 작성
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 높은 산을 올랐다.
셋째 날:
EOF

git add story.txt
git commit -m "feat: 둘째 날 - 산 등반"
```

### 2단계: 새 브랜치에서 다르게 수정

```bash
# 과거로 돌아가서 (첫 커밋으로)
git checkout HEAD~1

# 새 브랜치 생성
git switch -c alternative-story

# 둘째 날을 다르게 작성
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 바다에서 수영을 했다.
셋째 날:
EOF

git add story.txt
git commit -m "feat: 둘째 날 - 바다 수영"
```

### 3단계: 충돌 발생!

```bash
# main으로 돌아가서 병합 시도
git switch main
git merge alternative-story
```

**출력:**
```
Auto-merging story.txt
CONFLICT (content): Merge conflict in story.txt
Automatic merge failed; fix conflicts and then commit the result.
```

**축하합니다! 첫 충돌을 만들었어요!** 😊

## 충돌 표시 읽기

### 충돌 파일 확인

```bash
# 상태 확인
git status
```

**출력:**
```
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   story.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

### 충돌 마커 이해하기

```bash
cat story.txt
```

**출력:**
```
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
<<<<<<< HEAD
둘째 날: 높은 산을 올랐다.
=======
둘째 날: 바다에서 수영을 했다.
>>>>>>> alternative-story
셋째 날:
```

**충돌 마커 설명:**
```
<<<<<<< HEAD
현재 브랜치(main)의 내용
=======
병합하려는 브랜치(alternative-story)의 내용
>>>>>>> alternative-story
```

바데부의 해석:
```
"<<<<<<< HEAD부터 =======까지는 내가 선택한 버전
=======부터 >>>>>>> 까지는 병합하려는 버전

Git이 묻는 거예요:
'둘 중 어떤 걸 선택할래? 아니면 둘 다?
아니면 완전히 새로 작성할래?'"
```

## 충돌 해결 방법

### 방법 1: 한쪽 선택하기

**현재 브랜치(HEAD) 선택:**
```bash
# story.txt 수정
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 높은 산을 올랐다.
셋째 날:
EOF

# 충돌 해결 완료 표시
git add story.txt
git commit -m "merge: alternative-story 병합 (산 등반 버전 선택)"
```

### 방법 2: 병합하려는 브랜치 선택

```bash
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 바다에서 수영을 했다.
셋째 날:
EOF

git add story.txt
git commit -m "merge: alternative-story 병합 (바다 수영 버전 선택)"
```

### 방법 3: 둘 다 포함하기

```bash
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 높은 산을 올랐다. 그리고 내려와서 바다에서 수영을 했다.
셋째 날:
EOF

git add story.txt
git commit -m "merge: alternative-story 병합 (두 이야기 결합)"
```

### 방법 4: 완전히 새로 작성

```bash
cat > story.txt << 'EOF'
바데부의 모험

첫째 날: 바데부가 여행을 시작했다.
둘째 날: 신비로운 숲을 탐험했다.
셋째 날:
EOF

git add story.txt
git commit -m "merge: alternative-story 병합 (새로운 이야기)"
```

## 충돌 해결 도구

### VSCode로 충돌 해결

VSCode는 충돌을 시각적으로 보여줍니다:

```
<<<<<<< HEAD
둘째 날: 높은 산을 올랐다.
||||||| merged common ancestors
=======
둘째 날: 바다에서 수영을 했다.
>>>>>>> alternative-story

[Accept Current Change] [Accept Incoming Change]
[Accept Both Changes] [Compare Changes]
```

**버튼 클릭만으로 해결!**

### Git 내장 도구

```bash
# 병합 도구 실행
git mergetool

# 기본 에디터 설정
git config --global merge.tool vimdiff
git config --global merge.tool vscode
```

### 명령줄 옵션

```bash
# 현재 브랜치 버전으로 해결
git checkout --ours story.txt
git add story.txt

# 병합하려는 브랜치 버전으로 해결
git checkout --theirs story.txt
git add story.txt
```

바데부의 선택:
```
"저는 VSCode를 주로 써요.
버튼 클릭만으로 해결할 수 있어서 편하거든요.
하지만 명령줄 옵션도 알아두면 유용해요!"
```

## 실전 예제: 협업 충돌 해결

### 시나리오: 팀 프로젝트

**상황:**
- 바데부와 친구가 함께 웹사이트 개발
- 같은 파일의 스타일을 각자 수정
- 충돌 발생!

```bash
# 프로젝트 시작
mkdir team-website
cd team-website
git init

# 초기 HTML
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>팀 프로젝트</title>
    <style>
        body {
            background-color: white;
            color: black;
        }
    </style>
</head>
<body>
    <h1>환영합니다</h1>
</body>
</html>
EOF

git add index.html
git commit -m "feat: 초기 HTML"
```

### 바데부의 수정

```bash
# 바데부 브랜치
git switch -c badebu-style

cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>팀 프로젝트</title>
    <style>
        body {
            background-color: #2c3e50;
            color: #ecf0f1;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <h1>환영합니다</h1>
</body>
</html>
EOF

git add index.html
git commit -m "style: 다크 테마 적용"
```

### 친구의 수정

```bash
# main으로 돌아가서
git switch main

# 친구 브랜치
git switch -c friend-style

cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>팀 프로젝트</title>
    <style>
        body {
            background-color: #3498db;
            color: white;
            font-family: 'Helvetica', sans-serif;
        }
    </style>
</head>
<body>
    <h1>환영합니다</h1>
</body>
</html>
EOF

git add index.html
git commit -m "style: 블루 테마 적용"
```

### 충돌 발생 및 해결

```bash
# main에 바데부 버전 병합
git switch main
git merge badebu-style  # 성공

# 친구 버전 병합 시도
git merge friend-style  # 충돌!
```

**충돌 내용:**
```html
<!DOCTYPE html>
<html>
<head>
    <title>팀 프로젝트</title>
    <style>
        body {
<<<<<<< HEAD
            background-color: #2c3e50;
            color: #ecf0f1;
            font-family: Arial, sans-serif;
=======
            background-color: #3498db;
            color: white;
            font-family: 'Helvetica', sans-serif;
>>>>>>> friend-style
        }
    </style>
</head>
<body>
    <h1>환영합니다</h1>
</body>
</html>
```

**협의 후 해결:**
```bash
# 팀원들과 상의 후 최종 결정
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>팀 프로젝트</title>
    <style>
        body {
            /* 바데부의 다크 배경 + 친구의 폰트 */
            background-color: #2c3e50;
            color: #ecf0f1;
            font-family: 'Helvetica', Arial, sans-serif;
        }
    </style>
</head>
<body>
    <h1>환영합니다</h1>
</body>
</html>
EOF

git add index.html
git commit -m "merge: 스타일 충돌 해결 (다크 테마 + Helvetica 폰트)"
```

## 충돌 예방 전략

### 1. 자주 Pull하기

```bash
# 바데부의 일일 루틴
git pull origin main    # 아침에 한 번
# ... 작업 ...
git pull origin main    # 점심에 한 번
# ... 작업 ...
git pull origin main    # 저녁에 한 번
```

바데부의 격언:
```
"자주 pull하면 충돌이 작아져요.
작은 충돌은 해결하기 쉽죠!"
```

### 2. 작은 단위로 커밋하기

```bash
# 나쁜 습관
# 하루 종일 작업 후 한 번에 커밋
git add .
git commit -m "오늘 한 모든 것"

# 좋은 습관
# 의미 있는 단위로 자주 커밋
git add login.py
git commit -m "feat: 로그인 폼 추가"

git add validation.py
git commit -m "feat: 입력 검증 추가"
```

### 3. 다른 파일 작업하기

```
팀 협업 시:
바데부   → frontend/login.html
친구     → backend/auth.py

같은 파일을 동시에 수정하지 않으면
충돌 확률이 낮아져요!
```

### 4. 작업 시작 전 브랜치 확인

```bash
# 항상 확인!
git status              # 깨끗한 상태인지
git branch              # 올바른 브랜치인지
git pull                # 최신 코드인지
```

### 5. 코드 리뷰와 소통

```
슬랙/디스코드:
"나 지금 config.js 수정 중이야!"

→ 팀원들이 같은 파일 작업 피함
→ 충돌 예방!
```

## 복잡한 충돌 해결

### 여러 파일에 충돌

```bash
git status
```

**출력:**
```
Unmerged paths:
        both modified:   index.html
        both modified:   style.css
        both modified:   script.js
```

**한 번에 하나씩:**
```bash
# 1. index.html 해결
vi index.html
git add index.html

# 2. style.css 해결
vi style.css
git add style.css

# 3. script.js 해결
vi script.js
git add script.js

# 4. 모두 해결 후 커밋
git commit
```

### 이진 파일 충돌

```
이미지, PDF 등 이진 파일은 병합 불가!
```

```bash
# 둘 중 하나 선택
git checkout --ours image.png      # 현재 버전
git checkout --theirs image.png    # 병합하려는 버전

git add image.png
git commit
```

바데부의 조언:
```
"이진 파일은 충돌 해결이 어려워요.
가능하면 같은 이진 파일을 동시에 수정하지 마세요.
또는 파일명에 버전을 붙여서 관리하는 것도 방법이에요.
(logo-v1.png, logo-v2.png)"
```

## 충돌 해결 실수 복구

### 실수했을 때

```bash
# 충돌 해결 중 실수!
# 잘못 수정했어요...

# 병합 취소
git merge --abort

# 처음부터 다시 시작
git merge alternative-story
```

### 이미 커밋한 경우

```bash
# 직전 커밋 취소
git reset --hard HEAD~1

# 다시 병합
git merge alternative-story
```

바데부의 안심:
```
"실수해도 괜찮아요!
Git은 항상 되돌릴 방법이 있답니다.
--abort와 reset을 기억하세요!"
```

## 고급 병합 전략

### Rebase로 깔끔한 히스토리

```bash
# Merge 대신 Rebase
git switch feature
git rebase main

# 충돌 발생 시
# 1. 충돌 해결
vi conflicted-file.txt
git add conflicted-file.txt

# 2. Rebase 계속
git rebase --continue

# 3. 문제 발생 시 취소
git rebase --abort
```

### Squash Merge

```bash
# 여러 커밋을 하나로 합쳐서 병합
git merge --squash feature-branch
git commit -m "feat: 새 기능 추가 (feature-branch 병합)"
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. 충돌 상황 만들기
mkdir practice
cd practice
git init
echo "원본" > file.txt
git add file.txt
git commit -m "Original"

# 2. main에서 수정
echo "main 버전" > file.txt
git commit -am "Main version"

# 3. 새 브랜치에서 다르게 수정
git checkout HEAD~1
git switch -c feature
echo "feature 버전" > file.txt
git commit -am "Feature version"

# 4. 충돌 발생
git switch main
git merge feature

# 5. 충돌 해결
# file.txt 수정
git add file.txt
git commit
```

**확인 사항:**
- [ ] 충돌을 만들 수 있나요?
- [ ] 충돌 마커를 읽을 수 있나요?
- [ ] 충돌을 해결할 수 있나요?
- [ ] 병합을 취소할 수 있나요?

## 정리하며

### 충돌 해결 순서

```
1. 충돌 발생
   ↓
2. git status (어떤 파일이 충돌?)
   ↓
3. 파일 열기 (충돌 마커 확인)
   ↓
4. 수정 (원하는 버전 선택/결합)
   ↓
5. git add (해결 완료 표시)
   ↓
6. git commit (병합 완료)
```

### 바데부의 충돌 해결 마인드셋

```
충돌은:
✗ 실패가 아니에요
✗ Git 오류가 아니에요
✗ 무서운 게 아니에요

충돌은:
✓ 자연스러운 현상이에요
✓ Git이 도움을 요청하는 거예요
✓ 배울 기회예요
✓ 팀원과 소통할 기회예요
```

---

**바데부의 한마디:**
```
"첫 충돌을 만났을 때 정말 당황했어요.
하지만 이제는 충돌이 두렵지 않아요.

충돌은 단지 Git이
'너의 결정이 필요해!'라고 말하는 거예요.

처음 몇 번은 어렵겠지만,
경험이 쌓이면 금방 익숙해질 거예요.

중요한 건 당황하지 않고
차근차근 마커를 읽고 해결하는 거예요!"
```

## 다음 챕터 예고

**Chapter 6: Git 히스토리**
- git log 활용법
- git diff로 차이 확인
- git blame으로 코드 추적
- 히스토리 검색 기법

코드의 과거를 탐험해봅시다! 다음 챕터에서 만나요! 👋

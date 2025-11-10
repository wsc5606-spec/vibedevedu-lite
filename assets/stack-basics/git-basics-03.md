# Chapter 3: 브랜치 (Branch, Checkout, Merge)

## 바데부의 평행우주 개발법!

안녕하세요! 바데부입니다. 오늘은 Git의 가장 강력한 기능인 **브랜치(Branch)**를 배워볼게요.
브랜치는 마치 평행우주처럼 여러 버전의 코드를 동시에 관리할 수 있게 해줍니다!

## 브랜치란 무엇인가?

### 개념 이해하기

브랜치는 **독립적인 작업 공간**입니다.

```
메인 프로젝트 (main)
    ●──●──●──●──●
         \       \
새 기능    ●──●   버그수정
(feature)        (hotfix)
```

바데부의 비유:
```
"브랜치는 워드 문서의 '다른 이름으로 저장'과 비슷해요.
원본은 그대로 두고 새로운 버전에서 실험할 수 있죠.
하지만 Git 브랜치는 훨씬 더 가볍고 강력해요!"
```

### 왜 브랜치를 사용하나요?

**시나리오: 바데부의 웹사이트**
```
상황:
- 현재 운영 중인 웹사이트가 있음 (안정적)
- 새로운 기능을 추가하고 싶음 (실험적)
- 동시에 버그도 수정해야 함 (긴급)

해결책:
main (안정 버전)
 ├── feature/new-login (새 기능 개발)
 └── hotfix/bug-123 (긴급 버그 수정)
```

**브랜치의 장점:**
1. 안전한 실험 공간
2. 동시 다발적 작업
3. 쉬운 협업
4. 깔끔한 이력 관리

## 브랜치 기본 명령어

### git branch - 브랜치 목록 보기

```bash
# 현재 브랜치 확인
git branch
```

**출력:**
```
* main
```

`*` 표시는 현재 있는 브랜치를 의미합니다.

```bash
# 모든 브랜치 보기 (원격 포함)
git branch -a

# 마지막 커밋과 함께 보기
git branch -v
```

### git branch <이름> - 새 브랜치 만들기

```bash
# 새 브랜치 생성
git branch feature/greeting

# 브랜치 목록 확인
git branch
```

**출력:**
```
  feature/greeting
* main
```

바데부의 팁:
```
"브랜치는 생성해도 자동으로 이동하지 않아요!
현재 브랜치는 여전히 main이랍니다."
```

### git checkout - 브랜치 이동

```bash
# 브랜치로 이동
git checkout feature/greeting

# 확인
git branch
```

**출력:**
```
* feature/greeting
  main
```

### git checkout -b - 생성과 동시에 이동

```bash
# 브랜치 생성 + 이동 (한 번에!)
git checkout -b feature/user-profile

# 이것은 아래 두 명령어와 같아요
# git branch feature/user-profile
# git checkout feature/user-profile
```

**최신 Git (2.23+)에서는:**
```bash
# 더 직관적인 명령어
git switch feature/user-profile     # 브랜치 이동
git switch -c feature/new-feature   # 생성 + 이동
```

바데부의 선택:
```bash
# 저는 이렇게 써요
git switch -c 브랜치명    # 새로 만들 때
git switch 브랜치명       # 이동할 때
```

## 실전 실습: 바데부의 계산기 프로젝트

### 1단계: 프로젝트 시작

```bash
mkdir calculator
cd calculator
git init

# 메인 파일 생성
cat > calculator.py << 'EOF'
class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

if __name__ == "__main__":
    calc = Calculator()
    print(f"5 + 3 = {calc.add(5, 3)}")
    print(f"5 - 3 = {calc.subtract(5, 3)}")
EOF

# 첫 커밋
git add calculator.py
git commit -m "feat: 기본 계산기 구현 (더하기, 빼기)"
```

### 2단계: 곱하기 기능 추가 (새 브랜치)

```bash
# 새 브랜치 생성 및 이동
git switch -c feature/multiply

# 파일 수정
cat > calculator.py << 'EOF'
class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

    def multiply(self, a, b):
        """곱하기 기능 - 바데부가 추가함"""
        return a * b

if __name__ == "__main__":
    calc = Calculator()
    print(f"5 + 3 = {calc.add(5, 3)}")
    print(f"5 - 3 = {calc.subtract(5, 3)}")
    print(f"5 * 3 = {calc.multiply(5, 3)}")
EOF

# 커밋
git add calculator.py
git commit -m "feat: 곱하기 기능 추가"
```

### 3단계: 브랜치 간 이동해보기

```bash
# main으로 돌아가기
git switch main

# calculator.py 확인
cat calculator.py
```

**놀라운 발견!**
```python
# 곱하기 함수가 없어요!
class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b
```

```bash
# 다시 feature 브랜치로
git switch feature/multiply

# calculator.py 확인
cat calculator.py
```

**곱하기 함수가 다시 나타났어요!**

바데부의 마법:
```
"같은 파일이지만 브랜치마다 다른 내용!
이것이 바로 브랜치의 마법이에요.
Git이 브랜치를 전환할 때마다
작업 디렉토리를 자동으로 업데이트해줍니다."
```

## git merge - 브랜치 병합하기

### Fast-Forward Merge (빠른 병합)

```bash
# main 브랜치로 이동
git switch main

# feature/multiply 브랜치를 병합
git merge feature/multiply
```

**출력:**
```
Updating a1b2c3d..e4f5g6h
Fast-forward
 calculator.py | 6 ++++++
 1 file changed, 6 insertions(+)
```

**Fast-Forward란?**
```
main     ●──●
              \
feature        ●──● (새 커밋들)

병합 후:
main     ●──●──●──● (feature의 커밋들이 그대로)
```

### 3-Way Merge (3방향 병합)

더 복잡한 시나리오를 만들어봅시다:

```bash
# main에서 추가 작업
git switch main
echo "# 바데부의 계산기" > README.md
git add README.md
git commit -m "docs: README 추가"

# 나누기 기능 브랜치
git switch -c feature/divide

# 나누기 기능 추가
cat > calculator.py << 'EOF'
class Calculator:
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

    def multiply(self, a, b):
        return a * b

    def divide(self, a, b):
        """나누기 기능 - 바데부가 추가함"""
        if b == 0:
            return "0으로 나눌 수 없습니다!"
        return a / b

if __name__ == "__main__":
    calc = Calculator()
    print(f"5 + 3 = {calc.add(5, 3)}")
    print(f"5 - 3 = {calc.subtract(5, 3)}")
    print(f"5 * 3 = {calc.multiply(5, 3)}")
    print(f"6 / 3 = {calc.divide(6, 3)}")
EOF

git add calculator.py
git commit -m "feat: 나누기 기능 추가 (0 나누기 처리 포함)"
```

**현재 상황:**
```
        ●──● (main: README 추가)
       /
●──●──●
       \
        ●──● (feature/divide: 나누기 추가)
```

```bash
# main으로 이동 후 병합
git switch main
git merge feature/divide
```

**출력:**
```
Merge made by the 'recursive' strategy.
 calculator.py | 7 +++++++
 1 file changed, 7 insertions(+)
```

**병합 후:**
```
        ●──●──────● (merge commit)
       /         /
●──●──●         /
       \       /
        ●──●──●
```

### 병합 후 정리

```bash
# 병합이 완료된 브랜치 삭제
git branch -d feature/divide
git branch -d feature/multiply

# 확인
git branch
```

**출력:**
```
* main
```

바데부의 팁:
```bash
# 병합되지 않은 브랜치는 -d로 삭제 안 됨
git branch -d feature/incomplete  # 에러!

# 강제 삭제 (주의!)
git branch -D feature/incomplete  # 삭제됨
```

## 브랜치 히스토리 시각화

### 텍스트 그래프

```bash
# 아름다운 그래프 보기
git log --graph --oneline --all --decorate
```

**출력 예시:**
```
*   a7b8c9d (HEAD -> main) Merge branch 'feature/divide'
|\
| * e4f5g6h feat: 나누기 기능 추가 (0 나누기 처리 포함)
* | b2c3d4e docs: README 추가
|/
* a1b2c3d feat: 곱하기 기능 추가
* 1234567 feat: 기본 계산기 구현 (더하기, 빼기)
```

### 바데부의 별명 설정

```bash
# 편리한 별명 만들기
git config --global alias.tree "log --graph --oneline --all --decorate"

# 이제 이렇게만 입력
git tree
```

**더 화려한 버전:**
```bash
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

git lg
```

## 브랜치 네이밍 규칙

### 바데부의 추천 규칙

```
형식: 타입/간단한-설명

타입:
- feature/   : 새 기능
- bugfix/    : 버그 수정
- hotfix/    : 긴급 수정
- release/   : 릴리스 준비
- docs/      : 문서만 수정
- refactor/  : 리팩토링
- test/      : 테스트 추가

예시:
feature/user-authentication
bugfix/login-validation
hotfix/security-patch
docs/api-documentation
```

**좋은 예시:**
```bash
git switch -c feature/dark-mode
git switch -c bugfix/navbar-responsive
git switch -c hotfix/critical-security-issue
git switch -c docs/getting-started
```

**나쁜 예시:**
```bash
git switch -c new-feature      # 너무 모호
git switch -c ㅋㅋㅋ            # 의미 없음
git switch -c temp             # 임시는 나중에 까먹어요
git switch -c 바데부의-멋진-기능 # 한글은 호환성 문제
```

## 브랜치 워크플로우 실습

### 시나리오: 블로그 개발

```bash
# 1. 프로젝트 시작
mkdir blog
cd blog
git init

# 초기 파일
echo "# 바데부의 블로그" > README.md
git add README.md
git commit -m "docs: 프로젝트 시작"

# 2. 메인 페이지 개발
git switch -c feature/homepage
echo "<h1>메인 페이지</h1>" > index.html
git add index.html
git commit -m "feat: 메인 페이지 추가"

# main에 병합
git switch main
git merge feature/homepage
git branch -d feature/homepage

# 3. 동시에 두 기능 개발
git switch -c feature/about
echo "<h1>소개 페이지</h1>" > about.html
git add about.html
git commit -m "feat: 소개 페이지 추가"

git switch main
git switch -c feature/contact
echo "<h1>연락처 페이지</h1>" > contact.html
git add contact.html
git commit -m "feat: 연락처 페이지 추가"

# 4. 하나씩 병합
git switch main
git merge feature/about
git merge feature/contact

# 5. 정리
git branch -d feature/about
git branch -d feature/contact

# 6. 히스토리 확인
git tree
```

## 브랜치 충돌 미리보기

충돌은 다음 챕터에서 자세히 다룰 예정이지만, 간단히 살펴볼게요:

```bash
# 상황: 같은 파일을 두 브랜치에서 수정

# main에서 수정
git switch main
echo "바데부 버전" > file.txt
git add file.txt
git commit -m "main에서 수정"

# feature에서 수정
git switch -c feature/edit
echo "기능 브랜치 버전" > file.txt
git add file.txt
git commit -m "feature에서 수정"

# 병합 시도
git switch main
git merge feature/edit
```

**출력:**
```
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

바데부의 안심 메시지:
```
"걱정하지 마세요! 충돌은 Git이 어떤 버전을 선택해야 할지
모를 때 일어나는 자연스러운 현상이에요.
다음 챕터에서 충돌 해결법을 배울 거예요!"
```

## 실용 팁과 트릭

### 브랜치 비교하기

```bash
# 두 브랜치의 차이 보기
git diff main..feature/new-feature

# 어떤 커밋이 다른지
git log main..feature/new-feature

# 한 브랜치에만 있는 커밋
git log main...feature/new-feature --left-right
```

### 브랜치 정보 확인

```bash
# 병합된 브랜치 목록
git branch --merged

# 병합되지 않은 브랜치 목록
git branch --no-merged

# 브랜치의 마지막 커밋
git branch -v

# 브랜치의 원격 추적 정보
git branch -vv
```

### 브랜치 이름 변경

```bash
# 현재 브랜치 이름 변경
git branch -m new-name

# 다른 브랜치 이름 변경
git branch -m old-name new-name
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. 새 프로젝트
mkdir git-practice
cd git-practice
git init

# 2. 첫 커밋
echo "# Git Practice" > README.md
git add README.md
git commit -m "Initial commit"

# 3. 새 브랜치 생성 및 작업
git switch -c feature/test
echo "테스트 파일" > test.txt
git add test.txt
git commit -m "Add test file"

# 4. main으로 돌아가서 병합
git switch main
git merge feature/test

# 5. 브랜치 삭제
git branch -d feature/test

# 6. 히스토리 확인
git log --oneline
```

**확인 사항:**
- [ ] 브랜치를 만들 수 있나요?
- [ ] 브랜치 간 이동할 수 있나요?
- [ ] 브랜치에서 커밋할 수 있나요?
- [ ] 브랜치를 병합할 수 있나요?
- [ ] 병합 후 브랜치를 삭제할 수 있나요?

## 정리하며

### 핵심 명령어

```bash
git branch                    # 브랜치 목록
git branch <이름>             # 브랜치 생성
git switch <이름>             # 브랜치 이동
git switch -c <이름>          # 생성 + 이동
git merge <브랜치>            # 병합
git branch -d <이름>          # 브랜치 삭제
```

### 바데부의 브랜치 체크리스트

```
작업 시작 전:
□ 현재 어느 브랜치인지 확인 (git branch)
□ main이 최신 상태인지 확인
□ 적절한 이름으로 브랜치 생성

작업 중:
□ 의미 있는 단위로 커밋
□ 정기적으로 main과 동기화

작업 완료 후:
□ 테스트 완료
□ main에 병합
□ 브랜치 삭제
```

---

**바데부의 한마디:**
```
"브랜치는 처음엔 복잡해 보이지만,
막상 써보면 정말 편리하답니다!

실수해도 괜찮아요. main 브랜치는 안전하니까요.
feature 브랜치에서 마음껏 실험해보세요!

저는 이제 브랜치 없이는 개발을 상상할 수 없어요.
여러분도 곧 그렇게 될 거예요!"
```

## 다음 챕터 예고

**Chapter 4: 원격 저장소**
- GitHub 연동하기
- push와 pull 이해하기
- 원격 브랜치 다루기
- 바데부의 협업 시작!

드디어 온라인 세계로 나갑니다! 다음 챕터에서 만나요! 👋

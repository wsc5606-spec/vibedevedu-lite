# Chapter 8: Stash와 임시 저장

## 바데부의 작업 보관함! 📦

안녕하세요! 바데부입니다. 작업 중에 갑자기 다른 일을 해야 할 때가 있죠?
오늘은 현재 작업을 안전하게 보관하는 **stash**를 배워볼게요!

## Stash가 필요한 순간

### 바데부의 일상

```
상황:
9:00 - 새 기능 개발 중 (50% 완료)
9:30 - 긴급 버그 리포트 도착!
9:31 - main 브랜치로 가서 hotfix 해야 함
9:32 - 하지만 현재 작업은 커밋하기 애매함...

해결책: Stash!
```

바데부의 비유:
```
"Stash는 작업 서랍이에요.
지금 하던 일을 서랍에 넣고
다른 일을 한 다음
다시 꺼내서 이어할 수 있죠!"
```

## git stash 기본

### 작업 저장하기

```bash
# 현재 변경사항 저장
git stash

# 또는 메시지와 함께
git stash save "작업 중인 로그인 기능"

# 또는 (최신 방식)
git stash push -m "작업 중인 로그인 기능"
```

**실습:**
```bash
# 1. 작업 시작
echo "로그인 기능 개발 중..." > login.py
echo "스타일 수정 중..." > style.css

# 2. 상태 확인
git status

# 3. 저장
git stash

# 4. 작업 디렉토리가 깨끗해졌어요!
git status
ls  # login.py와 style.css가 보이지 않아요
```

### 저장 목록 보기

```bash
# stash 목록
git stash list
```

**출력:**
```
stash@{0}: WIP on main: a7b8c9d 커밋 메시지
stash@{1}: WIP on feature: b2c3d4e 다른 작업
stash@{2}: On main: 작업 중인 로그인 기능
```

**설명:**
- `stash@{0}`: 가장 최근 stash
- `stash@{1}`: 두 번째 stash
- `WIP`: Work In Progress

### 저장한 작업 복구하기

```bash
# 가장 최근 stash 적용 (stash 유지)
git stash apply

# 가장 최근 stash 적용 (stash 삭제)
git stash pop

# 특정 stash 적용
git stash apply stash@{1}
git stash pop stash@{1}
```

**apply vs pop:**
```
apply: stash 목록에 남음 (안전)
pop:   stash 목록에서 제거 (깔끔)
```

바데부의 선호:
```bash
# 저는 보통 pop을 써요
git stash
# ... 다른 작업 ...
git stash pop

# 하지만 여러 브랜치에 같은 변경사항을 적용할 때는
git stash apply  # 여러 번 사용 가능
```

## 실전 시나리오

### 시나리오 1: 긴급 버그 수정

```bash
# 상황: feature 브랜치에서 작업 중
git switch -c feature/new-design
echo "새로운 디자인 작업 중..." > design.css
echo "헤더 컴포넌트 수정 중..." > header.jsx

# 긴급 버그 리포트!
# 1. 현재 작업 저장
git stash push -m "새 디자인 작업 중"

# 2. main으로 이동
git switch main

# 3. hotfix 브랜치 생성
git switch -c hotfix/critical-bug

# 4. 버그 수정
echo "버그 수정 완료" > fix.py
git add fix.py
git commit -m "fix: 긴급 버그 수정"

# 5. main에 병합
git switch main
git merge hotfix/critical-bug
git push origin main

# 6. 원래 작업으로 복귀
git switch feature/new-design
git stash pop

# 7. 작업 계속!
```

### 시나리오 2: 브랜치를 잘못 선택

```bash
# 실수: main에서 작업 시작
git switch main
echo "새 기능" > feature.py

# 앗! feature 브랜치에서 해야 했는데!
# 1. 작업 저장
git stash

# 2. 올바른 브랜치로
git switch -c feature/new-feature

# 3. 작업 복구
git stash pop

# 4. 커밋
git add feature.py
git commit -m "feat: 새 기능 추가"
```

### 시나리오 3: 실험적 코드

```bash
# 아이디어 실험
echo "실험적 코드..." > experiment.py

# 일단 저장
git stash push -m "실험: 새로운 알고리즘"

# 나중에 확인
git stash list

# 필요하면 적용
git stash apply stash@{0}

# 필요없으면 삭제
git stash drop stash@{0}
```

## Stash 고급 기능

### Untracked 파일 포함

```bash
# 기본 stash는 추적 중인 파일만 저장
# 새 파일도 함께 저장하려면
git stash -u
git stash --include-untracked

# 무시된 파일까지 모두
git stash -a
git stash --all
```

**실습:**
```bash
# 1. 여러 종류의 파일 생성
echo "수정된 파일" >> tracked.txt
echo "새 파일" > new-file.txt
echo "임시 파일" > temp.log

# 2. .gitignore 설정
echo "*.log" > .gitignore

# 3. 일반 stash
git stash
git status  # new-file.txt가 남아있음

# 4. untracked 포함 stash
git stash -u
git status  # 모두 깨끗 (temp.log만 남음)

# 5. 모든 것 포함
git stash -a
git status  # 완전히 깨끗
```

### 특정 파일만 stash

```bash
# 특정 파일만 저장 (Git 2.13+)
git stash push -m "메시지" file1.py file2.py

# 경로 패턴으로
git stash push -m "CSS만" "*.css"
```

### Staged와 Unstaged 구분

```bash
# staged 상태 유지하면서 stash
git stash --keep-index

# staged만 stash (unstaged는 유지)
git stash --staged
```

**실습:**
```bash
# 1. 파일 수정
echo "변경 1" > file1.txt
echo "변경 2" > file2.txt

# 2. 하나만 add
git add file1.txt

# 3. staged 유지하고 stash
git stash --keep-index

# 4. 확인
git status  # file1.txt는 staged 상태
```

## Stash 관리

### Stash 내용 확인

```bash
# 간단한 요약
git stash show

# 상세 변경사항
git stash show -p
git stash show --patch

# 특정 stash
git stash show -p stash@{1}
```

**출력:**
```
 login.py  | 25 +++++++++++++++++++++++++
 style.css |  5 +++++
 2 files changed, 30 insertions(+)
```

### Stash 삭제

```bash
# 특정 stash 삭제
git stash drop stash@{1}

# 가장 최근 stash 삭제
git stash drop

# 모든 stash 삭제
git stash clear
```

바데부의 정리:
```bash
# 주말마다 stash 정리
git stash list  # 뭐가 있는지 확인
git stash clear  # 필요없으면 전부 삭제

# stash가 너무 많으면 헷갈려요!
```

### Stash를 브랜치로 만들기

```bash
# stash에서 새 브랜치 생성
git stash branch new-branch-name

# 또는 특정 stash로
git stash branch new-branch-name stash@{1}
```

**언제 사용하나요?**
```
상황: stash를 pop했는데 충돌 발생!

해결:
git stash branch temp-branch
→ 충돌 없이 새 브랜치 생성
→ 천천히 해결
```

## Stash 활용 패턴

### 패턴 1: 코드 리뷰 준비

```bash
# 작업 중인 내용 저장
git stash push -m "진행 중인 작업"

# 깨끗한 상태에서 코드 리뷰
git checkout feature-branch
# 리뷰 진행...

# 원래 작업으로 복귀
git switch my-branch
git stash pop
```

### 패턴 2: 실험과 비교

```bash
# 현재 접근법 A 저장
git stash push -m "접근법 A"

# 접근법 B 시도
# ... 코드 작성 ...

# B가 더 나쁘다면
git reset --hard HEAD

# A 복구
git stash pop

# B가 더 좋다면
git add .
git commit -m "feat: 접근법 B 적용"
git stash drop  # A 삭제
```

### 패턴 3: 정기적 백업

```bash
# 하루 일과 종료 시
git stash push -m "2025-10-28 작업 종료"

# 다음날
git stash list  # 어제 작업 확인
git stash apply stash@{0}  # 계속 작업
```

## 실전 예제

### 예제 1: 여러 브랜치에 같은 수정 적용

```bash
# CSS 버그 발견
echo "/* 버그 수정 */" >> style.css

# stash에 저장
git stash push -m "CSS 버그 수정"

# 여러 브랜치에 적용
git switch main
git stash apply
git commit -am "fix: CSS 버그 수정"

git switch develop
git stash apply
git commit -am "fix: CSS 버그 수정"

git switch feature
git stash apply
git commit -am "fix: CSS 버그 수정"

# stash 삭제
git stash drop
```

### 예제 2: Pull 전 충돌 방지

```bash
# 작업 중
echo "로컬 변경사항" >> file.txt

# pull이 필요
git pull  # 에러! 로컬 변경사항이 덮어씌워질 수 있음

# 해결
git stash
git pull
git stash pop

# 충돌이 있다면 해결
```

### 예제 3: 테스트 환경 구성

```bash
# 개발 환경 설정
echo "DEBUG=True" > .env
echo "DB=localhost" >> .env

# 테스트 시
git stash push -u -m "개발 환경"

# 프로덕션 설정
echo "DEBUG=False" > .env
echo "DB=production" >> .env

# 테스트 실행...

# 개발 환경 복구
git stash pop
```

## Stash vs 다른 방법들

### Stash vs 커밋

```
Stash:
✓ 임시 저장
✓ 히스토리에 남지 않음
✓ 빠른 작업 전환
✗ 공유 불가

커밋:
✓ 영구 저장
✓ 히스토리에 기록
✓ 팀과 공유 가능
✗ 의미 있는 단위여야 함
```

바데부의 기준:
```
Stash: 30분 이내 돌아올 작업
커밋: 의미 있는 진행 단계

예:
- 긴급 버그 수정: Stash
- 점심 먹으러 가기: Stash
- 기능 일부 완성: 커밋
- 하루 종료: 커밋
```

### Stash vs 브랜치

```
Stash:
✓ 빠름
✓ 간단함
✗ 관리 어려움 (많아지면)

브랜치:
✓ 체계적 관리
✓ 여러 작업 동시 진행
✗ 상대적으로 복잡
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. 작업 생성
mkdir stash-practice
cd stash-practice
git init
echo "원본" > file.txt
git add file.txt
git commit -m "Initial"

# 2. 수정 후 stash
echo "변경 1" >> file.txt
git stash

# 3. 다른 작업
echo "다른 작업" > other.txt
git add other.txt
git commit -m "Other work"

# 4. 원래 작업 복구
git stash pop

# 5. 두 작업 모두 확인
git status
```

**확인 사항:**
- [ ] 작업을 stash할 수 있나요?
- [ ] stash 목록을 확인할 수 있나요?
- [ ] stash를 apply/pop할 수 있나요?
- [ ] untracked 파일도 stash할 수 있나요?
- [ ] apply와 pop의 차이를 이해했나요?

## Stash 문제 해결

### 문제 1: Pop 시 충돌

```bash
# 충돌 발생
git stash pop
# Auto-merging file.txt
# CONFLICT (content): Merge conflict in file.txt

# 해결 방법 1: 충돌 해결
vi file.txt  # 충돌 수정
git add file.txt
# stash는 자동으로 삭제됨

# 해결 방법 2: 취소
git reset --merge
git stash drop  # 수동으로 삭제해야 함
```

### 문제 2: Stash가 많아짐

```bash
# 목록 확인
git stash list

# 하나씩 확인하며 정리
git stash show -p stash@{0}
git stash drop stash@{0}

# 또는 한 번에
git stash clear
```

### 문제 3: Stash를 실수로 삭제

```bash
# 최근 삭제된 stash 복구
git fsck --unreachable | grep commit | cut -d ' ' -f3 | xargs git log --merges --no-walk --grep=WIP

# 해시를 찾았으면
git cherry-pick [해시]
```

## 정리하며

### 핵심 명령어

```bash
git stash                    # 저장
git stash push -m "메시지"   # 메시지와 함께 저장
git stash -u                 # 새 파일 포함
git stash list               # 목록
git stash show -p            # 내용 확인
git stash pop                # 복구 (삭제)
git stash apply              # 복구 (유지)
git stash drop               # 삭제
git stash clear              # 전체 삭제
```

### 바데부의 Stash 워크플로우

```
1. 작업 중단 필요
   ↓
2. git stash push -m "설명"
   ↓
3. 브랜치 전환 / 다른 작업
   ↓
4. 원래 브랜치로 복귀
   ↓
5. git stash list (확인)
   ↓
6. git stash pop (복구)
   ↓
7. 작업 계속
```

### 모범 사례

```
✓ 의미 있는 메시지 작성
✓ 정기적으로 stash 정리
✓ 중요한 작업은 커밋으로 전환
✓ stash 목록을 3개 이하로 유지
✗ stash를 장기 저장소로 사용
✗ stash로 팀과 작업 공유
```

---

**바데부의 한마디:**
```
"Stash는 제 개발 생활을 바꿔놓았어요!

예전엔 급하게 브랜치를 전환해야 할 때
'임시 커밋'을 만들곤 했어요.
그러면 커밋 히스토리가 지저분해지죠.

이제는 stash로 깔끔하게 처리합니다.
마치 작업을 서랍에 넣었다가 꺼내는 것처럼요!

작업 전환이 빈번한 여러분에게
정말 유용한 도구가 될 거예요."
```

## 다음 챕터 예고

**Chapter 9: Git 워크플로우**
- Gitflow 이해하기
- Pull Request 과정
- 협업 전략
- 바데부의 팀 협업 경험

실전 협업 방법을 배워봅시다! 다음 챕터에서 만나요! 👋

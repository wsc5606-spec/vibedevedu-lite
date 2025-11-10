# Chapter 7: 되돌리기 (Reset, Revert, Checkout)

## 바데부의 타임머신! 🔙

안녕하세요! 바데부입니다. 실수는 누구나 합니다. 중요한 건 되돌리는 방법을 아는 것이죠!
오늘은 Git으로 시간을 되돌리는 여러 방법을 배워볼게요.

## 되돌리기 시나리오

### 바데부의 실수들

```
실수 1: 커밋 메시지를 잘못 썼어요
실수 2: 잘못된 파일을 커밋했어요
실수 3: 커밋 자체가 잘못되었어요
실수 4: 여러 커밋을 한꺼번에 되돌리고 싶어요
실수 5: 파일을 실수로 삭제했어요
```

**좋은 소식:** 모두 복구 가능합니다!

바데부의 위안:
```
"제가 Git을 사랑하는 이유는
실수를 두려워하지 않아도 되기 때문이에요.
거의 모든 것을 되돌릴 수 있거든요!"
```

## 되돌리기 레벨 이해

### 세 가지 영역

```
작업 디렉토리     준비 영역        저장소
(Working Dir)  (Staging Area)  (Repository)

레벨 1: 파일 수정 취소 (작업 디렉토리)
레벨 2: add 취소 (준비 영역)
레벨 3: 커밋 수정/취소 (저장소)
```

## 레벨 1: 작업 디렉토리 되돌리기

### 파일 수정 취소

```bash
# 상황: 파일을 수정했는데 취소하고 싶어요
echo "잘못된 내용" >> file.txt

# 마지막 커밋 상태로 복구
git restore file.txt

# 또는 (구버전)
git checkout -- file.txt
```

**실습:**
```bash
# 1. 파일 수정
echo "실수로 추가한 내용" >> README.md

# 2. 상태 확인
git status
git diff

# 3. 복구
git restore README.md

# 4. 확인
git status  # 깨끗!
```

### 모든 변경사항 취소

```bash
# 모든 수정된 파일 복구
git restore .

# 특정 폴더만
git restore src/
```

바데부의 주의:
```
"⚠️ restore는 되돌릴 수 없어요!
커밋하지 않은 변경사항은 영원히 사라집니다.
신중하게 사용하세요!"
```

## 레벨 2: 준비 영역 되돌리기

### add 취소하기

```bash
# 상황: 실수로 add했어요
git add wrong-file.txt

# add 취소
git restore --staged wrong-file.txt

# 또는 (구버전)
git reset HEAD wrong-file.txt
```

**실습:**
```bash
# 1. 파일 생성 및 추가
echo "비밀번호 123456" > secrets.txt
git add secrets.txt

# 2. 앗, 이건 커밋하면 안 되는데!
git status

# 3. add 취소
git restore --staged secrets.txt

# 4. 확인
git status  # Untracked files로 돌아감

# 5. .gitignore에 추가
echo "secrets.txt" >> .gitignore
git add .gitignore
git commit -m "chore: secrets.txt 무시하도록 설정"
```

### 모든 add 취소

```bash
# 모든 staged 파일 취소
git restore --staged .
```

## 레벨 3: 커밋 수정하기

### 직전 커밋 메시지 수정

```bash
# 상황: 커밋 메시지를 잘못 썼어요
git commit -m "fix: 로그인 뻐그 수정"  # 오타!

# 메시지 수정
git commit --amend -m "fix: 로그인 버그 수정"
```

### 직전 커밋에 파일 추가

```bash
# 상황: 파일을 빼먹었어요
git commit -m "feat: 로그인 기능 추가"

# 앗, style.css를 빼먹었어요!
git add style.css
git commit --amend --no-edit  # 메시지는 그대로
```

**실습:**
```bash
# 1. 커밋
echo "print('Hello')" > main.py
git add main.py
git commit -m "feat: 메인 파일 추가"

# 2. 앗, README도 추가해야 했는데!
echo "# My Project" > README.md
git add README.md

# 3. 이전 커밋에 합치기
git commit --amend --no-edit

# 4. 확인
git log --oneline -1
git show HEAD  # main.py와 README.md 둘 다 포함됨
```

바데부의 경고:
```
"⚠️ --amend는 이미 push한 커밋에는 사용하지 마세요!
커밋 해시가 바뀌어서 협업자들에게 혼란을 줄 수 있어요."
```

## git reset - 커밋 되돌리기

### reset의 세 가지 모드

```
--soft   : 커밋만 취소 (파일은 staged 상태)
--mixed  : 커밋 + add 취소 (기본값)
--hard   : 커밋 + add + 파일 변경 모두 취소
```

### 시각적 이해

```
초기 상태:
A → B → C (HEAD)

git reset --soft B:
A → B (HEAD)
C의 변경사항: staged 상태

git reset --mixed B:
A → B (HEAD)
C의 변경사항: unstaged 상태

git reset --hard B:
A → B (HEAD)
C의 변경사항: 완전히 삭제
```

### reset --soft 실습

```bash
# 준비
echo "파일 1" > file1.txt
git add file1.txt
git commit -m "커밋 1"

echo "파일 2" > file2.txt
git add file2.txt
git commit -m "커밋 2"

echo "파일 3" > file3.txt
git add file3.txt
git commit -m "커밋 3"

# 두 커밋 되돌리기
git reset --soft HEAD~2

# 확인
git status  # file2.txt, file3.txt가 staged 상태
git log --oneline  # "커밋 1"까지만 있음

# 다시 커밋
git commit -m "커밋 2와 3을 합침"
```

### reset --mixed 실습

```bash
# 이전과 동일하게 3개 커밋 생성

# 두 커밋 되돌리기
git reset HEAD~2  # --mixed는 기본값

# 확인
git status  # file2.txt, file3.txt가 unstaged 상태

# 원하는 대로 다시 커밋
git add file2.txt
git commit -m "파일 2만 추가"
```

### reset --hard 실습

```bash
# 이전과 동일하게 3개 커밋 생성

# 두 커밋 완전히 삭제
git reset --hard HEAD~2

# 확인
ls  # file1.txt만 있음
git log --oneline  # "커밋 1"만 있음
```

**⚠️ 위험!** `--hard`는 복구 불가능합니다!

### 특정 커밋으로 reset

```bash
# 특정 커밋 해시로
git reset --soft a7b8c9d

# 브랜치로
git reset --mixed origin/main

# 태그로
git reset --hard v1.0.0
```

## git revert - 안전한 되돌리기

### revert vs reset

```
reset: 커밋을 삭제 (위험, 히스토리 변경)
revert: 새로운 커밋으로 되돌림 (안전, 히스토리 유지)
```

**언제 무엇을 사용하나요?**
```
push 전: reset 사용 가능
push 후: revert 사용 (필수!)
```

### 기본 revert

```bash
# 직전 커밋 되돌리기
git revert HEAD

# 특정 커밋 되돌리기
git revert a7b8c9d
```

**실습:**
```bash
# 1. 커밋 생성
echo "기능 A" > feature-a.txt
git add feature-a.txt
git commit -m "feat: 기능 A 추가"

# 2. 문제 발견! 되돌려야 해요
git revert HEAD

# 3. 에디터가 열림
# 기본 메시지: "Revert "feat: 기능 A 추가""
# 저장하고 닫기

# 4. 확인
git log --oneline
```

**출력:**
```
b2c3d4e Revert "feat: 기능 A 추가"
a7b8c9d feat: 기능 A 추가
```

### 여러 커밋 revert

```bash
# 범위로 revert
git revert HEAD~3..HEAD

# 또는 하나씩
git revert HEAD
git revert HEAD~1
git revert HEAD~2
```

### 병합 커밋 revert

```bash
# 병합 커밋 되돌리기
git revert -m 1 <병합커밋해시>

# -m 1: 첫 번째 부모(main) 유지
# -m 2: 두 번째 부모(feature) 유지
```

바데부의 선호:
```
협업 중에는 항상 revert!

reset은:
- 로컬에서만
- push 전에만
- 혼자 작업할 때만

revert는:
- 원격 저장소에도 안전
- 히스토리 보존
- 투명한 작업 기록
```

## 파일 복구하기

### 삭제한 파일 복구

```bash
# 상황 1: 파일을 삭제했어요 (커밋 전)
rm important.txt

# 복구
git restore important.txt
```

```bash
# 상황 2: 파일을 삭제하고 커밋했어요
git rm important.txt
git commit -m "파일 삭제"

# 복구 (이전 커밋에서)
git checkout HEAD~1 -- important.txt
git add important.txt
git commit -m "파일 복구"
```

### 특정 버전의 파일 가져오기

```bash
# 3개 커밋 전의 파일
git checkout HEAD~3 -- file.txt

# 특정 커밋의 파일
git checkout a7b8c9d -- file.txt

# 다른 브랜치의 파일
git checkout feature-branch -- file.txt
```

## 실전 시나리오

### 시나리오 1: 실수로 main에 커밋

```bash
# 실수: feature 브랜치에서 작업해야 했는데 main에 커밋
# main에서
git add .
git commit -m "새 기능"

# 해결
# 1. 새 브랜치 생성 (현재 상태 유지)
git branch feature/new-feature

# 2. main을 이전 상태로
git reset --hard HEAD~1

# 3. feature 브랜치로 이동
git switch feature/new-feature

# 성공! 커밋이 올바른 브랜치에 있어요
```

### 시나리오 2: 여러 파일 중 일부만 되돌리기

```bash
# 커밋에서 특정 파일만 되돌리기
git show HEAD:old-file.txt > old-file.txt
git add old-file.txt
git commit -m "fix: old-file.txt를 이전 버전으로 복구"
```

### 시나리오 3: 병합 되돌리기

```bash
# 병합했는데 문제가 발생
git merge feature-branch  # 문제 발생!

# 즉시 취소
git merge --abort

# 또는 이미 커밋했다면
git reset --hard HEAD~1  # 로컬만
# 또는
git revert -m 1 HEAD  # push한 경우
```

### 시나리오 4: 잘못된 커밋을 push했어요!

```bash
# 1. 로컬에서 수정
git revert HEAD  # 또는 여러 커밋

# 2. push
git push origin main

# 절대 하지 말 것: git push --force (다른 사람에게 피해)
```

## git reflog - 최후의 수단

### reflog란?

**reflog**는 HEAD의 모든 이동 기록을 저장합니다.

```bash
git reflog
```

**출력:**
```
a7b8c9d HEAD@{0}: commit: 새 기능 추가
b2c3d4e HEAD@{1}: reset: moving to HEAD~1
c3d4e5f HEAD@{2}: commit: 잘못된 커밋
d4e5f6g HEAD@{3}: commit: 이전 커밋
```

### 실수 복구하기

```bash
# 실수: 중요한 커밋을 --hard로 삭제
git reset --hard HEAD~3

# 앗! 되돌리고 싶어요
git reflog

# 원하는 시점 찾기
git reset --hard HEAD@{1}
```

**실습:**
```bash
# 1. 커밋들 만들기
echo "A" > file.txt && git add . && git commit -m "A"
echo "B" > file.txt && git add . && git commit -m "B"
echo "C" > file.txt && git add . && git commit -m "C"

# 2. 실수로 모두 삭제
git reset --hard HEAD~3

# 3. reflog 확인
git reflog

# 4. 복구
git reset --hard HEAD@{1}

# 5. 모든 커밋이 돌아왔어요!
```

바데부의 구명줄:
```
"reflog는 제 구명줄이에요!
몇 번이나 실수를 복구했답니다.

기본적으로 30일간 보관되니까
한 달 안의 작업은 대부분 복구 가능해요!"
```

## 안전하게 실험하기

### 실험용 브랜치

```bash
# 위험한 작업 전에
git branch backup

# 실험
git reset --hard HEAD~5  # 또는 다른 위험한 작업

# 문제 발생 시
git switch backup
git branch -D main
git branch -m backup main
```

### Stash 활용

```bash
# 현재 작업 임시 저장
git stash

# 실험
git reset --hard HEAD~2

# 문제 발생 시
git stash pop  # 작업 복구
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. 테스트 저장소 만들기
mkdir reset-practice
cd reset-practice
git init

# 2. 여러 커밋 만들기
echo "1" > file.txt && git add . && git commit -m "1"
echo "2" > file.txt && git add . && git commit -m "2"
echo "3" > file.txt && git add . && git commit -m "3"

# 3. reset --soft 실습
git reset --soft HEAD~1
git status

# 4. reset --mixed 실습
git commit -m "3"
git reset HEAD~1
git status

# 5. revert 실습
git add . && git commit -m "3"
git revert HEAD

# 6. reflog 확인
git reflog
```

**확인 사항:**
- [ ] 파일 수정을 취소할 수 있나요?
- [ ] add를 취소할 수 있나요?
- [ ] 커밋을 수정할 수 있나요?
- [ ] reset의 세 가지 모드를 이해했나요?
- [ ] revert와 reset의 차이를 아나요?
- [ ] reflog를 활용할 수 있나요?

## 정리하며

### 되돌리기 결정 트리

```
Q: 무엇을 되돌리고 싶나요?

A: 파일 수정 (커밋 전)
   → git restore <파일>

A: add (staged 취소)
   → git restore --staged <파일>

A: 직전 커밋 메시지
   → git commit --amend

A: 로컬 커밋 (push 전)
   → git reset --soft/mixed/hard

A: 원격 커밋 (push 후)
   → git revert

A: 모든 것이 꼬였어요!
   → git reflog
```

### 안전 수칙

```
1. 중요한 작업 전 브랜치 백업
2. push한 커밋은 revert 사용
3. --hard 사용 시 두 번 생각하기
4. reflog는 30일만 유효
5. 확신이 없으면 stash 활용
```

### 바데부의 명령어 선호도

```
가장 자주: git restore (파일 복구)
자주: git commit --amend (커밋 수정)
가끔: git reset --soft (커밋 다시 정리)
드물게: git reset --hard (정말 필요할 때)
협업 시: git revert (항상!)
비상시: git reflog (구명줄!)
```

---

**바데부의 한마디:**
```
"처음 Git을 배울 때 가장 무서웠던 게
'실수하면 어떡하지?'였어요.

하지만 이제 알아요.
Git은 놀라울 정도로 관대한 시스템이에요.
거의 모든 실수를 되돌릴 수 있죠.

reset, revert, reflog를 알고 나니
자신감 있게 실험할 수 있게 되었어요.

실수를 두려워하지 마세요.
그것도 배움의 과정이니까요!"
```

## 다음 챕터 예고

**Chapter 8: Stash와 임시 저장**
- 작업 임시 저장하기
- stash 관리하기
- stash 활용 전략
- 바데부의 작업 전환 기술

작업을 잠시 보관하는 마법을 배워봅시다! 다음 챕터에서 만나요! 👋

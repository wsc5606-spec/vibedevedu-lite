# Chapter 6: Git 히스토리 (Log, Diff, Blame)

## 바데부의 시간 여행! ⏰

안녕하세요! 바데부입니다. 오늘은 Git으로 과거를 탐험하는 방법을 배워볼게요.
누가, 언제, 무엇을, 왜 바꿨는지 모두 알 수 있답니다!

## git log - 커밋 히스토리

### 기본 로그 보기

```bash
git log
```

**출력:**
```
commit a7b8c9d1e2f3g4h5i6j7k8l9m0n1o2p3 (HEAD -> main)
Author: 바데부 <badebu@vibedev.com>
Date:   Mon Oct 28 14:30:00 2025 +0900

    feat: 로그인 기능 추가

    사용자 인증 시스템 구현
    - 이메일/비밀번호 로그인
    - 세션 관리
    - 로그아웃 기능

commit b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7
Author: 바데부 <badebu@vibedev.com>
Date:   Mon Oct 28 10:00:00 2025 +0900

    docs: README 업데이트
```

**정보 해석:**
- `commit`: 고유 해시 (SHA-1)
- `Author`: 작성자
- `Date`: 작성 시간
- 메시지: 커밋 메시지

### 간단하게 보기

```bash
# 한 줄로 보기
git log --oneline
```

**출력:**
```
a7b8c9d (HEAD -> main) feat: 로그인 기능 추가
b2c3d4e docs: README 업데이트
c3d4e5f fix: 버그 수정
d4e5f6g feat: 초기 설정
```

바데부의 팁:
```bash
# 최근 5개만 보기
git log --oneline -5

# 최근 10개
git log --oneline -10
```

### 그래프로 보기

```bash
git log --graph --oneline --all
```

**출력:**
```
* a7b8c9d (HEAD -> main) feat: 로그인 기능 추가
*   b2c3d4e Merge branch 'feature/auth'
|\
| * c3d4e5f feat: 인증 모듈
| * d4e5f6g feat: 세션 관리
|/
* e5f6g7h feat: 초기 설정
```

### 상세 정보 보기

```bash
# 변경된 파일 목록 포함
git log --stat
```

**출력:**
```
commit a7b8c9d
Author: 바데부 <badebu@vibedev.com>
Date:   Mon Oct 28 14:30:00 2025 +0900

    feat: 로그인 기능 추가

 auth/login.py    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 auth/session.py  | 23 +++++++++++++++++++++++
 templates/login.html | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
```

```bash
# 실제 변경 내용까지 보기
git log -p
git log --patch
```

## 커스텀 로그 포맷

### 바데부의 선호 포맷

```bash
# 예쁜 포맷
git log --pretty=format:"%h - %an, %ar : %s"
```

**출력:**
```
a7b8c9d - 바데부, 2 hours ago : feat: 로그인 기능 추가
b2c3d4e - 바데부, 1 day ago : docs: README 업데이트
c3d4e5f - 바데부, 2 days ago : fix: 버그 수정
```

### 포맷 옵션들

```
%H  - 전체 커밋 해시
%h  - 짧은 커밋 해시
%an - 작성자 이름
%ae - 작성자 이메일
%ad - 작성 날짜
%ar - 상대적 날짜 (2 hours ago)
%s  - 커밋 메시지 제목
%b  - 커밋 메시지 본문
%Cred - 빨간색으로 전환
%Cgreen - 초록색으로 전환
%Creset - 색상 리셋
```

### 화려한 로그

```bash
git log --pretty=format:"%C(yellow)%h%C(reset) - %C(cyan)%an%C(reset), %C(green)%ar%C(reset) : %s" --graph
```

**별명으로 저장:**
```bash
git config --global alias.lg "log --graph --pretty=format:'%C(yellow)%h%C(reset) - %C(cyan)%an%C(reset), %C(green)%ar%C(reset) : %s' --abbrev-commit --date=relative"

# 이제 간단하게
git lg
```

## 로그 필터링

### 날짜로 필터링

```bash
# 특정 날짜 이후
git log --since="2025-10-01"
git log --since="2 weeks ago"
git log --since="3 days ago"

# 특정 날짜 이전
git log --until="2025-10-28"
git log --until="1 week ago"

# 범위 지정
git log --since="2025-10-01" --until="2025-10-28"
```

### 작성자로 필터링

```bash
# 바데부의 커밋만
git log --author="바데부"

# 여러 작성자
git log --author="바데부\|친구"

# 이메일로
git log --author="badebu@vibedev.com"
```

### 메시지로 검색

```bash
# "로그인"이 포함된 커밋
git log --grep="로그인"

# 대소문자 구분 없이
git log --grep="login" -i

# 여러 키워드
git log --grep="로그인" --grep="인증" --all-match
```

### 파일로 필터링

```bash
# 특정 파일의 히스토리
git log -- README.md

# 특정 폴더
git log -- src/

# 여러 파일
git log -- file1.py file2.py

# 삭제된 파일 포함
git log --all --full-history -- deleted-file.txt
```

### 내용으로 검색

```bash
# "function"이라는 단어가 추가/삭제된 커밋
git log -S"function"

# 정규표현식 검색
git log -G"func.*login"
```

바데부의 탐정 기술:
```bash
# 비밀번호가 커밋된 적이 있는지 확인
git log -S"password" --all

# 특정 함수가 언제 추가되었는지
git log -S"def login_user"
```

## git diff - 차이점 비교

### 작업 디렉토리 vs 준비 영역

```bash
# 아직 add하지 않은 변경사항
git diff
```

**실습:**
```bash
# 파일 수정
echo "새로운 줄" >> file.txt

# 차이 확인
git diff
```

**출력:**
```diff
diff --git a/file.txt b/file.txt
index 1234567..abcdefg 100644
--- a/file.txt
+++ b/file.txt
@@ -1,3 +1,4 @@
 첫 번째 줄
 두 번째 줄
 세 번째 줄
+새로운 줄
```

**기호 해석:**
- `---`: 이전 버전
- `+++`: 새 버전
- `-`: 삭제된 줄 (빨간색)
- `+`: 추가된 줄 (초록색)
- `@@`: 변경 위치

### 준비 영역 vs 저장소

```bash
# add한 후의 변경사항 확인
git add file.txt
git diff --staged
git diff --cached  # 같은 의미
```

### 커밋 간 비교

```bash
# 최근 두 커밋 비교
git diff HEAD~1 HEAD

# 특정 커밋들 비교
git diff a7b8c9d b2c3d4e

# 해시 일부만 써도 됨
git diff a7b b2c
```

### 브랜치 간 비교

```bash
# 두 브랜치 비교
git diff main feature

# 브랜치와 현재 상태
git diff main

# 세 점 표기법 (공통 조상부터)
git diff main...feature
```

### 특정 파일만 비교

```bash
# 특정 파일의 차이
git diff -- file.txt

# 여러 파일
git diff -- file1.txt file2.txt

# 특정 커밋의 특정 파일
git diff a7b8c9d -- file.txt
```

### 통계만 보기

```bash
# 간단한 통계
git diff --stat

# 요약
git diff --shortstat
```

**출력:**
```
 file1.txt | 10 ++++++++--
 file2.txt |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)
```

바데부의 활용법:
```bash
# 커밋 전에 항상 확인
git diff              # 무엇을 변경했는지
git add .
git diff --staged     # 무엇을 커밋할지
git commit
```

## git blame - 코드 추적

### 기본 사용법

```bash
# 각 줄을 누가 언제 수정했는지
git blame file.txt
```

**출력:**
```
a7b8c9d1 (바데부 2025-10-28 14:30:00 +0900  1) def login_user(email, password):
a7b8c9d1 (바데부 2025-10-28 14:30:00 +0900  2)     """사용자 로그인"""
b2c3d4e5 (친구   2025-10-27 10:00:00 +0900  3)     user = find_user(email)
b2c3d4e5 (친구   2025-10-27 10:00:00 +0900  4)     if user and check_password(user, password):
a7b8c9d1 (바데부 2025-10-28 14:30:00 +0900  5)         create_session(user)
a7b8c9d1 (바데부 2025-10-28 14:30:00 +0900  6)         return True
b2c3d4e5 (친구   2025-10-27 10:00:00 +0900  7)     return False
```

**정보:**
- 커밋 해시
- 작성자
- 작성 시간
- 줄 번호
- 코드 내용

### 특정 범위만 보기

```bash
# 10번째 줄부터 20번째 줄까지
git blame -L 10,20 file.txt

# 10번째 줄부터 5줄
git blame -L 10,+5 file.txt

# 특정 함수 추적 (정규표현식)
git blame -L :function_name: file.txt
```

### 이메일 주소 표시

```bash
git blame -e file.txt
```

### 더 간결하게

```bash
# 작성자와 시간만
git blame -s file.txt

# 커밋 해시만
git blame -l file.txt
```

바데부의 탐정 활동:
```
"버그를 발견했을 때 git blame을 써요.
누가 이 코드를 작성했는지 알면
그 사람에게 맥락을 물어볼 수 있거든요.

blame이라는 이름이 부정적이지만,
'비난'이 아니라 '추적'의 의미예요!"
```

## 실전 활용: 버그 추적

### 시나리오: 버그 발견!

```bash
# 1. 문제가 있는 파일 확인
git blame problematic_file.py

# 2. 해당 줄의 커밋 찾기
git show a7b8c9d

# 3. 그 커밋의 전체 맥락 보기
git log -p a7b8c9d

# 4. 작성자 확인
git log --author="작성자이름" --oneline
```

### 코드 리뷰 준비

```bash
# 어제부터 오늘까지 변경사항
git log --since="yesterday" --oneline

# 변경된 파일 목록
git log --since="yesterday" --name-only --oneline

# 상세 변경 내용
git log --since="yesterday" -p

# 통계
git log --since="yesterday" --stat
```

### 기여도 분석

```bash
# 커밋 수 통계
git shortlog -sn

# 기간별
git shortlog -sn --since="1 month ago"

# 특정 파일에 대한 기여도
git log --follow --pretty=format:"%an" file.txt | sort | uniq -c | sort -rn
```

**출력:**
```
    45 바데부
    23 친구
    12 동료
```

## 히스토리 검색 고급 기법

### 특정 커밋 찾기

```bash
# "버그"가 들어간 커밋
git log --all --grep="버그"

# 여러 조건 (AND)
git log --grep="로그인" --author="바데부" --since="1 week ago"

# 파일 변경과 함께
git log --grep="버그" --name-only
```

### 코드 변경 추적

```bash
# 특정 함수가 언제 변경되었는지
git log -L :function_name:file.py

# 특정 줄 범위의 히스토리
git log -L 10,20:file.py
```

### 병합 커밋 제외

```bash
# 병합 커밋 제외하고 보기
git log --no-merges --oneline
```

### 첫 부모만 따라가기

```bash
# 메인 라인만 보기
git log --first-parent main
```

## 시각화 도구

### Gitk

```bash
# Git 내장 GUI
gitk

# 모든 브랜치
gitk --all

# 특정 파일 히스토리
gitk file.txt
```

### Tig (터미널 인터페이스)

```bash
# 설치 (macOS)
brew install tig

# 실행
tig
tig log
tig blame file.txt
```

**단축키:**
- `q`: 종료
- `Enter`: 상세 보기
- `j/k`: 위/아래 이동

### VSCode 확장

**GitLens:**
- 인라인으로 git blame 표시
- 커밋 히스토리 시각화
- 파일 히스토리 추적

바데부의 도구함:
```
명령줄: 빠르고 정확한 검색
Gitk: 브랜치 구조 파악
GitLens: 일상적인 코드 탐색

상황에 맞게 선택해서 써요!
```

## 실용 예제 모음

### 예제 1: 특정 버그가 언제 들어왔는지

```bash
# 문제가 있는 코드 검색
git log -S"problematic_code" --oneline

# 그 커밋 확인
git show [해시]
```

### 예제 2: 삭제된 코드 찾기

```bash
# 삭제된 코드 검색
git log -S"deleted_function" --diff-filter=D --oneline

# 복구
git show [해시]:file.txt > recovered_file.txt
```

### 예제 3: 파일 이름 변경 추적

```bash
# 파일 히스토리 (이름 변경 포함)
git log --follow -- new_name.txt

# 언제 이름이 바뀌었는지
git log --follow --diff-filter=R -- new_name.txt
```

### 예제 4: 두 릴리스 간 변경사항

```bash
# v1.0과 v2.0 사이의 모든 변경
git log v1.0..v2.0 --oneline

# 변경된 파일들
git diff --stat v1.0 v2.0

# 상세 변경사항
git log v1.0..v2.0 -p
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. 로그 보기
git log --oneline -5

# 2. 그래프로 보기
git log --graph --oneline --all

# 3. 특정 파일 히스토리
git log -- README.md

# 4. 최근 일주일 커밋
git log --since="1 week ago" --oneline

# 5. 차이 확인
git diff HEAD~1 HEAD

# 6. 파일의 작성자 추적
git blame README.md

# 7. 특정 키워드 검색
git log --grep="feat" --oneline
```

**확인 사항:**
- [ ] 다양한 형식으로 로그를 볼 수 있나요?
- [ ] 커밋 간 차이를 비교할 수 있나요?
- [ ] 특정 조건으로 커밋을 검색할 수 있나요?
- [ ] git blame으로 코드를 추적할 수 있나요?

## 정리하며

### 핵심 명령어

```bash
git log                          # 커밋 히스토리
git log --oneline               # 간단하게
git log --graph --all           # 그래프로
git diff                        # 변경사항 비교
git blame <파일>                # 코드 추적
```

### 바데부의 일일 명령어

```bash
# 아침: 무슨 일이 있었는지
git log --since="yesterday" --oneline

# 작업 전: 내가 뭘 바꿨는지
git diff

# 커밋 전: 정말 커밋할 내용인지
git diff --staged

# 버그 발견: 누가 언제 수정했는지
git blame file.txt
```

### 유용한 별명들

```bash
# 예쁜 로그
git config --global alias.lg "log --graph --pretty=format:'%C(yellow)%h%C(reset) - %C(cyan)%an%C(reset), %C(green)%ar%C(reset) : %s'"

# 최근 5개
git config --global alias.last "log -5 --oneline"

# 오늘의 작업
git config --global alias.today "log --since='00:00:00' --oneline"
```

---

**바데부의 한마디:**
```
"Git 히스토리는 프로젝트의 일기장이에요.
과거를 돌아보고, 실수를 찾고,
배움을 얻을 수 있는 소중한 자원이죠.

처음엔 log와 diff가 복잡해 보이지만,
자주 사용하다 보면 손에 익어요.

특히 버그를 추적할 때나
다른 사람의 코드를 이해할 때
정말 유용하답니다!"
```

## 다음 챕터 예고

**Chapter 7: 되돌리기**
- reset vs revert
- 실수 복구하기
- 안전한 되돌리기 방법
- 바데부의 구조 작전

실수를 되돌리는 방법을 배워봅시다! 다음 챕터에서 만나요! 👋

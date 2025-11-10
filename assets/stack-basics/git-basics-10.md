# Chapter 10: 모범 사례와 팁

## 바데부의 Git 마스터 클래스! 🎓

안녕하세요! 바데부입니다. 드디어 마지막 챕터네요!
오늘은 실전에서 유용한 팁과 모범 사례를 모두 공유할게요.

## Git 모범 사례

### 1. 자주 커밋하기

**나쁜 습관:**
```bash
# 하루 종일 작업 후
git add .
git commit -m "오늘 작업"  # 100개 파일, 1000줄 변경
```

**좋은 습관:**
```bash
# 의미 있는 단위로
git commit -m "feat: 로그인 폼 UI 추가"
# 30분 후
git commit -m "feat: 로그인 검증 로직 추가"
# 30분 후
git commit -m "test: 로그인 기능 테스트 추가"
```

바데부의 규칙:
```
"기능 하나 = 커밋 하나
한 시간에 최소 한 번은 커밋!"
```

### 2. 의미 있는 커밋 메시지

**커밋 메시지 템플릿:**
```
제목: 50자 이내, 명령형
(빈 줄)
본문: 무엇을, 왜, 어떻게 (선택)
(빈 줄)
꼬리말: 이슈 번호 등 (선택)
```

**예시:**
```
feat: 사용자 프로필 이미지 업로드 기능 추가

사용자가 자신의 프로필 사진을 변경할 수 있도록
이미지 업로드 및 리사이징 기능을 구현함

- 이미지 크기 제한: 5MB
- 지원 포맷: JPG, PNG
- 자동 리사이징: 200x200px

Closes #234
```

### 3. main 브랜치 보호

**GitHub 설정:**
```
Settings → Branches → Add rule

보호 규칙:
☑ Require pull request reviews
☑ Require status checks to pass
☑ Require branches to be up to date
☑ Include administrators
```

### 4. .gitignore 철저히

**.gitignore 체크리스트:**
```gitignore
# 운영체제
.DS_Store
Thumbs.db
*.swp

# IDE
.vscode/
.idea/
*.sublime-*

# 의존성
node_modules/
venv/
vendor/

# 환경 변수
.env
.env.local
*.key
secrets.json

# 빌드 결과물
dist/
build/
*.pyc
*.class
*.o

# 로그
*.log
logs/

# 데이터베이스
*.db
*.sqlite

# 캐시
__pycache__/
.cache/
```

바데부의 실수담:
```
"한 번은 .env 파일을 커밋했어요.
다행히 push 전에 발견했지만,
그 뒤로는 항상 .gitignore를 먼저 만들어요!"
```

### 5. 민감 정보 관리

**절대 커밋하지 말 것:**
```
✗ 비밀번호
✗ API 키
✗ 데이터베이스 접속 정보
✗ 프라이빗 키
✗ 개인 정보
```

**대신 사용:**
```bash
# .env.example (템플릿)
DB_HOST=localhost
DB_USER=your_username
DB_PASS=your_password
API_KEY=your_api_key

# .env (실제 - .gitignore에 추가)
DB_HOST=localhost
DB_USER=badebu
DB_PASS=secret123
API_KEY=abc123xyz
```

**실수로 커밋했다면:**
```bash
# 1. 파일 제거
git rm --cached .env

# 2. .gitignore에 추가
echo ".env" >> .gitignore

# 3. 커밋
git commit -m "chore: .env 파일 추적 제거"

# 4. 이미 push했다면
# → 즉시 키/비밀번호 변경!
# → 저장소를 완전히 재작성 (위험)
```

## 성능 최적화

### 대용량 파일 관리

**Git LFS (Large File Storage):**
```bash
# 설치
brew install git-lfs
git lfs install

# 대용량 파일 추적
git lfs track "*.psd"
git lfs track "*.zip"
git lfs track "*.mp4"

# .gitattributes 커밋
git add .gitattributes
git commit -m "chore: Git LFS 설정"
```

### 저장소 크기 줄이기

```bash
# 저장소 크기 확인
git count-objects -vH

# 가비지 컬렉션
git gc --aggressive --prune=now

# 히스토리에서 파일 완전 제거 (위험!)
git filter-branch --tree-filter 'rm -f large-file.zip' HEAD
```

바데부의 조언:
```
"대용량 파일은 Git이 아닌
별도 저장소(S3, CDN 등)에 보관하고
Git에는 경로만 저장하세요!"
```

### Shallow Clone

```bash
# 최근 커밋만 다운로드
git clone --depth 1 https://github.com/user/repo.git

# 나중에 전체 히스토리 가져오기
git fetch --unshallow
```

## 유용한 Git 도구

### 1. Git Aliases (별명)

```bash
# ~/.gitconfig에 추가
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = restore --staged
    last = log -1 HEAD
    visual = log --graph --oneline --all --decorate
    undo = reset --soft HEAD~1
```

**사용:**
```bash
git st  # git status
git co main  # git checkout main
git visual  # 예쁜 로그
```

### 2. Git Hooks

**pre-commit hook (.git/hooks/pre-commit):**
```bash
#!/bin/sh

# 린터 실행
npm run lint
if [ $? -ne 0 ]; then
    echo "린터 검사 실패! 커밋을 중단합니다."
    exit 1
fi

# 테스트 실행
npm test
if [ $? -ne 0 ]; then
    echo "테스트 실패! 커밋을 중단합니다."
    exit 1
fi
```

**Husky로 관리:**
```bash
# 설치
npm install --save-dev husky

# 초기화
npx husky install

# pre-commit hook 추가
npx husky add .husky/pre-commit "npm test"
```

### 3. GitHub CLI

```bash
# 설치
brew install gh

# 로그인
gh auth login

# PR 생성
gh pr create --title "새 기능" --body "설명"

# PR 목록
gh pr list

# 이슈 생성
gh issue create --title "버그" --body "설명"
```

### 4. GitLens (VSCode)

**기능:**
- 인라인 git blame
- 커밋 히스토리
- 파일 히스토리
- 비교 기능

**설치:**
```
VSCode → Extensions → "GitLens" 검색
```

### 5. Tig (터미널 UI)

```bash
# 설치
brew install tig

# 사용
tig  # 저장소 탐색
tig blame file.txt  # 파일 blame
tig log  # 로그 보기
```

## 문제 해결

### 문제 1: 실수로 force push

```bash
# 복구 불가능한 경우가 많음
# 예방이 최선!

# force push 전 항상
git push --force-with-lease  # 더 안전

# 팀원이 피해를 입었다면
# 1. 팀원의 로컬 커밋 백업
git branch backup

# 2. 원격의 최신 상태 가져오기
git fetch origin
git reset --hard origin/main
```

### 문제 2: Detached HEAD 상태

```bash
# "You are in 'detached HEAD' state"

# 새 브랜치 만들어서 저장
git switch -c temp-branch

# 또는 버리기
git switch main
```

### 문제 3: 병합 지옥

```bash
# 너무 오래된 feature 브랜치

# 해결: rebase로 정리
git switch feature
git rebase main

# 충돌이 너무 많다면
# 새 브랜치로 다시 시작하는 것도 방법
```

### 문제 4: 커밋 히스토리 더러움

```bash
# 여러 불필요한 커밋

# Interactive rebase로 정리
git rebase -i HEAD~5

# 에디터에서:
pick a7b8c9d 기능 추가
squash b2c3d4e 오타 수정
squash c3d4e5f 다시 수정
pick d4e5f6g 다른 기능

# 저장하면 3개 커밋이 1개로!
```

## 보안 모범 사례

### GPG 서명

```bash
# GPG 키 생성
gpg --full-generate-key

# Git에 설정
git config --global user.signingkey [키ID]
git config --global commit.gpgsign true

# 서명된 커밋
git commit -S -m "서명된 커밋"
```

### 2FA (Two-Factor Authentication)

```
GitHub Settings → Security → Two-factor authentication

권장:
- 앱 인증 (Google Authenticator, Authy)
- 백업 코드 저장
- Personal Access Token 사용
```

### SSH 키 관리

```bash
# 여러 키 사용 (~/.ssh/config)
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_work

Host github-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_personal

# 사용
git clone git@github-work:company/repo.git
git clone git@github-personal:badebu/repo.git
```

## 바데부의 10가지 금언

### 1. "커밋은 자주, 푸시는 확실히"

```
하루에 최소 3-5번 커밋
의미 있는 단위로 푸시
```

### 2. "main은 성역이다"

```
직접 커밋 금지
항상 PR을 통해
테스트 통과 후 병합
```

### 3. "메시지는 미래의 나에게"

```
"수정", "업데이트" 금지
무엇을, 왜 변경했는지 명확히
```

### 4. "브랜치는 가볍게, 자주"

```
하나의 기능 = 하나의 브랜치
완료되면 즉시 병합하고 삭제
```

### 5. "충돌은 빨리 해결할수록 좋다"

```
자주 pull하기
작은 충돌이 쉬운 충돌
```

### 6. "되돌리기를 두려워하지 말라"

```
Git은 관대하다
거의 모든 것을 복구 가능
reflog를 기억하라
```

### 7. "협업은 소통이다"

```
PR에 설명 충분히
리뷰는 친절하게
질문은 언제나 환영
```

### 8. "보안은 타협 불가"

```
비밀번호는 절대 커밋 금지
.gitignore 먼저 설정
의심스러우면 물어보기
```

### 9. "테스트 없는 푸시는 도박"

```
커밋 전 테스트
푸시 전 재확인
CI/CD 활용
```

### 10. "배움은 끝이 없다"

```
새로운 명령어 시도
다른 사람의 코드 읽기
실수에서 배우기
```

## 학습 리소스

### 공식 문서

```
Git 공식: https://git-scm.com/doc
Pro Git 책: https://git-scm.com/book/ko/v2
GitHub Docs: https://docs.github.com
```

### 연습 사이트

```
Learn Git Branching: https://learngitbranching.js.org/
GitHub Skills: https://skills.github.com/
Katacoda Git Scenarios: https://www.katacoda.com/courses/git
```

### 커뮤니티

```
Stack Overflow: git 태그
Reddit: r/git
Discord: 각종 개발 서버의 git 채널
```

## 바데부의 일일 체크리스트

### 아침 루틴

```bash
# 1. 최신 코드 가져오기
git switch main
git pull origin main

# 2. 어제 작업 확인
git log --since="yesterday" --author="바데부" --oneline

# 3. 브랜치 정리
git branch --merged | grep -v "\*" | xargs -n 1 git branch -d
```

### 작업 시작

```bash
# 1. 브랜치 확인
git status
git branch

# 2. 새 브랜치 생성
git switch -c feature/today-work

# 3. 작업 시작!
```

### 작업 중

```bash
# 정기적으로
git status  # 무엇이 바뀌었는지
git diff  # 어떻게 바뀌었는지
git add .
git commit -m "의미있는 메시지"
```

### 퇴근 전

```bash
# 1. 모든 변경사항 커밋
git status  # 빠뜨린 것 없는지

# 2. 원격에 푸시 (백업)
git push origin feature/today-work

# 3. 내일 할 일 정리
# TODO.md 작성
```

## 최종 실습 프로젝트

### 완전한 워크플로우 실습

```bash
# 1. 프로젝트 시작
mkdir final-project
cd final-project
git init

# 2. .gitignore 설정
cat > .gitignore << 'EOF'
node_modules/
.env
.DS_Store
EOF

# 3. 첫 커밋
echo "# Final Project" > README.md
git add .
git commit -m "chore: 프로젝트 초기 설정"

# 4. GitHub에 저장소 생성 후 연결
git remote add origin [URL]
git push -u origin main

# 5. develop 브랜치
git switch -c develop
git push -u origin develop

# 6. 기능 개발
git switch -c feature/authentication
echo "로그인 기능" > auth.py
git commit -am "feat: 로그인 기능 추가"

# 7. 테스트 추가
echo "테스트 코드" > test_auth.py
git commit -am "test: 로그인 테스트 추가"

# 8. 푸시 및 PR
git push -u origin feature/authentication
# GitHub에서 PR 생성 (develop ← feature/authentication)

# 9. 병합 후 정리
git switch develop
git pull origin develop
git branch -d feature/authentication

# 10. 릴리스
git switch -c release/v1.0
# 버전 업데이트
git switch main
git merge release/v1.0
git tag -a v1.0 -m "첫 번째 릴리스"
git push origin main --tags

git switch develop
git merge release/v1.0
git push origin develop
```

## 정리하며

### Git 마스터 로드맵

```
레벨 1: 기초 (1-2주)
✓ init, add, commit, status
✓ 기본 워크플로우

레벨 2: 브랜치 (1-2주)
✓ branch, checkout/switch, merge
✓ 충돌 해결

레벨 3: 원격 (1주)
✓ clone, push, pull
✓ remote 관리

레벨 4: 협업 (2-3주)
✓ Pull Request
✓ 코드 리뷰
✓ 워크플로우

레벨 5: 고급 (계속)
✓ rebase, cherry-pick
✓ 성능 최적화
✓ 커스터마이징
```

### 계속 발전하기

```
매일:
- 의미 있는 커밋 메시지
- 작은 단위로 커밋
- 자주 pull

매주:
- 새로운 Git 명령어 배우기
- 브랜치 정리
- 히스토리 리뷰

매월:
- Git 설정 최적화
- 워크플로우 개선
- 팀과 회고
```

---

**바데부의 마지막 인사:**

```
여러분, 10개 챕터를 모두 마쳤습니다!
정말 수고하셨어요! 🎉

Git을 처음 배울 때
저도 많이 헤맸어요.
명령어는 어렵고,
에러 메시지는 무섭고,
충돌은 복잡했죠.

하지만 포기하지 않고 계속 연습했어요.
실수도 많이 했지만,
그때마다 배워나갔습니다.

이제 Git은 제 가장 친한 도구가 되었어요.
매일 사용하고, 의지하고,
Git 없이는 개발을 상상할 수 없답니다.

여러분도 곧 그렇게 될 거예요!

기억하세요:
- 실수해도 괜찮아요
- 모르는 건 물어봐도 돼요
- 천천히, 꾸준히 배워나가면 됩니다

Git은 도구일 뿐이에요.
중요한 건 여러분이 만들 멋진 프로젝트들이죠!

이 강의가 여러분의 개발 여정에
작은 도움이 되었기를 바랍니다.

Happy Coding! 💻
그리고 Happy Git-ing! 🌿

- 바데부 드림
```

## 다음 단계

**추천 학습 주제:**
1. GitHub Actions (CI/CD)
2. Git 내부 구조
3. Git 서버 구축
4. 고급 rebase 기법
5. Git hooks 활용
6. Monorepo 관리

**프로젝트 아이디어:**
1. 개인 포트폴리오 사이트 (GitHub Pages)
2. 오픈소스 프로젝트 기여
3. 팀 프로젝트 (실전 협업)
4. Git 자동화 도구 개발

---

**끝.**

바데부와 함께한 Git 여행이 여기서 마무리됩니다.
하지만 여러분의 Git 여정은 이제 시작입니다!

화이팅! 💪

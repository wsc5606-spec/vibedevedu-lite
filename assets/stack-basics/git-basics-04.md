# Chapter 4: 원격 저장소 (Remote, Push, Pull, Clone)

## 바데부의 세계로 나아가기! 🌍

안녕하세요! 바데부입니다. 지금까지는 로컬 컴퓨터에서만 Git을 사용했어요.
이제 온라인 세계로 나가서 코드를 공유하고 협업해봅시다!

## 원격 저장소란?

### 개념 이해하기

**원격 저장소(Remote Repository)**는 인터넷이나 네트워크에 있는 Git 저장소입니다.

```
로컬 저장소 (내 컴퓨터)          원격 저장소 (GitHub)
    ●──●──●──●                    ●──●──●──●
         ↓ push                    ↓ pull
    내 컴퓨터                      클라우드
```

바데부의 비유:
```
"로컬 저장소는 내 노트,
원격 저장소는 공유 게시판이에요.
노트에 정리한 내용을 게시판에 올리면
다른 사람들도 볼 수 있죠!"
```

### 인기 있는 원격 저장소 서비스

1. **GitHub** (가장 인기)
   - 전 세계 최대 개발자 커뮤니티
   - 무료 공개/비공개 저장소
   - https://github.com

2. **GitLab**
   - 오픈소스
   - CI/CD 기능 강력
   - https://gitlab.com

3. **Bitbucket**
   - Atlassian 제품
   - Jira 통합
   - https://bitbucket.org

바데부의 선택:
```
"저는 GitHub를 주로 써요!
오픈소스 프로젝트가 많고
개발자 커뮤니티가 활발해서
배울 게 정말 많답니다."
```

## GitHub 시작하기

### GitHub 계정 만들기

1. https://github.com 접속
2. Sign up 클릭
3. 이메일, 비밀번호 입력
4. 사용자 이름 선택 (예: badebu-dev)
5. 이메일 인증

### 첫 번째 저장소 생성

**GitHub 웹사이트에서:**

1. 우측 상단 `+` 버튼 클릭
2. `New repository` 선택
3. 저장소 정보 입력:
   ```
   Repository name: my-first-repo
   Description: 바데부의 첫 저장소
   Public (공개) 선택
   Initialize this repository with:
   ☑ Add a README file (체크)
   ```
4. `Create repository` 클릭

**축하합니다! 첫 원격 저장소가 생성되었어요!**

## git clone - 저장소 복제하기

### 저장소 복제

```bash
# GitHub에서 저장소 URL 복사
# 예: https://github.com/badebu-dev/my-first-repo.git

# 저장소 복제
git clone https://github.com/badebu-dev/my-first-repo.git

# 복제된 폴더로 이동
cd my-first-repo
```

**자동으로 설정되는 것들:**
```bash
# 원격 저장소가 자동으로 등록됨
git remote -v
```

**출력:**
```
origin  https://github.com/badebu-dev/my-first-repo.git (fetch)
origin  https://github.com/badebu-dev/my-first-repo.git (push)
```

### 다른 이름으로 복제

```bash
# 폴더 이름을 지정해서 복제
git clone https://github.com/badebu-dev/my-first-repo.git my-project

cd my-project
```

바데부의 팁:
```
"clone은 처음 한 번만 하면 돼요!
이미 로컬에 있다면 clone을 다시 할 필요 없이
pull로 최신 상태를 가져오면 됩니다."
```

## git remote - 원격 저장소 관리

### 원격 저장소 확인

```bash
# 원격 저장소 목록
git remote

# 상세 정보 (URL 포함)
git remote -v
```

**출력:**
```
origin  https://github.com/badebu-dev/my-first-repo.git (fetch)
origin  https://github.com/badebu-dev/my-first-repo.git (push)
```

**origin이란?**
```
origin = 기본 원격 저장소의 별명
(clone할 때 자동으로 붙는 이름)
```

### 원격 저장소 추가

```bash
# 원격 저장소 추가
git remote add <이름> <URL>

# 예시
git remote add upstream https://github.com/original/repo.git
```

### 원격 저장소 제거

```bash
# 원격 저장소 제거
git remote remove <이름>

# 예시
git remote remove upstream
```

### 원격 저장소 이름 변경

```bash
# 이름 변경
git remote rename <기존이름> <새이름>

# 예시
git remote rename origin github
```

## git push - 로컬 변경사항 업로드

### 기본 push

```bash
# 파일 수정
echo "바데부가 수정함" >> README.md
git add README.md
git commit -m "docs: README 업데이트"

# 원격에 업로드
git push origin main
```

**출력:**
```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 326 bytes | 326.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To https://github.com/badebu-dev/my-first-repo.git
   a1b2c3d..e4f5g6h  main -> main
```

**명령어 구조:**
```bash
git push <원격저장소> <브랜치>
git push origin main
         ↑       ↑
      어디로   무엇을
```

### 최초 push (upstream 설정)

```bash
# -u 옵션으로 기본 원격 브랜치 설정
git push -u origin main

# 이후부터는 간단하게
git push  # origin main이 자동으로 선택됨
```

바데부의 팁:
```bash
# 처음 한 번만
git push -u origin main

# 그 다음부터
git push  # 이것만 입력해도 됨!
```

### 모든 브랜치 push

```bash
# 모든 로컬 브랜치를 원격에 업로드
git push --all origin

# 태그도 함께
git push --tags origin
```

### 강제 push (주의!)

```bash
# 강제로 덮어쓰기 (위험!)
git push --force origin main

# 더 안전한 강제 push
git push --force-with-lease origin main
```

바데부의 경고:
```
"--force는 정말 조심해서 써야 해요!
다른 사람의 커밋을 날려버릴 수 있거든요.
협업 중에는 절대 main 브랜치에 force push 하지 마세요!"
```

## git pull - 원격 변경사항 다운로드

### 기본 pull

```bash
# 원격의 최신 변경사항 가져오기
git pull origin main

# 또는 (upstream이 설정되어 있다면)
git pull
```

**pull은 두 단계로 이루어져요:**
```bash
git pull = git fetch + git merge

1. fetch: 원격 데이터 다운로드
2. merge: 로컬 브랜치와 병합
```

### pull 시나리오

**시나리오 1: 충돌 없음**
```bash
# GitHub에서 파일 수정 (웹으로)
# → 로컬에서 pull

git pull origin main
```

**출력:**
```
Updating a1b2c3d..e4f5g6h
Fast-forward
 README.md | 1 +
 1 file changed, 1 insertion(+)
```

**시나리오 2: 충돌 발생**
```bash
# 로컬과 원격에서 같은 파일을 다르게 수정
git pull origin main
```

**출력:**
```
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

(충돌 해결은 다음 챕터에서!)

### rebase로 pull하기

```bash
# merge 대신 rebase 사용
git pull --rebase origin main
```

**차이점:**
```
일반 pull (merge):
로컬    ●──●──●──────●
              \     /
원격           ●──●

rebase pull:
로컬    ●──●──●──●──●
        (원격 커밋) (내 커밋)
```

바데부의 선호:
```bash
# 깔끔한 히스토리를 위해
git config --global pull.rebase true

# 이제 git pull이 자동으로 rebase!
```

## 실전 실습: 바데부의 포트폴리오

### 1단계: GitHub에 저장소 만들기

**GitHub에서:**
1. New repository 클릭
2. 이름: `badebu-portfolio`
3. Public 선택
4. `Add a README file` 체크 해제
5. Create repository

**중요! 표시되는 명령어 복사해두기:**
```bash
git remote add origin https://github.com/badebu-dev/badebu-portfolio.git
git branch -M main
git push -u origin main
```

### 2단계: 로컬에서 프로젝트 시작

```bash
# 프로젝트 폴더 생성
mkdir badebu-portfolio
cd badebu-portfolio
git init

# HTML 파일 생성
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>바데부의 포트폴리오</title>
</head>
<body>
    <header>
        <h1>바데부</h1>
        <p>열정적인 개발자</p>
    </header>

    <section>
        <h2>소개</h2>
        <p>안녕하세요! Git을 배우는 중인 바데부입니다.</p>
    </section>

    <section>
        <h2>기술 스택</h2>
        <ul>
            <li>Git & GitHub</li>
            <li>HTML/CSS</li>
            <li>Python</li>
        </ul>
    </section>
</body>
</html>
EOF

# CSS 파일 생성
cat > style.css << 'EOF'
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    line-height: 1.6;
}

header {
    text-align: center;
    padding: 40px 0;
    border-bottom: 3px solid #3498db;
}

h1 {
    color: #2c3e50;
    font-size: 2.5em;
    margin-bottom: 10px;
}

section {
    margin: 30px 0;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    background: #ecf0f1;
    margin: 10px 0;
    padding: 10px;
    border-left: 4px solid #3498db;
}
EOF

# 첫 커밋
git add .
git commit -m "feat: 포트폴리오 초기 버전"
```

### 3단계: 원격 저장소 연결 및 push

```bash
# 원격 저장소 추가 (GitHub에서 복사한 URL 사용)
git remote add origin https://github.com/badebu-dev/badebu-portfolio.git

# 브랜치 이름 확인 및 변경 (필요시)
git branch -M main

# 업로드
git push -u origin main
```

**성공!** GitHub에서 확인해보세요!

### 4단계: 온라인에서 수정하기

**GitHub 웹사이트에서:**
1. `index.html` 파일 클릭
2. 연필 아이콘 (Edit) 클릭
3. 프로젝트 섹션 추가:
   ```html
   <section>
       <h2>프로젝트</h2>
       <ul>
           <li>Git 학습 저장소</li>
           <li>포트폴리오 웹사이트</li>
       </ul>
   </section>
   ```
4. Commit changes 클릭
5. 커밋 메시지: `feat: 프로젝트 섹션 추가`
6. Commit changes 확인

### 5단계: 로컬로 가져오기

```bash
# 원격의 변경사항 가져오기
git pull origin main
```

**출력:**
```
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
From https://github.com/badebu-dev/badebu-portfolio
 * branch            main       -> FETCH_HEAD
   a1b2c3d..e4f5g6h  main       -> origin/main
Updating a1b2c3d..e4f5g6h
Fast-forward
 index.html | 6 ++++++
 1 file changed, 6 insertions(+)
```

**확인:**
```bash
cat index.html  # 프로젝트 섹션이 추가되었어요!
```

## git fetch - 데이터만 가져오기

### fetch vs pull

```bash
# fetch: 데이터만 다운로드 (병합 안 함)
git fetch origin

# 원격 브랜치 확인
git branch -r

# 직접 병합
git merge origin/main
```

**언제 fetch를 쓰나요?**
```
1. 먼저 변경사항을 확인하고 싶을 때
2. 여러 원격 브랜치를 한 번에 업데이트할 때
3. 수동으로 병합을 제어하고 싶을 때
```

바데부의 안전한 방법:
```bash
# 1. 원격 데이터 가져오기
git fetch origin

# 2. 차이점 확인
git diff main origin/main

# 3. 문제없으면 병합
git merge origin/main
```

## 원격 브랜치 다루기

### 원격 브랜치 보기

```bash
# 원격 브랜치 목록
git branch -r

# 모든 브랜치 (로컬 + 원격)
git branch -a
```

**출력:**
```
* main
  remotes/origin/main
  remotes/origin/feature/new-design
```

### 원격 브랜치로 전환

```bash
# 원격 브랜치를 로컬로 가져오기
git checkout -b feature/new-design origin/feature/new-design

# 또는 (Git 2.23+)
git switch -c feature/new-design origin/feature/new-design

# 또는 간단하게 (자동으로 추적)
git switch feature/new-design
```

### 원격 브랜치 삭제

```bash
# 로컬에서 브랜치 삭제
git branch -d feature/old-feature

# 원격에서도 삭제
git push origin --delete feature/old-feature

# 또는
git push origin :feature/old-feature
```

## SSH 키 설정 (보안 강화)

### SSH 키가 필요한 이유

```
HTTPS: 매번 비밀번호 입력
SSH: 한 번 설정하면 자동 인증
```

### SSH 키 생성

```bash
# SSH 키 생성
ssh-keygen -t ed25519 -C "badebu@vibedev.com"

# Enter 연타 (기본 위치와 비밀번호 없음)
```

**출력:**
```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/badebu/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/badebu/.ssh/id_ed25519
Your public key has been saved in /Users/badebu/.ssh/id_ed25519.pub
```

### 공개 키 복사

```bash
# 공개 키 내용 보기
cat ~/.ssh/id_ed25519.pub
```

**출력 예시:**
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl badebu@vibedev.com
```

### GitHub에 SSH 키 등록

1. GitHub 로그인
2. 우측 상단 프로필 → Settings
3. 좌측 메뉴 → SSH and GPG keys
4. New SSH key 클릭
5. Title: "바데부의 맥북" (또는 컴퓨터 이름)
6. Key: 복사한 공개 키 붙여넣기
7. Add SSH key

### SSH로 원격 저장소 변경

```bash
# 현재 URL 확인
git remote -v

# HTTPS에서 SSH로 변경
git remote set-url origin git@github.com:badebu-dev/my-first-repo.git

# 확인
git remote -v
```

**출력:**
```
origin  git@github.com:badebu-dev/my-first-repo.git (fetch)
origin  git@github.com:badebu-dev/my-first-repo.git (push)
```

**테스트:**
```bash
git push  # 비밀번호 입력 없이 작동!
```

## 협업 시나리오

### 시나리오: 바데부와 친구의 협업

**1. 친구가 저장소 수정**
```bash
# 친구 컴퓨터에서
git clone https://github.com/badebu-dev/team-project.git
cd team-project
echo "친구가 작성한 코드" > friend.txt
git add friend.txt
git commit -m "feat: 친구 기능 추가"
git push origin main
```

**2. 바데부가 최신 코드 가져오기**
```bash
# 바데부 컴퓨터에서
git pull origin main
```

**3. 바데부가 자신의 작업**
```bash
echo "바데부가 작성한 코드" > badebu.txt
git add badebu.txt
git commit -m "feat: 바데부 기능 추가"
git push origin main
```

**4. 친구가 바데부의 작업 가져오기**
```bash
# 친구 컴퓨터에서
git pull origin main
```

**완벽한 협업!**

## 실용 팁

### 자주 사용하는 명령어 조합

```bash
# 바데부의 일일 루틴
git pull                    # 1. 최신 코드 가져오기
# ... 작업 ...
git add .                   # 2. 변경사항 추가
git commit -m "..."         # 3. 커밋
git pull                    # 4. 혹시 모를 충돌 확인
git push                    # 5. 업로드
```

### 원격 저장소 정보 확인

```bash
# 원격 저장소 상세 정보
git remote show origin
```

**출력:**
```
* remote origin
  Fetch URL: https://github.com/badebu-dev/my-first-repo.git
  Push  URL: https://github.com/badebu-dev/my-first-repo.git
  HEAD branch: main
  Remote branches:
    main                tracked
    feature/new-design  tracked
  Local branch configured for 'git pull':
    main merges with remote main
  Local ref configured for 'git push':
    main pushes to main (up to date)
```

### 원격 브랜치 정리

```bash
# 삭제된 원격 브랜치 정보 정리
git fetch --prune

# 또는 자동으로
git config --global fetch.prune true
```

## 실습 체크리스트

직접 해보세요:

```bash
# 1. GitHub에 저장소 만들기
# (웹 브라우저에서)

# 2. 로컬 프로젝트 시작
mkdir test-remote
cd test-remote
git init
echo "# Test Project" > README.md
git add README.md
git commit -m "Initial commit"

# 3. 원격 연결
git remote add origin [복사한URL]
git push -u origin main

# 4. 온라인에서 수정
# (GitHub 웹에서 README 수정)

# 5. 로컬로 가져오기
git pull origin main
```

**확인 사항:**
- [ ] GitHub 저장소를 만들 수 있나요?
- [ ] 로컬 프로젝트를 원격에 업로드할 수 있나요?
- [ ] 원격의 변경사항을 로컬로 가져올 수 있나요?
- [ ] push와 pull의 차이를 이해했나요?

## 정리하며

### 핵심 명령어

```bash
git clone <URL>              # 저장소 복제
git remote add <이름> <URL>  # 원격 저장소 추가
git push <원격> <브랜치>     # 업로드
git pull <원격> <브랜치>     # 다운로드 + 병합
git fetch <원격>             # 다운로드만
```

### 바데부의 워크플로우

```
아침:
git pull        # 최신 코드로 시작

작업 중:
git add .
git commit -m "..."

작업 완료:
git pull        # 충돌 확인
git push        # 업로드
```

---

**바데부의 한마디:**
```
"원격 저장소는 정말 마법 같아요!
내 코드를 전 세계와 공유할 수 있고,
어디서든 접근할 수 있죠.

백업도 자동으로 되고,
팀원들과 협업도 쉬워요.

처음엔 push/pull이 헷갈릴 수 있지만,
몇 번만 해보면 금방 익숙해질 거예요!"
```

## 다음 챕터 예고

**Chapter 5: 충돌 해결**
- 충돌이 왜 발생하나요?
- 충돌 표시 읽는 법
- 충돌 해결하기
- 충돌 피하는 방법

협업의 필수 과정, 충돌 해결을 마스터해봅시다! 다음 챕터에서 만나요! 👋

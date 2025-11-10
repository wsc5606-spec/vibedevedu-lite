# Chapter 1: Git 소개 및 설치

## 바데부와 함께하는 Git 여행 시작! 🚀

안녕하세요! 저는 바데부입니다. 오늘부터 여러분과 함께 Git의 세계를 탐험하게 되어 정말 기쁩니다!

## Git이란 무엇인가요?

Git은 **분산 버전 관리 시스템(Distributed Version Control System)**입니다. 쉽게 말해, 여러분의 코드 변경 사항을 추적하고 관리하는 도구예요.

### 왜 Git을 배워야 할까요?

```
바데부의 경험담:
"처음 코딩을 시작했을 때, 실수로 중요한 코드를 지워버렸어요.
백업도 없었고, 되돌릴 방법도 몰랐죠...
그때 Git을 알았더라면 좋았을 텐데요!"
```

**Git을 사용하면:**
1. 코드의 모든 변경 이력을 추적할 수 있어요
2. 이전 버전으로 언제든 돌아갈 수 있어요
3. 여러 사람과 협업할 때 코드 충돌을 관리할 수 있어요
4. 실험적인 기능을 안전하게 개발할 수 있어요

## Git의 역사

Git은 2005년 리눅스 커널 개발자인 **리누스 토발즈(Linus Torvalds)**가 만들었습니다.

```markdown
타임라인:
2005년 - Git 탄생
2008년 - GitHub 출시
2018년 - Microsoft가 GitHub 인수
현재   - 전 세계 개발자들의 필수 도구
```

## Git vs 다른 버전 관리 시스템

### 중앙 집중식 vs 분산식

**중앙 집중식 (SVN, CVS):**
```
[개발자1] ──┐
[개발자2] ──┤──> [중앙 서버]
[개발자3] ──┘
```

**분산식 (Git):**
```
[개발자1 + 전체 저장소] ──┐
[개발자2 + 전체 저장소] ──┤──> [원격 저장소]
[개발자3 + 전체 저장소] ──┘
```

바데부의 팁: "Git은 인터넷 없이도 작업할 수 있어요!"

## Git 설치하기

### Windows 설치

1. **Git 다운로드**
   - 공식 사이트 방문: https://git-scm.com/download/win
   - 설치 파일 다운로드 (64-bit 권장)

2. **설치 진행**
   ```bash
   # 설치 후 버전 확인
   git --version
   ```

   예상 출력:
   ```
   git version 2.42.0
   ```

3. **권장 설정**
   - Editor: VSCode (또는 선호하는 에디터)
   - PATH 환경: Git from the command line and also from 3rd-party software
   - Line ending: Checkout Windows-style, commit Unix-style
   - Terminal: MinTTY

### macOS 설치

**방법 1: Homebrew 사용 (권장)**
```bash
# Homebrew로 설치
brew install git

# 버전 확인
git --version
```

**방법 2: Xcode Command Line Tools**
```bash
# Xcode 도구 설치
xcode-select --install
```

### Linux 설치

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install git
```

**Fedora:**
```bash
sudo dnf install git
```

**Arch Linux:**
```bash
sudo pacman -S git
```

## Git 초기 설정

Git을 설치했다면, 이제 사용자 정보를 설정해야 합니다.

### 사용자 정보 설정

```bash
# 사용자 이름 설정
git config --global user.name "바데부"

# 이메일 설정
git config --global user.email "badebu@vibedev.com"

# 기본 에디터 설정 (VSCode)
git config --global core.editor "code --wait"

# 설정 확인
git config --list
```

**출력 예시:**
```
user.name=바데부
user.email=badebu@vibedev.com
core.editor=code --wait
```

### 설정 레벨 이해하기

Git은 세 가지 레벨의 설정을 가집니다:

```bash
# 시스템 전체 설정 (모든 사용자)
git config --system user.name "이름"

# 사용자 전역 설정 (현재 사용자)
git config --global user.name "이름"

# 저장소별 설정 (현재 프로젝트만)
git config --local user.name "이름"
```

**우선순위:** local > global > system

바데부의 노트:
```
"대부분의 경우 --global 설정만으로 충분해요!
하지만 회사 프로젝트와 개인 프로젝트를 구분하고 싶다면
--local 설정을 활용하세요."
```

## Git 기본 용어

시작하기 전에 알아야 할 기본 용어들:

### Repository (저장소)
Git이 파일의 변경 이력을 저장하는 공간

```
프로젝트 폴더/
├── .git/           # Git 저장소 (숨김 폴더)
├── src/
├── README.md
└── ...
```

### Commit (커밋)
변경 사항의 스냅샷 (사진 찍기)

```
커밋 = 변경 내용 + 메시지 + 작성자 + 시간
```

### Branch (브랜치)
코드의 독립적인 개발 라인

```
main     ──●──●──●──●
            \
feature      ●──●
```

### Remote (원격)
인터넷상의 저장소 (예: GitHub, GitLab)

## Git GUI 도구

명령줄이 어렵다면 GUI 도구를 사용할 수도 있어요:

### 공식 Git GUI
```bash
# Git GUI 실행
git gui

# Gitk (히스토리 뷰어) 실행
gitk
```

### 인기 있는 GUI 도구들

1. **GitHub Desktop**
   - 초보자 친화적
   - GitHub와 완벽한 통합
   - 무료

2. **SourceTree**
   - 강력한 기능
   - 무료
   - Atlassian 제품

3. **GitKraken**
   - 아름다운 UI
   - 크로스 플랫폼
   - 유료 (무료 버전 있음)

4. **VSCode 내장 Git**
   - 에디터 통합
   - 가볍고 빠름
   - 무료

바데부의 조언:
```
"GUI 도구도 좋지만, 명령줄 사용법을 먼저 배우는 것을 추천해요.
명령줄을 이해하면 어떤 도구든 쉽게 사용할 수 있거든요!"
```

## 첫 번째 실습 준비

다음 챕터를 위해 준비해봅시다:

```bash
# 1. 실습용 폴더 생성
mkdir git-practice
cd git-practice

# 2. Git 버전 확인
git --version

# 3. 사용자 설정 확인
git config user.name
git config user.email
```

**확인 사항:**
- [ ] Git이 정상적으로 설치되었나요?
- [ ] 버전이 2.20 이상인가요?
- [ ] 사용자 이름과 이메일이 설정되었나요?

## 도움말 보기

Git 명령어가 기억나지 않을 때:

```bash
# 전체 도움말
git help

# 특정 명령어 도움말
git help init
git help commit

# 간단한 도움말 (더 빠름)
git init --help
git commit -h
```

바데부의 비법:
```bash
# 명령어를 잊어버렸을 때
git --help

# 옵션을 잊어버렸을 때
git 명령어 -h

# 자세한 설명이 필요할 때
git help 명령어
```

## 정리하며

이번 챕터에서 배운 내용:

1. ✅ Git이 무엇인지 이해했어요
2. ✅ Git을 설치하고 설정했어요
3. ✅ 기본 용어를 배웠어요
4. ✅ 도움말 보는 방법을 알게 되었어요

다음 챕터에서는 본격적으로 Git 저장소를 만들고 첫 커밋을 해볼 거예요!

---

**바데부의 한마디:**
```
"Git을 처음 배울 때는 어려울 수 있어요.
하지만 걱정하지 마세요! 천천히 따라오면서
하나씩 실습해보면 금방 익숙해질 거예요.
저도 처음엔 실수를 많이 했지만,
지금은 Git 없이는 개발을 상상할 수 없답니다!"
```

## 다음 챕터 예고

**Chapter 2: 저장소 초기화와 기본 명령어**
- 첫 Git 저장소 만들기
- 파일 추가하고 커밋하기
- 상태 확인하기
- 바데부와 함께하는 실전 예제

준비되셨나요? 그럼 다음 챕터에서 만나요! 👋

# Chapter 1: VS Code 소개 및 설치

Visual Studio Code(VS Code)는 Microsoft에서 만든 **무료 코드 에디터**입니다. 가볍고 빠르며, 모든 프로그래밍 언어를 지원합니다.

## 1.1 VS Code란?

VS Code는 개발자들이 가장 많이 사용하는 코드 에디터입니다.

**주요 특징:**
- 무료 오픈소스
- 가볍고 빠른 실행 속도
- 다양한 확장 프로그램
- Git 통합 지원
- 통합 터미널
- 인텔리센스(자동완성)

```text
바데부: "VS Code는 코딩을 위한 최고의 친구야!
       무료인데 기능이 정말 많아서 초보자부터 전문가까지 모두 사용해."
```

## 1.2 다른 에디터와의 비교

| 에디터 | 장점 | 단점 |
|--------|------|------|
| VS Code | 가볍고, 확장성 좋음, 무료 | - |
| Sublime Text | 매우 빠름 | 유료, 확장성 낮음 |
| Atom | 커스터마이징 자유 | 느림, 개발 중단 |
| IntelliJ IDEA | 강력한 기능 | 무겁고, 유료 |

**바데부의 추천:** "처음 시작한다면 VS Code가 최고의 선택이야!"

## 1.3 시스템 요구사항

VS Code는 거의 모든 컴퓨터에서 실행됩니다.

**최소 요구사항:**
- OS: Windows 10/11, macOS 10.15+, Linux
- CPU: 1.6GHz 이상
- RAM: 1GB (2GB 권장)
- 디스크: 200MB

```text
바데부: "내 노트북도 5년 됐는데 VS Code는 잘 돌아가!"
```

## 1.4 Windows에서 설치하기

**Step 1: 다운로드**
1. https://code.visualstudio.com 접속
2. "Download for Windows" 클릭
3. VSCodeUserSetup-x64-1.XX.X.exe 다운로드

**Step 2: 설치**
1. 다운로드한 파일 실행
2. 라이센스 동의
3. 설치 옵션 선택:
   - ✅ PATH에 추가 (중요!)
   - ✅ 우클릭 메뉴에 추가
   - ✅ 지원되는 파일 형식 연결

```text
📸 스크린샷 위치: 설치 프로그램의 옵션 선택 화면
   - "Add to PATH" 체크박스가 선택된 모습
   - "Open with Code" 옵션이 선택된 모습
```

**Step 3: 설치 완료**
1. "Finish" 클릭
2. VS Code 자동 실행

```text
바데부: "PATH에 추가를 꼭 체크해야 터미널에서 'code .' 명령어를 쓸 수 있어!"
```

## 1.5 macOS에서 설치하기

**방법 1: 공식 웹사이트**
1. https://code.visualstudio.com 접속
2. "Download for macOS" 클릭
3. .zip 파일 다운로드 및 압축 해제
4. Visual Studio Code.app을 Applications 폴더로 이동

**방법 2: Homebrew (추천)**
```bash
# Homebrew로 설치
brew install --cask visual-studio-code
```

**터미널에서 실행하기:**
1. VS Code 실행
2. `Cmd + Shift + P` → "Shell Command: Install 'code' command in PATH" 검색
3. 실행

```text
바데부: "Mac 사용자라면 Homebrew로 설치하면 진짜 편해!"
```

## 1.6 Linux에서 설치하기

**Ubuntu/Debian:**
```bash
# 1. Microsoft GPG 키 추가
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/

# 2. 저장소 추가
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# 3. 설치
sudo apt update
sudo apt install code
```

**Fedora/RHEL:**
```bash
# 저장소 추가 및 설치
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install code
```

## 1.7 첫 실행

VS Code를 처음 실행하면:

1. **Welcome 페이지** 표시
   - 새 파일 만들기
   - 폴더 열기
   - 최근 프로젝트
   - 도움말

```text
📸 스크린샷 위치: VS Code Welcome 화면
   - 깔끔한 인터페이스
   - 왼쪽 사이드바의 아이콘들
   - 중앙의 Welcome 탭
```

2. **언어 팩 설치 안내**
   - 한국어 사용하려면 Korean Language Pack 설치

```text
바데부: "처음 실행하면 영어로 나오는데, 한국어 팩을 설치하면 한글로 볼 수 있어!"
```

## 1.8 한국어 설정하기

**Step 1: Extensions 열기**
- `Ctrl + Shift + X` (Windows/Linux)
- `Cmd + Shift + X` (macOS)

**Step 2: Korean Language Pack 검색**
1. 검색창에 "korean" 입력
2. "Korean Language Pack for Visual Studio Code" 찾기
3. "Install" 클릭

**Step 3: 재시작**
1. 오른쪽 하단에 "Restart" 버튼 나타남
2. 클릭하여 재시작

```text
바데부: "한국어로 설정하면 메뉴나 설명을 이해하기 훨씬 쉬워져!"
```

## 1.9 첫 파일 만들기

간단한 HTML 파일을 만들어봅시다.

**Step 1: 새 파일 생성**
1. `Ctrl + N` (새 파일)
2. `Ctrl + S` (저장)
3. 파일명: `hello.html`

**Step 2: 코드 작성**
```html
<!DOCTYPE html>
<html>
<head>
    <title>바데부의 첫 페이지</title>
</head>
<body>
    <h1>안녕하세요, VS Code!</h1>
    <p>바데부와 함께 코딩을 시작해봐요!</p>
</body>
</html>
```

**Step 3: 브라우저에서 열기**
1. 파일 탐색기에서 hello.html 찾기
2. 더블클릭하여 브라우저에서 열기

```text
바데부: "우와! 내가 만든 첫 웹페이지가 브라우저에 나타났어!"
```

## 1.10 유용한 첫 설정들

VS Code를 더 편하게 사용하기 위한 초기 설정:

**자동 저장 켜기:**
1. File → Preferences → Settings
2. "Auto Save" 검색
3. "afterDelay"로 변경

```json
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000
}
```

**줄 번호 보기:**
```json
{
  "editor.lineNumbers": "on"
}
```

**미니맵 숨기기 (화면이 작을 때):**
```json
{
  "editor.minimap.enabled": false
}
```

```text
바데부: "자동 저장을 켜면 Ctrl+S를 깜빡해도 걱정 없어!"
```

## 1.11 추가 팁

**바데부의 초보자 팁:**

1. **테마 변경하기**
   - `Ctrl + K` → `Ctrl + T`
   - 밝은 테마와 어두운 테마 선택 가능

2. **글꼴 크기 조절**
   - `Ctrl + +` : 크게
   - `Ctrl + -` : 작게
   - `Ctrl + 0` : 원래대로

3. **Zen Mode (집중 모드)**
   - `Ctrl + K` → `Z`
   - 사이드바 등이 숨겨져 코드에만 집중

```text
바데부: "눈이 피로하면 테마를 바꿔보거나 글꼴을 키워봐.
       건강이 제일 중요해!"
```

## 1.12 문제 해결

**VS Code가 실행되지 않을 때:**
1. 바이러스 백신 확인 (VS Code 예외 추가)
2. 관리자 권한으로 실행
3. 최신 버전으로 업데이트

**한국어가 적용되지 않을 때:**
1. Locale 설정 확인: `Ctrl + Shift + P` → "Configure Display Language"
2. "ko" 선택
3. 재시작

**설치 파일을 찾을 수 없을 때:**
1. 다운로드 폴더 확인
2. 브라우저 다운로드 내역 확인
3. 공식 웹사이트에서 재다운로드

```text
바데부: "문제가 생기면 당황하지 말고, 천천히 하나씩 확인해봐!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ VS Code의 장점과 특징
- ✅ Windows, macOS, Linux에서 설치하는 방법
- ✅ 한국어 설정하기
- ✅ 첫 파일 만들기
- ✅ 기본 설정 변경하기

```text
바데부: "이제 VS Code 설치가 끝났어!
       다음 챕터에서는 VS Code의 인터페이스를 자세히 알아볼 거야.
       준비됐지?"
```

## 다음 챕터 예고

다음 챕터에서는:
- VS Code 인터페이스 구조
- 각 영역의 기능
- 기본 단축키
- 커맨드 팔레트 사용법

**바데부와 함께 VS Code 마스터하기! 화이팅!**

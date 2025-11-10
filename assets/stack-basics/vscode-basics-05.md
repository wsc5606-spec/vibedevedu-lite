# Chapter 5: 확장 프로그램 (Extensions)

VS Code의 진정한 힘은 확장 프로그램에 있습니다. 바데부와 함께 필수 확장을 알아봅시다!

## 5.1 확장 프로그램이란?

확장(Extensions)은 VS Code에 새로운 기능을 추가하는 플러그인입니다.

**확장으로 할 수 있는 것:**
- 새로운 프로그래밍 언어 지원
- 테마와 아이콘 변경
- 코드 자동완성 개선
- Git 도구 추가
- 디버깅 도구 강화
- 생산성 향상

```text
바데부: "확장 프로그램은 VS Code를 내 스타일대로 꾸밀 수 있게 해줘!"
```

## 5.2 Extensions 뷰 열기

**열기 방법:**
- `Ctrl + Shift + X`
- Activity Bar의 확장 아이콘 클릭

```text
EXTENSIONS
┌──────────────────────────────┐
│ 🔍 Search Extensions...      │
└──────────────────────────────┘

INSTALLED
  ✓ Korean Language Pack
  ✓ Prettier

RECOMMENDED
  → ESLint
  → GitLens
```

**뷰 구성:**
- **Search**: 확장 검색
- **Installed**: 설치된 확장
- **Recommended**: 추천 확장
- **Popular**: 인기 확장

```text
바데부: "Extensions 마켓플레이스에는 수만 개의 확장이 있어!"
```

## 5.3 확장 프로그램 설치

**설치 방법:**

**방법 1: Extensions 뷰에서**
1. `Ctrl + Shift + X`
2. 검색창에 확장 이름 입력
3. 원하는 확장 찾기
4. "Install" 버튼 클릭

**방법 2: 커맨드 팔레트**
1. `Ctrl + Shift + P`
2. "Extensions: Install Extensions" 입력
3. 확장 검색 및 설치

**방법 3: 웹사이트에서**
1. https://marketplace.visualstudio.com 접속
2. 확장 검색
3. "Install" 클릭 → VS Code로 자동 연결

```text
📸 스크린샷 위치: 확장 설치 과정
   - 검색 결과 목록
   - Install 버튼
   - 설치 진행 중 표시
```

```text
바데부: "확장을 설치하면 바로 사용할 수 있어! 재시작도 대부분 필요 없어."
```

## 5.4 필수 확장 프로그램

바데부가 추천하는 모든 개발자를 위한 필수 확장!

### 1. Korean Language Pack
```text
설명: VS Code를 한국어로 사용
설치: "Korean Language Pack" 검색
```

### 2. Prettier - Code formatter
```text
설명: 코드 자동 정렬
설치: "Prettier" 검색
기능:
  - 저장 시 자동 포맷
  - 일관된 코드 스타일
  - JavaScript, CSS, HTML 등 지원
```

**설정:**
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

### 3. ESLint
```text
설명: JavaScript 코드 검사
설치: "ESLint" 검색
기능:
  - 문법 오류 감지
  - 코드 품질 검사
  - 자동 수정
```

### 4. Auto Rename Tag
```text
설명: HTML/XML 태그 자동 이름 변경
기능: 여는 태그를 수정하면 닫는 태그도 자동 수정

예시:
<div>내용</div>
↓ div를 section으로 변경
<section>내용</section>  ← 자동으로 변경됨!
```

### 5. Bracket Pair Colorizer 2
```text
설명: 괄호 짝을 색상으로 구분
기능: 중첩된 괄호를 쉽게 파악
```

```javascript
// 각 괄호 쌍이 다른 색으로 표시
function calculate((a + (b * (c - d))))
                   ↑    ↑    ↑
                   빨강  파랑  초록
```

```text
바데부: "이 5개만 설치해도 VS Code가 훨씬 편해져!"
```

## 5.5 테마 확장

에디터의 모양을 바꾸는 확장입니다.

**인기 테마:**

### 1. One Dark Pro
```text
설명: Atom의 인기 테마
특징: 눈에 편한 어두운 테마
```

### 2. Material Theme
```text
설명: Google Material Design 테마
특징: 여러 색상 변형 제공
```

### 3. Dracula Official
```text
설명: 유명한 Dracula 테마
특징: 생생한 색상, 높은 대비
```

### 4. GitHub Theme
```text
설명: GitHub 스타일 테마
특징: 밝은/어두운 버전 모두 제공
```

**테마 변경:**
1. `Ctrl + K` → `Ctrl + T`
2. 테마 목록에서 선택
3. 실시간 미리보기

```text
바데부: "테마는 취향이니까 여러 개 써보고 마음에 드는 걸 골라!"
```

## 5.6 아이콘 테마

파일 아이콘을 예쁘게 만들어줍니다.

**인기 아이콘 테마:**

### 1. Material Icon Theme
```text
설명: 가장 인기 있는 아이콘 테마
특징:
  - 파일 종류별 다른 아이콘
  - 폴더 종류별 다른 색상
  - 매우 직관적
```

### 2. vscode-icons
```text
설명: 다양한 파일 형식 지원
특징: 300개 이상의 아이콘
```

**아이콘 테마 변경:**
1. `Ctrl + Shift + P`
2. "Preferences: File Icon Theme"
3. 원하는 테마 선택

```text
📸 스크린샷 위치: 아이콘 테마 적용 전후
   - 기본 아이콘 vs Material Icons
   - 각 파일 형식별 아이콘
```

```text
바데부: "아이콘 테마를 쓰면 파일 종류를 한눈에 알 수 있어!"
```

## 5.7 언어별 확장 프로그램

### JavaScript/TypeScript
```text
1. ESLint - 코드 검사
2. JavaScript (ES6) code snippets - 스니펫
3. Quokka.js - 실시간 코드 실행
```

### Python
```text
1. Python - Microsoft 공식 확장
2. Pylance - 타입 체킹, 자동완성
3. Jupyter - 노트북 지원
```

### HTML/CSS
```text
1. HTML CSS Support - 자동완성
2. Live Server - 실시간 미리보기
3. CSS Peek - CSS 정의로 이동
```

### React
```text
1. ES7+ React/Redux/React-Native snippets
2. Simple React Snippets
3. React Developer Tools
```

### Vue
```text
1. Vetur - Vue 공식 확장
2. Vue VSCode Snippets
```

```text
바데부: "내가 쓰는 언어에 맞는 확장을 설치하면 코딩이 훨씬 수월해!"
```

## 5.8 생산성 향상 확장

### 1. Live Server
```text
설명: HTML 파일을 실시간으로 브라우저에 표시
사용법:
  1. HTML 파일 열기
  2. 우클릭 → "Open with Live Server"
  3. 브라우저에서 자동으로 열림
  4. 수정하면 자동 새로고침!
```

### 2. GitLens
```text
설명: Git 기능 대폭 강화
기능:
  - 각 줄의 마지막 수정자 표시
  - 커밋 히스토리 시각화
  - 파일 히스토리 추적
  - Blame 주석
```

### 3. Todo Tree
```text
설명: TODO 주석을 한곳에 모아서 표시
기능:
  - TODO, FIXME, HACK 등 감지
  - 사이드바에 트리로 표시
  - 클릭하면 해당 위치로 이동
```

```javascript
// TODO: 로그인 기능 구현
function login() {}

// FIXME: 버그 수정 필요
function calculate() {}

// TODO 주석이 모두 Todo Tree에 나타남!
```

### 4. Path Intellisense
```text
설명: 파일 경로 자동완성
기능: 파일 경로 입력 시 자동완성 제공

예시:
import './src/com| ← 여기서 자동완성
         └─ components/
            └─ Header.jsx
```

### 5. Better Comments
```text
설명: 주석을 색상별로 구분
기능:
  ! 중요 - 빨간색
  ? 질문 - 파란색
  TODO - 주황색
  * 강조 - 초록색
```

```javascript
// ! 이 함수는 절대 수정하지 말 것!
// ? 이 부분이 필요한가?
// TODO: 나중에 최적화
// * 중요한 로직
```

```text
바데부: "이 확장들은 내 코딩 속도를 2배로 만들어줬어!"
```

## 5.9 협업 확장

### 1. Live Share
```text
설명: 실시간 협업 코딩
기능:
  - 코드를 여러 명이 동시에 편집
  - 화면 공유
  - 음성 통화
  - 디버깅 공유
```

**사용법:**
1. 확장 설치
2. "Live Share" 버튼 클릭
3. 링크를 팀원에게 공유
4. 함께 코딩!

### 2. CodeTogether
```text
설명: Live Share 대안
특징: 브라우저에서도 참여 가능
```

```text
바데부: "Live Share로 같은 코드를 보면서 페어 프로그래밍할 수 있어!"
```

## 5.10 확장 프로그램 관리

**확장 비활성화:**
1. Extensions 뷰에서 확장 선택
2. "Disable" 클릭
3. 필요할 때 다시 활성화

**확장 제거:**
1. Extensions 뷰에서 확장 선택
2. "Uninstall" 클릭

**작업 영역별 활성화:**
```text
전역 비활성화: Disable
현재 작업 영역만 비활성화: Disable (Workspace)

→ 프로젝트마다 다른 확장 사용 가능
```

**확장 자동 업데이트:**
```json
{
  "extensions.autoUpdate": true,
  "extensions.autoCheckUpdates": true
}
```

```text
바데부: "안 쓰는 확장은 비활성화하면 VS Code가 더 빨라져!"
```

## 5.11 확장 추천 공유

팀 프로젝트에서 확장을 추천할 수 있습니다.

**extensions.json 만들기:**
```json
// .vscode/extensions.json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "eamodio.gitlens"
  ]
}
```

**효과:**
- 프로젝트를 열면 추천 확장 알림
- 팀원 모두 같은 도구 사용
- 일관된 개발 환경

```text
바데부: "팀 프로젝트에서는 extensions.json으로 필수 확장을 공유해!"
```

## 5.12 확장 검색 팁

**효율적인 검색:**

**카테고리로 검색:**
```text
@category:themes         → 테마만
@category:formatters     → 포맷터만
@category:snippets       → 스니펫만
@category:linters        → 린터만
```

**정렬:**
```text
@sort:installs          → 설치 수 순
@sort:rating            → 평점 순
@sort:name              → 이름 순
```

**설치된 확장:**
```text
@installed              → 설치된 확장
@enabled                → 활성화된 확장
@disabled               → 비활성화된 확장
```

**추천 확장:**
```text
@recommended            → 추천 확장
@recommended:workspace  → 작업 영역 추천
```

```text
바데부: "검색 필터를 쓰면 원하는 확장을 빠르게 찾을 수 있어!"
```

## 5.13 확장 설정

각 확장마다 고유한 설정이 있습니다.

**설정 방법:**
1. Extensions 뷰에서 확장 선택
2. 톱니바퀴 아이콘 클릭
3. "Extension Settings" 선택

**예: Prettier 설정**
```json
{
  "prettier.singleQuote": true,
  "prettier.semi": false,
  "prettier.tabWidth": 2,
  "prettier.printWidth": 80
}
```

**예: ESLint 설정**
```json
{
  "eslint.autoFixOnSave": true,
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript"
  ]
}
```

```text
바데부: "확장 설정을 내 취향대로 바꾸면 더 편하게 쓸 수 있어!"
```

## 5.14 실습: 완벽한 개발 환경 구축

바데부와 함께 최고의 환경을 만들어봅시다!

**Step 1: 필수 확장 설치**
1. Korean Language Pack
2. Prettier
3. ESLint
4. Auto Rename Tag
5. Live Server

**Step 2: 테마 설정**
1. One Dark Pro 설치
2. Material Icon Theme 설치
3. 테마 적용

**Step 3: 설정 구성**
```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.fontSize": 14,
  "editor.lineHeight": 1.6,
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme"
}
```

**Step 4: HTML 파일 테스트**
1. 새 HTML 파일 생성
2. `!` 입력 후 Tab (Emmet)
3. 우클릭 → "Open with Live Server"
4. 브라우저에서 확인

```text
바데부: "이제 완벽한 개발 환경이 완성됐어! 코딩하기 딱 좋지?"
```

## 5.15 확장 개발하기 (고급)

자신만의 확장을 만들 수도 있습니다!

**확장 만들기 과정:**
1. Yeoman과 VS Code Extension Generator 설치
2. 확장 템플릿 생성
3. 기능 구현
4. 테스트
5. 마켓플레이스에 배포

```bash
# 확장 생성기 설치
npm install -g yo generator-code

# 새 확장 생성
yo code
```

```text
바데부: "확장 개발은 고급 주제지만, 나중에 도전해볼 만해!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ 확장 프로그램 검색과 설치
- ✅ 필수 확장 프로그램 (Prettier, ESLint 등)
- ✅ 테마와 아이콘 테마
- ✅ 언어별/용도별 확장
- ✅ 확장 관리와 설정

```text
바데부: "확장 프로그램으로 VS Code를 내 취향대로 꾸몄어!
       다음 챕터에서는 디버깅하는 방법을 배울 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 디버거 설정하기
- 브레이크포인트 사용법
- 변수 감시하기
- 디버그 콘솔 활용

**바데부와 함께 버그를 잡아보자! 다음 편도 기대해줘!**

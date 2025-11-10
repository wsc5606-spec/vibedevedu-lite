# Chapter 3: 파일과 폴더 관리

VS Code에서 파일과 폴더를 효율적으로 관리하는 방법을 배워봅시다.

## 3.1 Explorer 기본

Explorer는 프로젝트의 파일 시스템을 관리하는 곳입니다.

**열기:**
- `Ctrl + Shift + E`
- Activity Bar의 📄 아이콘 클릭

```text
EXPLORER
└─ 📁 OPEN EDITORS        ← 현재 열린 파일들
└─ 📁 바데부의 프로젝트    ← 작업 폴더
   ├─ 📁 src
   ├─ 📁 assets
   └─ README.md
```

```text
바데부: "Explorer는 내 프로젝트의 파일 캐비넷이야!"
```

## 3.2 폴더 열기

프로젝트 작업을 시작하려면 먼저 폴더를 열어야 합니다.

**방법 1: 메뉴에서**
1. File → Open Folder
2. 폴더 선택
3. "폴더 선택" 클릭

**방법 2: 드래그 앤 드롭**
1. 파일 탐색기에서 폴더를 찾기
2. VS Code 창으로 드래그
3. 놓기

**방법 3: 터미널에서**
```bash
# Windows/Linux
cd C:\Users\바데부\my-project
code .

# macOS
cd ~/my-project
code .
```

```text
바데부: "'code .' 명령어는 현재 폴더를 VS Code로 여는 마법 주문이야!"
```

## 3.3 새 파일 만들기

여러 방법으로 파일을 만들 수 있습니다.

**방법 1: Explorer에서**
1. Explorer에서 폴더 선택
2. 🆕 New File 아이콘 클릭
3. 파일명 입력: `index.html`
4. Enter

**방법 2: 단축키**
1. `Ctrl + N` (새 임시 파일)
2. `Ctrl + S` (저장)
3. 파일명과 위치 지정

**방법 3: 커맨드 팔레트**
1. `Ctrl + Shift + P`
2. "File: New File" 입력
3. 파일명 입력

```text
📸 스크린샷 위치: Explorer에서 새 파일 만드는 과정
   - New File 아이콘 위치
   - 파일명 입력 필드
```

**파일명 규칙:**
```text
✅ 좋은 예:
- index.html
- main.js
- user-profile.css
- api_handler.py

❌ 나쁜 예:
- 파일.html (한글)
- my file.js (공백)
- data?.json (특수문자)
```

```text
바데부: "파일명은 영어와 하이픈, 언더스코어만 써야 문제가 없어!"
```

## 3.4 새 폴더 만들기

프로젝트 구조를 정리하려면 폴더가 필요합니다.

**방법 1: Explorer에서**
1. 상위 폴더 선택
2. 📁 New Folder 아이콘 클릭
3. 폴더명 입력: `components`
4. Enter

**방법 2: 경로 포함 파일 생성**
```text
새 파일 이름: src/components/Header.jsx
→ src와 components 폴더가 자동으로 생성됨!
```

**일반적인 프로젝트 구조:**
```text
📁 my-project
├─ 📁 src                 ← 소스 코드
│  ├─ 📁 components       ← 컴포넌트
│  ├─ 📁 styles           ← 스타일 시트
│  └─ 📁 utils            ← 유틸리티 함수
├─ 📁 public              ← 정적 파일
│  ├─ 📁 images
│  └─ 📁 fonts
├─ 📁 tests               ← 테스트 파일
└─ README.md
```

```text
바데부: "폴더를 잘 정리하면 나중에 파일 찾기가 훨씬 쉬워져!"
```

## 3.5 파일 이름 변경

파일명을 수정하는 방법입니다.

**방법 1: Explorer에서**
1. 파일 우클릭
2. "Rename" 선택 (또는 `F2`)
3. 새 이름 입력
4. Enter

**방법 2: 단축키**
1. 파일 선택
2. `F2`
3. 새 이름 입력

```text
⚠️ 주의사항:
파일명을 변경하면:
- import/require 경로도 함께 수정해야 함
- Git에서는 삭제+추가로 인식될 수 있음
```

```text
바데부: "파일명을 바꿀 때는 다른 곳에서 참조하고 있지 않은지 확인해야 해!"
```

## 3.6 파일 이동

파일을 다른 폴더로 옮기는 방법입니다.

**방법 1: 드래그 앤 드롭**
1. 파일 선택
2. 대상 폴더로 드래그
3. 놓기

**방법 2: 잘라내기 + 붙여넣기**
1. 파일 선택 후 `Ctrl + X`
2. 대상 폴더 선택
3. `Ctrl + V`

**방법 3: 우클릭 메뉴**
1. 파일 우클릭 → Cut
2. 대상 폴더 우클릭 → Paste

```text
📸 스크린샷 위치: 드래그 앤 드롭으로 파일 이동
   - 파일을 드래그하는 모습
   - 대상 폴더가 하이라이트된 상태
```

**바데부의 팁:**
```text
여러 파일 한번에 이동하기:
1. Ctrl 누른 채로 파일들 클릭
2. 드래그하여 대상 폴더로 이동
```

## 3.7 파일 복사

파일을 복제하는 방법입니다.

**방법 1: 복사 + 붙여넣기**
1. 파일 선택 후 `Ctrl + C`
2. 대상 폴더 선택
3. `Ctrl + V`

**방법 2: 우클릭 메뉴**
1. 파일 우클릭 → Copy
2. 대상 폴더 우클릭 → Paste

**같은 폴더에 복사:**
```text
원본: config.js
복사: config copy.js  ← 자동으로 이름 변경됨
```

```text
바데부: "설정 파일을 수정하기 전에 백업으로 복사해두면 안전해!"
```

## 3.8 파일 삭제

파일을 삭제하는 방법입니다.

**방법 1: Delete 키**
1. 파일 선택
2. `Delete` 키
3. 확인 대화상자에서 확인

**방법 2: 우클릭 메뉴**
1. 파일 우클릭
2. "Delete" 선택
3. 확인

**휴지통 vs 영구 삭제:**
```text
기본 설정: 휴지통으로 이동
영구 삭제: Shift + Delete
```

**설정 변경:**
```json
{
  "explorer.confirmDelete": true,  // 삭제 확인 대화상자
  "files.enableTrash": true        // 휴지통 사용
}
```

```text
⚠️ 주의:
Git 프로젝트에서 파일을 삭제하면:
- Working tree에서 삭제됨
- Git에서는 staged 상태가 됨
- 커밋해야 최종 삭제
```

```text
바데부: "실수로 삭제했어도 휴지통에 있으니 걱정 마!"
```

## 3.9 파일 검색

프로젝트에서 파일을 빠르게 찾는 방법입니다.

**Quick Open (빠른 열기):**
```text
Ctrl + P
→ "index" 입력
→ index.html, index.js 등이 나타남
```

**전체 검색:**
```text
Ctrl + Shift + F
→ 파일 내용으로 검색
→ 찾는 파일이 어디 있는지 찾기
```

**Explorer에서 검색:**
```text
Explorer 뷰에 포커스
→ 파일명 입력
→ 일치하는 파일 하이라이트
```

**파일명 패턴:**
```text
Ctrl + P
→ "*.css"        (모든 CSS 파일)
→ "test/**"      (test 폴더 내 모든 파일)
→ "**/*.jsx"     (모든 JSX 파일)
```

```text
바데부: "Ctrl + P만 잘 써도 파일 찾는 시간이 10배는 줄어들어!"
```

## 3.10 파일 필터링

특정 파일이나 폴더를 숨기는 방법입니다.

**files.exclude 설정:**
```json
{
  "files.exclude": {
    "**/.git": true,           // Git 폴더 숨김
    "**/.DS_Store": true,      // macOS 파일 숨김
    "**/node_modules": true,   // Node 모듈 숨김
    "**/*.pyc": true,          // Python 캐시 숨김
    "**/__pycache__": true
  }
}
```

**검색에서 제외:**
```json
{
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true,
    "**/.git": true
  }
}
```

**임시로 숨긴 파일 보기:**
1. Explorer 상단의 `...` 메뉴
2. "Show Excluded Files" 체크

```text
바데부: "node_modules 같은 큰 폴더는 숨기면 Explorer가 훨씬 깔끔해져!"
```

## 3.11 Workspace (작업 영역)

여러 폴더를 하나의 작업 공간으로 관리합니다.

**Workspace 만들기:**
1. File → Add Folder to Workspace
2. 폴더 선택하여 추가
3. File → Save Workspace As
4. workspace.code-workspace 파일 저장

**Workspace 구조:**
```json
{
  "folders": [
    { "path": "frontend" },
    { "path": "backend" },
    { "path": "shared" }
  ],
  "settings": {
    "editor.fontSize": 14
  }
}
```

**언제 사용하나요?**
- 프론트엔드 + 백엔드 동시 작업
- 여러 관련 프로젝트
- 모노레포 구조

```text
바데부: "Workspace는 여러 프로젝트를 동시에 볼 수 있어서 편해!"
```

## 3.12 파일 비교하기

두 파일의 차이를 확인하는 방법입니다.

**방법 1: 우클릭 메뉴**
1. 첫 번째 파일 선택
2. 우클릭 → "Select for Compare"
3. 두 번째 파일 우클릭
4. "Compare with Selected"

**방법 2: 커맨드 팔레트**
```text
Ctrl + Shift + P
→ "File: Compare Active File With..."
→ 비교할 파일 선택
```

**비교 뷰:**
```text
┌────────────────┬────────────────┐
│  config.js     │  config.js     │
│  (원본)        │  (수정본)      │
│                │                │
│  port: 3000    │  port: 8080    │ ← 차이점 표시
│                │                │
└────────────────┴────────────────┘
```

```text
📸 스크린샷 위치: Diff 뷰
   - 나란히 표시된 두 파일
   - 빨간색 (삭제), 초록색 (추가) 표시
   - 변경된 줄 하이라이트
```

```text
바데부: "설정 파일을 수정할 때 원본과 비교하면 뭐가 바뀌었는지 확실해!"
```

## 3.13 파일 그룹 관리

열린 파일들을 효율적으로 관리합니다.

**Open Editors:**
```text
OPEN EDITORS
├─ index.html    ● ← 수정됨 (저장 안 됨)
├─ style.css
├─ script.js     ●
└─ README.md
```

**모든 파일 닫기:**
- 우클릭 → "Close All"
- `Ctrl + K` → `W`

**저장되지 않은 파일만 닫기:**
- 우클릭 → "Close Saved"

**현재 파일 제외 모두 닫기:**
- 우클릭 → "Close Others"

**탭 고정하기:**
- 탭 우클릭 → "Pin Tab"
- 고정된 탭은 왼쪽에 고정됨

```text
바데부: "중요한 파일은 Pin 해두면 실수로 안 닫혀!"
```

## 3.14 실습: 프로젝트 구조 만들기

바데부와 함께 간단한 웹 프로젝트를 만들어봅시다!

**Step 1: 프로젝트 폴더 생성**
```bash
mkdir my-website
cd my-website
code .
```

**Step 2: 폴더 구조 만들기**
```text
my-website
├─ src
│  ├─ css
│  └─ js
├─ images
└─ index.html
```

**Step 3: 파일 생성**
1. `src/css/style.css`
2. `src/js/main.js`
3. `index.html`

**Step 4: 기본 코드 작성**

`index.html`:
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>바데부의 웹사이트</title>
    <link rel="stylesheet" href="src/css/style.css">
</head>
<body>
    <h1>안녕하세요, 바데부입니다!</h1>
    <script src="src/js/main.js"></script>
</body>
</html>
```

`src/css/style.css`:
```css
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 20px;
}

h1 {
    color: #333;
}
```

`src/js/main.js`:
```javascript
console.log("바데부의 웹사이트에 오신 것을 환영합니다!");
```

```text
바데부: "직접 해보니까 파일 관리가 어렵지 않지? 연습하면 금방 익숙해져!"
```

## 3.15 파일 자동 저장

자동 저장을 설정하면 편리합니다.

**설정 방법:**
```json
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000
}
```

**옵션:**
- `off` : 수동 저장만
- `afterDelay` : 지연 후 자동 저장
- `onFocusChange` : 포커스 변경 시
- `onWindowChange` : 창 변경 시

**메뉴에서:**
1. File → Auto Save 클릭
2. 체크 표시되면 활성화

```text
바데부: "자동 저장을 켜면 Ctrl+S를 깜빡해도 걱정 없어!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Explorer 기본 사용법
- ✅ 파일과 폴더 생성, 삭제, 이동
- ✅ 파일 검색과 필터링
- ✅ Workspace 관리
- ✅ 파일 비교하기

```text
바데부: "파일 관리를 잘하면 프로젝트가 깔끔하게 정리돼!
       다음 챕터에서는 강력한 편집 기능들을 배워볼 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Multi-cursor 고급 활용
- 찾기 및 바꾸기
- 코드 접기/펼치기
- 스니펫 사용법

**바데부와 함께 VS Code 마스터 되기! 다음 편도 기대해줘!**

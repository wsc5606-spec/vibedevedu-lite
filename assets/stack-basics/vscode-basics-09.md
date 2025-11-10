# Chapter 9: 단축키와 생산성 팁

단축키를 익히면 코딩 속도가 몇 배로 빨라집니다. 바데부와 함께 VS Code 고수가 되어봅시다!

## 9.1 왜 단축키를 배워야 할까?

**마우스 vs 키보드:**
```text
마우스:
손 이동 → 마우스 찾기 → 메뉴 찾기 → 클릭 (3~5초)

키보드:
단축키 누르기 (0.5초)

→ 10배 빠름!
```

**바데부의 경험:**
```text
단축키 배우기 전: 프로젝트 완성 2주
단축키 배운 후: 프로젝트 완성 1주

→ 생산성 2배 증가!
```

```text
바데부: "처음엔 외우기 힘들지만, 일주일만 쓰면 손이 자동으로 움직여!"
```

## 9.2 필수 단축키 Top 20

바데부가 가장 많이 쓰는 단축키 순서대로!

**1. Ctrl + P (Quick Open)**
```text
파일 빠르게 열기
사용 빈도: ★★★★★
```

**2. Ctrl + Shift + P (Command Palette)**
```text
모든 명령어 검색
사용 빈도: ★★★★★
```

**3. Ctrl + D (다음 선택)**
```text
같은 단어 선택하여 멀티 커서
사용 빈도: ★★★★★
```

**4. Ctrl + / (주석 토글)**
```text
선택한 줄 주석 처리/해제
사용 빈도: ★★★★★
```

**5. Alt + ↑/↓ (줄 이동)**
```text
선택한 줄을 위/아래로 이동
사용 빈도: ★★★★★
```

**6. Ctrl + ` (터미널 토글)**
```text
통합 터미널 열기/닫기
사용 빈도: ★★★★★
```

**7. Ctrl + B (사이드바 토글)**
```text
사이드바 숨기기/보이기
사용 빈도: ★★★★☆
```

**8. Ctrl + F (찾기)**
```text
현재 파일에서 텍스트 찾기
사용 빈도: ★★★★★
```

**9. Ctrl + H (바꾸기)**
```text
찾아서 바꾸기
사용 빈도: ★★★★☆
```

**10. F2 (이름 바꾸기)**
```text
변수/함수명 일괄 변경
사용 빈도: ★★★★☆
```

**11. Ctrl + Shift + K (줄 삭제)**
```text
현재 줄 삭제
사용 빈도: ★★★★☆
```

**12. Ctrl + L (줄 선택)**
```text
현재 줄 전체 선택
사용 빈도: ★★★☆☆
```

**13. Shift + Alt + F (포맷)**
```text
코드 자동 정렬
사용 빈도: ★★★★☆
```

**14. Ctrl + Space (제안 표시)**
```text
자동완성 목록 표시
사용 빈도: ★★★★☆
```

**15. Alt + Click (멀티 커서)**
```text
여러 위치에 커서 추가
사용 빈도: ★★★★☆
```

**16. Ctrl + Shift + L (모두 선택)**
```text
같은 텍스트 모두 선택
사용 빈도: ★★★☆☆
```

**17. Ctrl + G (줄 이동)**
```text
특정 줄 번호로 이동
사용 빈도: ★★★☆☆
```

**18. Ctrl + Shift + E (Explorer)**
```text
파일 탐색기 열기
사용 빈도: ★★★☆☆
```

**19. Ctrl + Shift + F (전체 검색)**
```text
프로젝트 전체에서 찾기
사용 빈도: ★★★★☆
```

**20. Ctrl + \ (에디터 분할)**
```text
에디터 좌우 분할
사용 빈도: ★★★☆☆
```

```text
바데부: "이 20개만 외워도 VS Code를 90% 활용할 수 있어!"
```

## 9.3 단축키 카테고리별 정리

### 파일 관리
```text
Ctrl + N          새 파일
Ctrl + O          파일 열기
Ctrl + S          저장
Ctrl + Shift + S  다른 이름으로 저장
Ctrl + W          탭 닫기
Ctrl + K W        모든 탭 닫기
Ctrl + Tab        탭 전환
Ctrl + P          빠른 열기
```

### 편집
```text
Ctrl + C          복사
Ctrl + X          잘라내기
Ctrl + V          붙여넣기
Ctrl + Z          되돌리기
Ctrl + Shift + Z  다시 실행
Ctrl + /          주석 토글
Shift + Alt + A   블록 주석
```

### 선택
```text
Ctrl + A          전체 선택
Ctrl + L          줄 선택
Ctrl + D          다음 선택
Shift + Alt + →   영역 확장
Shift + Alt + ←   영역 축소
```

### 이동
```text
Ctrl + G          줄로 이동
Ctrl + P          파일로 이동
Ctrl + Shift + O  심볼로 이동
Alt + ←           뒤로 가기
Alt + →           앞으로 가기
Home              줄 시작
End               줄 끝
Ctrl + Home       파일 시작
Ctrl + End        파일 끝
```

### 검색
```text
Ctrl + F          찾기
Ctrl + H          바꾸기
Ctrl + Shift + F  전체 찾기
Ctrl + Shift + H  전체 바꾸기
F3                다음 찾기
Shift + F3        이전 찾기
```

### 뷰
```text
Ctrl + B          사이드바 토글
Ctrl + `          터미널 토글
Ctrl + Shift + E  Explorer
Ctrl + Shift + F  Search
Ctrl + Shift + G  Source Control
Ctrl + Shift + D  Debug
Ctrl + Shift + X  Extensions
```

### 디버깅
```text
F5                디버깅 시작/계속
F9                브레이크포인트 토글
F10               Step Over
F11               Step Into
Shift + F11       Step Out
Shift + F5        디버깅 중지
```

```text
바데부: "카테고리별로 나눠서 외우면 더 쉬워!"
```

## 9.4 커스텀 단축키 설정

자신만의 단축키를 만들 수 있습니다.

**단축키 설정 열기:**
- `Ctrl + K` → `Ctrl + S`
- File → Preferences → Keyboard Shortcuts

**단축키 검색:**
```text
검색창에 명령어 이름이나 키 입력
예: "format", "git push", "Ctrl+K"
```

**단축키 변경:**
1. 변경할 명령어 찾기
2. 더블클릭 또는 연필 아이콘
3. 새 키 조합 누르기
4. Enter

**예시: Git Push에 단축키 추가**
```text
1. "git push" 검색
2. 더블클릭
3. Ctrl + Shift + P 누르기
4. Enter
```

**keybindings.json 직접 편집:**
```json
[
  {
    "key": "ctrl+shift+p",
    "command": "git.push"
  },
  {
    "key": "ctrl+shift+alt+f",
    "command": "editor.action.formatDocument"
  },
  {
    "key": "ctrl+k ctrl+t",
    "command": "workbench.action.terminal.new"
  }
]
```

```text
바데부: "자주 쓰는 명령어에 단축키를 만들어두면 정말 편해!"
```

## 9.5 Emmet 완전 정복

HTML/CSS를 빠르게 작성하는 도구입니다.

**HTML 기본 약어:**
```html
<!-- ! 입력 후 Tab -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>

</body>
</html>

<!-- div.container 입력 후 Tab -->
<div class="container"></div>

<!-- ul>li*3 입력 후 Tab -->
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>

<!-- div#header>h1+p 입력 후 Tab -->
<div id="header">
  <h1></h1>
  <p></p>
</div>
```

**고급 Emmet:**
```html
<!-- nav>ul>li*4>a[href="#"]{메뉴$} -->
<nav>
  <ul>
    <li><a href="#">메뉴1</a></li>
    <li><a href="#">메뉴2</a></li>
    <li><a href="#">메뉴3</a></li>
    <li><a href="#">메뉴4</a></li>
  </ul>
</nav>

<!-- table>tr*3>td*4 -->
<table>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>

<!-- form:post>input:text+input:password+button:submit -->
<form action="" method="post">
  <input type="text" name="" id="">
  <input type="password" name="" id="">
  <button type="submit"></button>
</form>
```

**CSS Emmet:**
```css
/* m10 → margin: 10px; */
/* p20-30 → padding: 20px 30px; */
/* w100p → width: 100%; */
/* h50p → height: 50%; */
/* fz16 → font-size: 16px; */
/* c#333 → color: #333; */
/* bg#fff → background: #fff; */
/* df → display: flex; */
/* jcc → justify-content: center; */
/* aic → align-items: center; */
```

**Emmet 설정:**
```json
{
  "emmet.triggerExpansionOnTab": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "vue-html": "html"
  }
}
```

```text
바데부: "Emmet은 마법이야! HTML을 10배 빠르게 쓸 수 있어!"
```

## 9.6 스니펫 마스터하기

**기본 스니펫 사용:**
```javascript
// for + Tab
for (let index = 0; index < array.length; index++) {
  const element = array[index];

}

// if + Tab
if (condition) {

}

// log + Tab
console.log();

// func + Tab
function name(params) {

}
```

**커스텀 스니펫 만들기:**
1. `Ctrl + Shift + P` → "Preferences: Configure User Snippets"
2. 언어 선택 (예: javascript.json)
3. 스니펫 작성

**예시: JavaScript 스니펫**
```json
{
  "바데부 콘솔": {
    "prefix": "vlog",
    "body": [
      "console.log('바데부:', $1);",
      "$0"
    ],
    "description": "바데부 로그 출력"
  },
  "React 컴포넌트": {
    "prefix": "rfc",
    "body": [
      "import React from 'react';",
      "",
      "function ${1:ComponentName}() {",
      "  return (",
      "    <div>",
      "      $0",
      "    </div>",
      "  );",
      "}",
      "",
      "export default ${1:ComponentName};"
    ],
    "description": "React 함수형 컴포넌트"
  },
  "Try-Catch": {
    "prefix": "tryc",
    "body": [
      "try {",
      "  $1",
      "} catch (error) {",
      "  console.error('에러:', error);",
      "  $0",
      "}"
    ]
  }
}
```

**스니펫 변수:**
```text
$1, $2, $3...  : 탭 순서
$0             : 최종 커서 위치
${1:기본값}     : 기본값이 있는 탭 정지
$TM_FILENAME   : 현재 파일명
$TM_DIRECTORY  : 현재 디렉토리
$CURRENT_YEAR  : 현재 연도
$CURRENT_DATE  : 현재 날짜
```

**고급 스니펫:**
```json
{
  "파일 헤더": {
    "prefix": "header",
    "body": [
      "/**",
      " * 파일명: $TM_FILENAME",
      " * 작성자: 바데부",
      " * 날짜: $CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE",
      " * 설명: $0",
      " */"
    ]
  }
}
```

```text
바데부: "자주 쓰는 패턴을 스니펫으로 만들어두면 엄청 시간을 아낄 수 있어!"
```

## 9.7 IntelliSense 활용

자동완성을 최대한 활용하는 방법입니다.

**IntelliSense 트리거:**
- `Ctrl + Space` : 제안 목록 표시
- `.` 입력 : 객체 속성 표시
- `(` 입력 : 함수 파라미터 표시

**활용 예시:**
```javascript
// 변수 자동완성
const userName = "바데부";
console.log(user|)  // ← Ctrl + Space로 userName 자동완성

// 메서드 자동완성
const arr = [1, 2, 3];
arr.|  // ← map, filter, reduce 등 제안

// 파라미터 힌트
function greet(name, age) {
  // ...
}
greet(|)  // ← 파라미터 힌트 표시
```

**JSDoc으로 IntelliSense 개선:**
```javascript
/**
 * 사용자 정보를 가져옵니다.
 * @param {number} userId - 사용자 ID
 * @returns {Promise<User>} 사용자 객체
 */
function getUser(userId) {
  // ...
}

// getUser를 호출할 때 파라미터 설명이 표시됨!
```

**설정 최적화:**
```json
{
  "editor.suggestOnTriggerCharacters": true,
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  },
  "editor.acceptSuggestionOnCommitCharacter": true,
  "editor.acceptSuggestionOnEnter": "on"
}
```

```text
바데부: "IntelliSense를 잘 활용하면 오타도 줄고 속도도 빨라져!"
```

## 9.8 Multiple Cursors 고급 기법

**기법 1: Column Selection**
```javascript
// Alt + Shift + 드래그
const a = 1;
const b = 2;
const c = 3;

// "const" 부분만 선택하여 "let"으로 변경
let a = 1;
let b = 2;
let c = 3;
```

**기법 2: 줄 끝에 커서 추가**
```javascript
// 여러 줄 선택 후 Alt + Shift + I
const items = [
  "사과",  // ← 여기에
  "바나나", // ← 여기에
  "오렌지"  // ← 커서 추가
];

// 각 줄 끝에 동시에 입력 가능
```

**기법 3: 패턴으로 커서 추가**
```javascript
// Ctrl + F로 "user" 검색
// Alt + Enter로 모든 "user"에 커서 추가
const user = getUser();
updateUser(user);
console.log(user);
// → 모든 "user"를 "member"로 동시 변경
```

**기법 4: 정규표현식 + 멀티 커서**
```javascript
// Ctrl + H로 바꾸기 열기
// 정규표현식 모드 활성화
// 찾기: function (\w+)
// 바꾸기: const $1 =
// 모든 function을 const로 변환!
```

```text
바데부: "멀티 커서 고급 기법을 쓰면 마치 마법사가 된 기분이야!"
```

## 9.9 Zen Mode와 집중력

**Zen Mode 활성화:**
- `Ctrl + K` → `Z`

**Zen Mode 설정:**
```json
{
  "zenMode.fullScreen": true,
  "zenMode.centerLayout": true,
  "zenMode.hideTabs": true,
  "zenMode.hideStatusBar": true,
  "zenMode.hideActivityBar": true,
  "zenMode.restore": true
}
```

**Focus 기능:**
```text
Ctrl + K Ctrl + 1  : 레벨 1만 접기
Ctrl + K Ctrl + 2  : 레벨 2까지 접기
Ctrl + K Ctrl + 0  : 모두 접기
Ctrl + K Ctrl + J  : 모두 펼치기
```

**방해 요소 제거:**
```json
{
  "editor.minimap.enabled": false,
  "editor.lineNumbers": "off",
  "breadcrumbs.enabled": false,
  "workbench.statusBar.visible": false
}
```

```text
바데부: "집중이 안 될 때 Zen Mode로 코드에만 몰입해!"
```

## 9.10 생산성 극대화 팁

**팁 1: Workspace 활용**
```text
프론트엔드, 백엔드를 하나의 Workspace에
→ 파일 전환이 빠름
→ 통합 검색 가능
```

**팁 2: 파일 즐겨찾기**
```text
자주 쓰는 파일은 Pin (우클릭 → Pin Tab)
→ 왼쪽에 고정
→ 실수로 안 닫힘
```

**팁 3: 스크래치 파일**
```text
Ctrl + N으로 임시 파일 열기
→ 코드 테스트용
→ 저장 안 해도 됨
```

**팁 4: 자동 저장**
```json
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000
}
```

**팁 5: 프로젝트별 설정**
```text
.vscode/settings.json
→ 프로젝트마다 다른 설정
→ 팀원과 공유 가능
```

**팁 6: 템플릿 프로젝트**
```text
자주 쓰는 프로젝트 구조를 템플릿으로
→ Git에 템플릿 저장
→ 새 프로젝트 시 Clone
```

**팁 7: 키보드만 사용하기**
```text
한 주 동안 마우스 사용 금지
→ 단축키가 자연스럽게 외워짐
→ 속도 2배 향상
```

**팁 8: 매크로 활용 (확장)**
```text
"macros" 확장 설치
→ 여러 명령을 하나로 묶기
→ 복잡한 작업 자동화
```

```text
바데부: "이 팁들을 모두 적용하니까 코딩 속도가 3배는 빨라진 것 같아!"
```

## 9.11 실습: 단축키 챌린지

바데부와 함께 단축키 마스터 되기!

**챌린지 1: 파일 없이 프로젝트 만들기**
```text
목표: 마우스 없이 HTML 프로젝트 생성

1. Ctrl + N (새 파일)
2. ! + Tab (HTML 템플릿)
3. Ctrl + S (저장 - index.html)
4. Ctrl + N (새 파일)
5. style + Tab (CSS)
6. Ctrl + S (저장 - style.css)
7. Ctrl + 1 (index.html로 돌아가기)
8. link:css + Tab (CSS 링크 추가)
```

**챌린지 2: 변수명 일괄 변경**
```javascript
// "user"를 모두 "customer"로 변경
const user = getUser();
updateUser(user);
console.log(user);

// 방법 1: Ctrl + D
// 방법 2: F2 (Rename Symbol)
// 방법 3: Ctrl + H (바꾸기)
```

**챌린지 3: 멀티 커서로 배열 만들기**
```javascript
// 1~10까지 배열 만들기
const arr = [
  1,  // Ctrl + Alt + ↓로 커서 추가
  2,  // 숫자만 입력하면
  3,  // 모든 줄에 동시 입력
  // ...
  10
];
```

**챌린지 4: 코드 정리하기**
```javascript
// 들여쓰기 엉망인 코드를
// Shift + Alt + F로 한 번에 정리!
function hello(){
console.log("Hello");
const name="바데부";
console.log(name);
}
```

```text
바데부: "챌린지를 해보면서 손에 익히는 게 제일 빨라!"
```

## 9.12 단축키 치트시트

바데부의 최종 단축키 정리!

**절대 필수 (매일 쓰는 것):**
```text
Ctrl + P          파일 열기
Ctrl + Shift + P  명령 팔레트
Ctrl + D          다음 선택
Ctrl + /          주석
Alt + ↑/↓         줄 이동
Ctrl + `          터미널
```

**자주 쓰는 것:**
```text
Ctrl + F          찾기
Ctrl + H          바꾸기
F2                이름 변경
Shift + Alt + F   포맷
Ctrl + B          사이드바
Ctrl + \          분할
```

**알아두면 좋은 것:**
```text
Ctrl + G          줄 이동
Ctrl + L          줄 선택
Ctrl + Shift + K  줄 삭제
Alt + Click       멀티 커서
Ctrl + K Z        Zen Mode
```

```text
📸 스크린샷 위치: 단축키 치트시트 PDF
   - 인쇄하여 모니터에 붙여두기
   - 자주 보면서 외우기
```

```text
바데부: "이 치트시트를 프린트해서 책상에 붙여놨어!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ 필수 단축키 Top 20
- ✅ 카테고리별 단축키 정리
- ✅ 커스텀 단축키 설정
- ✅ Emmet과 스니펫 마스터
- ✅ 생산성 극대화 팁

```text
바데부: "단축키를 익히는 데 일주일, 마스터하는 데 한 달!
       다음 챕터는 마지막으로 설정과 커스터마이징을 배울 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Settings.json 완전 정복
- 테마와 색상 커스터마이징
- 작업 환경 최적화
- VS Code를 내 것으로 만들기

**바데부와 함께 VS Code 완전 정복! 마지막 편도 기대해줘!**

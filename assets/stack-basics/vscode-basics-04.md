# Chapter 4: 편집 기능 (Multi-cursor, Find/Replace)

VS Code의 강력한 편집 기능들을 마스터하면 코딩 속도가 몇 배로 빨라집니다!

## 4.1 Multi-cursor (멀티 커서)

여러 위치에서 동시에 편집할 수 있는 강력한 기능입니다.

**기본 사용법:**

**1. Alt + Click**
```javascript
// 바데부가 세 줄에 동시에 커서 추가
const name = "홍길동";
const age = 25;
const city = "서울";

// Alt + Click으로 세 곳의 " 앞에 커서를 추가하여
// 한번에 수정 가능
```

**2. Ctrl + Alt + ↑/↓**
```javascript
// 위아래로 커서 추가
let item1 = "사과";
let item2 = "바나나";  ← Ctrl + Alt + ↓ 누르면
let item3 = "오렌지";  ← 커서가 추가됨
```

**3. Ctrl + D (같은 단어 선택)**
```javascript
// "name"을 한 번에 변경하기
const name = "바데부";
console.log(name);
alert(name);

// "name" 위에서 Ctrl + D를 3번 누르면
// 모든 "name"에 커서가 추가됨
```

```text
📸 스크린샷 위치: Multi-cursor 사용 예시
   - 여러 줄에 동시에 커서가 표시된 모습
   - 동시에 입력되는 텍스트
```

```text
바데부: "멀티 커서는 진짜 신세계야! 같은 작업을 반복할 필요가 없어!"
```

## 4.2 Multi-cursor 고급 활용

**4. Ctrl + Shift + L (모든 항목 선택)**
```javascript
// "user"를 모두 선택
const user = getUser();
updateUser(user);
saveUser(user);
logUser(user);

// "user" 선택 후 Ctrl + Shift + L
// → 모든 "user"에 커서 추가
```

**5. Alt + Shift + I (줄 끝에 커서)**
```javascript
// 여러 줄 선택 후 Alt + Shift + I
const a = 1;    |  ← 각 줄 끝에
const b = 2;    |  ← 커서가
const c = 3;    |  ← 추가됨
```

**6. 직사각형 선택**
```javascript
// Alt + Shift + 드래그
데이터1    값1
데이터2    값2
데이터3    값3

// "값" 부분만 드래그하여 한번에 수정
```

```text
바데부: "직사각형 선택은 표 형식 데이터 수정할 때 완전 유용해!"
```

## 4.3 실전 Multi-cursor 예제

**예제 1: 변수명 일괄 변경**
```javascript
// BEFORE: user를 member로 변경
const user = fetchUser();
updateUser(user);
deleteUser(user);

// 1. "user" 더블클릭
// 2. Ctrl + D를 3번 (또는 Ctrl + Shift + L)
// 3. "member" 입력

// AFTER:
const member = fetchUser();
updateUser(member);
deleteUser(member);
```

**예제 2: 배열 항목에 따옴표 추가**
```javascript
// BEFORE:
const items = [
  사과,
  바나나,
  오렌지
];

// 1. Alt + Shift + 드래그로 각 항목 선택
// 2. Ctrl + Shift + L
// 3. Home 키로 줄 시작으로 이동
// 4. " 입력
// 5. End 키로 줄 끝으로 이동
// 6. " 입력

// AFTER:
const items = [
  "사과",
  "바나나",
  "오렌지"
];
```

**예제 3: 주석 추가**
```javascript
// Ctrl + Alt + ↓로 커서 추가 후
// 한번에 주석 작성
const PORT = 3000;        // 서버 포트
const HOST = 'localhost'; // 호스트 주소
const DB = 'mydb';        // 데이터베이스명
```

```text
바데부: "멀티 커서로 반복 작업을 한번에 끝낼 수 있어서 시간을 엄청 아낄 수 있어!"
```

## 4.4 찾기 (Find)

코드에서 특정 텍스트를 찾는 기능입니다.

**기본 찾기:**
- `Ctrl + F` : 찾기 창 열기

```text
┌──────────────────────────────┐
│ 🔍 function                  │  ← 검색어
│    Aa  .*  Ab  ""           │  ← 옵션들
│    1 of 5                   │  ← 결과 개수
└──────────────────────────────┘
```

**찾기 옵션:**
- `Aa` : 대소문자 구분 (Match Case)
- `.*` : 정규표현식 (Regex)
- `Ab` : 단어 단위 (Match Whole Word)

**검색 결과 이동:**
- `Enter` : 다음 결과
- `Shift + Enter` : 이전 결과
- `Alt + Enter` : 모든 결과 선택

```text
바데부: "Alt + Enter로 모든 결과를 선택하면 멀티 커서처럼 쓸 수 있어!"
```

## 4.5 바꾸기 (Replace)

찾은 텍스트를 다른 텍스트로 바꿉니다.

**기본 바꾸기:**
- `Ctrl + H` : 바꾸기 창 열기

```text
┌──────────────────────────────┐
│ 🔍 var                       │  ← 찾을 단어
│ ↓  let                       │  ← 바꿀 단어
│    Aa  .*  Ab  ""           │
│    5 results                │
└──────────────────────────────┘
```

**바꾸기 버튼:**
- `Ctrl + Shift + 1` : 현재 항목 바꾸기
- `Ctrl + Shift + Enter` : 모두 바꾸기
- `Ctrl + Shift + H` : 다음 항목 바꾸기

**예제: var를 let으로 변경**
```javascript
// BEFORE:
var name = "바데부";
var age = 25;
var isStudent = true;

// Ctrl + H → "var" 입력 → "let" 입력 → 모두 바꾸기

// AFTER:
let name = "바데부";
let age = 25;
let isStudent = true;
```

```text
⚠️ 주의:
"모두 바꾸기"는 신중하게!
- 예상치 못한 곳도 바뀔 수 있음
- 하나씩 확인하며 바꾸는 게 안전
```

```text
바데부: "바꾸기 전에 미리보기로 확인하고, Ctrl+Z로 되돌릴 수 있으니 걱정 마!"
```

## 4.6 전체 파일에서 찾기

프로젝트 전체에서 텍스트를 검색합니다.

**열기:**
- `Ctrl + Shift + F`

```text
SEARCH
┌──────────────────────────────┐
│ 🔍 바데부                    │
│    📁 files to include       │
│    📁 files to exclude       │
└──────────────────────────────┘

RESULTS
📄 src/index.html (2)
  5: <title>바데부의 페이지</title>
  10: <h1>바데부 환영합니다</h1>

📄 src/about.html (1)
  3: <p>바데부 소개</p>
```

**검색 옵션:**
- **files to include**: `*.js, *.jsx` (특정 파일만)
- **files to exclude**: `node_modules, dist` (제외할 폴더)

**고급 검색 패턴:**
```text
*.js              → 모든 JS 파일
src/**/*.css      → src 내 모든 CSS
!**/test/**       → test 폴더 제외
```

```text
바데부: "프로젝트가 커지면 전체 검색이 필수야!"
```

## 4.7 전체 파일에서 바꾸기

여러 파일에서 동시에 바꿀 수 있습니다.

**열기:**
- `Ctrl + Shift + H`

**안전한 사용법:**
1. 검색어와 바꿀 단어 입력
2. 결과 미리보기로 확인
3. 파일별로 체크/해제
4. "Replace All" 클릭

```text
📸 스크린샷 위치: 전체 바꾸기 화면
   - 여러 파일의 검색 결과
   - 각 파일별 체크박스
   - "Replace All" 버튼
```

**예제: 함수명 변경**
```javascript
// 10개 파일에서 getUserData → fetchUserData로 변경
// 1. Ctrl + Shift + H
// 2. "getUserData" 입력
// 3. "fetchUserData" 입력
// 4. 결과 확인 후 Replace All
```

```text
⚠️ 위험!
전체 바꾸기는 되돌리기 어려움
- Git 커밋 후에 하기
- 중요한 프로젝트는 백업
- 테스트 파일부터 시도
```

```text
바데부: "전체 바꾸기는 강력한 만큼 조심해서 써야 해!"
```

## 4.8 정규표현식 (Regex) 활용

복잡한 패턴을 찾을 때 사용합니다.

**정규표현식 켜기:**
- 찾기 창에서 `.*` 아이콘 클릭

**자주 쓰는 패턴:**

**1. 이메일 찾기**
```regex
\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b
```

**2. 전화번호 찾기**
```regex
\d{3}-\d{4}-\d{4}
```

**3. URL 찾기**
```regex
https?://[^\s]+
```

**4. 빈 줄 찾기**
```regex
^\s*$
```

**예제: console.log 찾아서 제거**
```javascript
// 찾기: console\.log\(.*\);?
// 바꾸기: (비워두기)

// BEFORE:
console.log("디버그 메시지");
const result = getData();
console.log(result);

// AFTER:
const result = getData();
```

```text
바데부: "정규표현식은 어렵지만, 자주 쓰는 패턴 몇 개만 알아도 유용해!"
```

## 4.9 코드 접기/펼치기 (Folding)

긴 코드를 접어서 보기 좋게 만듭니다.

**수동 접기:**
- 줄 번호 옆의 `-` 아이콘 클릭
- `Ctrl + Shift + [` : 접기
- `Ctrl + Shift + ]` : 펼치기

```javascript
// 접기 전:
function calculateTotal() {
  const items = getItems();
  let total = 0;
  for (let item of items) {
    total += item.price;
  }
  return total;
}

// 접은 후:
function calculateTotal() {...}
```

**모든 코드 접기/펼치기:**
- `Ctrl + K` → `Ctrl + 0` : 모두 접기
- `Ctrl + K` → `Ctrl + J` : 모두 펼치기

**레벨별 접기:**
- `Ctrl + K` → `Ctrl + 1` : 레벨 1만
- `Ctrl + K` → `Ctrl + 2` : 레벨 2까지

```text
📸 스크린샷 위치: 코드 접기 예시
   - 접힌 함수들
   - ... 표시
   - 접기/펼치기 아이콘
```

```text
바데부: "큰 파일을 볼 때 함수들을 접으면 구조를 파악하기 쉬워!"
```

## 4.10 들여쓰기 조정

코드 정렬을 자동으로 맞춥니다.

**자동 들여쓰기:**
- `Shift + Alt + F` : 전체 파일 포맷
- `Ctrl + K` → `Ctrl + F` : 선택 영역만

**들여쓰기 설정:**
```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": true
}
```

**들여쓰기 변환:**
1. Status Bar의 들여쓰기 클릭
2. "Indent Using Spaces" 또는 "Indent Using Tabs" 선택
3. 크기 선택 (2, 4 등)

```javascript
// BEFORE (들여쓰기 엉망):
function hello() {
console.log("Hello");
    const name = "바데부";
        console.log(name);
}

// AFTER (Shift + Alt + F):
function hello() {
  console.log("Hello");
  const name = "바데부";
  console.log(name);
}
```

```text
바데부: "포맷팅은 협업할 때 특히 중요해! 코드가 깔끔해야 읽기 쉬워."
```

## 4.11 줄 이동과 복사

코드 줄을 빠르게 이동하거나 복사합니다.

**줄 이동:**
- `Alt + ↑` : 위로 이동
- `Alt + ↓` : 아래로 이동

**줄 복사:**
- `Shift + Alt + ↑` : 위로 복사
- `Shift + Alt + ↓` : 아래로 복사

**줄 삭제:**
- `Ctrl + Shift + K` : 현재 줄 삭제

**예제:**
```javascript
// 줄 순서 바꾸기
const c = 3;
const a = 1;  ← Alt + ↑로 위로 이동
const b = 2;

// 결과:
const a = 1;
const c = 3;
const b = 2;
```

```text
바데부: "마우스 드래그 없이 키보드만으로 줄을 옮길 수 있어서 빠르고 정확해!"
```

## 4.12 주석 토글

코드를 빠르게 주석 처리합니다.

**단축키:**
- `Ctrl + /` : 줄 주석
- `Shift + Alt + A` : 블록 주석

**줄 주석:**
```javascript
const name = "바데부";
// const age = 25;  ← Ctrl + / 로 주석 처리
const city = "서울";
```

**블록 주석:**
```javascript
/*
const config = {
  port: 3000,
  host: 'localhost'
};
*/
```

**여러 줄 한번에:**
```javascript
// 3줄 선택 후 Ctrl + /
// const a = 1;
// const b = 2;
// const c = 3;
```

```text
바데부: "디버깅할 때 코드를 임시로 꺼야 할 때 주석이 진짜 유용해!"
```

## 4.13 Emmet 약어

HTML/CSS를 빠르게 작성하는 도구입니다.

**HTML Emmet:**
```html
<!-- ul>li*3 입력 후 Tab -->
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>

<!-- div.container>h1+p 입력 후 Tab -->
<div class="container">
  <h1></h1>
  <p></p>
</div>

<!-- a[href="#"]{바데부} 입력 후 Tab -->
<a href="#">바데부</a>
```

**CSS Emmet:**
```css
/* m10 입력 후 Tab */
margin: 10px;

/* p20-30 입력 후 Tab */
padding: 20px 30px;

/* w100p 입력 후 Tab */
width: 100%;
```

**자주 쓰는 약어:**
```text
! → HTML5 템플릿
lorem → Lorem ipsum 텍스트
link:css → CSS 링크 태그
script:src → JavaScript 스크립트 태그
```

```text
바데부: "Emmet은 마법 같아! HTML을 10배 빠르게 쓸 수 있어!"
```

## 4.14 스니펫 (Snippets)

자주 쓰는 코드를 빠르게 삽입합니다.

**기본 스니펫 사용:**
```javascript
// "for" 입력 후 Tab
for (let index = 0; index < array.length; index++) {
  const element = array[index];

}

// "func" 입력 후 Tab
function name(params) {

}

// "log" 입력 후 Tab
console.log();
```

**커스텀 스니펫 만들기:**
1. `Ctrl + Shift + P`
2. "Preferences: Configure User Snippets"
3. 언어 선택 (예: javascript.json)

```json
{
  "바데부 로그": {
    "prefix": "vlog",
    "body": [
      "console.log('바데부:', $1);",
      "$2"
    ],
    "description": "바데부 로그 출력"
  }
}
```

**사용:**
```javascript
// "vlog" 입력 후 Tab
console.log('바데부:', |);  // ← 커서 위치
```

```text
바데부: "내가 자주 쓰는 패턴을 스니펫으로 만들어두면 정말 편해!"
```

## 4.15 실습: 편집 마스터하기

바데부와 함께 실전 연습!

**연습 1: Multi-cursor로 배열 만들기**
```javascript
// 1부터 5까지 배열 만들기
// Ctrl + Alt + ↓로 커서 5개 추가
const arr = [
  1,
  2,
  3,
  4,
  5
];
```

**연습 2: 찾기/바꾸기로 함수명 변경**
```javascript
// getUserInfo → fetchUserInfo
function getUserInfo() { }
const user = getUserInfo();
console.log(getUserInfo());
```

**연습 3: Emmet으로 네비게이션 만들기**
```html
<!-- nav>ul>li*4>a[href="#"] 입력 -->
<nav>
  <ul>
    <li><a href="#">홈</a></li>
    <li><a href="#">소개</a></li>
    <li><a href="#">프로젝트</a></li>
    <li><a href="#">연락처</a></li>
  </ul>
</nav>
```

```text
바데부: "처음엔 어색하지만, 연습하면 손에 익어서 자연스럽게 쓸 수 있어!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Multi-cursor 다양한 활용법
- ✅ 찾기와 바꾸기 (파일 내, 전체 프로젝트)
- ✅ 정규표현식 기본
- ✅ 코드 접기, 들여쓰기, 줄 이동
- ✅ Emmet과 스니펫

```text
바데부: "편집 기능들을 마스터하면 코딩 속도가 정말 빨라져!
       다음 챕터에서는 확장 프로그램으로 VS Code를 더 강력하게 만들어볼 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 필수 확장 프로그램
- 테마와 아이콘
- 언어별 확장 프로그램
- 확장 프로그램 관리

**바데부와 함께 VS Code를 더욱 강력하게! 다음 편도 기대해줘!**

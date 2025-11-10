# Chapter 6: 디버깅

디버깅은 버그를 찾고 수정하는 과정입니다. VS Code는 강력한 디버깅 도구를 제공합니다!

## 6.1 디버깅이란?

**디버깅(Debugging)**: 프로그램의 오류를 찾아서 수정하는 과정

**왜 필요한가요?**
- 코드가 예상대로 동작하지 않을 때
- 오류의 원인을 찾을 때
- 변수 값을 확인할 때
- 프로그램 흐름을 이해할 때

```text
바데부: "디버깅 없이 console.log만 쓰면 시간이 너무 오래 걸려.
       디버거를 쓰면 문제를 10배 빠르게 찾을 수 있어!"
```

## 6.2 디버거 열기

**Run and Debug 뷰:**
- `Ctrl + Shift + D`
- Activity Bar의 디버그 아이콘 클릭

```text
RUN AND DEBUG
┌──────────────────────────────┐
│ ▶ Run and Debug              │
│                              │
│ create a launch.json file    │
└──────────────────────────────┘

VARIABLES
WATCH
CALL STACK
BREAKPOINTS
```

```text
바데부: "처음 보면 복잡해 보이지만, 하나씩 배우면 금방 익숙해져!"
```

## 6.3 launch.json 설정

디버깅 설정을 저장하는 파일입니다.

**생성 방법:**
1. Run and Debug 뷰 열기
2. "create a launch.json file" 클릭
3. 환경 선택 (Node.js, Chrome, Python 등)

**Node.js 예시:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/app.js",
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

**Chrome 예시:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Launch Chrome",
      "url": "http://localhost:3000",
      "webRoot": "${workspaceFolder}"
    }
  ]
}
```

**주요 속성:**
- `type`: 디버거 종류 (node, chrome, python 등)
- `request`: launch(새로 실행) 또는 attach(실행 중인 프로세스에 연결)
- `name`: 설정 이름
- `program`: 실행할 파일
- `url`: 웹 애플리케이션 URL

```text
바데부: "launch.json은 처음 한 번만 설정하면 돼!"
```

## 6.4 브레이크포인트 (Breakpoint)

코드 실행을 멈추는 지점입니다.

**설정 방법:**
1. 줄 번호 왼쪽 클릭
2. 빨간 점 생성됨
3. 다시 클릭하면 제거

```javascript
function calculateTotal(items) {
  let total = 0;              // ← 여기 클릭하여 브레이크포인트 설정
  for (let item of items) {   // 🔴 빨간 점 표시
    total += item.price;
  }
  return total;
}
```

```text
📸 스크린샷 위치: 브레이크포인트 설정
   - 줄 번호 왼쪽의 빨간 점
   - 여러 개의 브레이크포인트
```

**브레이크포인트 단축키:**
- `F9`: 현재 줄에 브레이크포인트 토글
- `Ctrl + Shift + F9`: 모든 브레이크포인트 비활성화

```text
바데부: "브레이크포인트에서 멈추면 그 순간의 모든 변수 값을 볼 수 있어!"
```

## 6.5 디버깅 시작하기

**실행 방법:**
1. 브레이크포인트 설정
2. `F5` 키 누르기 (또는 "Run" 버튼)
3. 브레이크포인트에서 실행 멈춤

**디버깅 컨트롤:**
```text
▶  Continue (F5)        - 다음 브레이크포인트까지 실행
⏯  Step Over (F10)      - 다음 줄로 이동
⏬  Step Into (F11)      - 함수 안으로 들어가기
⏫  Step Out (Shift+F11) - 함수 밖으로 나가기
🔄  Restart (Ctrl+Shift+F5) - 디버깅 재시작
⏹  Stop (Shift+F5)      - 디버깅 중단
```

**예시:**
```javascript
function greet(name) {
  const message = `안녕하세요, ${name}님!`;  // 🔴 브레이크포인트
  console.log(message);
  return message;
}

const result = greet("바데부");  // F5로 시작
// → 브레이크포인트에서 멈춤
// → F10으로 한 줄씩 실행
// → message 변수 값 확인 가능
```

```text
바데부: "F10으로 한 줄씩 실행하면서 변수 값을 확인하면 버그를 쉽게 찾을 수 있어!"
```

## 6.6 Variables (변수 패널)

현재 스코프의 모든 변수를 보여줍니다.

```text
VARIABLES
├─ Local
│  ├─ name: "바데부"
│  └─ message: "안녕하세요, 바데부님!"
├─ Global
│  ├─ console: Object
│  └─ process: Object
└─ Closure
```

**변수 값 수정:**
1. 변수 우클릭
2. "Set Value" 선택
3. 새 값 입력
4. 계속 실행하여 결과 확인

```javascript
function calculateDiscount(price, rate) {
  const discount = price * rate;  // 🔴 여기서 멈춤
  return price - discount;        // rate를 0.2로 수정 가능
}
```

```text
바데부: "변수 값을 직접 바꿔가며 테스트할 수 있어서 정말 편해!"
```

## 6.7 Watch (감시 표현식)

특정 변수나 표현식을 계속 감시합니다.

**추가 방법:**
1. WATCH 패널에서 + 클릭
2. 변수명이나 표현식 입력
3. Enter

**예시:**
```javascript
let count = 0;
for (let i = 0; i < 10; i++) {
  count += i;  // 🔴 브레이크포인트
}

// WATCH에 추가:
// - count
// - i
// - count + i
// - i % 2 === 0
```

```text
WATCH
├─ count: 10
├─ i: 5
├─ count + i: 15
└─ i % 2 === 0: false
```

**유용한 감시 표현식:**
```javascript
// 배열 길이
items.length

// 객체 속성
user.name

// 계산식
price * 0.1

// 조건식
age >= 18

// 함수 호출
Math.round(value)
```

```text
바데부: "Watch를 쓰면 관심 있는 값만 계속 볼 수 있어서 좋아!"
```

## 6.8 Call Stack (호출 스택)

함수 호출의 흐름을 보여줍니다.

```javascript
function c() {
  console.log("C");  // 🔴 여기서 멈춤
}

function b() {
  c();
}

function a() {
  b();
}

a();
```

```text
CALL STACK
├─ c (line 2)      ← 현재 위치
├─ b (line 6)      ← b에서 c를 호출
├─ a (line 10)     ← a에서 b를 호출
└─ anonymous (line 13)  ← 전역에서 a를 호출
```

**활용:**
- 함수 호출 순서 파악
- 어디서 함수가 호출되었는지 확인
- 스택 프레임 간 이동

```text
바데부: "Call Stack을 보면 함수가 어떤 순서로 호출되었는지 알 수 있어!"
```

## 6.9 Breakpoints 패널

모든 브레이크포인트를 관리합니다.

```text
BREAKPOINTS
✓ Breakpoints
  ✓ app.js:12
  ✓ app.js:25
  ✓ utils.js:5
✓ Exception Breakpoints
  ✓ Uncaught Exceptions
  □ Caught Exceptions
```

**기능:**
- 체크박스: 브레이크포인트 활성화/비활성화
- 우클릭: 편집, 제거
- Exception Breakpoints: 예외 발생 시 멈춤

```text
바데부: "디버깅 끝나면 브레이크포인트를 비활성화만 해두면 나중에 다시 쓸 수 있어!"
```

## 6.10 조건부 브레이크포인트

특정 조건일 때만 멈추는 브레이크포인트입니다.

**설정 방법:**
1. 브레이크포인트 우클릭
2. "Edit Breakpoint" → "Expression"
3. 조건식 입력

**예시:**
```javascript
for (let i = 0; i < 100; i++) {
  processItem(i);  // 🔴 조건: i === 50
}
// i가 50일 때만 멈춤!
```

**유용한 조건:**
```javascript
// 특정 값일 때
count === 10

// 특정 범위일 때
i > 50 && i < 60

// null 체크
user === null

// 배열 길이
items.length > 5

// 문자열 포함
name.includes("바데부")
```

```text
바데부: "반복문에서 특정 시점만 확인하고 싶을 때 조건부 브레이크포인트가 완전 유용해!"
```

## 6.11 Logpoints (로그포인트)

코드를 멈추지 않고 로그만 출력합니다.

**설정 방법:**
1. 브레이크포인트 우클릭
2. "Edit Breakpoint" → "Log Message"
3. 메시지 입력

**예시:**
```javascript
function processUser(user) {
  // 💎 Logpoint: "Processing user: {user.name}"
  const result = calculateScore(user);
  return result;
}

// console.log를 추가하지 않아도 로그 출력!
```

**로그 메시지 형식:**
```text
{변수명}          → 변수 값 출력
{표현식}          → 표현식 결과 출력
일반 텍스트       → 그대로 출력

예시:
"User: {user.name}, Age: {user.age}"
"Count is {count}, Next is {count + 1}"
```

```text
바데부: "Logpoint는 코드를 수정하지 않고도 로그를 볼 수 있어서 편해!"
```

## 6.12 Debug Console

디버깅 중 코드를 실행할 수 있는 콘솔입니다.

**열기:**
- 디버깅 중 하단 패널의 "Debug Console" 탭

**사용 예시:**
```javascript
function calculate(a, b) {
  const result = a + b;  // 🔴 여기서 멈춤
  return result;
}

// Debug Console에서 실행:
> a
10
> b
20
> a + b
30
> result
30
> Math.max(a, b)
20
```

**활용:**
- 변수 값 확인
- 표현식 평가
- 함수 호출 테스트
- 임시 계산

```text
바데부: "Debug Console은 디버깅 중에 마음대로 코드를 실행할 수 있는 놀이터야!"
```

## 6.13 JavaScript 디버깅 실습

바데부와 함께 실전 디버깅!

**예제 코드:**
```javascript
// bug.js
function calculateAverage(numbers) {
  let sum = 0;
  for (let i = 0; i <= numbers.length; i++) {  // 🐛 버그!
    sum += numbers[i];
  }
  return sum / numbers.length;
}

const scores = [80, 90, 100];
const avg = calculateAverage(scores);
console.log(`평균: ${avg}`);  // NaN 출력됨!
```

**디버깅 과정:**

**Step 1: 브레이크포인트 설정**
```javascript
function calculateAverage(numbers) {
  let sum = 0;                              // 🔴 브레이크포인트
  for (let i = 0; i <= numbers.length; i++) {
    sum += numbers[i];                      // 🔴 브레이크포인트
  }
  return sum / numbers.length;
}
```

**Step 2: 디버깅 시작 (F5)**

**Step 3: 변수 확인**
```text
VARIABLES
├─ numbers: [80, 90, 100]
├─ sum: 0
└─ i: 0

반복문 1회차: i=0, numbers[0]=80, sum=80
반복문 2회차: i=1, numbers[1]=90, sum=170
반복문 3회차: i=2, numbers[2]=100, sum=270
반복문 4회차: i=3, numbers[3]=undefined! ← 버그 발견!
```

**Step 4: 버그 수정**
```javascript
// 수정 전: i <= numbers.length
// 수정 후: i < numbers.length
for (let i = 0; i < numbers.length; i++) {
  sum += numbers[i];
}
```

```text
바데부: "디버거로 변수 값을 하나씩 확인하니까 버그를 금방 찾았어!"
```

## 6.14 HTML/JavaScript 디버깅

웹 페이지를 디버깅하는 방법입니다.

**Debugger for Chrome 설치:**
1. Extensions에서 "Debugger for Chrome" 검색
2. 설치

**launch.json 설정:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Chrome 디버깅",
      "url": "http://localhost:5500",
      "webRoot": "${workspaceFolder}",
      "sourceMaps": true
    }
  ]
}
```

**예제:**
```html
<!-- index.html -->
<!DOCTYPE html>
<html>
<head>
  <title>바데부의 카운터</title>
</head>
<body>
  <button id="btn">클릭: 0</button>
  <script src="script.js"></script>
</body>
</html>
```

```javascript
// script.js
let count = 0;
const btn = document.getElementById('btn');

btn.addEventListener('click', () => {
  count++;  // 🔴 브레이크포인트
  btn.textContent = `클릭: ${count}`;
});

// F5로 Chrome 열기
// 버튼 클릭하면 브레이크포인트에서 멈춤!
```

```text
바데부: "VS Code에서 브라우저 디버깅까지 할 수 있어서 개발 도구를 왔다갔다 안 해도 돼!"
```

## 6.15 디버깅 팁

바데부의 디버깅 노하우!

**팁 1: console.log vs 디버거**
```javascript
// ❌ 나쁜 방법: console.log 남발
function process(data) {
  console.log("1:", data);
  const result = transform(data);
  console.log("2:", result);
  const final = calculate(result);
  console.log("3:", final);
  return final;
}

// ✅ 좋은 방법: 브레이크포인트 1개
function process(data) {
  const result = transform(data);  // 🔴 여기서 모든 변수 확인
  const final = calculate(result);
  return final;
}
```

**팁 2: 복잡한 조건에 브레이크포인트**
```javascript
// 특정 사용자에서만 버그 발생
users.forEach(user => {
  processUser(user);  // 🔴 조건: user.id === 123
});
```

**팁 3: Watch로 복잡한 표현식 추적**
```javascript
const data = { users: [...], total: 0 };
// WATCH:
// - data.users.length
// - data.users.filter(u => u.active).length
// - data.total / data.users.length
```

**팁 4: Call Stack으로 흐름 파악**
```javascript
// 이 함수가 어디서 호출되는지 모를 때
function mysteryFunction() {
  // 🔴 브레이크포인트 설정
  // Call Stack 확인하여 호출 경로 추적
}
```

```text
바데부: "디버거를 잘 쓰면 개발 시간이 반으로 줄어들어!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ 디버거 설정 (launch.json)
- ✅ 브레이크포인트 설정과 활용
- ✅ Variables, Watch, Call Stack
- ✅ 조건부 브레이크포인트, Logpoint
- ✅ Debug Console 활용

```text
바데부: "디버깅은 개발자의 필수 스킬이야!
       다음 챕터에서는 Git을 VS Code에서 사용하는 방법을 배울 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Git 기본 개념
- VS Code Git 통합 기능
- 커밋, 푸시, 풀
- 브랜치 관리
- 충돌 해결

**바데부와 함께 Git 마스터하기! 다음 편도 기대해줘!**

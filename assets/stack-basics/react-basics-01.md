# React 소개 및 프로젝트 설정

## React란 무엇인가?

React는 Facebook(현 Meta)에서 개발한 사용자 인터페이스를 만들기 위한 JavaScript 라이브러리입니다. 컴포넌트 기반 아키텍처를 사용하여 재사용 가능하고 유지보수가 쉬운 UI를 구축할 수 있습니다.

### React의 주요 특징

1. **컴포넌트 기반**: UI를 독립적이고 재사용 가능한 조각으로 나눕니다
2. **선언적**: UI가 어떻게 보여야 하는지 선언하면, React가 알아서 DOM을 업데이트합니다
3. **Virtual DOM**: 실제 DOM 조작을 최소화하여 성능을 최적화합니다
4. **단방향 데이터 흐름**: 데이터가 한 방향으로만 흐르므로 디버깅이 쉽습니다

## React를 사용하는 이유

```javascript
// 일반 JavaScript로 UI 업데이트
const button = document.getElementById('myButton');
button.innerHTML = '바데부님, 환영합니다!';
button.style.color = 'blue';

// React로 UI 업데이트 (선언적)
function WelcomeButton() {
  return <button style={{ color: 'blue' }}>바데부님, 환영합니다!</button>;
}
```

React를 사용하면 복잡한 UI 로직을 더 간단하고 직관적으로 표현할 수 있습니다.

## 개발 환경 설정

### 필수 도구 설치

1. **Node.js**: JavaScript 런타임 환경
   - https://nodejs.org 에서 LTS 버전 다운로드
   - 설치 후 확인:
   ```bash
   node --version
   npm --version
   ```

2. **코드 에디터**: VS Code 추천
   - https://code.visualstudio.com 에서 다운로드
   - 추천 확장 프로그램:
     - ES7+ React/Redux/React-Native snippets
     - Prettier - Code formatter
     - ESLint

## Create React App으로 프로젝트 생성

Create React App은 React 프로젝트를 빠르게 시작할 수 있는 공식 도구입니다.

### 프로젝트 생성

```bash
# 새 React 프로젝트 생성
npx create-react-app badebu-app

# 프로젝트 폴더로 이동
cd badebu-app

# 개발 서버 실행
npm start
```

브라우저에서 `http://localhost:3000`이 자동으로 열리면 성공입니다!

### 프로젝트 구조 이해하기

```
badebu-app/
├── node_modules/        # 설치된 패키지들
├── public/              # 정적 파일
│   ├── index.html       # 메인 HTML 파일
│   └── favicon.ico      # 파비콘
├── src/                 # 소스 코드
│   ├── App.js           # 메인 컴포넌트
│   ├── App.css          # 스타일
│   ├── index.js         # 진입점
│   └── index.css        # 전역 스타일
├── package.json         # 프로젝트 정보 및 의존성
└── README.md            # 프로젝트 설명서
```

## 첫 번째 수정해보기

`src/App.js` 파일을 열어서 수정해봅시다:

```javascript
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>안녕하세요, 바데부입니다!</h1>
        <p>React 학습을 시작합니다.</p>
        <p>이것이 제 첫 번째 React 앱입니다!</p>
      </header>
    </div>
  );
}

export default App;
```

파일을 저장하면 브라우저가 자동으로 새로고침되며 변경사항이 반영됩니다. 이것이 **Hot Reloading**입니다!

## React의 동작 원리

### index.html의 역할

`public/index.html` 파일을 보면:

```html
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <title>바데부의 React 앱</title>
  </head>
  <body>
    <div id="root"></div>
    <!-- React 앱이 여기에 렌더링됩니다 -->
  </body>
</html>
```

### index.js의 역할

`src/index.js`에서 React 앱을 시작합니다:

```javascript
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

// root DOM 노드를 찾습니다
const root = ReactDOM.createRoot(document.getElementById('root'));

// App 컴포넌트를 렌더링합니다
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

**React.StrictMode**는 개발 모드에서 잠재적인 문제를 발견하는 데 도움을 줍니다.

## 유용한 NPM 명령어

```bash
# 개발 서버 시작
npm start

# 프로덕션 빌드 생성
npm run build

# 테스트 실행
npm test

# 설정 파일 노출 (주의: 되돌릴 수 없음)
npm run eject
```

## 실습: 간단한 프로필 카드 만들기

`src/App.js`를 다음과 같이 수정해봅시다:

```javascript
import './App.css';

function App() {
  const userName = '바데부';
  const userLevel = '초보 개발자';
  const userGoal = 'React 마스터하기';

  return (
    <div className="App">
      <div style={{
        maxWidth: '400px',
        margin: '50px auto',
        padding: '20px',
        border: '2px solid #61dafb',
        borderRadius: '10px',
        backgroundColor: '#282c34',
        color: 'white'
      }}>
        <h1>👨‍💻 {userName}</h1>
        <p><strong>레벨:</strong> {userLevel}</p>
        <p><strong>목표:</strong> {userGoal}</p>
        <button style={{
          padding: '10px 20px',
          backgroundColor: '#61dafb',
          border: 'none',
          borderRadius: '5px',
          cursor: 'pointer',
          fontSize: '16px'
        }}>
          프로필 보기
        </button>
      </div>
    </div>
  );
}

export default App;
```

## 다음 단계

축하합니다! 첫 번째 React 프로젝트를 성공적으로 만들고 실행했습니다. 다음 장에서는:

- JSX 문법을 자세히 배웁니다
- 컴포넌트를 분리하는 방법을 학습합니다
- JavaScript 표현식을 JSX에서 사용하는 방법을 익힙니다

## 핵심 요약

- React는 컴포넌트 기반의 UI 라이브러리입니다
- Create React App으로 쉽게 프로젝트를 시작할 수 있습니다
- `index.js`가 앱의 진입점이며, `App.js`가 메인 컴포넌트입니다
- 코드 변경 시 자동으로 브라우저가 새로고침됩니다 (Hot Reloading)
- JSX를 사용하여 JavaScript 안에서 HTML과 유사한 코드를 작성합니다

바데부 여러분, React의 세계에 오신 것을 환영합니다! 🚀

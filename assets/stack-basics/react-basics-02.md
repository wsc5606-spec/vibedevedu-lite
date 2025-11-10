# JSX 문법과 컴포넌트

## JSX란 무엇인가?

JSX(JavaScript XML)는 JavaScript를 확장한 문법으로, React에서 UI를 표현하는 데 사용됩니다. HTML처럼 보이지만 실제로는 JavaScript입니다.

```javascript
// JSX 사용
const element = <h1>안녕하세요, 바데부님!</h1>;

// 위 코드는 실제로 다음과 같이 변환됩니다
const element = React.createElement('h1', null, '안녕하세요, 바데부님!');
```

## JSX의 기본 규칙

### 1. 하나의 부모 요소로 감싸기

JSX에서는 반드시 하나의 부모 요소로 감싸야 합니다.

```javascript
// ❌ 잘못된 예 - 여러 개의 최상위 요소
function BadExample() {
  return (
    <h1>바데부의 프로필</h1>
    <p>React 개발자</p>
  );
}

// ✅ 올바른 예 - div로 감싸기
function GoodExample() {
  return (
    <div>
      <h1>바데부의 프로필</h1>
      <p>React 개발자</p>
    </div>
  );
}

// ✅ 더 좋은 예 - Fragment 사용 (불필요한 DOM 노드 추가 안 함)
function BestExample() {
  return (
    <>
      <h1>바데부의 프로필</h1>
      <p>React 개발자</p>
    </>
  );
}
```

### 2. JavaScript 표현식 사용하기

중괄호 `{}`를 사용하여 JavaScript 표현식을 삽입할 수 있습니다.

```javascript
function BadebuProfile() {
  const name = '바데부';
  const age = 25;
  const skills = ['React', 'JavaScript', 'CSS'];
  const isOnline = true;

  return (
    <div>
      <h1>{name}의 프로필</h1>
      <p>나이: {age}세</p>
      <p>내년 나이: {age + 1}세</p>
      <p>주요 스킬: {skills.join(', ')}</p>
      <p>상태: {isOnline ? '온라인' : '오프라인'}</p>
    </div>
  );
}
```

### 3. 속성(Props) 사용하기

HTML 속성과 유사하지만 camelCase를 사용합니다.

```javascript
function BadebuCard() {
  const imageUrl = 'https://example.com/badebu.jpg';
  const cardStyle = {
    backgroundColor: '#f0f0f0',
    padding: '20px',
    borderRadius: '10px'
  };

  return (
    <div style={cardStyle}>
      <img
        src={imageUrl}
        alt="바데부 프로필"
        className="profile-image"
        width="100"
      />
      <input
        type="text"
        placeholder="바데부에게 메시지 보내기"
        maxLength="100"
      />
      <button onClick={() => alert('메시지 전송!')}>
        전송
      </button>
    </div>
  );
}
```

### 4. className과 style

JSX에서는 `class` 대신 `className`을, 인라인 스타일은 객체로 작성합니다.

```javascript
function StyledBadebu() {
  return (
    <div className="badebu-container">
      {/* CSS 클래스 사용 */}
      <h1 className="title">바데부</h1>

      {/* 인라인 스타일 사용 (객체 형태) */}
      <p style={{
        color: 'blue',
        fontSize: '18px',
        fontWeight: 'bold',
        backgroundColor: '#f9f9f9'
      }}>
        React를 학습중입니다!
      </p>
    </div>
  );
}
```

### 5. 주석 작성하기

```javascript
function BadebuComponent() {
  return (
    <div>
      {/* JSX 안에서는 이렇게 주석을 작성합니다 */}
      <h1>바데부</h1>

      {/*
        여러 줄 주석도
        이렇게 작성할 수 있습니다
      */}
      <p>React 개발자</p>
    </div>
  );
}
```

## 컴포넌트란?

컴포넌트는 UI를 구성하는 독립적이고 재사용 가능한 코드 블록입니다. React 앱은 여러 컴포넌트로 구성됩니다.

### 함수형 컴포넌트

현대 React에서 주로 사용하는 방식입니다.

```javascript
// 기본 함수형 컴포넌트
function Welcome() {
  return <h1>환영합니다, 바데부님!</h1>;
}

// 화살표 함수로 작성
const Greeting = () => {
  return <h1>안녕하세요!</h1>;
};

// 한 줄일 경우 return 생략 가능
const SimpleGreeting = () => <h1>안녕!</h1>;
```

### 컴포넌트 조합하기

컴포넌트는 다른 컴포넌트를 포함할 수 있습니다.

```javascript
// 개별 컴포넌트들
function Header() {
  return (
    <header>
      <h1>바데부의 블로그</h1>
      <nav>
        <a href="#home">홈</a>
        <a href="#about">소개</a>
        <a href="#posts">포스트</a>
      </nav>
    </header>
  );
}

function ProfileCard() {
  return (
    <div className="profile-card">
      <img src="/badebu.jpg" alt="바데부" />
      <h2>바데부</h2>
      <p>React 개발자</p>
    </div>
  );
}

function PostList() {
  return (
    <div className="posts">
      <h3>최근 포스트</h3>
      <ul>
        <li>React 시작하기</li>
        <li>JSX 완벽 가이드</li>
        <li>컴포넌트 설계 패턴</li>
      </ul>
    </div>
  );
}

function Footer() {
  return (
    <footer>
      <p>&copy; 2024 바데부. All rights reserved.</p>
    </footer>
  );
}

// 모든 컴포넌트를 조합한 메인 앱
function App() {
  return (
    <div className="App">
      <Header />
      <main>
        <ProfileCard />
        <PostList />
      </main>
      <Footer />
    </div>
  );
}

export default App;
```

## 컴포넌트 분리하기

프로젝트가 커지면 컴포넌트를 별도 파일로 분리하는 것이 좋습니다.

### src/components/Header.js

```javascript
function Header() {
  return (
    <header>
      <h1>바데부의 React 학습</h1>
      <p>함께 성장하는 개발자</p>
    </header>
  );
}

export default Header;
```

### src/components/UserCard.js

```javascript
function UserCard() {
  return (
    <div className="user-card">
      <div className="avatar">👨‍💻</div>
      <h2>바데부</h2>
      <p>레벨: 초급 개발자</p>
      <p>학습 중: React, JavaScript</p>
    </div>
  );
}

export default UserCard;
```

### src/App.js

```javascript
import Header from './components/Header';
import UserCard from './components/UserCard';
import './App.css';

function App() {
  return (
    <div className="App">
      <Header />
      <UserCard />
    </div>
  );
}

export default App;
```

## 조건부 렌더링 맛보기

```javascript
function BadebuStatus() {
  const isLearning = true;
  const currentTopic = 'JSX';

  return (
    <div>
      <h2>바데부의 학습 현황</h2>
      {isLearning ? (
        <p>현재 {currentTopic}를 학습 중입니다! 🔥</p>
      ) : (
        <p>휴식 중입니다 😴</p>
      )}
    </div>
  );
}
```

## 리스트 렌더링 맛보기

```javascript
function BadebuSkills() {
  const skills = [
    { id: 1, name: 'JavaScript', level: '중급' },
    { id: 2, name: 'React', level: '초급' },
    { id: 3, name: 'CSS', level: '중급' }
  ];

  return (
    <div>
      <h2>바데부의 스킬</h2>
      <ul>
        {skills.map(skill => (
          <li key={skill.id}>
            {skill.name} - {skill.level}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## 실습: 종합 프로필 페이지 만들기

```javascript
// src/App.js
import './App.css';

function ProfileHeader() {
  return (
    <div className="profile-header">
      <div className="avatar">👨‍💻</div>
      <h1>바데부</h1>
      <p className="subtitle">열정적인 React 개발자</p>
    </div>
  );
}

function InfoSection() {
  const info = {
    email: 'badebu@example.com',
    location: '서울, 한국',
    joined: '2024년 1월'
  };

  return (
    <div className="info-section">
      <h2>기본 정보</h2>
      <p>📧 {info.email}</p>
      <p>📍 {info.location}</p>
      <p>📅 가입일: {info.joined}</p>
    </div>
  );
}

function SkillsSection() {
  const skills = ['React', 'JavaScript', 'HTML', 'CSS', 'Git'];

  return (
    <div className="skills-section">
      <h2>보유 스킬</h2>
      <div className="skills-list">
        {skills.map((skill, index) => (
          <span key={index} className="skill-tag">
            {skill}
          </span>
        ))}
      </div>
    </div>
  );
}

function App() {
  return (
    <div className="App">
      <ProfileHeader />
      <InfoSection />
      <SkillsSection />
    </div>
  );
}

export default App;
```

## 핵심 요약

- JSX는 JavaScript 안에서 HTML과 유사한 문법을 사용할 수 있게 해줍니다
- 반드시 하나의 부모 요소로 감싸야 합니다 (또는 Fragment `<>` 사용)
- `{}`를 사용하여 JavaScript 표현식을 삽입합니다
- `className`으로 CSS 클래스를, 객체로 인라인 스타일을 지정합니다
- 컴포넌트는 재사용 가능한 UI 블록입니다
- 컴포넌트를 조합하여 복잡한 UI를 구성합니다
- 컴포넌트는 별도 파일로 분리하여 관리할 수 있습니다

다음 장에서는 Props를 사용하여 컴포넌트 간에 데이터를 전달하는 방법을 배웁니다! 🚀

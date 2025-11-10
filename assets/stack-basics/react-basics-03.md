# Props와 컴포넌트 간 데이터 전달

## Props란 무엇인가?

Props(Properties)는 부모 컴포넌트에서 자식 컴포넌트로 데이터를 전달하는 방법입니다. 함수의 매개변수처럼 작동하며, 컴포넌트를 재사용 가능하게 만듭니다.

```javascript
// Props 없이 (재사용 불가능)
function GreetingBadebu() {
  return <h1>안녕하세요, 바데부님!</h1>;
}

// Props 사용 (재사용 가능)
function Greeting(props) {
  return <h1>안녕하세요, {props.name}님!</h1>;
}

function App() {
  return (
    <div>
      <Greeting name="바데부" />
      <Greeting name="철수" />
      <Greeting name="영희" />
    </div>
  );
}
```

## Props 기본 사용법

### 1. Props 전달하기

```javascript
function UserCard(props) {
  return (
    <div className="user-card">
      <h2>{props.name}</h2>
      <p>나이: {props.age}세</p>
      <p>직업: {props.job}</p>
    </div>
  );
}

function App() {
  return (
    <div>
      <UserCard
        name="바데부"
        age={25}
        job="React 개발자"
      />
    </div>
  );
}
```

### 2. 구조 분해 할당 사용하기

더 깔끔한 코드를 위해 구조 분해 할당을 사용할 수 있습니다.

```javascript
// props 객체 사용
function UserCard(props) {
  return (
    <div>
      <h2>{props.name}</h2>
      <p>{props.age}세</p>
    </div>
  );
}

// 구조 분해 할당 (추천)
function UserCard({ name, age, job }) {
  return (
    <div className="user-card">
      <h2>{name}</h2>
      <p>나이: {age}세</p>
      <p>직업: {job}</p>
    </div>
  );
}

function App() {
  return (
    <UserCard
      name="바데부"
      age={25}
      job="React 개발자"
    />
  );
}
```

### 3. 다양한 타입의 Props

```javascript
function BadebuProfile({
  name,           // 문자열
  age,            // 숫자
  isOnline,       // 불리언
  skills,         // 배열
  address,        // 객체
  onClick         // 함수
}) {
  return (
    <div className="profile">
      <h2>{name}</h2>
      <p>나이: {age}세</p>
      <p>상태: {isOnline ? '온라인 🟢' : '오프라인 ⚫'}</p>

      <div>
        <h3>스킬:</h3>
        <ul>
          {skills.map((skill, index) => (
            <li key={index}>{skill}</li>
          ))}
        </ul>
      </div>

      <p>위치: {address.city}, {address.country}</p>

      <button onClick={onClick}>프로필 보기</button>
    </div>
  );
}

function App() {
  const handleClick = () => {
    alert('바데부의 프로필을 확인합니다!');
  };

  return (
    <BadebuProfile
      name="바데부"
      age={25}
      isOnline={true}
      skills={['React', 'JavaScript', 'CSS']}
      address={{ city: '서울', country: '한국' }}
      onClick={handleClick}
    />
  );
}
```

## 기본값(Default Props) 설정

Props가 전달되지 않았을 때 사용할 기본값을 설정할 수 있습니다.

```javascript
// 방법 1: 함수 매개변수 기본값
function UserCard({ name = '익명', level = '초보', points = 0 }) {
  return (
    <div className="user-card">
      <h2>{name}</h2>
      <p>레벨: {level}</p>
      <p>포인트: {points}</p>
    </div>
  );
}

function App() {
  return (
    <div>
      <UserCard name="바데부" level="중급" points={1500} />
      <UserCard name="철수" />  {/* level과 points는 기본값 사용 */}
      <UserCard />  {/* 모든 값이 기본값 사용 */}
    </div>
  );
}

// 방법 2: defaultProps (이전 방식)
function ProfileCard({ name, bio }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{bio}</p>
    </div>
  );
}

ProfileCard.defaultProps = {
  name: '바데부',
  bio: 'React를 학습하는 개발자입니다.'
};
```

## Children Props

특별한 `children` prop을 사용하여 컴포넌트 사이의 내용을 전달할 수 있습니다.

```javascript
// 기본 children 사용
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}

function App() {
  return (
    <div>
      <Card>
        <h2>바데부의 학습 카드</h2>
        <p>오늘은 Props를 배우고 있습니다!</p>
      </Card>

      <Card>
        <h2>진행 상황</h2>
        <ul>
          <li>JSX 완료 ✅</li>
          <li>Props 학습 중 🔥</li>
          <li>State 예정 📅</li>
        </ul>
      </Card>
    </div>
  );
}

// 고급 예제: 레이아웃 컴포넌트
function Panel({ title, children }) {
  return (
    <div className="panel">
      <div className="panel-header">
        <h3>{title}</h3>
      </div>
      <div className="panel-body">
        {children}
      </div>
    </div>
  );
}

function App() {
  return (
    <Panel title="바데부의 일일 학습">
      <p>📚 React Props 완성</p>
      <p>⏰ 학습 시간: 2시간</p>
      <p>✨ 이해도: 90%</p>
    </Panel>
  );
}
```

## Props 검증 (PropTypes)

Props의 타입을 검증하여 버그를 예방할 수 있습니다.

```javascript
import PropTypes from 'prop-types';

function BadebuCard({ name, age, email, isActive }) {
  return (
    <div className="badebu-card">
      <h2>{name}</h2>
      <p>나이: {age}세</p>
      <p>이메일: {email}</p>
      <p>활성: {isActive ? '예' : '아니오'}</p>
    </div>
  );
}

// PropTypes로 타입 검증
BadebuCard.propTypes = {
  name: PropTypes.string.isRequired,  // 필수 문자열
  age: PropTypes.number.isRequired,   // 필수 숫자
  email: PropTypes.string,             // 선택적 문자열
  isActive: PropTypes.bool             // 선택적 불리언
};

// 기본값 설정
BadebuCard.defaultProps = {
  isActive: true,
  email: 'badebu@example.com'
};
```

## 실전 예제: 사용자 대시보드

```javascript
// src/components/StatCard.js
function StatCard({ icon, label, value, color }) {
  const cardStyle = {
    backgroundColor: color,
    padding: '20px',
    borderRadius: '10px',
    color: 'white',
    textAlign: 'center'
  };

  return (
    <div style={cardStyle}>
      <div style={{ fontSize: '40px' }}>{icon}</div>
      <h3>{label}</h3>
      <p style={{ fontSize: '24px', fontWeight: 'bold' }}>{value}</p>
    </div>
  );
}

// src/components/ProgressBar.js
function ProgressBar({ title, current, total, color = '#4CAF50' }) {
  const percentage = (current / total) * 100;

  return (
    <div className="progress-bar">
      <div className="progress-header">
        <span>{title}</span>
        <span>{current} / {total}</span>
      </div>
      <div style={{
        width: '100%',
        backgroundColor: '#e0e0e0',
        borderRadius: '10px',
        overflow: 'hidden'
      }}>
        <div style={{
          width: `${percentage}%`,
          backgroundColor: color,
          height: '20px',
          transition: 'width 0.3s ease'
        }} />
      </div>
    </div>
  );
}

// src/components/AchievementBadge.js
function AchievementBadge({ title, description, unlocked }) {
  return (
    <div style={{
      padding: '15px',
      border: '2px solid #ddd',
      borderRadius: '8px',
      opacity: unlocked ? 1 : 0.5,
      backgroundColor: unlocked ? '#fff3cd' : '#f8f9fa'
    }}>
      <h4>{title} {unlocked ? '🏆' : '🔒'}</h4>
      <p style={{ fontSize: '14px', color: '#666' }}>{description}</p>
    </div>
  );
}

// src/App.js
import StatCard from './components/StatCard';
import ProgressBar from './components/ProgressBar';
import AchievementBadge from './components/AchievementBadge';
import './App.css';

function App() {
  const badebuStats = {
    completedLessons: 15,
    totalLessons: 50,
    studyStreak: 7,
    totalPoints: 1250
  };

  const achievements = [
    { title: '첫 걸음', description: '첫 강의 완료', unlocked: true },
    { title: '열정가', description: '7일 연속 학습', unlocked: true },
    { title: '마스터', description: '모든 강의 완료', unlocked: false }
  ];

  return (
    <div className="App">
      <h1>바데부의 학습 대시보드</h1>

      <div className="stats-grid">
        <StatCard
          icon="📚"
          label="완료한 강의"
          value={badebuStats.completedLessons}
          color="#3498db"
        />
        <StatCard
          icon="🔥"
          label="연속 학습"
          value={`${badebuStats.studyStreak}일`}
          color="#e74c3c"
        />
        <StatCard
          icon="⭐"
          label="총 포인트"
          value={badebuStats.totalPoints}
          color="#f39c12"
        />
      </div>

      <div className="progress-section">
        <h2>학습 진행률</h2>
        <ProgressBar
          title="React 기초"
          current={badebuStats.completedLessons}
          total={badebuStats.totalLessons}
          color="#61dafb"
        />
        <ProgressBar
          title="JavaScript"
          current={30}
          total={40}
          color="#f7df1e"
        />
      </div>

      <div className="achievements-section">
        <h2>업적</h2>
        <div className="achievements-grid">
          {achievements.map((achievement, index) => (
            <AchievementBadge
              key={index}
              title={achievement.title}
              description={achievement.description}
              unlocked={achievement.unlocked}
            />
          ))}
        </div>
      </div>
    </div>
  );
}

export default App;
```

## Props 전달 패턴

### 1. Spread Operator로 Props 전달

```javascript
function UserInfo({ name, age, city }) {
  return (
    <div>
      <p>이름: {name}</p>
      <p>나이: {age}</p>
      <p>도시: {city}</p>
    </div>
  );
}

function App() {
  const badebuData = {
    name: '바데부',
    age: 25,
    city: '서울'
  };

  // spread operator 사용
  return <UserInfo {...badebuData} />;
}
```

### 2. Props 중첩 전달

```javascript
function GrandParent() {
  return <Parent userName="바데부" />;
}

function Parent({ userName }) {
  return <Child userName={userName} />;
}

function Child({ userName }) {
  return <h1>{userName}님 환영합니다!</h1>;
}
```

## 핵심 요약

- Props는 부모에서 자식 컴포넌트로 데이터를 전달하는 방법입니다
- Props는 읽기 전용이며 수정할 수 없습니다
- 구조 분해 할당으로 더 깔끔한 코드를 작성할 수 있습니다
- 기본값을 설정하여 Props가 없을 때 대비할 수 있습니다
- `children` prop으로 컴포넌트 사이의 내용을 전달할 수 있습니다
- PropTypes로 타입을 검증하여 버그를 예방할 수 있습니다

다음 장에서는 State와 useState Hook을 배워 동적인 컴포넌트를 만들어봅니다! 🚀

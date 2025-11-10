# 조건부 렌더링과 리스트

## 조건부 렌더링이란?

조건부 렌더링은 특정 조건에 따라 다른 UI를 표시하는 것입니다. JavaScript의 조건문을 사용하여 React 컴포넌트에서 조건부로 요소를 렌더링할 수 있습니다.

## if 문 사용하기

```javascript
function BadebuGreeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>환영합니다, 바데부님! 👋</h1>;
  }
  return <h1>로그인이 필요합니다 🔒</h1>;
}

function App() {
  return (
    <div>
      <BadebuGreeting isLoggedIn={true} />
      <BadebuGreeting isLoggedIn={false} />
    </div>
  );
}
```

## 삼항 연산자 사용하기

가장 일반적으로 사용되는 방법입니다.

```javascript
import { useState } from 'react';

function LoginButton() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  return (
    <div>
      <h2>
        {isLoggedIn ? '바데부님, 안녕하세요!' : '로그인해주세요'}
      </h2>

      <button onClick={() => setIsLoggedIn(!isLoggedIn)}>
        {isLoggedIn ? '로그아웃' : '로그인'}
      </button>

      <p>
        상태: {isLoggedIn ? '온라인 🟢' : '오프라인 ⚫'}
      </p>
    </div>
  );
}
```

## 논리 AND (&&) 연산자

조건이 참일 때만 렌더링하고, 거짓이면 아무것도 렌더링하지 않을 때 유용합니다.

```javascript
import { useState } from 'react';

function Notifications() {
  const [messages, setMessages] = useState([
    '바데부님, 새 강의가 업데이트되었습니다!',
    'React 학습을 완료했습니다!',
    '새로운 업적을 달성했습니다!'
  ]);

  return (
    <div>
      <h2>알림</h2>

      {/* 메시지가 있을 때만 표시 */}
      {messages.length > 0 && (
        <div className="notification-badge">
          {messages.length}개의 새 알림
        </div>
      )}

      {/* 메시지가 없으면 표시 */}
      {messages.length === 0 && (
        <p>새로운 알림이 없습니다.</p>
      )}

      <ul>
        {messages.map((msg, index) => (
          <li key={index}>{msg}</li>
        ))}
      </ul>

      <button onClick={() => setMessages([])}>
        모든 알림 삭제
      </button>
    </div>
  );
}
```

## 조건부 렌더링 패턴들

### 1. 변수에 저장하기

```javascript
function BadebuProfile({ user }) {
  let content;

  if (!user) {
    content = <p>사용자 정보를 불러오는 중...</p>;
  } else if (user.isPremium) {
    content = (
      <div className="premium-profile">
        <h2>⭐ {user.name} (프리미엄)</h2>
        <p>모든 기능을 사용할 수 있습니다!</p>
      </div>
    );
  } else {
    content = (
      <div className="basic-profile">
        <h2>{user.name}</h2>
        <p>기본 회원입니다.</p>
        <button>프리미엄으로 업그레이드</button>
      </div>
    );
  }

  return <div>{content}</div>;
}

function App() {
  const badebu = { name: '바데부', isPremium: false };

  return <BadebuProfile user={badebu} />;
}
```

### 2. 즉시 실행 함수 사용하기

```javascript
function StudentGrade({ score }) {
  return (
    <div>
      <h2>바데부의 성적</h2>
      <p>점수: {score}점</p>
      <p>
        등급: {(() => {
          if (score >= 90) return 'A 🏆';
          if (score >= 80) return 'B 👍';
          if (score >= 70) return 'C 👌';
          if (score >= 60) return 'D 😐';
          return 'F 😢';
        })()}
      </p>
    </div>
  );
}
```

### 3. 컴포넌트 분리하기

```javascript
function WelcomeUser({ name }) {
  return <h1>환영합니다, {name}님! 👋</h1>;
}

function LoginPrompt() {
  return (
    <div>
      <h1>로그인이 필요합니다 🔒</h1>
      <button>로그인하기</button>
    </div>
  );
}

function App({ isLoggedIn, userName }) {
  return (
    <div>
      {isLoggedIn ? (
        <WelcomeUser name={userName} />
      ) : (
        <LoginPrompt />
      )}
    </div>
  );
}
```

## 리스트 렌더링

### 기본 리스트 렌더링

```javascript
function SkillList() {
  const skills = ['React', 'JavaScript', 'CSS', 'HTML', 'Git'];

  return (
    <div>
      <h2>바데부의 스킬</h2>
      <ul>
        {skills.map((skill, index) => (
          <li key={index}>{skill}</li>
        ))}
      </ul>
    </div>
  );
}
```

### Key Props의 중요성

Key는 React가 어떤 항목이 변경, 추가, 삭제되었는지 식별하는 데 도움을 줍니다.

```javascript
function TodoList() {
  const todos = [
    { id: 1, text: 'React 공부하기', done: true },
    { id: 2, text: 'Props 복습하기', done: false },
    { id: 3, text: 'State 연습하기', done: false }
  ];

  return (
    <div>
      <h2>바데부의 할 일 목록</h2>
      <ul>
        {todos.map(todo => (
          // ✅ 고유한 id를 key로 사용
          <li
            key={todo.id}
            style={{
              textDecoration: todo.done ? 'line-through' : 'none',
              color: todo.done ? '#888' : '#000'
            }}
          >
            {todo.text}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

**주의**: index를 key로 사용하는 것은 항목의 순서가 변경될 수 있을 때 문제가 발생할 수 있습니다. 가능하면 고유한 id를 사용하세요.

### 객체 배열 렌더링

```javascript
import { useState } from 'react';

function StudentList() {
  const [students, setStudents] = useState([
    { id: 1, name: '바데부', score: 95, level: '고급' },
    { id: 2, name: '철수', score: 88, level: '중급' },
    { id: 3, name: '영희', score: 92, level: '고급' },
    { id: 4, name: '민수', score: 76, level: '초급' }
  ]);

  return (
    <div>
      <h2>학생 목록</h2>
      <table border="1" style={{ width: '100%', borderCollapse: 'collapse' }}>
        <thead>
          <tr>
            <th>이름</th>
            <th>점수</th>
            <th>레벨</th>
            <th>등급</th>
          </tr>
        </thead>
        <tbody>
          {students.map(student => (
            <tr key={student.id}>
              <td>{student.name}</td>
              <td>{student.score}점</td>
              <td>{student.level}</td>
              <td>
                {student.score >= 90 ? 'A' :
                 student.score >= 80 ? 'B' :
                 student.score >= 70 ? 'C' : 'D'}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
```

## 필터링과 정렬

```javascript
import { useState } from 'react';

function CourseList() {
  const [courses, setCourses] = useState([
    { id: 1, title: 'React 기초', category: 'frontend', price: 30000, difficulty: '초급' },
    { id: 2, title: 'Node.js 입문', category: 'backend', price: 40000, difficulty: '중급' },
    { id: 3, title: 'CSS 마스터', category: 'frontend', price: 25000, difficulty: '초급' },
    { id: 4, title: 'MongoDB 완벽가이드', category: 'backend', price: 35000, difficulty: '고급' }
  ]);

  const [filter, setFilter] = useState('all');
  const [sortBy, setSortBy] = useState('title');

  // 필터링
  const filteredCourses = courses.filter(course => {
    if (filter === 'all') return true;
    return course.category === filter;
  });

  // 정렬
  const sortedCourses = [...filteredCourses].sort((a, b) => {
    if (sortBy === 'price') {
      return a.price - b.price;
    }
    return a.title.localeCompare(b.title);
  });

  return (
    <div>
      <h2>바데부의 강의 목록</h2>

      <div className="controls">
        <label>
          카테고리:
          <select value={filter} onChange={(e) => setFilter(e.target.value)}>
            <option value="all">전체</option>
            <option value="frontend">프론트엔드</option>
            <option value="backend">백엔드</option>
          </select>
        </label>

        <label>
          정렬:
          <select value={sortBy} onChange={(e) => setSortBy(e.target.value)}>
            <option value="title">제목순</option>
            <option value="price">가격순</option>
          </select>
        </label>
      </div>

      <div className="course-grid">
        {sortedCourses.length === 0 ? (
          <p>검색 결과가 없습니다.</p>
        ) : (
          sortedCourses.map(course => (
            <div key={course.id} className="course-card">
              <h3>{course.title}</h3>
              <p>난이도: {course.difficulty}</p>
              <p>가격: {course.price.toLocaleString()}원</p>
              <button>수강신청</button>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
```

## 중첩 리스트 렌더링

```javascript
function CurriculumList() {
  const curriculum = [
    {
      id: 1,
      title: 'React 기초',
      lessons: [
        { id: 101, name: 'React 소개', duration: '10분' },
        { id: 102, name: 'JSX 문법', duration: '15분' },
        { id: 103, name: '컴포넌트', duration: '20분' }
      ]
    },
    {
      id: 2,
      title: 'React 심화',
      lessons: [
        { id: 201, name: 'Hooks 완벽가이드', duration: '30분' },
        { id: 202, name: 'Context API', duration: '25분' }
      ]
    }
  ];

  return (
    <div>
      <h2>바데부의 커리큘럼</h2>
      {curriculum.map(section => (
        <div key={section.id} className="section">
          <h3>{section.title}</h3>
          <ul>
            {section.lessons.map(lesson => (
              <li key={lesson.id}>
                {lesson.name} ({lesson.duration})
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  );
}
```

## 실전 예제: 대시보드

```javascript
import { useState } from 'react';

function Dashboard() {
  const [view, setView] = useState('overview'); // 'overview', 'courses', 'achievements'

  const stats = {
    completedCourses: 12,
    totalHours: 48,
    currentStreak: 7,
    totalPoints: 1850
  };

  const courses = [
    { id: 1, title: 'React 기초', progress: 100, status: 'completed' },
    { id: 2, title: 'JavaScript ES6', progress: 75, status: 'in-progress' },
    { id: 3, title: 'CSS Grid', progress: 45, status: 'in-progress' },
    { id: 4, title: 'Node.js', progress: 0, status: 'not-started' }
  ];

  const achievements = [
    { id: 1, title: '첫 강의 완료', unlocked: true, icon: '🎓' },
    { id: 2, title: '일주일 연속 학습', unlocked: true, icon: '🔥' },
    { id: 3, title: '10개 강의 완료', unlocked: true, icon: '⭐' },
    { id: 4, title: '100시간 학습', unlocked: false, icon: '🏆' }
  ];

  return (
    <div className="dashboard">
      <h1>바데부의 학습 대시보드</h1>

      {/* 네비게이션 */}
      <nav>
        <button
          onClick={() => setView('overview')}
          style={{ fontWeight: view === 'overview' ? 'bold' : 'normal' }}
        >
          개요
        </button>
        <button
          onClick={() => setView('courses')}
          style={{ fontWeight: view === 'courses' ? 'bold' : 'normal' }}
        >
          강의
        </button>
        <button
          onClick={() => setView('achievements')}
          style={{ fontWeight: view === 'achievements' ? 'bold' : 'normal' }}
        >
          업적
        </button>
      </nav>

      {/* 조건부 렌더링: 선택된 뷰 표시 */}
      {view === 'overview' && (
        <div className="overview">
          <h2>학습 통계</h2>
          <div className="stats-grid">
            <div className="stat-card">
              <h3>완료한 강의</h3>
              <p>{stats.completedCourses}개</p>
            </div>
            <div className="stat-card">
              <h3>총 학습 시간</h3>
              <p>{stats.totalHours}시간</p>
            </div>
            <div className="stat-card">
              <h3>연속 학습</h3>
              <p>{stats.currentStreak}일 🔥</p>
            </div>
            <div className="stat-card">
              <h3>총 포인트</h3>
              <p>{stats.totalPoints}점</p>
            </div>
          </div>
        </div>
      )}

      {view === 'courses' && (
        <div className="courses">
          <h2>수강 중인 강의</h2>

          {/* 진행 중인 강의만 필터링 */}
          <div>
            <h3>진행 중 📚</h3>
            {courses
              .filter(course => course.status === 'in-progress')
              .map(course => (
                <div key={course.id} className="course-item">
                  <h4>{course.title}</h4>
                  <div className="progress-bar">
                    <div
                      style={{
                        width: `${course.progress}%`,
                        backgroundColor: '#4CAF50',
                        height: '20px'
                      }}
                    />
                  </div>
                  <p>{course.progress}% 완료</p>
                </div>
              ))}
          </div>

          {/* 완료된 강의 */}
          <div>
            <h3>완료 ✅</h3>
            {courses
              .filter(course => course.status === 'completed')
              .map(course => (
                <div key={course.id} className="course-item completed">
                  <h4>{course.title}</h4>
                  <p>완료됨</p>
                </div>
              ))}
          </div>

          {/* 시작 전 강의 */}
          <div>
            <h3>예정 📅</h3>
            {courses
              .filter(course => course.status === 'not-started')
              .map(course => (
                <div key={course.id} className="course-item">
                  <h4>{course.title}</h4>
                  <button>시작하기</button>
                </div>
              ))}
          </div>
        </div>
      )}

      {view === 'achievements' && (
        <div className="achievements">
          <h2>업적</h2>
          <div className="achievement-grid">
            {achievements.map(achievement => (
              <div
                key={achievement.id}
                className="achievement-card"
                style={{
                  opacity: achievement.unlocked ? 1 : 0.5,
                  backgroundColor: achievement.unlocked ? '#fff3cd' : '#f8f9fa'
                }}
              >
                <div className="icon">{achievement.icon}</div>
                <h4>{achievement.title}</h4>
                {achievement.unlocked ? (
                  <p>✅ 달성</p>
                ) : (
                  <p>🔒 잠김</p>
                )}
              </div>
            ))}
          </div>

          <p>
            달성한 업적: {achievements.filter(a => a.unlocked).length} / {achievements.length}
          </p>
        </div>
      )}
    </div>
  );
}

export default Dashboard;
```

## 핵심 요약

- 조건부 렌더링은 if, 삼항 연산자, && 연산자 등을 사용합니다
- 삼항 연산자는 두 가지 경우를 처리할 때 유용합니다
- && 연산자는 조건이 참일 때만 렌더링할 때 사용합니다
- 리스트 렌더링은 `map()` 함수를 사용합니다
- 각 항목에는 고유한 `key` prop이 필요합니다
- `filter()`로 조건에 맞는 항목만 표시할 수 있습니다
- `sort()`로 리스트를 정렬할 수 있습니다

다음 장에서는 useEffect와 컴포넌트 생명주기에 대해 배웁니다! 🚀

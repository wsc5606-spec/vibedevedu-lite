# 실전 프로젝트와 모범 사례

## React 프로젝트 구조

효율적인 프로젝트 구조는 유지보수와 확장성을 높입니다.

### 추천 폴더 구조

```
src/
├── assets/              # 이미지, 폰트 등 정적 파일
│   ├── images/
│   └── styles/
├── components/          # 재사용 가능한 컴포넌트
│   ├── common/          # 공통 컴포넌트 (Button, Input 등)
│   ├── layout/          # 레이아웃 컴포넌트 (Header, Footer 등)
│   └── features/        # 기능별 컴포넌트
├── contexts/            # Context API
│   ├── AuthContext.js
│   └── ThemeContext.js
├── hooks/               # Custom Hooks
│   ├── useAuth.js
│   └── useFetch.js
├── pages/               # 페이지 컴포넌트
│   ├── Home.js
│   └── Dashboard.js
├── services/            # API 호출 함수
│   └── api.js
├── utils/               # 유틸리티 함수
│   └── helpers.js
├── App.js
└── index.js
```

## Custom Hooks 만들기

Custom Hook은 로직을 재사용하기 위한 강력한 도구입니다.

### useFetch Hook

```javascript
// src/hooks/useFetch.js
import { useState, useEffect } from 'react';

function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);

      try {
        const response = await fetch(url);

        if (!response.ok) {
          throw new Error('네트워크 응답이 올바르지 않습니다.');
        }

        const result = await response.json();
        setData(result);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
}

export default useFetch;

// 사용 예시
function BadebuPosts() {
  const { data, loading, error } = useFetch('https://api.example.com/posts');

  if (loading) return <p>로딩 중...</p>;
  if (error) return <p>에러: {error}</p>;

  return (
    <div>
      <h2>바데부의 포스트</h2>
      {data?.map(post => (
        <div key={post.id}>{post.title}</div>
      ))}
    </div>
  );
}
```

### useLocalStorage Hook

```javascript
// src/hooks/useLocalStorage.js
import { useState, useEffect } from 'react';

function useLocalStorage(key, initialValue) {
  // 로컬 스토리지에서 초기값 가져오기
  const [value, setValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.log(error);
      return initialValue;
    }
  });

  // 값이 변경될 때마다 로컬 스토리지 업데이트
  useEffect(() => {
    try {
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.log(error);
    }
  }, [key, value]);

  return [value, setValue];
}

export default useLocalStorage;

// 사용 예시
function BadebuSettings() {
  const [theme, setTheme] = useLocalStorage('theme', 'light');
  const [language, setLanguage] = useLocalStorage('language', 'ko');

  return (
    <div>
      <h2>바데부의 설정</h2>
      <select value={theme} onChange={(e) => setTheme(e.target.value)}>
        <option value="light">라이트</option>
        <option value="dark">다크</option>
      </select>

      <select value={language} onChange={(e) => setLanguage(e.target.value)}>
        <option value="ko">한국어</option>
        <option value="en">English</option>
      </select>
    </div>
  );
}
```

### useDebounce Hook

```javascript
// src/hooks/useDebounce.js
import { useState, useEffect } from 'react';

function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);

  return debouncedValue;
}

export default useDebounce;

// 사용 예시
function SearchComponent() {
  const [searchTerm, setSearchTerm] = useState('');
  const debouncedSearchTerm = useDebounce(searchTerm, 500);

  useEffect(() => {
    if (debouncedSearchTerm) {
      console.log('검색 실행:', debouncedSearchTerm);
      // API 호출
    }
  }, [debouncedSearchTerm]);

  return (
    <input
      type="text"
      value={searchTerm}
      onChange={(e) => setSearchTerm(e.target.value)}
      placeholder="바데부가 검색..."
    />
  );
}
```

## 성능 최적화

### React.memo로 불필요한 재렌더링 방지

```javascript
import { memo } from 'react';

// 일반 컴포넌트 (부모가 렌더링되면 항상 재렌더링)
function NormalCard({ title, content }) {
  console.log('렌더링:', title);
  return (
    <div>
      <h3>{title}</h3>
      <p>{content}</p>
    </div>
  );
}

// memo로 최적화 (props가 변경될 때만 재렌더링)
const OptimizedCard = memo(function Card({ title, content }) {
  console.log('렌더링:', title);
  return (
    <div>
      <h3>{title}</h3>
      <p>{content}</p>
    </div>
  );
});

function BadebuDashboard() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <button onClick={() => setCount(count + 1)}>카운트: {count}</button>

      {/* count가 변경되어도 재렌더링 안 됨 */}
      <OptimizedCard
        title="바데부의 카드"
        content="이 카드는 props가 변경될 때만 렌더링됩니다."
      />
    </div>
  );
}
```

### useMemo로 계산 최적화

```javascript
import { useState, useMemo } from 'react';

function ExpensiveComponent() {
  const [count, setCount] = useState(0);
  const [items, setItems] = useState([]);

  // 매우 무거운 계산
  const expensiveCalculation = (num) => {
    console.log('무거운 계산 실행...');
    let result = 0;
    for (let i = 0; i < 1000000000; i++) {
      result += num;
    }
    return result;
  };

  // ❌ count가 변경될 때마다 계산 실행
  const result1 = expensiveCalculation(count);

  // ✅ count가 변경될 때만 계산 실행
  const result2 = useMemo(() => expensiveCalculation(count), [count]);

  return (
    <div>
      <h2>바데부의 계산기</h2>
      <p>결과: {result2}</p>
      <button onClick={() => setCount(count + 1)}>증가</button>
      <button onClick={() => setItems([...items, '새 항목'])}>
        항목 추가 (계산 재실행 안 됨)
      </button>
    </div>
  );
}
```

### useCallback으로 함수 최적화

```javascript
import { useState, useCallback, memo } from 'react';

const TodoItem = memo(({ todo, onDelete }) => {
  console.log('TodoItem 렌더링:', todo.text);
  return (
    <li>
      {todo.text}
      <button onClick={() => onDelete(todo.id)}>삭제</button>
    </li>
  );
});

function TodoList() {
  const [todos, setTodos] = useState([
    { id: 1, text: 'React 공부' },
    { id: 2, text: 'Props 복습' }
  ]);
  const [count, setCount] = useState(0);

  // ❌ 매 렌더링마다 새로운 함수 생성 (TodoItem이 모두 재렌더링)
  const handleDelete1 = (id) => {
    setTodos(todos.filter(todo => todo.id !== id));
  };

  // ✅ todos가 변경될 때만 함수 재생성
  const handleDelete2 = useCallback((id) => {
    setTodos(prev => prev.filter(todo => todo.id !== id));
  }, []);

  return (
    <div>
      <h2>바데부의 할 일 목록</h2>
      <button onClick={() => setCount(count + 1)}>카운트: {count}</button>

      <ul>
        {todos.map(todo => (
          <TodoItem
            key={todo.id}
            todo={todo}
            onDelete={handleDelete2}
          />
        ))}
      </ul>
    </div>
  );
}
```

## 에러 처리

### Error Boundary

```javascript
// src/components/ErrorBoundary.js
import { Component } from 'react';

class ErrorBoundary extends Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    console.log('에러 발생:', error, errorInfo);
    // 에러 로깅 서비스에 전송
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ padding: '20px', textAlign: 'center' }}>
          <h1>앗! 문제가 발생했습니다 😢</h1>
          <p>바데부님, 죄송합니다. 오류가 발생했습니다.</p>
          <button onClick={() => window.location.reload()}>
            페이지 새로고침
          </button>
        </div>
      );
    }

    return this.props.children;
  }
}

export default ErrorBoundary;

// 사용 예시
function App() {
  return (
    <ErrorBoundary>
      <BadebuApp />
    </ErrorBoundary>
  );
}
```

## 코드 분할 (Code Splitting)

```javascript
import { lazy, Suspense } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

// 코드 분할: 필요할 때만 로드
const Home = lazy(() => import('./pages/Home'));
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Profile = lazy(() => import('./pages/Profile'));

function App() {
  return (
    <BrowserRouter>
      <Suspense fallback={
        <div style={{ textAlign: 'center', padding: '50px' }}>
          <h2>로딩 중...</h2>
          <p>바데부의 페이지를 불러오고 있습니다 ⏳</p>
        </div>
      }>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/profile" element={<Profile />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
```

## 환경 변수 사용하기

```javascript
// .env 파일
REACT_APP_API_URL=https://api.example.com
REACT_APP_API_KEY=your-api-key-here

// src/services/api.js
const API_URL = process.env.REACT_APP_API_URL;
const API_KEY = process.env.REACT_APP_API_KEY;

export const fetchData = async (endpoint) => {
  const response = await fetch(`${API_URL}${endpoint}`, {
    headers: {
      'Authorization': `Bearer ${API_KEY}`
    }
  });

  return response.json();
};

// 사용 예시
function BadebuData() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetchData('/users').then(setData);
  }, []);

  return <div>{/* 데이터 표시 */}</div>;
}
```

## 실전 프로젝트: 학습 관리 앱

### 프로젝트 구조

```
src/
├── components/
│   ├── CourseCard.js
│   ├── ProgressBar.js
│   └── StudyTimer.js
├── contexts/
│   ├── AuthContext.js
│   └── LearningContext.js
├── hooks/
│   ├── useLocalStorage.js
│   └── useTimer.js
├── pages/
│   ├── Dashboard.js
│   ├── Courses.js
│   └── Progress.js
└── App.js
```

### LearningContext

```javascript
// src/contexts/LearningContext.js
import { createContext, useContext, useState } from 'react';
import useLocalStorage from '../hooks/useLocalStorage';

const LearningContext = createContext();

export function LearningProvider({ children }) {
  const [courses, setCourses] = useLocalStorage('badebu-courses', [
    { id: 1, title: 'React 기초', progress: 30, totalLessons: 10, completedLessons: 3 },
    { id: 2, title: 'JavaScript ES6', progress: 60, totalLessons: 15, completedLessons: 9 },
    { id: 3, title: 'CSS Grid', progress: 0, totalLessons: 8, completedLessons: 0 }
  ]);

  const [studyTime, setStudyTime] = useLocalStorage('badebu-study-time', 0);
  const [streak, setStreak] = useLocalStorage('badebu-streak', 7);

  const completeLesson = (courseId) => {
    setCourses(prev => prev.map(course => {
      if (course.id === courseId && course.completedLessons < course.totalLessons) {
        const newCompleted = course.completedLessons + 1;
        const newProgress = Math.round((newCompleted / course.totalLessons) * 100);

        return {
          ...course,
          completedLessons: newCompleted,
          progress: newProgress
        };
      }
      return course;
    }));
  };

  const addStudyTime = (minutes) => {
    setStudyTime(prev => prev + minutes);
  };

  const value = {
    courses,
    studyTime,
    streak,
    completeLesson,
    addStudyTime
  };

  return (
    <LearningContext.Provider value={value}>
      {children}
    </LearningContext.Provider>
  );
}

export function useLearning() {
  const context = useContext(LearningContext);
  if (!context) {
    throw new Error('useLearning must be used within LearningProvider');
  }
  return context;
}
```

### 대시보드 페이지

```javascript
// src/pages/Dashboard.js
import { useLearning } from '../contexts/LearningContext';
import CourseCard from '../components/CourseCard';

function Dashboard() {
  const { courses, studyTime, streak } = useLearning();

  const totalProgress = Math.round(
    courses.reduce((sum, course) => sum + course.progress, 0) / courses.length
  );

  return (
    <div style={{ padding: '20px' }}>
      <h1>바데부의 학습 대시보드</h1>

      {/* 통계 카드 */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '20px',
        marginBottom: '30px'
      }}>
        <StatCard
          icon="📚"
          label="수강 중인 강의"
          value={courses.length}
        />
        <StatCard
          icon="⏱️"
          label="총 학습 시간"
          value={`${studyTime}분`}
        />
        <StatCard
          icon="🔥"
          label="연속 학습"
          value={`${streak}일`}
        />
        <StatCard
          icon="📊"
          label="전체 진행률"
          value={`${totalProgress}%`}
        />
      </div>

      {/* 강의 목록 */}
      <h2>내 강의</h2>
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
        gap: '20px'
      }}>
        {courses.map(course => (
          <CourseCard key={course.id} course={course} />
        ))}
      </div>
    </div>
  );
}

function StatCard({ icon, label, value }) {
  return (
    <div style={{
      padding: '20px',
      backgroundColor: '#f8f9fa',
      borderRadius: '10px',
      textAlign: 'center'
    }}>
      <div style={{ fontSize: '40px', marginBottom: '10px' }}>{icon}</div>
      <div style={{ fontSize: '14px', color: '#666', marginBottom: '5px' }}>
        {label}
      </div>
      <div style={{ fontSize: '24px', fontWeight: 'bold' }}>{value}</div>
    </div>
  );
}

export default Dashboard;
```

### 강의 카드 컴포넌트

```javascript
// src/components/CourseCard.js
import { useLearning } from '../contexts/LearningContext';

function CourseCard({ course }) {
  const { completeLesson } = useLearning();

  return (
    <div style={{
      border: '1px solid #ddd',
      borderRadius: '10px',
      padding: '20px',
      backgroundColor: 'white'
    }}>
      <h3>{course.title}</h3>

      <div style={{ margin: '15px 0' }}>
        <div style={{
          display: 'flex',
          justifyContent: 'space-between',
          marginBottom: '5px',
          fontSize: '14px',
          color: '#666'
        }}>
          <span>진행률</span>
          <span>{course.progress}%</span>
        </div>

        <div style={{
          width: '100%',
          height: '10px',
          backgroundColor: '#e0e0e0',
          borderRadius: '5px',
          overflow: 'hidden'
        }}>
          <div style={{
            width: `${course.progress}%`,
            height: '100%',
            backgroundColor: '#4CAF50',
            transition: 'width 0.3s ease'
          }} />
        </div>
      </div>

      <p style={{ fontSize: '14px', color: '#666' }}>
        {course.completedLessons} / {course.totalLessons} 강의 완료
      </p>

      <button
        onClick={() => completeLesson(course.id)}
        disabled={course.completedLessons >= course.totalLessons}
        style={{
          width: '100%',
          padding: '10px',
          backgroundColor: course.progress === 100 ? '#6c757d' : '#007bff',
          color: 'white',
          border: 'none',
          borderRadius: '5px',
          cursor: course.progress === 100 ? 'not-allowed' : 'pointer',
          marginTop: '10px'
        }}
      >
        {course.progress === 100 ? '완료됨 ✅' : '다음 강의 수강'}
      </button>
    </div>
  );
}

export default CourseCard;
```

## 모범 사례 체크리스트

### ✅ 코드 품질

- [ ] 컴포넌트는 단일 책임 원칙을 따른다
- [ ] 재사용 가능한 컴포넌트를 만든다
- [ ] Custom Hook으로 로직을 분리한다
- [ ] 의미 있는 변수/함수 이름을 사용한다
- [ ] 주석은 "왜"에 집중한다 ("무엇"이 아니라)

### ✅ 성능

- [ ] 불필요한 재렌더링을 방지한다 (memo, useMemo, useCallback)
- [ ] 큰 리스트는 가상화를 고려한다
- [ ] 이미지를 최적화한다
- [ ] 코드 분할을 적용한다
- [ ] 번들 크기를 모니터링한다

### ✅ 상태 관리

- [ ] 로컬 상태와 전역 상태를 구분한다
- [ ] 상태를 최소화한다
- [ ] 파생 상태는 계산으로 처리한다
- [ ] 상태 업데이트는 불변성을 유지한다

### ✅ 보안

- [ ] 사용자 입력을 검증한다
- [ ] XSS 공격을 방지한다
- [ ] API 키는 환경 변수로 관리한다
- [ ] HTTPS를 사용한다

## 핵심 요약

- 체계적인 폴더 구조로 프로젝트를 관리합니다
- Custom Hook으로 로직을 재사용합니다
- memo, useMemo, useCallback으로 성능을 최적화합니다
- Error Boundary로 에러를 우아하게 처리합니다
- Code Splitting으로 초기 로딩 속도를 개선합니다
- 환경 변수로 설정을 관리합니다
- 단일 책임 원칙을 따르고 재사용 가능한 컴포넌트를 만듭니다

축하합니다, 바데부님! React 기초를 모두 마스터했습니다! 🎉

이제 실전 프로젝트를 만들며 계속 학습해나가세요. React는 계속 발전하고 있으니, 공식 문서와 커뮤니티를 통해 최신 정보를 접하는 것이 중요합니다.

화이팅! 💪

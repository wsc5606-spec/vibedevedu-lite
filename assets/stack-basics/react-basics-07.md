# useEffect와 생명주기

## useEffect란 무엇인가?

`useEffect`는 React Hook으로, 컴포넌트에서 side effect(부수 효과)를 수행할 수 있게 해줍니다. Side effect에는 데이터 가져오기, 구독 설정, DOM 수동 조작, 타이머 설정 등이 포함됩니다.

### Side Effect의 예시

```javascript
// ❌ 컴포넌트 본문에서 직접 side effect 수행 (잘못된 방법)
function BadExample() {
  const [count, setCount] = useState(0);

  // 렌더링마다 실행되어 무한 루프 발생!
  document.title = `바데부의 카운트: ${count}`;

  return <button onClick={() => setCount(count + 1)}>클릭</button>;
}

// ✅ useEffect로 side effect 수행 (올바른 방법)
import { useState, useEffect } from 'react';

function GoodExample() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    document.title = `바데부의 카운트: ${count}`;
  }, [count]);  // count가 변경될 때만 실행

  return <button onClick={() => setCount(count + 1)}>클릭</button>;
}
```

## useEffect 기본 사용법

### 1. 마운트 시 한 번만 실행

```javascript
import { useState, useEffect } from 'react';

function WelcomeMessage() {
  useEffect(() => {
    console.log('바데부님, 환영합니다!');
    alert('컴포넌트가 마운트되었습니다!');
  }, []);  // 빈 배열: 마운트 시 한 번만 실행

  return <h1>환영합니다!</h1>;
}
```

### 2. 특정 값이 변경될 때 실행

```javascript
import { useState, useEffect } from 'react';

function SearchComponent() {
  const [searchTerm, setSearchTerm] = useState('');
  const [results, setResults] = useState([]);

  useEffect(() => {
    console.log(`바데부가 검색: ${searchTerm}`);

    // 실제로는 API 호출
    if (searchTerm) {
      const mockResults = [
        `${searchTerm} 결과 1`,
        `${searchTerm} 결과 2`,
        `${searchTerm} 결과 3`
      ];
      setResults(mockResults);
    } else {
      setResults([]);
    }
  }, [searchTerm]);  // searchTerm이 변경될 때마다 실행

  return (
    <div>
      <input
        type="text"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        placeholder="검색어를 입력하세요"
      />
      <ul>
        {results.map((result, index) => (
          <li key={index}>{result}</li>
        ))}
      </ul>
    </div>
  );
}
```

### 3. 모든 렌더링 후 실행

```javascript
import { useState, useEffect } from 'react';

function RenderCounter() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log('컴포넌트가 렌더링되었습니다!');
  });  // 의존성 배열 없음: 매 렌더링마다 실행

  return (
    <div>
      <p>카운트: {count}</p>
      <button onClick={() => setCount(count + 1)}>증가</button>
    </div>
  );
}
```

## Cleanup 함수

useEffect는 cleanup 함수를 반환할 수 있습니다. 이 함수는 컴포넌트가 언마운트되거나 effect가 다시 실행되기 전에 실행됩니다.

### 타이머 정리

```javascript
import { useState, useEffect } from 'react';

function Timer() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    console.log('바데부의 타이머 시작!');

    const interval = setInterval(() => {
      setSeconds(prev => prev + 1);
    }, 1000);

    // Cleanup 함수: 컴포넌트 언마운트 시 실행
    return () => {
      console.log('타이머 정리');
      clearInterval(interval);
    };
  }, []);

  return (
    <div>
      <h2>바데부의 타이머</h2>
      <p>{seconds}초 경과</p>
    </div>
  );
}
```

### 이벤트 리스너 정리

```javascript
import { useState, useEffect } from 'react';

function WindowSize() {
  const [windowSize, setWindowSize] = useState({
    width: window.innerWidth,
    height: window.innerHeight
  });

  useEffect(() => {
    const handleResize = () => {
      setWindowSize({
        width: window.innerWidth,
        height: window.innerHeight
      });
    };

    window.addEventListener('resize', handleResize);

    // Cleanup: 이벤트 리스너 제거
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []);

  return (
    <div>
      <h2>바데부의 창 크기</h2>
      <p>너비: {windowSize.width}px</p>
      <p>높이: {windowSize.height}px</p>
    </div>
  );
}
```

## 데이터 가져오기 (Data Fetching)

```javascript
import { useState, useEffect } from 'react';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    // 로딩 시작
    setLoading(true);
    setError(null);

    // API 호출 시뮬레이션
    const fetchUser = async () => {
      try {
        // 실제로는 fetch() 또는 axios 사용
        await new Promise(resolve => setTimeout(resolve, 1000));

        const userData = {
          id: userId,
          name: userId === 1 ? '바데부' : '사용자',
          level: '중급',
          points: 1500
        };

        setUser(userData);
      } catch (err) {
        setError('사용자 정보를 불러오는데 실패했습니다.');
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]);  // userId가 변경될 때마다 다시 가져오기

  if (loading) return <p>로딩 중...</p>;
  if (error) return <p>{error}</p>;
  if (!user) return <p>사용자를 찾을 수 없습니다.</p>;

  return (
    <div>
      <h2>{user.name}의 프로필</h2>
      <p>레벨: {user.level}</p>
      <p>포인트: {user.points}</p>
    </div>
  );
}
```

## 여러 개의 useEffect 사용하기

관심사를 분리하기 위해 여러 개의 useEffect를 사용할 수 있습니다.

```javascript
import { useState, useEffect } from 'react';

function Dashboard() {
  const [user, setUser] = useState(null);
  const [notifications, setNotifications] = useState([]);
  const [onlineUsers, setOnlineUsers] = useState(0);

  // 사용자 정보 가져오기
  useEffect(() => {
    console.log('사용자 정보 로딩');

    const loadUser = async () => {
      const userData = { name: '바데부', level: 5 };
      setUser(userData);
    };

    loadUser();
  }, []);

  // 알림 가져오기
  useEffect(() => {
    console.log('알림 로딩');

    const loadNotifications = async () => {
      const notifs = ['새 강의 업데이트', '댓글이 달렸습니다'];
      setNotifications(notifs);
    };

    loadNotifications();
  }, []);

  // 온라인 사용자 수 실시간 업데이트
  useEffect(() => {
    console.log('온라인 사용자 구독 시작');

    const interval = setInterval(() => {
      setOnlineUsers(Math.floor(Math.random() * 100));
    }, 5000);

    return () => {
      console.log('온라인 사용자 구독 정리');
      clearInterval(interval);
    };
  }, []);

  return (
    <div>
      <h1>바데부 대시보드</h1>
      {user && <p>환영합니다, {user.name}님!</p>}
      <p>알림: {notifications.length}개</p>
      <p>현재 온라인: {onlineUsers}명</p>
    </div>
  );
}
```

## 의존성 배열 이해하기

```javascript
import { useState, useEffect } from 'react';

function DependencyExample() {
  const [count, setCount] = useState(0);
  const [name, setName] = useState('바데부');

  // 1. 의존성 배열 없음 - 매 렌더링마다 실행
  useEffect(() => {
    console.log('매번 실행됨');
  });

  // 2. 빈 의존성 배열 - 마운트 시 한 번만
  useEffect(() => {
    console.log('마운트 시 한 번만 실행됨');
  }, []);

  // 3. count만 의존 - count 변경 시에만 실행
  useEffect(() => {
    console.log(`count가 ${count}로 변경됨`);
  }, [count]);

  // 4. name만 의존 - name 변경 시에만 실행
  useEffect(() => {
    console.log(`name이 ${name}로 변경됨`);
  }, [name]);

  // 5. 여러 의존성 - count나 name 변경 시 실행
  useEffect(() => {
    console.log(`count: ${count}, name: ${name}`);
  }, [count, name]);

  return (
    <div>
      <p>카운트: {count}</p>
      <button onClick={() => setCount(count + 1)}>증가</button>

      <p>이름: {name}</p>
      <button onClick={() => setName(name + '!')}>이름 변경</button>
    </div>
  );
}
```

## 실전 예제: 실시간 검색

```javascript
import { useState, useEffect } from 'react';

function LiveSearch() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [isSearching, setIsSearching] = useState(false);

  // 가상의 데이터베이스
  const database = [
    'React 기초',
    'React Hooks',
    'React Router',
    'JavaScript ES6',
    'TypeScript 입문',
    'Node.js 백엔드',
    'MongoDB 기초',
    'Express.js 튜토리얼'
  ];

  useEffect(() => {
    // 검색어가 비어있으면 결과 초기화
    if (!query.trim()) {
      setResults([]);
      return;
    }

    // 디바운싱: 사용자가 타이핑을 멈춘 후 500ms 후에 검색
    setIsSearching(true);

    const timeoutId = setTimeout(() => {
      const searchResults = database.filter(item =>
        item.toLowerCase().includes(query.toLowerCase())
      );

      setResults(searchResults);
      setIsSearching(false);
    }, 500);

    // Cleanup: 이전 타이머 취소
    return () => clearTimeout(timeoutId);
  }, [query]);

  return (
    <div>
      <h2>바데부의 강의 검색</h2>
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="강의를 검색하세요..."
      />

      {isSearching && <p>검색 중...</p>}

      <ul>
        {results.map((result, index) => (
          <li key={index}>{result}</li>
        ))}
      </ul>

      {query && !isSearching && results.length === 0 && (
        <p>"{query}"에 대한 검색 결과가 없습니다.</p>
      )}
    </div>
  );
}
```

## 실전 예제: 자동 저장 기능

```javascript
import { useState, useEffect } from 'react';

function AutoSaveEditor() {
  const [content, setContent] = useState('');
  const [lastSaved, setLastSaved] = useState(null);
  const [isSaving, setIsSaving] = useState(false);

  // 로컬 스토리지에서 불러오기 (마운트 시)
  useEffect(() => {
    const saved = localStorage.getItem('badebu-draft');
    if (saved) {
      setContent(saved);
      setLastSaved(new Date());
    }
  }, []);

  // 자동 저장 (content 변경 시)
  useEffect(() => {
    if (!content) return;

    const timeoutId = setTimeout(() => {
      setIsSaving(true);

      // 저장 시뮬레이션
      setTimeout(() => {
        localStorage.setItem('badebu-draft', content);
        setLastSaved(new Date());
        setIsSaving(false);
      }, 500);
    }, 2000);  // 2초 후 저장

    return () => clearTimeout(timeoutId);
  }, [content]);

  const formatTime = (date) => {
    if (!date) return '없음';
    return date.toLocaleTimeString('ko-KR');
  };

  return (
    <div>
      <h2>바데부의 노트</h2>
      <p>
        {isSaving ? '저장 중...' : `마지막 저장: ${formatTime(lastSaved)}`}
      </p>

      <textarea
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="여기에 메모를 작성하세요..."
        rows="10"
        style={{ width: '100%' }}
      />
    </div>
  );
}
```

## 실전 예제: 온라인/오프라인 감지

```javascript
import { useState, useEffect } from 'react';

function OnlineStatus() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);

  useEffect(() => {
    const handleOnline = () => {
      setIsOnline(true);
      console.log('바데부님, 다시 온라인 상태입니다! ✅');
    };

    const handleOffline = () => {
      setIsOnline(false);
      console.log('바데부님, 오프라인 상태입니다. ❌');
    };

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    // Cleanup
    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  return (
    <div>
      <h2>연결 상태</h2>
      <div style={{
        padding: '20px',
        backgroundColor: isOnline ? '#d4edda' : '#f8d7da',
        color: isOnline ? '#155724' : '#721c24',
        borderRadius: '5px'
      }}>
        {isOnline ? (
          <p>✅ 온라인 - 모든 기능을 사용할 수 있습니다.</p>
        ) : (
          <p>❌ 오프라인 - 인터넷 연결을 확인해주세요.</p>
        )}
      </div>
    </div>
  );
}
```

## useEffect 사용 시 주의사항

### 1. 무한 루프 방지

```javascript
// ❌ 무한 루프 발생
function BadExample() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    setCount(count + 1);  // count 변경
  }, [count]);  // count 변경으로 다시 실행 → 무한 루프!

  return <p>{count}</p>;
}

// ✅ 올바른 방법
function GoodExample() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    const timer = setTimeout(() => {
      setCount(prev => prev + 1);
    }, 1000);

    return () => clearTimeout(timer);
  }, []);  // 빈 배열: 한 번만 실행

  return <p>{count}</p>;
}
```

### 2. 비동기 함수 사용

```javascript
// ❌ 잘못된 방법
function BadAsync() {
  useEffect(async () => {
    const data = await fetchData();
    setData(data);
  }, []);  // useEffect는 async 함수를 반환할 수 없음!
}

// ✅ 올바른 방법
function GoodAsync() {
  useEffect(() => {
    const loadData = async () => {
      const data = await fetchData();
      setData(data);
    };

    loadData();
  }, []);
}
```

### 3. 의존성 배열 누락

```javascript
// ⚠️ ESLint 경고 발생
function WarningExample({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetchUser(userId).then(setUser);
  }, []);  // userId를 의존성에 추가해야 함!
}

// ✅ 올바른 방법
function CorrectExample({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetchUser(userId).then(setUser);
  }, [userId]);  // userId 추가
}
```

## 핵심 요약

- useEffect는 컴포넌트에서 side effect를 수행하는 Hook입니다
- 빈 배열 `[]`을 전달하면 마운트 시 한 번만 실행됩니다
- 의존성 배열에 값을 넣으면 그 값이 변경될 때마다 실행됩니다
- cleanup 함수를 반환하여 리소스를 정리할 수 있습니다
- 타이머, 이벤트 리스너, 구독 등은 반드시 cleanup 해야 합니다
- 데이터 가져오기, DOM 조작, 로깅 등에 useEffect를 사용합니다
- 무한 루프를 방지하기 위해 의존성 배열을 올바르게 설정해야 합니다

다음 장에서는 React Router를 사용한 라우팅에 대해 배웁니다! 🚀

# React Router

## React Router란?

React Router는 React 애플리케이션에서 라우팅을 구현하는 가장 인기 있는 라이브러리입니다. 페이지 새로고침 없이 URL을 변경하고 다른 컴포넌트를 표시할 수 있습니다(SPA - Single Page Application).

### 설치하기

```bash
npm install react-router-dom
```

## 기본 라우팅 설정

### 프로젝트 구조

```
src/
├── App.js
├── pages/
│   ├── Home.js
│   ├── About.js
│   └── Contact.js
└── components/
    └── Navbar.js
```

### 기본 라우터 설정

```javascript
// src/App.js
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import About from './pages/About';
import Contact from './pages/Contact';
import Navbar from './components/Navbar';

function App() {
  return (
    <BrowserRouter>
      <div className="App">
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;
```

### 페이지 컴포넌트 만들기

```javascript
// src/pages/Home.js
function Home() {
  return (
    <div>
      <h1>홈 페이지</h1>
      <p>바데부의 React 학습 사이트에 오신 것을 환영합니다!</p>
    </div>
  );
}

export default Home;

// src/pages/About.js
function About() {
  return (
    <div>
      <h1>소개</h1>
      <p>안녕하세요! 저는 바데부입니다.</p>
      <p>React를 학습하고 있습니다.</p>
    </div>
  );
}

export default About;

// src/pages/Contact.js
function Contact() {
  return (
    <div>
      <h1>연락처</h1>
      <p>이메일: badebu@example.com</p>
    </div>
  );
}

export default Contact;
```

## Link와 NavLink

페이지 이동을 위해 `<a>` 태그 대신 `<Link>`나 `<NavLink>`를 사용합니다.

### Link 사용하기

```javascript
// src/components/Navbar.js
import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <nav style={{ padding: '20px', backgroundColor: '#f0f0f0' }}>
      <Link to="/" style={{ margin: '0 10px' }}>홈</Link>
      <Link to="/about" style={{ margin: '0 10px' }}>소개</Link>
      <Link to="/contact" style={{ margin: '0 10px' }}>연락처</Link>
    </nav>
  );
}

export default Navbar;
```

### NavLink 사용하기 (활성 링크 스타일링)

```javascript
import { NavLink } from 'react-router-dom';

function Navbar() {
  const navLinkStyle = ({ isActive }) => ({
    margin: '0 10px',
    padding: '5px 10px',
    textDecoration: 'none',
    color: isActive ? 'white' : 'black',
    backgroundColor: isActive ? '#007bff' : 'transparent',
    borderRadius: '5px'
  });

  return (
    <nav style={{ padding: '20px', backgroundColor: '#f0f0f0' }}>
      <NavLink to="/" style={navLinkStyle}>홈</NavLink>
      <NavLink to="/about" style={navLinkStyle}>소개</NavLink>
      <NavLink to="/contact" style={navLinkStyle}>연락처</NavLink>
    </nav>
  );
}

export default Navbar;
```

## URL 파라미터 (Dynamic Routes)

URL에서 동적으로 값을 받아올 수 있습니다.

```javascript
// src/App.js
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import CourseDetail from './pages/CourseDetail';
import UserProfile from './pages/UserProfile';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/course/:courseId" element={<CourseDetail />} />
        <Route path="/user/:username" element={<UserProfile />} />
      </Routes>
    </BrowserRouter>
  );
}
```

### useParams로 파라미터 받기

```javascript
// src/pages/CourseDetail.js
import { useParams } from 'react-router-dom';

function CourseDetail() {
  const { courseId } = useParams();

  const courses = {
    'react-basics': {
      title: 'React 기초',
      instructor: '바데부',
      duration: '10시간',
      description: 'React의 기초를 배웁니다.'
    },
    'javascript-advanced': {
      title: 'JavaScript 심화',
      instructor: '바데부',
      duration: '15시간',
      description: 'JavaScript를 깊이 있게 학습합니다.'
    }
  };

  const course = courses[courseId];

  if (!course) {
    return <h2>강의를 찾을 수 없습니다.</h2>;
  }

  return (
    <div>
      <h1>{course.title}</h1>
      <p>강사: {course.instructor}</p>
      <p>시간: {course.duration}</p>
      <p>{course.description}</p>
    </div>
  );
}

export default CourseDetail;

// src/pages/UserProfile.js
import { useParams } from 'react-router-dom';

function UserProfile() {
  const { username } = useParams();

  return (
    <div>
      <h1>{username}의 프로필</h1>
      <p>사용자 이름: {username}</p>
    </div>
  );
}

export default UserProfile;
```

### 링크에서 파라미터 전달

```javascript
import { Link } from 'react-router-dom';

function CourseList() {
  const courses = [
    { id: 'react-basics', title: 'React 기초' },
    { id: 'javascript-advanced', title: 'JavaScript 심화' },
    { id: 'css-mastery', title: 'CSS 마스터' }
  ];

  return (
    <div>
      <h2>바데부의 강의 목록</h2>
      <ul>
        {courses.map(course => (
          <li key={course.id}>
            <Link to={`/course/${course.id}`}>{course.title}</Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## Query String (검색 파라미터)

URL의 쿼리 스트링을 읽고 사용할 수 있습니다.

```javascript
import { useSearchParams } from 'react-router-dom';

function SearchPage() {
  const [searchParams, setSearchParams] = useSearchParams();

  const query = searchParams.get('q') || '';
  const category = searchParams.get('category') || 'all';
  const sort = searchParams.get('sort') || 'newest';

  const handleSearch = (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const newQuery = formData.get('search');

    setSearchParams({ q: newQuery, category, sort });
  };

  return (
    <div>
      <h2>바데부의 검색</h2>

      <form onSubmit={handleSearch}>
        <input
          type="text"
          name="search"
          defaultValue={query}
          placeholder="검색어 입력"
        />
        <button type="submit">검색</button>
      </form>

      <div>
        <label>
          카테고리:
          <select
            value={category}
            onChange={(e) => setSearchParams({ q: query, category: e.target.value, sort })}
          >
            <option value="all">전체</option>
            <option value="react">React</option>
            <option value="javascript">JavaScript</option>
          </select>
        </label>

        <label>
          정렬:
          <select
            value={sort}
            onChange={(e) => setSearchParams({ q: query, category, sort: e.target.value })}
          >
            <option value="newest">최신순</option>
            <option value="popular">인기순</option>
          </select>
        </label>
      </div>

      <div>
        <h3>검색 결과</h3>
        <p>검색어: {query}</p>
        <p>카테고리: {category}</p>
        <p>정렬: {sort}</p>
      </div>
    </div>
  );
}

export default SearchPage;
```

## 프로그래밍 방식 네비게이션

버튼 클릭 등으로 페이지를 이동해야 할 때 `useNavigate`를 사용합니다.

```javascript
import { useNavigate } from 'react-router-dom';

function LoginForm() {
  const navigate = useNavigate();

  const handleLogin = (e) => {
    e.preventDefault();

    // 로그인 로직...
    const success = true;

    if (success) {
      alert('바데부님, 로그인 성공!');
      navigate('/dashboard');  // 대시보드로 이동
    }
  };

  const handleCancel = () => {
    navigate(-1);  // 이전 페이지로
  };

  return (
    <form onSubmit={handleLogin}>
      <h2>로그인</h2>
      <input type="text" placeholder="아이디" />
      <input type="password" placeholder="비밀번호" />
      <button type="submit">로그인</button>
      <button type="button" onClick={handleCancel}>취소</button>
    </form>
  );
}
```

## 중첩 라우트 (Nested Routes)

라우트 안에 라우트를 중첩할 수 있습니다.

```javascript
// src/App.js
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Dashboard from './pages/Dashboard';
import Profile from './pages/dashboard/Profile';
import Settings from './pages/dashboard/Settings';
import Stats from './pages/dashboard/Stats';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/dashboard" element={<Dashboard />}>
          <Route path="profile" element={<Profile />} />
          <Route path="settings" element={<Settings />} />
          <Route path="stats" element={<Stats />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
```

```javascript
// src/pages/Dashboard.js
import { Outlet, Link } from 'react-router-dom';

function Dashboard() {
  return (
    <div>
      <h1>바데부의 대시보드</h1>

      <nav>
        <Link to="/dashboard/profile">프로필</Link>
        <Link to="/dashboard/settings">설정</Link>
        <Link to="/dashboard/stats">통계</Link>
      </nav>

      {/* 중첩된 라우트가 여기에 렌더링됩니다 */}
      <Outlet />
    </div>
  );
}

export default Dashboard;
```

## 404 페이지 (Not Found)

존재하지 않는 경로에 대한 처리를 할 수 있습니다.

```javascript
function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}

function NotFound() {
  const navigate = useNavigate();

  return (
    <div style={{ textAlign: 'center', padding: '50px' }}>
      <h1>404</h1>
      <h2>페이지를 찾을 수 없습니다</h2>
      <p>바데부님, 요청하신 페이지가 존재하지 않습니다.</p>
      <button onClick={() => navigate('/')}>홈으로 돌아가기</button>
    </div>
  );
}
```

## Protected Routes (보호된 라우트)

로그인이 필요한 페이지를 보호할 수 있습니다.

```javascript
import { Navigate } from 'react-router-dom';

function ProtectedRoute({ children, isAuthenticated }) {
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return children;
}

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login setIsLoggedIn={setIsLoggedIn} />} />

        {/* 보호된 라우트 */}
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute isAuthenticated={isLoggedIn}>
              <Dashboard />
            </ProtectedRoute>
          }
        />

        <Route
          path="/profile"
          element={
            <ProtectedRoute isAuthenticated={isLoggedIn}>
              <Profile />
            </ProtectedRoute>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}
```

## 실전 예제: 블로그 애플리케이션

```javascript
// src/App.js
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { useState } from 'react';
import Navbar from './components/Navbar';
import Home from './pages/Home';
import BlogList from './pages/BlogList';
import BlogPost from './pages/BlogPost';
import CreatePost from './pages/CreatePost';
import NotFound from './pages/NotFound';

function App() {
  const [posts, setPosts] = useState([
    { id: 1, title: 'React 시작하기', author: '바데부', content: 'React는 재미있습니다!', date: '2024-01-15' },
    { id: 2, title: 'Props 완전 정복', author: '바데부', content: 'Props는 컴포넌트 간 데이터 전달 방법입니다.', date: '2024-01-16' },
    { id: 3, title: 'State 마스터하기', author: '바데부', content: 'State로 동적인 UI를 만들 수 있습니다.', date: '2024-01-17' }
  ]);

  return (
    <BrowserRouter>
      <div className="App">
        <Navbar />
        <div style={{ padding: '20px' }}>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/blog" element={<BlogList posts={posts} />} />
            <Route path="/blog/:postId" element={<BlogPost posts={posts} />} />
            <Route path="/create" element={<CreatePost posts={posts} setPosts={setPosts} />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </div>
      </div>
    </BrowserRouter>
  );
}

export default App;
```

```javascript
// src/pages/BlogList.js
import { Link } from 'react-router-dom';

function BlogList({ posts }) {
  return (
    <div>
      <h1>바데부의 블로그</h1>

      <div style={{ marginBottom: '20px' }}>
        <Link to="/create">
          <button>새 글 작성</button>
        </Link>
      </div>

      <div>
        {posts.map(post => (
          <div key={post.id} style={{
            border: '1px solid #ddd',
            padding: '15px',
            marginBottom: '10px',
            borderRadius: '5px'
          }}>
            <h2>
              <Link to={`/blog/${post.id}`}>{post.title}</Link>
            </h2>
            <p style={{ color: '#666' }}>
              작성자: {post.author} | 날짜: {post.date}
            </p>
            <p>{post.content.substring(0, 100)}...</p>
            <Link to={`/blog/${post.id}`}>더 읽기 →</Link>
          </div>
        ))}
      </div>
    </div>
  );
}

export default BlogList;
```

```javascript
// src/pages/BlogPost.js
import { useParams, useNavigate } from 'react-router-dom';

function BlogPost({ posts }) {
  const { postId } = useParams();
  const navigate = useNavigate();

  const post = posts.find(p => p.id === parseInt(postId));

  if (!post) {
    return (
      <div>
        <h2>포스트를 찾을 수 없습니다</h2>
        <button onClick={() => navigate('/blog')}>목록으로</button>
      </div>
    );
  }

  return (
    <div>
      <button onClick={() => navigate('/blog')}>← 목록으로</button>

      <article style={{ marginTop: '20px' }}>
        <h1>{post.title}</h1>
        <p style={{ color: '#666' }}>
          작성자: {post.author} | 날짜: {post.date}
        </p>
        <hr />
        <p>{post.content}</p>
      </article>

      <div style={{ marginTop: '30px' }}>
        <h3>댓글</h3>
        <p>바데부: 좋은 글이네요! 👍</p>
      </div>
    </div>
  );
}

export default BlogPost;
```

```javascript
// src/pages/CreatePost.js
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function CreatePost({ posts, setPosts }) {
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!title || !content) {
      alert('제목과 내용을 입력해주세요!');
      return;
    }

    const newPost = {
      id: posts.length + 1,
      title,
      content,
      author: '바데부',
      date: new Date().toISOString().split('T')[0]
    };

    setPosts([...posts, newPost]);
    alert('글이 작성되었습니다!');
    navigate('/blog');
  };

  return (
    <div>
      <h1>새 글 작성</h1>

      <form onSubmit={handleSubmit}>
        <div style={{ marginBottom: '10px' }}>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="제목을 입력하세요"
            style={{ width: '100%', padding: '10px' }}
          />
        </div>

        <div style={{ marginBottom: '10px' }}>
          <textarea
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="내용을 입력하세요"
            rows="10"
            style={{ width: '100%', padding: '10px' }}
          />
        </div>

        <button type="submit">작성</button>
        <button type="button" onClick={() => navigate('/blog')}>취소</button>
      </form>
    </div>
  );
}

export default CreatePost;
```

## 핵심 요약

- React Router는 SPA에서 라우팅을 구현하는 라이브러리입니다
- `<BrowserRouter>`로 앱을 감싸고 `<Routes>`와 `<Route>`로 경로를 정의합니다
- `<Link>`와 `<NavLink>`로 페이지 이동을 합니다
- `useParams()`로 URL 파라미터를 받아올 수 있습니다
- `useSearchParams()`로 쿼리 스트링을 다룰 수 있습니다
- `useNavigate()`로 프로그래밍 방식으로 페이지를 이동합니다
- `<Outlet>`으로 중첩 라우트를 구현합니다
- 와일드카드 `*`로 404 페이지를 만들 수 있습니다

다음 장에서는 Context API로 전역 상태 관리를 배웁니다! 🚀

# Context API와 전역 상태 관리

## Context API란?

Context API는 React에서 제공하는 전역 상태 관리 도구입니다. Props drilling(Props를 여러 단계 거쳐 전달하는 것) 없이 컴포넌트 트리 전체에 데이터를 공유할 수 있습니다.

### Props Drilling 문제

```javascript
// ❌ Props Drilling: 깊이 중첩된 컴포넌트에 데이터 전달
function App() {
  const user = { name: '바데부', level: '중급' };

  return <ParentComponent user={user} />;
}

function ParentComponent({ user }) {
  return <ChildComponent user={user} />;
}

function ChildComponent({ user }) {
  return <GrandchildComponent user={user} />;
}

function GrandchildComponent({ user }) {
  return <h1>{user.name}님 환영합니다!</h1>;
}
```

### Context로 해결

```javascript
import { createContext, useContext } from 'react';

// Context 생성
const UserContext = createContext();

// ✅ Context 사용: Props drilling 없이 데이터 전달
function App() {
  const user = { name: '바데부', level: '중급' };

  return (
    <UserContext.Provider value={user}>
      <ParentComponent />
    </UserContext.Provider>
  );
}

function ParentComponent() {
  return <ChildComponent />;
}

function ChildComponent() {
  return <GrandchildComponent />;
}

function GrandchildComponent() {
  const user = useContext(UserContext);
  return <h1>{user.name}님 환영합니다!</h1>;
}
```

## Context 생성과 사용

### 1. Context 생성하기

```javascript
// src/contexts/ThemeContext.js
import { createContext, useState, useContext } from 'react';

// Context 생성
const ThemeContext = createContext();

// Provider 컴포넌트
export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };

  const value = {
    theme,
    toggleTheme
  };

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
}

// Custom Hook
export function useTheme() {
  const context = useContext(ThemeContext);

  if (!context) {
    throw new Error('useTheme must be used within ThemeProvider');
  }

  return context;
}
```

### 2. Provider로 앱 감싸기

```javascript
// src/App.js
import { ThemeProvider } from './contexts/ThemeContext';
import Header from './components/Header';
import Content from './components/Content';

function App() {
  return (
    <ThemeProvider>
      <div className="App">
        <Header />
        <Content />
      </div>
    </ThemeProvider>
  );
}

export default App;
```

### 3. Context 사용하기

```javascript
// src/components/Header.js
import { useTheme } from '../contexts/ThemeContext';

function Header() {
  const { theme, toggleTheme } = useTheme();

  const headerStyle = {
    backgroundColor: theme === 'light' ? '#fff' : '#333',
    color: theme === 'light' ? '#000' : '#fff',
    padding: '20px'
  };

  return (
    <header style={headerStyle}>
      <h1>바데부의 앱</h1>
      <button onClick={toggleTheme}>
        {theme === 'light' ? '🌙 다크 모드' : '☀️ 라이트 모드'}
      </button>
    </header>
  );
}

export default Header;
```

## 사용자 인증 Context

실전에서 가장 많이 사용하는 패턴입니다.

```javascript
// src/contexts/AuthContext.js
import { createContext, useState, useContext } from 'react';

const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const login = (username, password) => {
    // 실제로는 API 호출
    if (username === 'badebu' && password === '1234') {
      const userData = {
        id: 1,
        username: 'badebu',
        name: '바데부',
        email: 'badebu@example.com',
        level: '중급'
      };

      setUser(userData);
      setIsAuthenticated(true);
      localStorage.setItem('user', JSON.stringify(userData));
      return true;
    }
    return false;
  };

  const logout = () => {
    setUser(null);
    setIsAuthenticated(false);
    localStorage.removeItem('user');
  };

  const signup = (username, email, password) => {
    // 실제로는 API 호출
    const newUser = {
      id: Date.now(),
      username,
      name: username,
      email,
      level: '초급'
    };

    setUser(newUser);
    setIsAuthenticated(true);
    localStorage.setItem('user', JSON.stringify(newUser));
    return true;
  };

  const value = {
    user,
    isAuthenticated,
    login,
    logout,
    signup
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);

  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }

  return context;
}
```

### 로그인 컴포넌트

```javascript
// src/pages/Login.js
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');

    const success = login(username, password);

    if (success) {
      alert('바데부님, 로그인 성공!');
      navigate('/dashboard');
    } else {
      setError('아이디 또는 비밀번호가 잘못되었습니다.');
    }
  };

  return (
    <div style={{ maxWidth: '400px', margin: '50px auto', padding: '20px' }}>
      <h2>로그인</h2>

      {error && (
        <div style={{ color: 'red', marginBottom: '10px' }}>
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit}>
        <div style={{ marginBottom: '10px' }}>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            placeholder="아이디"
            style={{ width: '100%', padding: '10px' }}
          />
        </div>

        <div style={{ marginBottom: '10px' }}>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="비밀번호"
            style={{ width: '100%', padding: '10px' }}
          />
        </div>

        <button type="submit" style={{ width: '100%', padding: '10px' }}>
          로그인
        </button>
      </form>

      <p style={{ marginTop: '10px', fontSize: '12px', color: '#666' }}>
        테스트 계정: badebu / 1234
      </p>
    </div>
  );
}

export default Login;
```

### 사용자 프로필 컴포넌트

```javascript
// src/pages/Profile.js
import { useAuth } from '../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';

function Profile() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    alert('로그아웃되었습니다.');
    navigate('/');
  };

  return (
    <div style={{ padding: '20px' }}>
      <h1>프로필</h1>

      <div style={{
        border: '1px solid #ddd',
        padding: '20px',
        borderRadius: '10px',
        maxWidth: '500px'
      }}>
        <p><strong>사용자 ID:</strong> {user.id}</p>
        <p><strong>아이디:</strong> {user.username}</p>
        <p><strong>이름:</strong> {user.name}</p>
        <p><strong>이메일:</strong> {user.email}</p>
        <p><strong>레벨:</strong> {user.level}</p>

        <button
          onClick={handleLogout}
          style={{
            marginTop: '20px',
            padding: '10px 20px',
            backgroundColor: '#dc3545',
            color: 'white',
            border: 'none',
            borderRadius: '5px',
            cursor: 'pointer'
          }}
        >
          로그아웃
        </button>
      </div>
    </div>
  );
}

export default Profile;
```

## 여러 Context 조합하기

```javascript
// src/App.js
import { AuthProvider } from './contexts/AuthContext';
import { ThemeProvider } from './contexts/ThemeContext';
import { CartProvider } from './contexts/CartProvider';

function App() {
  return (
    <AuthProvider>
      <ThemeProvider>
        <CartProvider>
          <AppContent />
        </CartProvider>
      </ThemeProvider>
    </AuthProvider>
  );
}
```

## 장바구니 Context 예제

```javascript
// src/contexts/CartContext.js
import { createContext, useState, useContext } from 'react';

const CartContext = createContext();

export function CartProvider({ children }) {
  const [cartItems, setCartItems] = useState([]);

  const addToCart = (product) => {
    setCartItems(prev => {
      const existingItem = prev.find(item => item.id === product.id);

      if (existingItem) {
        return prev.map(item =>
          item.id === product.id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      }

      return [...prev, { ...product, quantity: 1 }];
    });
  };

  const removeFromCart = (productId) => {
    setCartItems(prev => prev.filter(item => item.id !== productId));
  };

  const updateQuantity = (productId, quantity) => {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    setCartItems(prev =>
      prev.map(item =>
        item.id === productId ? { ...item, quantity } : item
      )
    );
  };

  const clearCart = () => {
    setCartItems([]);
  };

  const getTotalItems = () => {
    return cartItems.reduce((sum, item) => sum + item.quantity, 0);
  };

  const getTotalPrice = () => {
    return cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
  };

  const value = {
    cartItems,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,
    getTotalItems,
    getTotalPrice
  };

  return (
    <CartContext.Provider value={value}>
      {children}
    </CartContext.Provider>
  );
}

export function useCart() {
  const context = useContext(CartContext);

  if (!context) {
    throw new Error('useCart must be used within CartProvider');
  }

  return context;
}
```

### 상품 목록 컴포넌트

```javascript
// src/pages/Products.js
import { useCart } from '../contexts/CartContext';

function Products() {
  const { addToCart } = useCart();

  const products = [
    { id: 1, name: 'React 강의', price: 30000 },
    { id: 2, name: 'JavaScript 책', price: 25000 },
    { id: 3, name: 'CSS 튜토리얼', price: 20000 },
    { id: 4, name: 'Node.js 강의', price: 35000 }
  ];

  return (
    <div style={{ padding: '20px' }}>
      <h1>바데부의 상품 목록</h1>

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))',
        gap: '20px'
      }}>
        {products.map(product => (
          <div
            key={product.id}
            style={{
              border: '1px solid #ddd',
              padding: '15px',
              borderRadius: '5px'
            }}
          >
            <h3>{product.name}</h3>
            <p>{product.price.toLocaleString()}원</p>
            <button
              onClick={() => addToCart(product)}
              style={{
                width: '100%',
                padding: '10px',
                backgroundColor: '#007bff',
                color: 'white',
                border: 'none',
                borderRadius: '5px',
                cursor: 'pointer'
              }}
            >
              장바구니에 추가
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Products;
```

### 장바구니 컴포넌트

```javascript
// src/pages/Cart.js
import { useCart } from '../contexts/CartContext';

function Cart() {
  const {
    cartItems,
    removeFromCart,
    updateQuantity,
    clearCart,
    getTotalItems,
    getTotalPrice
  } = useCart();

  if (cartItems.length === 0) {
    return (
      <div style={{ padding: '20px', textAlign: 'center' }}>
        <h1>장바구니</h1>
        <p>장바구니가 비어있습니다.</p>
      </div>
    );
  }

  return (
    <div style={{ padding: '20px' }}>
      <h1>바데부의 장바구니</h1>

      <div>
        {cartItems.map(item => (
          <div
            key={item.id}
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
              border: '1px solid #ddd',
              padding: '15px',
              marginBottom: '10px',
              borderRadius: '5px'
            }}
          >
            <div>
              <h3>{item.name}</h3>
              <p>{item.price.toLocaleString()}원</p>
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
              <button onClick={() => updateQuantity(item.id, item.quantity - 1)}>
                -
              </button>
              <span>{item.quantity}</span>
              <button onClick={() => updateQuantity(item.id, item.quantity + 1)}>
                +
              </button>
              <span style={{ marginLeft: '10px' }}>
                {(item.price * item.quantity).toLocaleString()}원
              </span>
              <button
                onClick={() => removeFromCart(item.id)}
                style={{
                  marginLeft: '10px',
                  backgroundColor: '#dc3545',
                  color: 'white',
                  border: 'none',
                  padding: '5px 10px',
                  borderRadius: '3px',
                  cursor: 'pointer'
                }}
              >
                삭제
              </button>
            </div>
          </div>
        ))}
      </div>

      <div style={{
        marginTop: '20px',
        padding: '20px',
        backgroundColor: '#f8f9fa',
        borderRadius: '5px'
      }}>
        <h3>주문 요약</h3>
        <p>총 상품 수: {getTotalItems()}개</p>
        <p style={{ fontSize: '20px', fontWeight: 'bold' }}>
          총 금액: {getTotalPrice().toLocaleString()}원
        </p>

        <div style={{ marginTop: '20px', display: 'flex', gap: '10px' }}>
          <button
            style={{
              flex: 1,
              padding: '15px',
              backgroundColor: '#28a745',
              color: 'white',
              border: 'none',
              borderRadius: '5px',
              cursor: 'pointer',
              fontSize: '16px'
            }}
          >
            결제하기
          </button>

          <button
            onClick={clearCart}
            style={{
              padding: '15px 30px',
              backgroundColor: '#6c757d',
              color: 'white',
              border: 'none',
              borderRadius: '5px',
              cursor: 'pointer'
            }}
          >
            장바구니 비우기
          </button>
        </div>
      </div>
    </div>
  );
}

export default Cart;
```

## 네비게이션 바에서 Context 사용하기

```javascript
// src/components/Navbar.js
import { Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useCart } from '../contexts/CartContext';
import { useTheme } from '../contexts/ThemeContext';

function Navbar() {
  const { isAuthenticated, user, logout } = useAuth();
  const { getTotalItems } = useCart();
  const { theme, toggleTheme } = useTheme();

  return (
    <nav style={{
      padding: '15px 20px',
      backgroundColor: theme === 'light' ? '#f8f9fa' : '#343a40',
      color: theme === 'light' ? '#000' : '#fff',
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center'
    }}>
      <div>
        <Link to="/" style={{ marginRight: '15px' }}>홈</Link>
        <Link to="/products" style={{ marginRight: '15px' }}>상품</Link>
        <Link to="/cart" style={{ marginRight: '15px' }}>
          장바구니 ({getTotalItems()})
        </Link>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
        <button onClick={toggleTheme}>
          {theme === 'light' ? '🌙' : '☀️'}
        </button>

        {isAuthenticated ? (
          <>
            <span>{user.name}님</span>
            <Link to="/profile">프로필</Link>
            <button onClick={logout}>로그아웃</button>
          </>
        ) : (
          <Link to="/login">로그인</Link>
        )}
      </div>
    </nav>
  );
}

export default Navbar;
```

## Context 사용 시 주의사항

### 1. 불필요한 재렌더링 방지

```javascript
// ❌ 매번 새로운 객체를 생성 (모든 consumer가 재렌더링)
function BadProvider({ children }) {
  const [user, setUser] = useState(null);

  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
}

// ✅ useMemo로 최적화
import { useMemo } from 'react';

function GoodProvider({ children }) {
  const [user, setUser] = useState(null);

  const value = useMemo(() => ({ user, setUser }), [user]);

  return (
    <UserContext.Provider value={value}>
      {children}
    </UserContext.Provider>
  );
}
```

### 2. Context 분리하기

```javascript
// ❌ 하나의 큰 Context (일부만 필요해도 전체 재렌더링)
const AppContext = createContext();

// ✅ 여러 개의 작은 Context (필요한 것만 구독)
const UserContext = createContext();
const ThemeContext = createContext();
const CartContext = createContext();
```

## 핵심 요약

- Context API는 Props drilling 없이 전역 상태를 관리합니다
- `createContext()`로 Context를 생성합니다
- Provider로 앱을 감싸고 value를 전달합니다
- `useContext()` Hook으로 Context 값을 사용합니다
- Custom Hook을 만들어 Context 사용을 간편하게 할 수 있습니다
- 인증, 테마, 장바구니 등 전역 상태 관리에 유용합니다
- 불필요한 재렌더링을 방지하기 위해 useMemo를 사용합니다

다음 장에서는 실전 프로젝트와 모범 사례를 배웁니다! 🚀

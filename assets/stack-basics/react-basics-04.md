# State와 useState 훅

## State란 무엇인가?

State는 컴포넌트의 상태 데이터를 저장하고 관리하는 객체입니다. Props와 달리 컴포넌트 내부에서 변경할 수 있으며, State가 변경되면 컴포넌트가 자동으로 다시 렌더링됩니다.

### Props vs State

```javascript
// Props: 부모에서 받아오는 데이터 (읽기 전용)
function Greeting({ name }) {
  // name은 변경할 수 없음
  return <h1>안녕하세요, {name}님!</h1>;
}

// State: 컴포넌트 내부에서 관리하는 데이터 (변경 가능)
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);  // count는 변경 가능

  return (
    <div>
      <p>카운트: {count}</p>
      <button onClick={() => setCount(count + 1)}>증가</button>
    </div>
  );
}
```

## useState 훅 기본 사용법

`useState`는 React에서 제공하는 Hook으로, 함수형 컴포넌트에서 상태를 관리할 수 있게 해줍니다.

### 기본 문법

```javascript
import { useState } from 'react';

function BadebuCounter() {
  // [현재 상태, 상태 업데이트 함수] = useState(초기값)
  const [count, setCount] = useState(0);

  return (
    <div>
      <h2>바데부의 학습 카운터</h2>
      <p>완료한 강의: {count}개</p>
      <button onClick={() => setCount(count + 1)}>
        강의 완료 +1
      </button>
    </div>
  );
}
```

### 다양한 타입의 State

```javascript
import { useState } from 'react';

function BadebuProfile() {
  // 문자열 state
  const [name, setName] = useState('바데부');

  // 숫자 state
  const [age, setAge] = useState(25);

  // 불리언 state
  const [isOnline, setIsOnline] = useState(true);

  // 배열 state
  const [skills, setSkills] = useState(['React', 'JavaScript']);

  // 객체 state
  const [user, setUser] = useState({
    name: '바데부',
    level: '초급',
    points: 100
  });

  return (
    <div>
      <h2>{name}</h2>
      <p>나이: {age}세</p>
      <p>상태: {isOnline ? '온라인' : '오프라인'}</p>
      <p>스킬: {skills.join(', ')}</p>
      <p>레벨: {user.level}, 포인트: {user.points}</p>
    </div>
  );
}
```

## State 업데이트하기

### 1. 직접 값 설정

```javascript
import { useState } from 'react';

function LikeButton() {
  const [likes, setLikes] = useState(0);

  const handleLike = () => {
    setLikes(likes + 1);  // 직접 새 값 설정
  };

  return (
    <div>
      <p>바데부의 포스트</p>
      <p>좋아요: {likes}개 ❤️</p>
      <button onClick={handleLike}>좋아요</button>
    </div>
  );
}
```

### 2. 함수형 업데이트 (이전 상태 기반)

```javascript
function Counter() {
  const [count, setCount] = useState(0);

  const increment = () => {
    // 함수형 업데이트: 이전 값을 기반으로 업데이트
    setCount(prevCount => prevCount + 1);
  };

  const incrementByFive = () => {
    // 여러 번 업데이트할 때는 함수형 업데이트 사용
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
  };

  return (
    <div>
      <p>바데부의 포인트: {count}</p>
      <button onClick={increment}>+1</button>
      <button onClick={incrementByFive}>+5</button>
    </div>
  );
}
```

### 3. 객체 State 업데이트

```javascript
import { useState } from 'react';

function BadebuProfile() {
  const [profile, setProfile] = useState({
    name: '바데부',
    level: 1,
    exp: 0,
    coins: 100
  });

  const gainExp = () => {
    setProfile(prevProfile => ({
      ...prevProfile,  // 기존 속성 유지
      exp: prevProfile.exp + 10  // exp만 업데이트
    }));
  };

  const levelUp = () => {
    setProfile(prevProfile => ({
      ...prevProfile,
      level: prevProfile.level + 1,
      exp: 0  // 레벨업 시 경험치 초기화
    }));
  };

  return (
    <div className="profile">
      <h2>{profile.name}</h2>
      <p>레벨: {profile.level}</p>
      <p>경험치: {profile.exp}/100</p>
      <p>코인: {profile.coins}개</p>
      <button onClick={gainExp}>경험치 획득 (+10)</button>
      <button onClick={levelUp}>레벨업!</button>
    </div>
  );
}
```

### 4. 배열 State 업데이트

```javascript
import { useState } from 'react';

function TodoList() {
  const [todos, setTodos] = useState([
    'React 기초 학습',
    'Props 복습'
  ]);
  const [inputValue, setInputValue] = useState('');

  // 할 일 추가
  const addTodo = () => {
    if (inputValue.trim()) {
      setTodos(prevTodos => [...prevTodos, inputValue]);
      setInputValue('');
    }
  };

  // 할 일 삭제
  const removeTodo = (index) => {
    setTodos(prevTodos => prevTodos.filter((_, i) => i !== index));
  };

  return (
    <div>
      <h2>바데부의 학습 목록</h2>

      <div>
        <input
          type="text"
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          placeholder="새 학습 목표 입력"
        />
        <button onClick={addTodo}>추가</button>
      </div>

      <ul>
        {todos.map((todo, index) => (
          <li key={index}>
            {todo}
            <button onClick={() => removeTodo(index)}>삭제</button>
          </li>
        ))}
      </ul>
    </div>
  );
}
```

## 입력 폼과 State

### 단일 입력 필드

```javascript
import { useState } from 'react';

function NameForm() {
  const [name, setName] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(`안녕하세요, ${name}님!`);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>이름을 입력하세요</h2>
      <input
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="바데부"
      />
      <button type="submit">제출</button>
      <p>입력된 이름: {name}</p>
    </form>
  );
}
```

### 여러 입력 필드

```javascript
import { useState } from 'react';

function SignUpForm() {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: '',
    age: ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('가입 정보:', formData);
    alert(`${formData.username}님 환영합니다!`);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>바데부 회원가입</h2>

      <input
        type="text"
        name="username"
        value={formData.username}
        onChange={handleChange}
        placeholder="사용자 이름"
      />

      <input
        type="email"
        name="email"
        value={formData.email}
        onChange={handleChange}
        placeholder="이메일"
      />

      <input
        type="password"
        name="password"
        value={formData.password}
        onChange={handleChange}
        placeholder="비밀번호"
      />

      <input
        type="number"
        name="age"
        value={formData.age}
        onChange={handleChange}
        placeholder="나이"
      />

      <button type="submit">가입하기</button>
    </form>
  );
}
```

## 실전 예제: 학습 타이머

```javascript
import { useState } from 'react';

function StudyTimer() {
  const [minutes, setMinutes] = useState(25);
  const [seconds, setSeconds] = useState(0);
  const [isRunning, setIsRunning] = useState(false);
  const [completedSessions, setCompletedSessions] = useState(0);

  const startTimer = () => {
    setIsRunning(true);
    const interval = setInterval(() => {
      setSeconds(prev => {
        if (prev === 0) {
          setMinutes(prevMin => {
            if (prevMin === 0) {
              clearInterval(interval);
              setIsRunning(false);
              setCompletedSessions(prev => prev + 1);
              alert('바데부님, 학습 시간이 끝났습니다! 🎉');
              return 0;
            }
            return prevMin - 1;
          });
          return 59;
        }
        return prev - 1;
      });
    }, 1000);
  };

  const resetTimer = () => {
    setIsRunning(false);
    setMinutes(25);
    setSeconds(0);
  };

  return (
    <div className="timer">
      <h2>바데부의 학습 타이머</h2>

      <div className="timer-display">
        <span className="time">
          {String(minutes).padStart(2, '0')}:
          {String(seconds).padStart(2, '0')}
        </span>
      </div>

      <div className="timer-controls">
        <button
          onClick={startTimer}
          disabled={isRunning}
        >
          시작
        </button>
        <button onClick={resetTimer}>리셋</button>
      </div>

      <div className="stats">
        <p>완료한 세션: {completedSessions}회</p>
        <p>총 학습 시간: {completedSessions * 25}분</p>
      </div>
    </div>
  );
}
```

## 실전 예제: 쇼핑 카트

```javascript
import { useState } from 'react';

function ShoppingCart() {
  const [items, setItems] = useState([]);
  const [productName, setProductName] = useState('');
  const [price, setPrice] = useState('');

  const addItem = () => {
    if (productName && price) {
      const newItem = {
        id: Date.now(),
        name: productName,
        price: Number(price),
        quantity: 1
      };
      setItems(prev => [...prev, newItem]);
      setProductName('');
      setPrice('');
    }
  };

  const updateQuantity = (id, change) => {
    setItems(prev => prev.map(item => {
      if (item.id === id) {
        const newQuantity = item.quantity + change;
        return newQuantity > 0 ? { ...item, quantity: newQuantity } : item;
      }
      return item;
    }));
  };

  const removeItem = (id) => {
    setItems(prev => prev.filter(item => item.id !== id));
  };

  const totalPrice = items.reduce((sum, item) => {
    return sum + (item.price * item.quantity);
  }, 0);

  return (
    <div className="shopping-cart">
      <h2>바데부의 장바구니</h2>

      <div className="add-item">
        <input
          type="text"
          value={productName}
          onChange={(e) => setProductName(e.target.value)}
          placeholder="상품명"
        />
        <input
          type="number"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          placeholder="가격"
        />
        <button onClick={addItem}>추가</button>
      </div>

      <div className="cart-items">
        {items.length === 0 ? (
          <p>장바구니가 비어있습니다.</p>
        ) : (
          items.map(item => (
            <div key={item.id} className="cart-item">
              <span>{item.name}</span>
              <span>{item.price}원</span>
              <div>
                <button onClick={() => updateQuantity(item.id, -1)}>-</button>
                <span>{item.quantity}</span>
                <button onClick={() => updateQuantity(item.id, 1)}>+</button>
              </div>
              <span>{item.price * item.quantity}원</span>
              <button onClick={() => removeItem(item.id)}>삭제</button>
            </div>
          ))
        )}
      </div>

      <div className="cart-total">
        <h3>총 금액: {totalPrice.toLocaleString()}원</h3>
        <button disabled={items.length === 0}>결제하기</button>
      </div>
    </div>
  );
}
```

## State 사용 시 주의사항

### 1. State를 직접 수정하지 마세요

```javascript
// ❌ 잘못된 방법
const [user, setUser] = useState({ name: '바데부', age: 25 });
user.age = 26;  // 직접 수정 (작동하지 않음)

// ✅ 올바른 방법
setUser(prev => ({ ...prev, age: 26 }));
```

### 2. State 업데이트는 비동기입니다

```javascript
const [count, setCount] = useState(0);

const handleClick = () => {
  setCount(count + 1);
  console.log(count);  // 여전히 이전 값이 출력됨
};

// 최신 값이 필요하면 useEffect 사용
```

### 3. 배열/객체는 새로운 참조를 만들어야 합니다

```javascript
// ❌ 잘못된 방법
const [items, setItems] = useState([1, 2, 3]);
items.push(4);
setItems(items);  // 재렌더링 안 됨

// ✅ 올바른 방법
setItems(prev => [...prev, 4]);
```

## 핵심 요약

- State는 컴포넌트 내부에서 관리하는 동적 데이터입니다
- `useState` Hook으로 함수형 컴포넌트에서 상태를 관리합니다
- State가 변경되면 컴포넌트가 자동으로 재렌더링됩니다
- 객체와 배열 State는 spread 연산자로 불변성을 유지하며 업데이트합니다
- 함수형 업데이트를 사용하면 이전 상태를 안전하게 참조할 수 있습니다
- State를 직접 수정하지 말고 항상 setState 함수를 사용해야 합니다

다음 장에서는 이벤트 처리에 대해 자세히 배웁니다! 🚀

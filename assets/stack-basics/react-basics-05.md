# 이벤트 처리

## React에서 이벤트란?

이벤트는 사용자의 행동(클릭, 입력, 마우스 이동 등)에 반응하는 방법입니다. React는 브라우저의 기본 이벤트를 감싸서 더 일관되고 사용하기 쉽게 만든 합성 이벤트(Synthetic Event)를 제공합니다.

### HTML vs React 이벤트

```html
<!-- HTML -->
<button onclick="handleClick()">클릭</button>

<!-- React -->
<button onClick={handleClick}>클릭</button>
```

차이점:
- React는 camelCase를 사용합니다 (`onclick` → `onClick`)
- React는 함수 자체를 전달합니다 (문자열이 아님)
- React는 `return false`로 기본 동작을 막을 수 없고, `preventDefault()`를 명시적으로 호출해야 합니다

## 기본 이벤트 처리

### 클릭 이벤트

```javascript
import { useState } from 'react';

function ClickExample() {
  const [message, setMessage] = useState('바데부님, 버튼을 클릭하세요!');

  // 이벤트 핸들러 함수
  const handleClick = () => {
    setMessage('버튼이 클릭되었습니다! 👍');
  };

  return (
    <div>
      <h2>{message}</h2>
      <button onClick={handleClick}>클릭!</button>
    </div>
  );
}

// 인라인 함수 사용
function InlineExample() {
  return (
    <button onClick={() => alert('바데부님 안녕하세요!')}>
      인사하기
    </button>
  );
}
```

### 입력 이벤트

```javascript
import { useState } from 'react';

function InputExample() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');

  return (
    <div>
      <h2>바데부의 회원가입</h2>

      <div>
        <label>이름: </label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
        <p>입력된 이름: {name}</p>
      </div>

      <div>
        <label>이메일: </label>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <p>입력된 이메일: {email}</p>
      </div>
    </div>
  );
}
```

## 이벤트 객체 (Event Object)

이벤트 핸들러는 자동으로 이벤트 객체를 받습니다.

```javascript
import { useState } from 'react';

function EventObjectExample() {
  const [logs, setLogs] = useState([]);

  const handleClick = (event) => {
    console.log('이벤트 타입:', event.type);
    console.log('클릭된 요소:', event.target);
    console.log('현재 요소:', event.currentTarget);

    const log = `${event.type} 이벤트 발생!`;
    setLogs(prev => [...prev, log]);
  };

  const handleMouseMove = (event) => {
    console.log(`마우스 위치: X=${event.clientX}, Y=${event.clientY}`);
  };

  const handleKeyPress = (event) => {
    console.log('눌린 키:', event.key);
    console.log('키 코드:', event.keyCode);

    if (event.key === 'Enter') {
      alert('바데부님, Enter를 누르셨습니다!');
    }
  };

  return (
    <div>
      <h2>이벤트 객체 탐색</h2>

      <button onClick={handleClick}>클릭 이벤트</button>

      <div
        onMouseMove={handleMouseMove}
        style={{
          width: '200px',
          height: '200px',
          border: '2px solid blue',
          margin: '10px'
        }}
      >
        마우스를 움직여보세요
      </div>

      <input
        type="text"
        onKeyDown={handleKeyPress}
        placeholder="키를 눌러보세요"
      />

      <div>
        <h3>이벤트 로그:</h3>
        {logs.map((log, index) => (
          <p key={index}>{log}</p>
        ))}
      </div>
    </div>
  );
}
```

## 폼 이벤트

### submit 이벤트

```javascript
import { useState } from 'react';

function LoginForm() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();  // 페이지 새로고침 방지

    if (!username || !password) {
      alert('모든 필드를 입력해주세요!');
      return;
    }

    console.log('로그인 시도:', { username, password });
    alert(`${username}님, 환영합니다!`);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>바데부 로그인</h2>

      <div>
        <input
          type="text"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          placeholder="사용자 이름"
        />
      </div>

      <div>
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="비밀번호"
        />
      </div>

      <button type="submit">로그인</button>
    </form>
  );
}
```

### 다중 입력 처리

```javascript
import { useState } from 'react';

function MultiInputForm() {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    age: '',
    country: 'korea',
    agreeTerms: false
  });

  // 모든 입력 필드를 하나의 함수로 처리
  const handleChange = (event) => {
    const { name, value, type, checked } = event.target;

    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log('제출된 데이터:', formData);
    alert(`바데부님, 가입이 완료되었습니다!`);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2>회원가입</h2>

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
        type="number"
        name="age"
        value={formData.age}
        onChange={handleChange}
        placeholder="나이"
      />

      <select
        name="country"
        value={formData.country}
        onChange={handleChange}
      >
        <option value="korea">한국</option>
        <option value="usa">미국</option>
        <option value="japan">일본</option>
      </select>

      <label>
        <input
          type="checkbox"
          name="agreeTerms"
          checked={formData.agreeTerms}
          onChange={handleChange}
        />
        약관에 동의합니다
      </label>

      <button type="submit" disabled={!formData.agreeTerms}>
        가입하기
      </button>
    </form>
  );
}
```

## 이벤트 핸들러에 인자 전달하기

```javascript
import { useState } from 'react';

function MessageList() {
  const [messages, setMessages] = useState([
    { id: 1, text: '안녕하세요!', author: '바데부' },
    { id: 2, text: 'React 재미있어요!', author: '철수' },
    { id: 3, text: '같이 공부해요!', author: '영희' }
  ]);

  // 방법 1: 화살표 함수 사용
  const deleteMessage = (id) => {
    setMessages(prev => prev.filter(msg => msg.id !== id));
  };

  // 방법 2: bind 사용
  const likeMessage = function(id, event) {
    console.log(`메시지 ${id}에 좋아요!`);
  };

  return (
    <div>
      <h2>바데부의 메시지</h2>
      {messages.map(msg => (
        <div key={msg.id} className="message">
          <p><strong>{msg.author}:</strong> {msg.text}</p>

          {/* 화살표 함수로 인자 전달 */}
          <button onClick={() => deleteMessage(msg.id)}>
            삭제
          </button>

          {/* bind로 인자 전달 */}
          <button onClick={likeMessage.bind(null, msg.id)}>
            좋아요
          </button>
        </div>
      ))}
    </div>
  );
}
```

## 다양한 이벤트 타입

```javascript
import { useState } from 'react';

function EventTypes() {
  const [eventLog, setEventLog] = useState([]);

  const addLog = (message) => {
    setEventLog(prev => [...prev, `${new Date().toLocaleTimeString()}: ${message}`]);
  };

  return (
    <div>
      <h2>바데부의 이벤트 실험실</h2>

      {/* 클릭 이벤트들 */}
      <button onClick={() => addLog('클릭!')}>
        클릭
      </button>

      <button onDoubleClick={() => addLog('더블클릭!')}>
        더블클릭
      </button>

      {/* 마우스 이벤트들 */}
      <div
        style={{ padding: '20px', backgroundColor: '#f0f0f0', margin: '10px' }}
        onMouseEnter={() => addLog('마우스 진입')}
        onMouseLeave={() => addLog('마우스 이탈')}
      >
        마우스를 올려보세요
      </div>

      {/* 포커스 이벤트들 */}
      <input
        type="text"
        placeholder="포커스 이벤트 테스트"
        onFocus={() => addLog('입력창 포커스')}
        onBlur={() => addLog('입력창 블러')}
      />

      {/* 키보드 이벤트들 */}
      <input
        type="text"
        placeholder="키보드 이벤트 테스트"
        onKeyDown={(e) => addLog(`키 다운: ${e.key}`)}
        onKeyUp={(e) => addLog(`키 업: ${e.key}`)}
      />

      {/* 복사 이벤트 */}
      <input
        type="text"
        defaultValue="바데부"
        onCopy={() => addLog('텍스트 복사됨')}
        onPaste={() => addLog('텍스트 붙여넣기')}
      />

      {/* 이벤트 로그 */}
      <div style={{ marginTop: '20px', maxHeight: '200px', overflow: 'auto' }}>
        <h3>이벤트 로그:</h3>
        {eventLog.map((log, index) => (
          <p key={index} style={{ fontSize: '12px' }}>{log}</p>
        ))}
      </div>

      <button onClick={() => setEventLog([])}>로그 지우기</button>
    </div>
  );
}
```

## 이벤트 버블링과 캡처링

```javascript
function EventBubbling() {
  const handleParentClick = () => {
    console.log('부모 클릭');
  };

  const handleChildClick = (event) => {
    console.log('자식 클릭');
    // event.stopPropagation();  // 주석 해제하면 버블링 중지
  };

  const handleButtonClick = (event) => {
    console.log('버튼 클릭');
    event.stopPropagation();  // 버블링 중지
  };

  return (
    <div onClick={handleParentClick} style={{ padding: '20px', backgroundColor: '#ffe0e0' }}>
      <p>부모 (클릭해보세요)</p>

      <div onClick={handleChildClick} style={{ padding: '20px', backgroundColor: '#e0e0ff' }}>
        <p>자식 (클릭해보세요)</p>

        <button onClick={handleButtonClick}>
          버튼 (버블링 중지됨)
        </button>
      </div>
    </div>
  );
}
```

## 실전 예제: 인터랙티브 게임

```javascript
import { useState } from 'react';

function WhackAMole() {
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(30);
  const [activeMole, setActiveMole] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);

  const startGame = () => {
    setScore(0);
    setTimeLeft(30);
    setIsPlaying(true);

    // 타이머
    const timer = setInterval(() => {
      setTimeLeft(prev => {
        if (prev <= 1) {
          clearInterval(timer);
          setIsPlaying(false);
          alert(`게임 종료! 바데부님의 점수: ${score}점`);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    // 두더지 랜덤 출현
    const moleInterval = setInterval(() => {
      if (timeLeft > 0) {
        setActiveMole(Math.floor(Math.random() * 9));
        setTimeout(() => setActiveMole(null), 800);
      } else {
        clearInterval(moleInterval);
      }
    }, 1000);
  };

  const hitMole = (index) => {
    if (isPlaying && activeMole === index) {
      setScore(prev => prev + 10);
      setActiveMole(null);
    }
  };

  return (
    <div className="game">
      <h2>바데부의 두더지 게임</h2>

      <div className="game-info">
        <p>점수: {score}점</p>
        <p>남은 시간: {timeLeft}초</p>
      </div>

      {!isPlaying && timeLeft === 30 && (
        <button onClick={startGame}>게임 시작</button>
      )}

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(3, 100px)',
        gap: '10px',
        marginTop: '20px'
      }}>
        {[...Array(9)].map((_, index) => (
          <div
            key={index}
            onClick={() => hitMole(index)}
            style={{
              width: '100px',
              height: '100px',
              backgroundColor: activeMole === index ? '#ff6b6b' : '#4ecdc4',
              borderRadius: '10px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              fontSize: '40px',
              transition: 'all 0.2s'
            }}
          >
            {activeMole === index ? '🐹' : '⬜'}
          </div>
        ))}
      </div>
    </div>
  );
}
```

## 실전 예제: 드래그 앤 드롭 리스트

```javascript
import { useState } from 'react';

function DraggableList() {
  const [items, setItems] = useState([
    { id: 1, text: 'React 기초', done: false },
    { id: 2, text: 'Props 학습', done: false },
    { id: 3, text: 'State 마스터', done: false }
  ]);
  const [draggedItem, setDraggedItem] = useState(null);

  const handleDragStart = (item) => {
    setDraggedItem(item);
  };

  const handleDragOver = (event) => {
    event.preventDefault();
  };

  const handleDrop = (targetItem) => {
    if (draggedItem && draggedItem.id !== targetItem.id) {
      const draggedIndex = items.findIndex(item => item.id === draggedItem.id);
      const targetIndex = items.findIndex(item => item.id === targetItem.id);

      const newItems = [...items];
      newItems.splice(draggedIndex, 1);
      newItems.splice(targetIndex, 0, draggedItem);

      setItems(newItems);
    }
    setDraggedItem(null);
  };

  const toggleDone = (id) => {
    setItems(prev => prev.map(item =>
      item.id === id ? { ...item, done: !item.done } : item
    ));
  };

  return (
    <div>
      <h2>바데부의 학습 체크리스트</h2>
      <p>드래그하여 순서를 변경하세요</p>

      <div>
        {items.map(item => (
          <div
            key={item.id}
            draggable
            onDragStart={() => handleDragStart(item)}
            onDragOver={handleDragOver}
            onDrop={() => handleDrop(item)}
            style={{
              padding: '15px',
              margin: '10px 0',
              backgroundColor: item.done ? '#d4edda' : '#f8f9fa',
              border: '2px solid #dee2e6',
              borderRadius: '5px',
              cursor: 'move',
              textDecoration: item.done ? 'line-through' : 'none'
            }}
          >
            <input
              type="checkbox"
              checked={item.done}
              onChange={() => toggleDone(item.id)}
            />
            <span style={{ marginLeft: '10px' }}>{item.text}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
```

## 핵심 요약

- React는 camelCase 이벤트 이름을 사용합니다 (`onClick`, `onChange` 등)
- 이벤트 핸들러는 함수를 전달합니다 (문자열이 아님)
- 이벤트 객체를 통해 이벤트 정보에 접근할 수 있습니다
- `preventDefault()`로 기본 동작을 방지합니다
- `stopPropagation()`으로 이벤트 버블링을 중지합니다
- 화살표 함수나 bind로 이벤트 핸들러에 인자를 전달할 수 있습니다
- 하나의 핸들러로 여러 입력 필드를 처리할 수 있습니다

다음 장에서는 조건부 렌더링과 리스트 렌더링을 배웁니다! 🚀

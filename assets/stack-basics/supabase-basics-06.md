# Chapter 6: 실시간 구독 (Realtime Subscriptions)

## Supabase Realtime 이해하기

Supabase Realtime은 PostgreSQL의 변경사항을 실시간으로 클라이언트에 전달하는 기능입니다. 데이터베이스에 INSERT, UPDATE, DELETE가 발생하면 즉시 알림을 받을 수 있어 채팅, 협업 도구, 실시간 대시보드 등을 쉽게 구현할 수 있습니다.

### Realtime의 핵심 개념

- **채널 (Channel)**: 실시간 이벤트를 주고받는 통로
- **구독 (Subscription)**: 특정 테이블의 변경사항 감지
- **페이로드 (Payload)**: 변경된 데이터의 내용
- **필터 (Filter)**: 특정 조건의 변경사항만 수신

## Realtime 활성화하기

### Dashboard에서 활성화

```sql
-- 1. Supabase Dashboard > Database > Replication
-- 2. 테이블 선택하여 Realtime 활성화

-- SQL로 활성화
ALTER PUBLICATION supabase_realtime ADD TABLE learning_records;

-- 비활성화
ALTER PUBLICATION supabase_realtime DROP TABLE learning_records;

-- 활성화된 테이블 확인
SELECT * FROM pg_publication_tables WHERE pubname = 'supabase_realtime';
```

## 기본 실시간 구독

### 테이블의 모든 변경사항 구독

```javascript
import { supabase } from './supabase.js'

// 학습 기록 테이블의 모든 변경사항 구독
const channel = supabase
  .channel('learning-records-changes')
  .on(
    'postgres_changes',
    {
      event: '*',  // INSERT, UPDATE, DELETE 모두
      schema: 'public',
      table: 'learning_records'
    },
    (payload) => {
      console.log('변경사항 감지:', payload)
      console.log('이벤트 타입:', payload.eventType)
      console.log('새 데이터:', payload.new)
      console.log('이전 데이터:', payload.old)
    }
  )
  .subscribe()

// 구독 해제
// channel.unsubscribe()
```

### 특정 이벤트만 구독

```javascript
// INSERT 이벤트만 구독
const insertChannel = supabase
  .channel('new-records')
  .on(
    'postgres_changes',
    {
      event: 'INSERT',
      schema: 'public',
      table: 'learning_records'
    },
    (payload) => {
      console.log('새 학습 기록 추가됨:', payload.new)
      // UI 업데이트 로직
    }
  )
  .subscribe()

// UPDATE 이벤트만 구독
const updateChannel = supabase
  .channel('updated-records')
  .on(
    'postgres_changes',
    {
      event: 'UPDATE',
      schema: 'public',
      table: 'learning_records'
    },
    (payload) => {
      console.log('학습 기록 수정됨:', payload.new)
      console.log('이전 값:', payload.old)
    }
  )
  .subscribe()

// DELETE 이벤트만 구독
const deleteChannel = supabase
  .channel('deleted-records')
  .on(
    'postgres_changes',
    {
      event: 'DELETE',
      schema: 'public',
      table: 'learning_records'
    },
    (payload) => {
      console.log('학습 기록 삭제됨:', payload.old)
    }
  )
  .subscribe()
```

## 필터를 사용한 구독

### 특정 사용자의 데이터만 구독

```javascript
// 바데부의 학습 기록만 구독
async function subscribeToBadebuRecords() {
  const { data: { user } } = await supabase.auth.getUser()

  const channel = supabase
    .channel('badebu-records')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'learning_records',
        filter: `user_id=eq.${user.id}`  // 현재 사용자의 데이터만
      },
      (payload) => {
        console.log('바데부의 학습 기록 변경됨:', payload)
        updateUI(payload)
      }
    )
    .subscribe()

  return channel
}
```

### 여러 필터 조건

```javascript
// 완료된 학습 기록만 구독
const completedChannel = supabase
  .channel('completed-records')
  .on(
    'postgres_changes',
    {
      event: 'UPDATE',
      schema: 'public',
      table: 'learning_records',
      filter: 'completed=eq.true'
    },
    (payload) => {
      console.log('학습 완료!', payload.new.subject)
      showCelebration()
    }
  )
  .subscribe()
```

## 바데부의 실전 예제: 실시간 학습 대시보드

```javascript
// realtime-dashboard.js
class RealtimeDashboard {
  constructor() {
    this.channels = []
    this.stats = {
      totalRecords: 0,
      todayHours: 0,
      completedToday: 0
    }
  }

  async initialize() {
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) return

    // 초기 데이터 로드
    await this.loadInitialData(user.id)

    // 실시간 구독 시작
    this.subscribeToChanges(user.id)
  }

  async loadInitialData(userId) {
    const today = new Date().toISOString().split('T')[0]

    const { data, error } = await supabase
      .from('learning_records')
      .select('*')
      .eq('user_id', userId)
      .gte('created_at', `${today}T00:00:00`)

    if (!error && data) {
      this.stats.totalRecords = data.length
      this.stats.todayHours = data.reduce((sum, r) => sum + r.hours_spent, 0)
      this.stats.completedToday = data.filter(r => r.completed).length
      this.updateUI()
    }
  }

  subscribeToChanges(userId) {
    // 새 학습 기록 추가 감지
    const insertChannel = supabase
      .channel('dashboard-insert')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'learning_records',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          console.log('바데부가 새 학습 기록을 추가했습니다!')
          this.stats.totalRecords++
          this.stats.todayHours += payload.new.hours_spent
          if (payload.new.completed) {
            this.stats.completedToday++
          }
          this.updateUI()
          this.showNotification('새 학습 기록이 추가되었습니다', payload.new)
        }
      )
      .subscribe()

    // 학습 기록 수정 감지
    const updateChannel = supabase
      .channel('dashboard-update')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'learning_records',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          console.log('바데부가 학습 기록을 수정했습니다!')

          // 시간 변경 감지
          const hoursDiff = payload.new.hours_spent - payload.old.hours_spent
          this.stats.todayHours += hoursDiff

          // 완료 상태 변경 감지
          if (payload.new.completed && !payload.old.completed) {
            this.stats.completedToday++
            this.showCelebration('학습 완료!')
          }

          this.updateUI()
        }
      )
      .subscribe()

    // 학습 기록 삭제 감지
    const deleteChannel = supabase
      .channel('dashboard-delete')
      .on(
        'postgres_changes',
        {
          event: 'DELETE',
          schema: 'public',
          table: 'learning_records',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          console.log('학습 기록이 삭제되었습니다')
          this.stats.totalRecords--
          this.stats.todayHours -= payload.old.hours_spent
          if (payload.old.completed) {
            this.stats.completedToday--
          }
          this.updateUI()
        }
      )
      .subscribe()

    this.channels = [insertChannel, updateChannel, deleteChannel]
  }

  updateUI() {
    console.log('=== 바데부의 학습 통계 ===')
    console.log('총 기록:', this.stats.totalRecords)
    console.log('오늘 학습 시간:', this.stats.todayHours.toFixed(2), '시간')
    console.log('오늘 완료:', this.stats.completedToday, '개')

    // 실제로는 DOM 업데이트
    // document.getElementById('total-records').textContent = this.stats.totalRecords
    // document.getElementById('today-hours').textContent = this.stats.todayHours
  }

  showNotification(title, data) {
    console.log(`[알림] ${title}:`, data.subject)
  }

  showCelebration(message) {
    console.log(`[축하] ${message}`)
  }

  destroy() {
    // 모든 구독 해제
    this.channels.forEach(channel => channel.unsubscribe())
    this.channels = []
  }
}

// 사용 예시
const dashboard = new RealtimeDashboard()
await dashboard.initialize()

// 정리 시
// dashboard.destroy()
```

## Presence: 온라인 사용자 추적

### 누가 온라인인지 감지

```javascript
// 바데부와 친구들의 온라인 상태 추적
async function trackOnlineUsers() {
  const { data: { user } } = await supabase.auth.getUser()

  const channel = supabase.channel('online-users', {
    config: {
      presence: {
        key: user.id
      }
    }
  })

  // 자신의 상태 전송
  channel
    .on('presence', { event: 'sync' }, () => {
      const state = channel.presenceState()
      console.log('온라인 사용자:', Object.keys(state).length)

      Object.entries(state).forEach(([userId, presence]) => {
        console.log('사용자:', presence[0].nickname, '- 온라인')
      })
    })
    .on('presence', { event: 'join' }, ({ key, newPresences }) => {
      console.log('접속:', newPresences[0].nickname)
    })
    .on('presence', { event: 'leave' }, ({ key, leftPresences }) => {
      console.log('퇴장:', leftPresences[0].nickname)
    })
    .subscribe(async (status) => {
      if (status === 'SUBSCRIBED') {
        await channel.track({
          user_id: user.id,
          nickname: '바데부',
          online_at: new Date().toISOString()
        })
      }
    })

  return channel
}
```

## Broadcast: 실시간 메시지 전송

### 채팅 구현하기

```javascript
// 실시간 채팅
class RealtimeChat {
  constructor(roomId) {
    this.roomId = roomId
    this.channel = null
  }

  async initialize() {
    const { data: { user } } = await supabase.auth.getUser()

    this.channel = supabase.channel(`chat-${this.roomId}`)

    // 메시지 수신
    this.channel
      .on('broadcast', { event: 'message' }, (payload) => {
        console.log('새 메시지:', payload.payload)
        this.displayMessage(payload.payload)
      })
      .on('broadcast', { event: 'typing' }, (payload) => {
        console.log('입력 중:', payload.payload.nickname)
        this.showTypingIndicator(payload.payload.nickname)
      })
      .subscribe()
  }

  async sendMessage(text) {
    const { data: { user } } = await supabase.auth.getUser()

    await this.channel.send({
      type: 'broadcast',
      event: 'message',
      payload: {
        user_id: user.id,
        nickname: '바데부',
        text: text,
        sent_at: new Date().toISOString()
      }
    })
  }

  async sendTypingIndicator() {
    const { data: { user } } = await supabase.auth.getUser()

    await this.channel.send({
      type: 'broadcast',
      event: 'typing',
      payload: {
        user_id: user.id,
        nickname: '바데부'
      }
    })
  }

  displayMessage(message) {
    console.log(`[${message.nickname}]: ${message.text}`)
    // 실제로는 DOM에 메시지 추가
  }

  showTypingIndicator(nickname) {
    console.log(`${nickname}님이 입력 중...`)
  }

  destroy() {
    if (this.channel) {
      this.channel.unsubscribe()
    }
  }
}

// 사용 예시
const chat = new RealtimeChat('study-room-1')
await chat.initialize()
await chat.sendMessage('안녕하세요! 바데부입니다.')
```

## 협업 기능 구현

### 실시간 협업 문서 편집

```javascript
// 여러 사용자가 동시에 문서를 편집
class CollaborativeEditor {
  constructor(documentId) {
    this.documentId = documentId
    this.channel = null
    this.cursors = new Map()
  }

  async initialize() {
    const { data: { user } } = await supabase.auth.getUser()

    this.channel = supabase.channel(`doc-${this.documentId}`, {
      config: {
        presence: { key: user.id }
      }
    })

    // 문서 변경 감지
    this.channel
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'documents',
          filter: `id=eq.${this.documentId}`
        },
        (payload) => {
          console.log('문서가 수정되었습니다')
          this.updateDocument(payload.new.content)
        }
      )
      // 커서 위치 공유
      .on('broadcast', { event: 'cursor' }, (payload) => {
        this.updateCursor(payload.payload)
      })
      // 온라인 편집자 추적
      .on('presence', { event: 'sync' }, () => {
        const editors = this.channel.presenceState()
        console.log('현재 편집자:', Object.keys(editors).length, '명')
      })
      .subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await this.channel.track({
            user_id: user.id,
            nickname: '바데부',
            color: '#3b82f6'  // 커서 색상
          })
        }
      })
  }

  async updateContent(content, cursorPosition) {
    // 데이터베이스 업데이트 (다른 사용자에게 자동 전파)
    await supabase
      .from('documents')
      .update({ content: content })
      .eq('id', this.documentId)

    // 커서 위치 브로드캐스트
    await this.channel.send({
      type: 'broadcast',
      event: 'cursor',
      payload: {
        user_id: (await supabase.auth.getUser()).data.user.id,
        position: cursorPosition
      }
    })
  }

  updateDocument(content) {
    console.log('문서 내용 업데이트:', content)
    // 에디터 내용 업데이트
  }

  updateCursor(cursor) {
    this.cursors.set(cursor.user_id, cursor.position)
    console.log('커서 위치 업데이트:', cursor)
  }

  destroy() {
    if (this.channel) {
      this.channel.unsubscribe()
    }
  }
}
```

## 연결 상태 관리

### 연결 상태 모니터링

```javascript
// 연결 상태 추적
const channel = supabase
  .channel('my-channel')
  .on(
    'postgres_changes',
    { event: '*', schema: 'public', table: 'learning_records' },
    (payload) => console.log(payload)
  )
  .subscribe((status, err) => {
    if (status === 'SUBSCRIBED') {
      console.log('✅ 실시간 구독 시작')
    }
    if (status === 'CHANNEL_ERROR') {
      console.error('❌ 채널 에러:', err)
    }
    if (status === 'TIMED_OUT') {
      console.error('⏱️ 타임아웃')
    }
    if (status === 'CLOSED') {
      console.log('🔌 연결 종료')
    }
  })

// 연결 재시도
async function retryConnection(channelName, maxRetries = 3) {
  let retries = 0

  while (retries < maxRetries) {
    try {
      const channel = supabase
        .channel(channelName)
        .on('postgres_changes', { event: '*', schema: 'public', table: 'learning_records' }, (payload) => {
          console.log('데이터 수신:', payload)
        })
        .subscribe((status) => {
          if (status === 'SUBSCRIBED') {
            console.log('연결 성공!')
            return channel
          }
        })

      return channel
    } catch (error) {
      retries++
      console.log(`재시도 ${retries}/${maxRetries}...`)
      await new Promise(resolve => setTimeout(resolve, 1000 * retries))
    }
  }

  console.error('최대 재시도 횟수 초과')
  return null
}
```

## 일반적인 실수와 해결방법

### 실수 1: 구독 해제 안 함 (메모리 누수)

```javascript
// ❌ 구독 해제 안 함
const channel = supabase.channel('my-channel').on(...).subscribe()

// ✅ 정리 시 반드시 해제
useEffect(() => {
  const channel = supabase.channel('my-channel').on(...).subscribe()

  return () => {
    channel.unsubscribe()
  }
}, [])
```

### 실수 2: Realtime이 활성화되지 않음

```sql
-- ❌ 테이블에 Realtime 활성화 안 함
-- 결과: 이벤트가 전달되지 않음

-- ✅ 반드시 활성화
ALTER PUBLICATION supabase_realtime ADD TABLE learning_records;
```

### 실수 3: RLS 정책 누락

```sql
-- ❌ RLS는 있지만 realtime 이벤트를 받을 정책이 없음
-- 결과: 데이터는 변경되지만 클라이언트가 받지 못함

-- ✅ SELECT 정책 필요
CREATE POLICY "realtime_select" ON learning_records
FOR SELECT TO authenticated USING (auth.uid() = user_id);
```

### 실수 4: 너무 많은 채널 생성

```javascript
// ❌ 매번 새 채널 생성
function getData() {
  supabase.channel('my-channel').on(...).subscribe()  // 중복 생성
}

// ✅ 채널 재사용
const channel = supabase.channel('my-channel').on(...).subscribe()
// 필요할 때 channel 사용
```

## 실습 과제

1. **실시간 TODO 리스트**: 여러 사용자가 동시에 편집 가능한 TODO 리스트 구현
2. **온라인 사용자 표시**: Presence를 사용하여 현재 온라인인 사용자 표시
3. **실시간 알림**: 새 데이터가 추가될 때 브라우저 알림 표시
4. **채팅방**: Broadcast를 사용한 간단한 채팅 기능 구현

## 다음 장 미리보기

다음 장에서는 Supabase Storage를 배웁니다. 파일 업로드, 다운로드, 이미지 최적화 등 파일 관리 기능을 알아봅니다.

## 핵심 요약

- Realtime은 PostgreSQL 변경사항을 실시간으로 전달
- postgres_changes로 테이블 변경 감지
- Presence로 온라인 사용자 추적
- Broadcast로 실시간 메시지 전송
- 필터로 특정 조건의 데이터만 구독
- 반드시 구독 해제하여 메모리 누수 방지
- RLS 정책과 Realtime 활성화 필수

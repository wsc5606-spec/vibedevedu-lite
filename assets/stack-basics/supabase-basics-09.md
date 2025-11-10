# Chapter 9: 데이터베이스 트리거 및 함수

## PostgreSQL 함수 이해하기

PostgreSQL 함수는 데이터베이스 내에서 실행되는 재사용 가능한 코드 블록입니다. 복잡한 로직을 캡슐화하고, 트리거와 함께 사용하여 자동화된 데이터 처리를 구현할 수 있습니다.

### 함수의 장점

- **성능**: 데이터베이스 내에서 실행되어 네트워크 오버헤드 없음
- **재사용성**: 여러 곳에서 같은 로직을 재사용
- **자동화**: 트리거와 결합하여 자동 실행
- **트랜잭션 안전성**: 데이터베이스 트랜잭션 내에서 실행

## PostgreSQL 함수 작성하기

### 기본 함수 구조

```sql
CREATE OR REPLACE FUNCTION 함수명(매개변수)
RETURNS 반환타입
LANGUAGE plpgsql
AS $$
DECLARE
  -- 변수 선언
BEGIN
  -- 로직 작성
  RETURN 결과;
END;
$$;
```

### 바데부의 첫 번째 함수: 학습 시간 계산

```sql
-- 사용자의 총 학습 시간을 계산하는 함수
CREATE OR REPLACE FUNCTION calculate_total_hours(user_uuid UUID)
RETURNS DECIMAL(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE
  total_hours DECIMAL(10, 2);
BEGIN
  SELECT COALESCE(SUM(hours_spent), 0)
  INTO total_hours
  FROM learning_records
  WHERE user_id = user_uuid;

  RETURN total_hours;
END;
$$;

-- 함수 호출
SELECT calculate_total_hours('user-uuid-here');
```

### JavaScript에서 함수 호출

```javascript
// RPC를 사용하여 PostgreSQL 함수 호출
async function getBadebuTotalHours(userId) {
  const { data, error } = await supabase
    .rpc('calculate_total_hours', {
      user_uuid: userId
    })

  if (error) {
    console.error('함수 호출 실패:', error)
    return null
  }

  console.log('바데부의 총 학습 시간:', data, '시간')
  return data
}
```

## 트리거 이해하기

트리거는 특정 이벤트(INSERT, UPDATE, DELETE)가 발생할 때 자동으로 실행되는 함수입니다.

### 트리거 타이밍

- **BEFORE**: 작업 실행 전
- **AFTER**: 작업 실행 후
- **INSTEAD OF**: 작업 대신 실행 (주로 뷰에서 사용)

### 트리거 이벤트

- **INSERT**: 새 행 삽입 시
- **UPDATE**: 행 수정 시
- **DELETE**: 행 삭제 시

## 바데부의 실전 예제: 자동 타임스탬프 업데이트

### updated_at 자동 갱신

```sql
-- updated_at을 자동으로 갱신하는 함수
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- learning_records 테이블에 트리거 생성
CREATE TRIGGER update_learning_records_updated_at
  BEFORE UPDATE ON learning_records
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- 다른 테이블에도 같은 트리거 적용
CREATE TRIGGER update_user_profiles_updated_at
  BEFORE UPDATE ON user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

이제 바데부가 학습 기록을 수정하면 updated_at이 자동으로 갱신됩니다!

```javascript
// 수정 시 updated_at을 명시하지 않아도 자동 갱신
await supabase
  .from('learning_records')
  .update({ hours_spent: 5.0 })
  .eq('id', recordId)
// updated_at이 자동으로 NOW()로 설정됨
```

## 사용자 통계 자동 업데이트

### 학습 기록 추가 시 통계 자동 갱신

```sql
-- 사용자 통계 테이블
CREATE TABLE user_statistics (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  total_records INTEGER DEFAULT 0,
  total_hours DECIMAL(10, 2) DEFAULT 0,
  completed_count INTEGER DEFAULT 0,
  last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 통계 업데이트 함수
CREATE OR REPLACE FUNCTION update_user_statistics()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    -- 새 기록 추가 시
    INSERT INTO user_statistics (user_id, total_records, total_hours, completed_count)
    VALUES (
      NEW.user_id,
      1,
      NEW.hours_spent,
      CASE WHEN NEW.completed THEN 1 ELSE 0 END
    )
    ON CONFLICT (user_id) DO UPDATE SET
      total_records = user_statistics.total_records + 1,
      total_hours = user_statistics.total_hours + NEW.hours_spent,
      completed_count = user_statistics.completed_count + CASE WHEN NEW.completed THEN 1 ELSE 0 END,
      last_updated = NOW();

  ELSIF TG_OP = 'UPDATE' THEN
    -- 기록 수정 시
    UPDATE user_statistics SET
      total_hours = total_hours - OLD.hours_spent + NEW.hours_spent,
      completed_count = completed_count
        - CASE WHEN OLD.completed THEN 1 ELSE 0 END
        + CASE WHEN NEW.completed THEN 1 ELSE 0 END,
      last_updated = NOW()
    WHERE user_id = NEW.user_id;

  ELSIF TG_OP = 'DELETE' THEN
    -- 기록 삭제 시
    UPDATE user_statistics SET
      total_records = total_records - 1,
      total_hours = total_hours - OLD.hours_spent,
      completed_count = completed_count - CASE WHEN OLD.completed THEN 1 ELSE 0 END,
      last_updated = NOW()
    WHERE user_id = OLD.user_id;

  END IF;

  RETURN NULL;
END;
$$;

-- 트리거 생성
CREATE TRIGGER update_statistics_on_record_change
  AFTER INSERT OR UPDATE OR DELETE ON learning_records
  FOR EACH ROW
  EXECUTE FUNCTION update_user_statistics();
```

이제 바데부가 학습 기록을 추가/수정/삭제하면 통계가 자동으로 갱신됩니다!

```javascript
// 학습 기록 추가
await supabase
  .from('learning_records')
  .insert({
    subject: 'PostgreSQL 트리거',
    hours_spent: 3.0,
    completed: true
  })

// user_statistics 테이블이 자동으로 업데이트됨!
// - total_records: +1
// - total_hours: +3.0
// - completed_count: +1

// 통계 조회
const { data: stats } = await supabase
  .from('user_statistics')
  .select('*')
  .eq('user_id', userId)
  .single()

console.log('바데부의 통계:', stats)
```

## 데이터 검증 트리거

### 학습 시간 유효성 검사

```sql
-- 학습 시간이 24시간을 초과하지 않도록 검증
CREATE OR REPLACE FUNCTION validate_learning_hours()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.hours_spent < 0 THEN
    RAISE EXCEPTION '학습 시간은 0 이상이어야 합니다';
  END IF;

  IF NEW.hours_spent > 24 THEN
    RAISE EXCEPTION '하루에 24시간 이상 학습할 수 없습니다';
  END IF;

  -- 같은 날 총 학습 시간 확인
  DECLARE
    daily_total DECIMAL(10, 2);
  BEGIN
    SELECT COALESCE(SUM(hours_spent), 0) + NEW.hours_spent
    INTO daily_total
    FROM learning_records
    WHERE user_id = NEW.user_id
      AND DATE(created_at) = DATE(NEW.created_at)
      AND id != COALESCE(NEW.id, '00000000-0000-0000-0000-000000000000'::UUID);

    IF daily_total > 24 THEN
      RAISE EXCEPTION '오늘 총 학습 시간이 24시간을 초과할 수 없습니다 (현재: % 시간)', daily_total;
    END IF;
  END;

  RETURN NEW;
END;
$$;

-- 트리거 생성
CREATE TRIGGER validate_hours_before_insert_update
  BEFORE INSERT OR UPDATE ON learning_records
  FOR EACH ROW
  EXECUTE FUNCTION validate_learning_hours();
```

```javascript
// 잘못된 데이터 입력 시도
try {
  await supabase
    .from('learning_records')
    .insert({
      subject: 'Supabase',
      hours_spent: 30  // 24시간 초과!
    })
} catch (error) {
  console.error('에러:', error.message)
  // '하루에 24시간 이상 학습할 수 없습니다'
}
```

## 자동 알림 생성

### 학습 목표 달성 시 알림

```sql
-- 알림 테이블
CREATE TABLE notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  type VARCHAR(50) NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 학습 목표 달성 시 알림 생성 함수
CREATE OR REPLACE FUNCTION create_achievement_notification()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- 10시간 달성 시
  IF NEW.total_hours >= 10 AND OLD.total_hours < 10 THEN
    INSERT INTO notifications (user_id, title, message, type)
    VALUES (
      NEW.user_id,
      '축하합니다! 🎉',
      '바데부님이 10시간 학습을 달성했습니다!',
      'achievement'
    );
  END IF;

  -- 50시간 달성 시
  IF NEW.total_hours >= 50 AND OLD.total_hours < 50 THEN
    INSERT INTO notifications (user_id, title, message, type)
    VALUES (
      NEW.user_id,
      '대단해요! 🏆',
      '바데부님이 50시간 학습을 달성했습니다!',
      'achievement'
    );
  END IF;

  -- 100개 완료 시
  IF NEW.completed_count >= 100 AND OLD.completed_count < 100 THEN
    INSERT INTO notifications (user_id, title, message, type)
    VALUES (
      NEW.user_id,
      '완벽해요! ⭐',
      '바데부님이 100개의 학습을 완료했습니다!',
      'achievement'
    );
  END IF;

  RETURN NEW;
END;
$$;

-- 트리거 생성
CREATE TRIGGER notify_on_achievement
  AFTER UPDATE ON user_statistics
  FOR EACH ROW
  EXECUTE FUNCTION create_achievement_notification();
```

```javascript
// 바데부가 학습 기록을 추가하면
await supabase
  .from('learning_records')
  .insert({
    subject: 'Supabase Triggers',
    hours_spent: 2.0,
    completed: true
  })

// 통계가 자동 업데이트되고 (update_user_statistics 트리거)
// 목표 달성 시 알림이 자동 생성됨 (notify_on_achievement 트리거)

// 알림 조회
const { data: notifications } = await supabase
  .from('notifications')
  .select('*')
  .eq('is_read', false)
  .order('created_at', { ascending: false })

notifications.forEach(notif => {
  console.log(notif.title, notif.message)
})
```

## 복잡한 함수: 순위 계산

```sql
-- 사용자 순위를 계산하는 함수
CREATE OR REPLACE FUNCTION get_user_rank(target_user_id UUID)
RETURNS TABLE (
  rank BIGINT,
  total_users BIGINT,
  percentile NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  WITH ranked_users AS (
    SELECT
      user_id,
      total_hours,
      RANK() OVER (ORDER BY total_hours DESC) as user_rank
    FROM user_statistics
  ),
  total_count AS (
    SELECT COUNT(*) as total FROM user_statistics
  )
  SELECT
    ru.user_rank,
    tc.total,
    ROUND((ru.user_rank::NUMERIC / tc.total) * 100, 2) as percentile
  FROM ranked_users ru, total_count tc
  WHERE ru.user_id = target_user_id;
END;
$$;
```

```javascript
// 바데부의 순위 조회
async function getBadebuRank(userId) {
  const { data, error } = await supabase
    .rpc('get_user_rank', {
      target_user_id: userId
    })

  if (error) {
    console.error('순위 조회 실패:', error)
    return null
  }

  const rank = data[0]
  console.log(`바데부는 전체 ${rank.total_users}명 중 ${rank.rank}등입니다!`)
  console.log(`상위 ${rank.percentile}%에 속합니다`)
  return rank
}
```

## 스케줄링: pg_cron 사용하기

### 매일 자정에 데이터 정리

```sql
-- pg_cron 확장 활성화 (Supabase Dashboard > Database > Extensions)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- 매일 자정에 오래된 알림 삭제
SELECT cron.schedule(
  'delete-old-notifications',
  '0 0 * * *',  -- 매일 자정
  $$
    DELETE FROM notifications
    WHERE created_at < NOW() - INTERVAL '30 days'
      AND is_read = TRUE;
  $$
);

-- 매주 월요일 아침 8시에 주간 통계 생성
SELECT cron.schedule(
  'weekly-stats',
  '0 8 * * 1',  -- 매주 월요일 8시
  $$
    INSERT INTO weekly_reports (user_id, total_hours, created_at)
    SELECT
      user_id,
      SUM(hours_spent),
      NOW()
    FROM learning_records
    WHERE created_at >= NOW() - INTERVAL '7 days'
    GROUP BY user_id;
  $$
);

-- 스케줄 조회
SELECT * FROM cron.job;

-- 스케줄 삭제
SELECT cron.unschedule('delete-old-notifications');
```

## 일반적인 실수와 해결방법

### 실수 1: 무한 루프 트리거

```sql
-- ❌ 무한 루프 발생 가능
CREATE TRIGGER dangerous_trigger
  AFTER UPDATE ON table_a
  FOR EACH ROW
  EXECUTE FUNCTION update_table_a();
-- update_table_a() 함수가 다시 table_a를 업데이트하면 무한 루프

-- ✅ 조건 추가로 방지
CREATE OR REPLACE FUNCTION update_table_a()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.some_column != OLD.some_column THEN
    -- 업데이트 로직
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### 실수 2: RETURN 누락

```sql
-- ❌ RETURN 누락
CREATE FUNCTION my_trigger()
RETURNS TRIGGER AS $$
BEGIN
  -- 로직
  -- RETURN 없음!
END;
$$ LANGUAGE plpgsql;

-- ✅ 항상 RETURN
CREATE FUNCTION my_trigger()
RETURNS TRIGGER AS $$
BEGIN
  -- 로직
  RETURN NEW;  -- BEFORE 트리거는 NEW 또는 OLD 반환
END;
$$ LANGUAGE plpgsql;
```

### 실수 3: OLD/NEW 혼동

```sql
-- ❌ DELETE 트리거에서 NEW 사용
CREATE TRIGGER delete_trigger
  AFTER DELETE ON table_a
  FOR EACH ROW
  EXECUTE FUNCTION my_function();

CREATE FUNCTION my_function()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO logs (data) VALUES (NEW.id);  -- NEW는 NULL!
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- ✅ DELETE는 OLD 사용
CREATE FUNCTION my_function()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO logs (data) VALUES (OLD.id);  -- OLD 사용
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

### 실수 4: 성능 문제

```sql
-- ❌ 트리거 안에서 복잡한 쿼리
CREATE FUNCTION slow_trigger()
RETURNS TRIGGER AS $$
BEGIN
  -- 매 행마다 복잡한 집계 쿼리 실행
  PERFORM calculate_complex_stats();  -- 느림!
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ✅ 배치 처리나 스케줄링 사용
-- 트리거 대신 pg_cron으로 주기적으로 실행
```

## 실습 과제

1. **자동 slug 생성**: 제목이 입력되면 URL용 slug를 자동 생성하는 트리거
2. **포인트 시스템**: 학습 완료 시 포인트를 자동으로 부여하는 함수와 트리거
3. **중복 방지**: 같은 과목을 같은 날에 중복 추가하지 못하도록 검증 트리거
4. **감사 로그**: 모든 변경사항을 audit_logs 테이블에 기록하는 트리거

## 다음 장 미리보기

마지막 장에서는 Supabase 애플리케이션을 프로덕션에 배포하는 방법과 모범 사례를 배웁니다. 성능 최적화, 보안, 모니터링, 백업 등을 다룹니다.

## 핵심 요약

- PostgreSQL 함수로 복잡한 로직을 캡슐화
- 트리거로 자동화된 데이터 처리 구현
- BEFORE 트리거로 데이터 검증
- AFTER 트리거로 연관 데이터 자동 업데이트
- pg_cron으로 스케줄링 작업 실행
- 무한 루프와 성능 문제 주의
- RPC로 JavaScript에서 함수 호출

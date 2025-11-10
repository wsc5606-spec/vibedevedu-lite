# 📚 Supabase 650개 챌린지 업로드 가이드

## 🎯 개요

총 **650개의 프로그래밍 챌린지** (13개 언어 × 50문제)를 Supabase에 업로드하는 방법입니다.

## 📁 파일 구성

1. **`1-DELETE-OLD-DATA.sql`** (Step 1)
   - 기존 challenges 테이블 삭제
   - 크기: 약 1 KB
   - 실행 시간: ~1초

2. **`2-CREATE-AND-INSERT.sql`** (Step 2)
   - 테이블 생성 + 650개 챌린지 삽입
   - 크기: 약 460 KB
   - 실행 시간: ~5-10초

## 🚀 업로드 방법 (2단계)

### ⚠️ 중요: 반드시 순서대로 실행하세요!

### Step 1: 기존 데이터 삭제

1. **Supabase Dashboard** 접속
2. 좌측 메뉴 **"SQL Editor"** 클릭
3. **"New query"** 버튼 클릭
4. **`1-DELETE-OLD-DATA.sql`** 파일 열기
5. 전체 내용 복사 (Ctrl+A → Ctrl+C)
6. SQL Editor에 붙여넣기 (Ctrl+V)
7. **"Run"** 버튼 클릭 ▶️
8. ✅ 성공 메시지 확인:
   ```
   기존 challenges 테이블이 삭제되었습니다.
   이제 2-CREATE-AND-INSERT.sql 파일을 실행하세요.
   ```

### Step 2: 테이블 생성 및 데이터 삽입

1. SQL Editor에서 **새로운 쿼리 탭** 열기
2. **`2-CREATE-AND-INSERT.sql`** 파일 열기
3. 전체 내용 복사 (Ctrl+A → Ctrl+C)
4. SQL Editor에 붙여넣기 (Ctrl+V)
5. **"Run"** 버튼 클릭 ▶️
6. ✅ 성공 메시지 확인:
   ```
   테이블이 성공적으로 생성되었습니다.
   이제 데이터를 삽입합니다...
   ```
7. 650개 INSERT 문 실행 완료 대기 (약 5-10초)

## ✅ 완료 확인

업로드가 성공하면:

1. Supabase Dashboard > **Table Editor** 이동
2. **challenges** 테이블 선택
3. 데이터 확인:
   - 총 행(row) 수: **650개**
   - 언어별: 각 50개씩

### 간단한 확인 쿼리:

```sql
-- 전체 챌린지 수
SELECT COUNT(*) FROM challenges;
-- 결과: 650

-- 언어별 챌린지 수
SELECT language, COUNT(*)
FROM challenges
GROUP BY language
ORDER BY language;
-- 결과: 각 언어당 50개씩
```

## 📊 데이터 구조

### challenges 테이블 스키마:

| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| `id` | UUID | 고유 ID (자동 생성) |
| `slug` | TEXT | URL-friendly 식별자 |
| `language` | TEXT | 프로그래밍 언어 |
| `kind` | TEXT | 문제 유형 (syntax/algorithm) |
| `level` | INTEGER | 난이도 레벨 (1-50) |
| `title` | TEXT | 제목 |
| `description` | TEXT | 설명 |
| `difficulty` | INTEGER | 난이도 (1-3) |
| `problem_description` | TEXT | 문제 설명 |
| `constraints` | TEXT | 제약 조건 |
| `examples` | JSONB | 예제 |
| `initial_code` | TEXT | 초기 코드 |
| `solution_code` | TEXT | 정답 코드 |
| `test_cases` | JSONB | 테스트 케이스 |
| `hints` | JSONB | 힌트 |
| `tags` | JSONB | 태그 |
| `estimated_time` | INTEGER | 예상 소요 시간 (분) |

### 포함된 언어 (13개):

1. HTML (50 challenges)
2. CSS (50 challenges)
3. JavaScript (50 challenges)
4. TypeScript (50 challenges)
5. Python (50 challenges)
6. Dart (50 challenges)
7. Kotlin (50 challenges)
8. C# (50 challenges)
9. Java (50 challenges)
10. Go (50 challenges)
11. C (50 challenges)
12. C++ (50 challenges)
13. SQL (50 challenges)

## 🔧 문제 해결

### 문제: "relation challenges does not exist"
**해결:** Step 1을 먼저 실행하세요.

### 문제: "duplicate key value violates unique constraint"
**해결:** Step 1을 다시 실행한 후 Step 2를 실행하세요.

### 문제: 실행이 너무 오래 걸림
**해결:**
- 인터넷 연결 확인
- Supabase 프로젝트 상태 확인
- 브라우저 새로고침 후 재시도

### 문제: 일부 데이터만 삽입됨
**해결:**
1. 현재 데이터 수 확인: `SELECT COUNT(*) FROM challenges;`
2. Step 1 실행 (삭제)
3. Step 2 다시 실행

## 📝 참고사항

- **백업**: 기존 데이터가 중요한 경우 먼저 백업하세요
- **실행 시간**: 총 약 10-15초 소요
- **네트워크**: 안정적인 인터넷 연결 필요
- **권한**: Supabase 프로젝트의 관리자 권한 필요

## 🎉 완료!

모든 단계를 완료하면 650개의 챌린지를 사용할 수 있습니다!

앱에서 다음과 같이 쿼리하세요:

```dart
// 전체 챌린지 가져오기
final challenges = await supabase
  .from('challenges')
  .select()
  .order('level');

// 특정 언어 챌린지 가져오기
final htmlChallenges = await supabase
  .from('challenges')
  .select()
  .eq('language', 'html')
  .order('level');

// 난이도별 챌린지
final easyChallenges = await supabase
  .from('challenges')
  .select()
  .eq('difficulty', 1)
  .order('level');
```

---

**생성일**: 2025-11-10
**버전**: 1.0
**총 챌린지**: 650개

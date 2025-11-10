# 📚 챌린지 추가 가이드

## 🎯 개요
- **총 1,300개 챌린지** (13개 언어 × 100문제)
- **26개 SQL 파일** (각 언어당 Part 1 + Part 2)
- 각 파일당 **50개 챌린지** 포함

## 📋 실행 순서

### ⚠️ **중요: 먼저 이것부터!**

**1단계: 테이블 컬럼 추가** (반드시 먼저 실행!)
- 📄 `../add-challenge-columns.sql` 실행
- 이 파일은 모든 챌린지 테이블에 필요한 컬럼을 추가합니다
- **한 번만 실행하면 됩니다!**

### ✅ Supabase 대시보드에서 실행하기

1. **Supabase 대시보드 접속**
   - https://supabase.com/dashboard
   - 프로젝트 선택: `soweluoqppldiybgonkc`

2. **SQL Editor 열기**
   - 왼쪽 메뉴에서 `SQL Editor` 클릭
   - `New query` 클릭

3. **파일 내용 복사 & 실행**
   - 아래 순서대로 파일을 열어서
   - 전체 내용을 복사 (Ctrl+A, Ctrl+C)
   - SQL Editor에 붙여넣기 (Ctrl+V)
   - `Run` 버튼 클릭 또는 `Ctrl+Enter`

---

## 📂 실행 파일 목록 (순서대로)

### 1️⃣ C 언어 (100개)
- [ ] `c-part1.sql` (50개 - EASY)
- [ ] `c-part2.sql` (50개 - MEDIUM/HARD)

### 2️⃣ C++ (100개)
- [ ] `cpp-part1.sql` (50개 - EASY)
- [ ] `cpp-part2.sql` (50개 - MEDIUM/HARD)

### 3️⃣ C# (100개)
- [ ] `csharp-part1.sql` (50개 - EASY)
- [ ] `csharp-part2.sql` (50개 - MEDIUM/HARD)

### 4️⃣ Dart (100개)
- [ ] `dart-part1.sql` (50개 - EASY)
- [ ] `dart-part2.sql` (50개 - MEDIUM/HARD)

### 5️⃣ Go (100개)
- [ ] `go-part1.sql` (50개 - EASY)
- [ ] `go-part2.sql` (50개 - MEDIUM/HARD)

### 6️⃣ Java (100개)
- [ ] `java-part1.sql` (50개 - EASY)
- [ ] `java-part2.sql` (50개 - MEDIUM/HARD)

### 7️⃣ JavaScript (100개)
- [ ] `javascript-part1.sql` (50개 - EASY)
- [ ] `javascript-part2.sql` (50개 - MEDIUM/HARD)

### 8️⃣ Kotlin (100개)
- [ ] `kotlin-part1.sql` (50개 - EASY)
- [ ] `kotlin-part2.sql` (50개 - MEDIUM/HARD)

### 9️⃣ Python (100개)
- [ ] `python-part1.sql` (50개 - EASY)
- [ ] `python-part2.sql` (50개 - MEDIUM/HARD)

### 🔟 TypeScript (100개)
- [ ] `typescript-part1.sql` (50개 - EASY)
- [ ] `typescript-part2.sql` (50개 - MEDIUM/HARD)

### 1️⃣1️⃣ SQL (100개)
- [ ] `sql-part1.sql` (50개 - EASY)
- [ ] `sql-part2.sql` (50개 - MEDIUM/HARD)

### 1️⃣2️⃣ HTML (100개)
- [ ] `html-part1.sql` (50개 - EASY)
- [ ] `html-part2.sql` (50개 - MEDIUM/HARD)

### 1️⃣3️⃣ CSS (100개)
- [ ] `css-part1.sql` (50개 - EASY)
- [ ] `css-part2.sql` (50개 - MEDIUM/HARD)

---

## ⚠️ 중요 사항

### ✅ 성공 확인 방법
각 SQL 실행 후 하단에 다음 메시지가 표시되면 성공:
```
✅ [언어] Part X 완료 (50 challenges)
```

### 🔴 에러 발생 시
1. **중복 데이터 에러** (`duplicate key value`)
   - 이미 해당 챌린지가 존재함
   - 안전하게 무시 가능

2. **테이블 없음 에러** (`relation does not exist`)
   - 해당 언어의 테이블이 생성되지 않음
   - v2.7 마이그레이션 먼저 실행 필요

3. **타임아웃 에러**
   - SQL이 너무 큼
   - 파일을 반으로 나눠서 실행

### 💡 팁
- 각 파일 실행 후 **결과 확인** 후 다음 파일로
- 에러 발생 시 **스크린샷** 찍어두기
- 한 번에 여러 파일 실행하지 말고 **하나씩** 실행

---

## 📊 진행 상황 체크

### 언어별 완료 체크
```
[ ] C (100)
[ ] C++ (100)
[ ] C# (100)
[ ] Dart (100)
[ ] Go (100)
[ ] Java (100)
[ ] JavaScript (100)
[ ] Kotlin (100)
[ ] Python (100)
[ ] TypeScript (100)
[ ] SQL (100)
[ ] HTML (100)
[ ] CSS (100)
```

**총 진행률: _____ / 1,300 챌린지**

---

## 🎉 완료 후 확인

모든 파일 실행 후 데이터베이스에서 확인:

```sql
-- 언어별 챌린지 개수 확인
SELECT
  'C' as language, COUNT(*) FROM challenges_c
UNION ALL
SELECT 'C++', COUNT(*) FROM challenges_cpp
UNION ALL
SELECT 'C#', COUNT(*) FROM challenges_csharp
UNION ALL
SELECT 'Dart', COUNT(*) FROM challenges_dart
UNION ALL
SELECT 'Go', COUNT(*) FROM challenges_go
UNION ALL
SELECT 'Java', COUNT(*) FROM challenges_java
UNION ALL
SELECT 'JavaScript', COUNT(*) FROM challenges_javascript
UNION ALL
SELECT 'Kotlin', COUNT(*) FROM challenges_kotlin
UNION ALL
SELECT 'Python', COUNT(*) FROM challenges_python
UNION ALL
SELECT 'TypeScript', COUNT(*) FROM challenges_typescript
UNION ALL
SELECT 'SQL', COUNT(*) FROM challenges_sql
UNION ALL
SELECT 'HTML', COUNT(*) FROM challenges_html
UNION ALL
SELECT 'CSS', COUNT(*) FROM challenges_css;
```

각 언어당 **100개**씩 표시되어야 합니다!

---

## 📞 문제 발생 시

1. 에러 메시지 스크린샷
2. 어느 파일에서 발생했는지 메모
3. 나한테 알려주기

**화이팅! 🚀**

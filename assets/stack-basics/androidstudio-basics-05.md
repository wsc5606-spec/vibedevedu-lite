# Chapter 5: 디버깅 도구

버그는 개발의 일부입니다! Android Studio의 강력한 디버깅 도구를 사용하면 문제를 빠르게 찾고 해결할 수 있어요.

## 5.1 Logcat 소개

Logcat은 Android 앱의 로그를 실시간으로 보여주는 도구입니다.

**Logcat 열기:**
- View → Tool Windows → Logcat
- 단축키: `Alt + 6`

**로그 레벨:**
```text
V (Verbose) - 상세한 정보 (개발 중)
D (Debug)   - 디버그 정보
I (Info)    - 일반 정보
W (Warning) - 경고
E (Error)   - 에러
A (Assert)  - 치명적 에러
```

```text
바데부: "Logcat은 앱에서 무슨 일이 일어나는지 보여주는 창이야!
       println()보다 Log를 쓰는 게 훨씬 전문적이고 관리하기 쉬워."
```

## 5.2 Log 사용하기

**기본 사용법:**
```kotlin
import android.util.Log

class MainActivity : AppCompatActivity() {
    private val TAG = "MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        Log.v(TAG, "Verbose 로그")
        Log.d(TAG, "Debug 로그")
        Log.i(TAG, "Info 로그")
        Log.w(TAG, "Warning 로그")
        Log.e(TAG, "Error 로그")
    }
}
```

**변수 값 로깅:**
```kotlin
val userName = "바데부"
val age = 25
Log.d(TAG, "사용자: $userName, 나이: $age")

// 객체 로깅
val user = User("바데부", 25)
Log.d(TAG, "사용자 정보: $user")
```

**예외 로깅:**
```kotlin
try {
    // 위험한 코드
} catch (e: Exception) {
    Log.e(TAG, "에러 발생!", e)
}
```

```text
바데부: "TAG는 보통 클래스 이름으로 정해!
       그러면 Logcat에서 필터링하기 쉬워."
```

## 5.3 Logcat 필터링

**패키지로 필터링:**
```text
Logcat 상단의 드롭다운에서:
- Show only selected application
- No Filters (모두 보기)
- Firebase (특정 라이브러리)
```

**텍스트로 검색:**
```text
검색창에 입력:
- MainActivity       → MainActivity 포함된 로그만
- tag:MainActivity   → TAG가 MainActivity인 것만
- level:error        → Error 레벨만
```

**정규식 검색:**
```text
Regex 버튼 활성화 후:
- user.*name         → user로 시작, name 포함
- ^Error:            → Error:로 시작하는 것
```

```text
바데부: "로그가 너무 많을 땐 필터링이 필수야!
       내가 원하는 로그만 보면 문제를 훨씬 빨리 찾을 수 있어."
```

## 5.4 Debugger 기초

**디버거 시작:**
- 디버그 모드로 실행: `Shift + F9`
- 또는 상단 툴바에서 벌레 아이콘 클릭

**브레이크포인트 설정:**
- 줄 번호 왼쪽 클릭 (빨간 점 생성)
- 단축키: `Ctrl + F8`

```kotlin
fun calculateSum(a: Int, b: Int): Int {
    val result = a + b  // ← 여기 브레이크포인트 설정
    return result
}
```

```text
바데부: "브레이크포인트를 설정하면 그 줄에서 실행이 멈춰!
       그때 변수 값을 확인하고 한 줄씩 실행해볼 수 있어."
```

## 5.5 디버거 단계별 실행

**실행 제어:**
- `F8` (Step Over): 다음 줄로 (함수는 건너뛰기)
- `F7` (Step Into): 함수 내부로 들어가기
- `Shift + F8` (Step Out): 함수에서 빠져나오기
- `F9` (Resume): 다음 브레이크포인트까지 실행
- `Ctrl + F2` (Stop): 디버깅 중단

**예제:**
```kotlin
fun onCreate() {
    val x = 10           // 브레이크포인트
    val y = 20           // F8 누르면 여기로
    val sum = add(x, y)  // F7 누르면 add 함수 안으로
    Log.d(TAG, "$sum")   // F8로 계속 진행
}

fun add(a: Int, b: Int): Int {
    return a + b         // Step Into했을 때 여기 도착
}
```

```text
바데부: "F8은 빠르게 진행, F7은 자세히 들여다볼 때!
       함수가 제대로 동작하는지 확인하려면 F7로 들어가봐."
```

## 5.6 Variables 창

디버깅 중에 모든 변수의 현재 값을 볼 수 있어요.

**Variables 창 정보:**
```text
Name         Value           Type
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
this         MainActivity@123 MainActivity
userName     "바데부"         String
age          25              Int
user         User@456        User
  └─ name    "바데부"         String
  └─ age     25              Int
```

**변수 값 변경:**
- 변수 우클릭 → Set Value
- 디버깅 중에 값을 바꿔서 테스트 가능!

```text
바데부: "Variables 창에서 객체를 펼치면 내부 속성까지 다 볼 수 있어!
       복잡한 객체의 상태를 확인할 때 정말 유용해."
```

## 5.7 Watches (감시 표현식)

특정 변수나 표현식을 계속 감시할 수 있어요.

**Watch 추가:**
1. Watches 탭 클릭
2. "+" 버튼 클릭
3. 표현식 입력

**유용한 Watch 예제:**
```kotlin
// 간단한 변수
userName

// 표현식
userName.length

// 조건식
age >= 18

// 함수 호출
isValidUser(user)

// 복잡한 표현식
list.filter { it.age > 20 }.size
```

```text
바데부: "Watch에 추가하면 매 단계마다 자동으로 값을 계산해서 보여줘!
       복잡한 조건을 확인할 때 정말 편해."
```

## 5.8 조건부 브레이크포인트

특정 조건일 때만 멈추는 브레이크포인트!

**설정 방법:**
1. 브레이크포인트 우클릭
2. "Edit Breakpoint" 또는 "More" 클릭
3. Condition 입력

**예제:**
```kotlin
for (i in 0 until 100) {
    val result = calculate(i)  // 브레이크포인트
    // Condition: i == 50
    // → i가 50일 때만 멈춤!
}
```

**유용한 조건:**
```text
- i == 10                   → i가 10일 때
- userName == null          → userName이 null일 때
- list.size > 100           → 리스트 크기가 100 이상일 때
- userName.contains("Error") → userName에 "Error" 포함될 때
```

```text
바데부: "루프에서 특정 상황만 디버깅하고 싶을 때 조건부 브레이크포인트가 정말 유용해!
       매번 멈추지 않고 원하는 순간만 멈출 수 있어."
```

## 5.9 예외 브레이크포인트

예외가 발생하면 자동으로 멈추게 할 수 있어요.

**설정 방법:**
1. Run → View Breakpoints (Ctrl + Shift + F8)
2. "+" 클릭 → Java Exception Breakpoints
3. 예외 클래스 입력 (예: NullPointerException)

**활용:**
```kotlin
fun getUserName(): String? {
    return null
}

fun main() {
    val name = getUserName()!!  // NullPointerException 발생
    // 예외 브레이크포인트 설정했다면 여기서 자동으로 멈춤!
}
```

```text
바데부: "앱이 갑자기 크래시될 때 예외 브레이크포인트를 설정하면
       정확히 어디서 문제가 생기는지 바로 알 수 있어!"
```

## 5.10 Evaluate Expression

디버깅 중에 코드를 실행해볼 수 있어요!

**사용 방법:**
- 단축키: `Alt + F8`
- 또는 우클릭 → Evaluate Expression

**예제:**
```kotlin
// 디버깅 중 멈춘 상태에서
userName.uppercase()         // "바데부" → "바데부" (대문자 변환 결과 확인)
list.filter { it.age > 20 }  // 필터링 결과 미리보기
calculateTotal()             // 함수 실행해보기
```

```text
바데부: "Evaluate Expression은 정말 강력해!
       코드를 수정하지 않고도 여러 시나리오를 테스트해볼 수 있어."
```

## 5.11 Profiler 소개

앱의 성능을 분석하는 도구입니다.

**Profiler 열기:**
- View → Tool Windows → Profiler
- 또는 Run → Profile 'app'

**측정 항목:**
- **CPU**: CPU 사용률 및 함수 호출 추적
- **Memory**: 메모리 사용량 및 누수 확인
- **Network**: 네트워크 요청 모니터링
- **Energy**: 배터리 소모량 분석

```text
바데부: "앱이 느리거나 배터리를 많이 쓴다면 Profiler로 원인을 찾아!
       어떤 함수가 느린지, 어디서 메모리를 많이 쓰는지 알 수 있어."
```

## 5.12 Memory Profiler

**메모리 누수 찾기:**
1. Profiler에서 MEMORY 탭 클릭
2. 앱 사용하면서 메모리 그래프 확인
3. "Dump Java heap" 클릭
4. 메모리 스냅샷 분석

**확인할 것:**
- Shallow Size: 객체 자체 크기
- Retained Size: 객체가 참조하는 모든 크기
- Instance Count: 인스턴스 개수

```text
📸 스크린샷 위치: Memory Profiler 화면
   - 시간에 따른 메모리 사용 그래프
   - 객체별 메모리 사용량 표
   - Allocation/Deallocation 추적
```

```text
바데부: "Activity가 종료됐는데도 메모리에 남아있다면 메모리 누수야!
       Profiler로 찾아서 고쳐야 해."
```

## 5.13 CPU Profiler

**성능 병목 찾기:**
1. Profiler에서 CPU 탭 클릭
2. "Record" 버튼 클릭
3. 앱의 느린 작업 수행
4. "Stop" 버튼 클릭
5. 함수별 실행 시간 분석

**Flame Chart:**
- 가로 길이: 실행 시간
- 세로: 함수 호출 스택
- 넓은 막대가 느린 함수!

```text
바데부: "어떤 함수가 시간을 많이 잡아먹는지 한눈에 볼 수 있어!
       그 함수를 최적화하면 앱이 빨라져."
```

## 5.14 Network Profiler

**네트워크 요청 모니터링:**
1. Profiler에서 NETWORK 탭 클릭
2. 앱에서 네트워크 요청 수행
3. 각 요청 클릭하여 상세 정보 확인

**확인할 수 있는 정보:**
- 요청 URL
- 응답 시간
- 요청/응답 헤더
- 요청/응답 본문
- 응답 코드

```text
바데부: "API 호출이 제대로 되는지, 얼마나 시간이 걸리는지 확인할 수 있어!
       네트워크 문제를 디버깅할 때 정말 유용해."
```

## 5.15 Database Inspector

**데이터베이스 실시간 확인:**
1. View → Tool Windows → App Inspection
2. Database Inspector 탭 선택
3. 실행 중인 앱의 DB 확인

**기능:**
- 테이블 구조 확인
- 데이터 실시간 조회
- SQL 쿼리 실행
- 데이터 수정 (개발 중에만)

```text
바데부: "Room이나 SQLite를 쓴다면 Database Inspector가 정말 편해!
       앱을 다시 시작할 필요 없이 DB를 바로 확인할 수 있어."
```

## 5.16 Layout Inspector

**UI 구조 분석:**
1. Tools → Layout Inspector
2. 실행 중인 앱 선택
3. 3D로 UI 계층 확인

**확인할 수 있는 것:**
- 뷰 계층 구조
- 각 뷰의 속성
- 실제 크기와 위치
- 겹쳐진 뷰 확인

```text
📸 스크린샷 위치: Layout Inspector 3D 뷰
   - UI가 3D로 분해된 모습
   - 각 레이어가 분리되어 보임
   - 속성 패널에 상세 정보
```

```text
바데부: "UI가 왜 이상하게 보이는지 모르겠을 때 Layout Inspector를 써봐!
       뷰가 어떻게 배치됐는지 3D로 볼 수 있어서 문제를 쉽게 찾을 수 있어."
```

## 5.17 일반적인 에러 해결

**NullPointerException:**
```kotlin
// 잘못된 코드
val name: String? = null
val length = name.length  // 💥 크래시!

// 올바른 코드
val name: String? = null
val length = name?.length ?: 0  // 안전하게 처리
```

**ClassCastException:**
```kotlin
// 잘못된 코드
val view = findViewById(R.id.myButton)
val textView = view as TextView  // 💥 Button을 TextView로 캐스팅!

// 올바른 코드
val button = findViewById<Button>(R.id.myButton)
```

**ResourceNotFoundException:**
```kotlin
// 잘못된 코드
setContentView(R.layout.activity_main)  // 파일 없음!

// 해결: layout 폴더에 activity_main.xml 있는지 확인
// Build → Clean Project → Rebuild Project
```

```text
바데부: "에러 메시지를 잘 읽어봐! 어디서 문제가 생겼는지 알려줘.
       스택 트레이스의 첫 번째 줄이 가장 중요해!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Logcat으로 로그 확인하고 필터링하기
- ✅ Debugger로 브레이크포인트 설정하고 단계별 실행
- ✅ Profiler로 성능 분석하기
- ✅ Database Inspector로 DB 확인하기
- ✅ Layout Inspector로 UI 구조 분석하기

```text
바데부: "디버깅 도구를 잘 쓰면 버그를 10배 빠르게 찾을 수 있어!
       다음 챕터에서는 에뮬레이터와 실제 기기에서 앱을 테스트하는 방법을 배워볼 거야.
       다양한 환경에서 테스트하는 게 얼마나 중요한지 알려줄게!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 에뮬레이터 고급 설정
- 실제 기기 연결 및 테스트
- 다양한 화면 크기 테스트
- USB 디버깅 설정

**바데부와 함께 Android Studio 마스터하기! 화이팅!**

# Chapter 3: 에디터 기능과 단축키

Android Studio의 강력한 에디터 기능을 배우면 코딩 속도가 10배는 빨라집니다! 단축키와 자동화 기능을 마스터해봐요.

## 3.1 코드 자동완성 (Intellisense)

Android Studio는 입력하면서 자동으로 제안해줍니다.

**기본 자동완성:**
```kotlin
// "over"까지만 입력하면
over  ← 여기서 Ctrl + Space

// 자동완성 목록이 나타남
override fun onCreate()
override fun onStart()
...
```

**강제 자동완성:**
- `Ctrl + Space`: 기본 자동완성
- `Ctrl + Shift + Space`: 스마트 자동완성 (타입에 맞는 것만)
- `Ctrl + Shift + Enter`: 현재 문장 완성

```text
바데부: "자동완성은 개발자의 절친이야!
       함수 이름 일부만 입력하고 Ctrl + Space하면 다 나와!"
```

## 3.2 코드 생성 단축키

**주요 코드 생성:**
- `Ctrl + O`: Override 메서드 생성
- `Ctrl + I`: Interface 메서드 구현
- `Alt + Insert`: Generate 메뉴 (생성자, getter/setter 등)

**예제:**
```kotlin
class MyActivity : AppCompatActivity() {
    // Ctrl + O를 누르면
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 자동 생성됨!
    }
}
```

```text
바데부: "Override할 메서드를 일일이 타이핑할 필요 없어!
       Ctrl + O 누르고 선택하면 끝!"
```

## 3.3 리팩토링 단축키

**자주 쓰는 리팩토링:**

**1. 이름 변경 (Rename):**
```kotlin
// oldName을 선택하고 Shift + F6
val oldName = "Hello"  // → newName으로 한 번에 변경됨
println(oldName)       // → println(newName)
```

**2. 변수 추출 (Extract Variable):**
```kotlin
// Ctrl + Alt + V
println("Hello " + userName + "!")

// 선택 후 단축키 누르면
val message = "Hello " + userName + "!"
println(message)
```

**3. 메서드 추출 (Extract Method):**
```kotlin
// Ctrl + Alt + M
// 코드 블록 선택 후 단축키
fun onCreate() {
    val user = getUser()
    validateUser(user)
    saveUser(user)
}

// 추출됨
fun onCreate() {
    processUser()
}

private fun processUser() {
    val user = getUser()
    validateUser(user)
    saveUser(user)
}
```

```text
바데부: "리팩토링은 코드를 깔끔하게 정리하는 거야.
       단축키 하나로 안전하게 코드를 개선할 수 있어!"
```

## 3.4 네비게이션 단축키

**파일 및 코드 탐색:**
- `Ctrl + N`: 클래스로 이동
- `Ctrl + Shift + N`: 파일로 이동
- `Ctrl + Alt + Shift + N`: 심볼(함수, 변수)로 이동
- `Ctrl + B` 또는 `Ctrl + Click`: 정의로 이동
- `Ctrl + Alt + B`: 구현으로 이동
- `Alt + F7`: 사용처 찾기

**예제:**
```kotlin
// setContentView 위에 커서 놓고 Ctrl + B
setContentView(R.layout.activity_main)
// → activity_main.xml 파일로 이동!
```

```text
바데부: "Ctrl + B는 내가 제일 자주 쓰는 단축키야!
       함수가 어디 정의됐는지 찾을 때 정말 편해."
```

## 3.5 편집 단축키

**효율적인 편집:**
- `Ctrl + D`: 현재 줄 복제
- `Ctrl + Y`: 현재 줄 삭제
- `Ctrl + /`: 줄 주석 토글
- `Ctrl + Shift + /`: 블록 주석 토글
- `Alt + Up/Down`: 메서드 간 이동
- `Ctrl + Shift + Up/Down`: 줄 이동

**예제:**
```kotlin
// val name = "바데부" ← 여기서 Ctrl + D
val name = "바데부"
val name = "바데부"  // 복제됨!

// 선택 후 Ctrl + /
// val name = "바데부"  // 주석 처리됨
```

```text
바데부: "Ctrl + D로 줄 복제하고, Ctrl + Y로 삭제하고...
       마우스 없이도 코딩할 수 있어!"
```

## 3.6 멀티 커서 (Multiple Cursors)

여러 곳을 동시에 수정할 수 있는 강력한 기능!

**멀티 커서 만들기:**
- `Alt + J`: 다음 같은 단어 선택 (Mac: Ctrl + G)
- `Ctrl + Alt + Shift + J`: 모두 선택
- `Alt + Shift + Click`: 원하는 위치에 커서 추가
- `Alt + Shift + Insert`: 열 선택 모드 (Column Selection)

**예제:**
```kotlin
val name1 = "홍길동"
val name2 = "김철수"
val name3 = "이영희"

// name 위에 커서 두고 Alt + J 세 번
// 세 개의 name이 모두 선택됨
// 그 상태로 타이핑하면 동시에 변경!
val userName1 = "홍길동"
val userName2 = "김철수"
val userName3 = "이영희"
```

```text
바데부: "멀티 커서는 진짜 마법같아!
       같은 작업을 여러 번 반복할 필요가 없어."
```

## 3.7 Live Templates

자주 쓰는 코드 패턴을 약어로 빠르게 입력!

**내장 템플릿:**
```kotlin
// "fori" 입력 후 Tab
for (i in 0 until ) {

}

// "fun0" 입력 후 Tab
fun name() {

}

// "logd" 입력 후 Tab
Log.d(TAG, "")

// "Toast" 입력 후 Tab
Toast.makeText(this, "", Toast.LENGTH_SHORT).show()
```

**더 많은 템플릿:**
- `sout`: println()
- `psvm`: main 함수
- `ifn`: if (x == null)
- `inn`: if (x != null)
- `todo`: TODO 주석

```text
바데부: "Live Templates 외워두면 코딩이 정말 빨라져!
       자주 쓰는 코드는 템플릿으로 만들어두는 게 좋아."
```

## 3.8 커스텀 Live Template 만들기

**나만의 템플릿 만들기:**
1. Settings → Editor → Live Templates
2. "+" 클릭 → Live Template 추가
3. Abbreviation: 약어 (예: mylog)
4. Description: 설명
5. Template text: 코드 패턴

**예제 템플릿:**
```kotlin
// Abbreviation: mylog
// Template text:
Log.d("바데부", "$END$")

// 사용:
mylog [Tab]
// → Log.d("바데부", "")
```

```text
바데부: "자주 쓰는 코드가 있다면 템플릿으로 만들어봐!
       시간이 엄청 절약돼."
```

## 3.9 코드 포맷팅

**자동 정렬:**
- `Ctrl + Alt + L`: 코드 포맷팅
- `Ctrl + Alt + O`: Import 최적화
- `Ctrl + Alt + I`: 들여쓰기 자동 조정

**Before:**
```kotlin
class MainActivity:AppCompatActivity(){
override fun onCreate(savedInstanceState:Bundle?){
super.onCreate(savedInstanceState)
setContentView(R.layout.activity_main)
}}
```

**After (Ctrl + Alt + L):**
```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}
```

```text
바데부: "코드 스타일 신경 쓸 필요 없어!
       다 쓰고 Ctrl + Alt + L 한 번만 누르면 깔끔하게 정리돼."
```

## 3.10 Intention Actions

코드를 개선하기 위한 제안을 자동으로 해줍니다.

**사용법:**
- 노란 전구 아이콘 클릭
- `Alt + Enter`: Intention Actions 메뉴

**예제:**
```kotlin
// if를 when으로 변경 제안
if (x == 1) {
    doA()
} else if (x == 2) {
    doB()
} else {
    doC()
}
// Alt + Enter → "Replace 'if' with 'when'"

// 변경 후
when (x) {
    1 -> doA()
    2 -> doB()
    else -> doC()
}
```

```text
바데부: "노란 전구를 보면 클릭해봐!
       코드를 개선할 수 있는 좋은 제안들이 나와."
```

## 3.11 빠른 수정 (Quick Fix)

에러나 경고를 자동으로 고쳐줍니다.

**빨간 줄 (에러):**
```kotlin
// 빨간 줄: Unresolved reference
val textView = findViewById(R.id.textView)
// Alt + Enter → "Import TextView"
import android.widget.TextView  // 자동 추가됨
```

**노란 줄 (경고):**
```kotlin
// 노란 줄: 사용하지 않는 import
import android.util.Log  // 회색으로 표시됨
// Alt + Enter → "Optimize imports"
```

```text
바데부: "빨간 줄이나 노란 줄이 보이면 Alt + Enter!
       대부분 자동으로 고칠 수 있어."
```

## 3.12 검색 및 바꾸기

**검색:**
- `Ctrl + F`: 현재 파일에서 찾기
- `Ctrl + Shift + F`: 프로젝트 전체에서 찾기
- `Ctrl + R`: 현재 파일에서 바꾸기
- `Ctrl + Shift + R`: 프로젝트 전체에서 바꾸기

**정규식 검색:**
```text
검색창에서 ".*" 버튼 클릭하면 정규식 모드

예: "fun.*()$" → 모든 함수 찾기
```

```text
바데부: "프로젝트 전체에서 찾기는 정말 유용해!
       특정 함수가 어디서 쓰이는지 한 번에 볼 수 있어."
```

## 3.13 북마크

중요한 코드에 북마크를 달아두세요!

**북마크 사용:**
- `F11`: 익명 북마크 토글
- `Ctrl + F11`: 숫자 북마크 추가 (0-9)
- `Shift + F11`: 북마크 목록 보기
- `Ctrl + [숫자]`: 해당 북마크로 이동

```text
바데부: "긴 코드를 작업할 때 북마크가 정말 유용해!
       중요한 부분에 북마크해두고 빠르게 왔다갔다 할 수 있어."
```

## 3.14 코드 분석 (Inspect Code)

코드의 문제점을 찾아줍니다.

**실행 방법:**
1. Analyze → Inspect Code
2. 분석 범위 선택 (파일/모듈/전체)
3. OK 클릭
4. 결과 확인

**찾을 수 있는 것들:**
- 사용하지 않는 변수/함수
- 널 포인터 가능성
- 성능 문제
- 보안 취약점
- 코드 스타일 위반

```text
바데부: "가끔 Inspect Code를 돌려보면 놓친 문제를 찾을 수 있어!
       배포 전에 꼭 한 번 확인해봐."
```

## 3.15 필수 단축키 정리

**최우선 암기 (TOP 10):**
```text
1. Ctrl + Space         - 자동완성
2. Ctrl + B             - 정의로 이동
3. Shift + F6           - 이름 변경
4. Ctrl + Alt + L       - 코드 포맷팅
5. Alt + Enter          - 빠른 수정
6. Ctrl + /             - 주석 토글
7. Ctrl + D             - 줄 복제
8. Ctrl + Y             - 줄 삭제
9. Alt + J              - 다음 같은 단어 선택
10. Ctrl + Shift + F    - 전체 검색
```

```text
바데부: "이 10개만 완벽하게 외워도 코딩 속도가 2배는 빨라져!
       매일 쓰다 보면 자연스럽게 손에 익어."
```

## 3.16 단축키 커스터마이징

**단축키 변경하기:**
1. Settings → Keymap
2. 원하는 기능 검색
3. 우클릭 → Add Keyboard Shortcut
4. 새 단축키 입력

**인기 Keymap Presets:**
- Default: Android Studio 기본
- Visual Studio: VS 사용자용
- Eclipse: Eclipse 사용자용
- Sublime Text: Sublime 사용자용
- Emacs: Emacs 사용자용

```text
바데부: "다른 에디터에서 넘어왔다면 익숙한 keymap을 선택하면 돼!
       나는 그냥 기본 설정이 제일 좋더라."
```

## 요약

이번 챕터에서 배운 내용:
- ✅ 강력한 자동완성 기능
- ✅ 코드 생성 및 리팩토링 단축키
- ✅ 멀티 커서로 효율적인 편집
- ✅ Live Templates로 빠른 코딩
- ✅ 필수 단축키 TOP 10

```text
바데부: "단축키는 처음엔 외우기 어렵지만, 매일 쓰다 보면 자연스러워져!
       다음 챕터에서는 UI를 만드는 레이아웃 에디터를 배워볼 거야.
       드래그 앤 드롭으로 화면을 만드는 방법을 알려줄게!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Layout Editor로 UI 디자인하기
- XML과 Design 뷰 전환
- ConstraintLayout 마스터하기
- 다양한 뷰와 위젯 사용법

**바데부와 함께 Android Studio 마스터하기! 화이팅!**

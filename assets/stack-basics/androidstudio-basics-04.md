# Chapter 4: 레이아웃 에디터와 XML

Android 앱의 화면을 만드는 방법을 배워봅시다! Layout Editor와 XML을 자유자재로 다루면 원하는 UI를 뭐든 만들 수 있어요.

## 4.1 Layout Editor 소개

Layout Editor는 드래그 앤 드롭으로 UI를 만들 수 있는 비주얼 도구입니다.

**두 가지 모드:**
- **Design**: 시각적 편집 (드래그 앤 드롭)
- **Code**: XML 직접 편집
- **Split**: 두 가지 동시에 보기 (권장!)

```text
바데부: "Split 모드를 쓰면 디자인하면서 XML도 볼 수 있어서 정말 편해!
       나는 항상 Split 모드로 작업해."
```

## 4.2 Layout Editor 구성 요소

```text
📸 스크린샷 위치: Layout Editor 전체 화면
   ┌─────────────────────────────────────┐
   │ Palette (위젯 목록)                 │
   ├──────────┬──────────────────────────┤
   │          │                          │
   │ Component│   Preview (미리보기)     │
   │   Tree   │                          │
   │  (구조)  │                          │
   │          │                          │
   ├──────────┴──────────────────────────┤
   │ Attributes (속성)                   │
   └─────────────────────────────────────┘
```

**주요 영역:**
1. **Palette**: 사용 가능한 위젯들 (Button, TextView 등)
2. **Component Tree**: 위젯 계층 구조
3. **Preview**: 실제 화면 미리보기
4. **Attributes**: 선택한 위젯의 속성

```text
바데부: "각 영역이 다 중요해!
       Palette에서 위젯을 드래그해서 Preview에 놓으면 돼."
```

## 4.3 ConstraintLayout 기초

ConstraintLayout은 가장 강력하고 유연한 레이아웃입니다.

**Constraint란?**
- 위젯과 위젯 사이의 관계
- "이 버튼은 화면 왼쪽에서 16dp 떨어뜨려!"
- 최소 2개의 constraint 필요 (가로, 세로 각각)

**Constraint 종류:**
```text
┌─────────┐
│    ○    │  ← 위쪽 constraint
│  ○ □ ○  │  ← 왼쪽, 오른쪽 constraint
│    ○    │  ← 아래쪽 constraint
└─────────┘
```

```text
바데부: "위젯의 4면에 동그라미가 보이지?
       그걸 드래그해서 연결하면 constraint가 만들어져!"
```

## 4.4 ConstraintLayout 사용법

**위젯 추가하고 제약 설정:**
```xml
<Button
    android:id="@+id/myButton"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="클릭하세요"
    app:layout_constraintTop_toTopOf="parent"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintEnd_toEndOf="parent"
    app:layout_constraintBottom_toBottomOf="parent" />
```

**제약 조건 해석:**
- `constraintTop_toTopOf="parent"`: 위쪽을 parent의 위쪽에 맞춤
- `constraintStart_toStartOf="parent"`: 시작(왼쪽)을 parent에 맞춤
- `constraintEnd_toEndOf="parent"`: 끝(오른쪽)을 parent에 맞춤
- `constraintBottom_toBottomOf="parent"`: 아래쪽을 parent에 맞춤

→ 결과: **화면 정중앙에 버튼 배치!**

```text
바데부: "4방향 모두 제약을 걸면 정중앙에 위치해!
       마법같지? ConstraintLayout의 핵심이야."
```

## 4.5 위젯 간 연결

**위젯끼리 제약 걸기:**
```xml
<TextView
    android:id="@+id/textView1"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="제목"
    app:layout_constraintTop_toTopOf="parent"
    app:layout_constraintStart_toStartOf="parent" />

<TextView
    android:id="@+id/textView2"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="내용"
    app:layout_constraintTop_toBottomOf="@id/textView1"
    app:layout_constraintStart_toStartOf="parent" />
```

**해석:**
- textView2의 위쪽을 textView1의 아래쪽에 연결
- → textView2가 textView1 바로 아래에 배치됨!

```text
바데부: "위젯끼리 연결하면 상대적인 위치를 정할 수 있어!
       레이아웃이 복잡해져도 깔끔하게 정리할 수 있어."
```

## 4.6 Margin과 Padding

**Margin (외부 여백):**
```xml
<Button
    android:layout_margin="16dp"           <!-- 전체 -->
    android:layout_marginStart="8dp"       <!-- 시작(왼쪽) -->
    android:layout_marginTop="8dp"         <!-- 위 -->
    android:layout_marginEnd="8dp"         <!-- 끝(오른쪽) -->
    android:layout_marginBottom="8dp" />   <!-- 아래 -->
```

**Padding (내부 여백):**
```xml
<Button
    android:padding="16dp"        <!-- 전체 -->
    android:paddingStart="8dp"    <!-- 시작 -->
    android:paddingTop="8dp"      <!-- 위 -->
    android:paddingEnd="8dp"      <!-- 끝 -->
    android:paddingBottom="8dp"   <!-- 아래 -->
    android:text="버튼" />
```

```text
┌──────────────────┐
│ Margin (외부)    │
│  ┌────────────┐  │
│  │ Padding    │  │
│  │  ┌──────┐  │  │
│  │  │ 내용 │  │  │
│  │  └──────┘  │  │
│  └────────────┘  │
└──────────────────┘
```

```text
바데부: "Margin은 바깥 여백, Padding은 안쪽 여백!
       dp 단위를 쓰면 다양한 화면 크기에 대응할 수 있어."
```

## 4.7 주요 위젯들

**텍스트:**
- `TextView`: 읽기 전용 텍스트
- `EditText`: 입력 가능한 텍스트
- `Button`: 버튼

**이미지:**
- `ImageView`: 이미지 표시
- `ImageButton`: 이미지 버튼

**컨테이너:**
- `ConstraintLayout`: 제약 기반 레이아웃
- `LinearLayout`: 선형 레이아웃 (세로/가로)
- `FrameLayout`: 단순 컨테이너
- `ScrollView`: 스크롤 가능한 영역

**기타:**
- `RecyclerView`: 목록 표시
- `CardView`: 카드 형태 컨테이너
- `Switch`: 스위치 토글
- `CheckBox`: 체크박스
- `RadioButton`: 라디오 버튼

```text
바데부: "위젯이 정말 많지? 하나씩 써보면서 배우는 게 가장 빠른 방법이야!"
```

## 4.8 TextView 속성

**기본 속성:**
```xml
<TextView
    android:id="@+id/titleText"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="안녕하세요"
    android:textSize="24sp"
    android:textColor="#000000"
    android:textStyle="bold"
    android:fontFamily="sans-serif"
    android:gravity="center" />
```

**주요 속성:**
- `text`: 표시할 텍스트
- `textSize`: 글자 크기 (sp 단위 사용)
- `textColor`: 글자 색상
- `textStyle`: bold, italic, normal
- `gravity`: 텍스트 정렬 (center, start, end)

```text
바데부: "textSize는 sp 단위를 써!
       사용자가 시스템 글꼴 크기를 변경해도 비율이 유지돼."
```

## 4.9 Button과 클릭 이벤트

**Button XML:**
```xml
<Button
    android:id="@+id/myButton"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="클릭하세요"
    android:onClick="onButtonClick" />
```

**Kotlin 코드:**
```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // 방법 1: findViewById 사용
        val button = findViewById<Button>(R.id.myButton)
        button.setOnClickListener {
            Toast.makeText(this, "버튼 클릭!", Toast.LENGTH_SHORT).show()
        }

        // 방법 2: ViewBinding 사용 (권장)
        binding.myButton.setOnClickListener {
            Toast.makeText(this, "버튼 클릭!", Toast.LENGTH_SHORT).show()
        }
    }
}
```

```text
바데부: "버튼은 앱에서 가장 많이 쓰는 위젯이야!
       클릭 이벤트를 잘 다루는 게 중요해."
```

## 4.10 ImageView 사용하기

**이미지 추가:**
1. res/drawable에 이미지 파일 복사
2. XML에서 ImageView 추가

```xml
<ImageView
    android:id="@+id/myImage"
    android:layout_width="200dp"
    android:layout_height="200dp"
    android:src="@drawable/my_image"
    android:scaleType="centerCrop"
    android:contentDescription="내 이미지" />
```

**scaleType 옵션:**
- `centerCrop`: 비율 유지하며 꽉 채움
- `fitCenter`: 비율 유지하며 전체 표시
- `center`: 원본 크기로 중앙 배치
- `fitXY`: 비율 무시하고 늘림

```text
바데부: "contentDescription은 접근성을 위해 꼭 넣어줘!
       시각 장애인도 앱을 사용할 수 있게 해주는 거야."
```

## 4.11 EditText로 입력 받기

**XML:**
```xml
<EditText
    android:id="@+id/nameInput"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:hint="이름을 입력하세요"
    android:inputType="text"
    android:maxLines="1"
    android:imeOptions="actionDone" />
```

**inputType 옵션:**
- `text`: 일반 텍스트
- `textPassword`: 비밀번호 (숨김)
- `number`: 숫자만
- `phone`: 전화번호
- `textEmailAddress`: 이메일

**Kotlin 코드:**
```kotlin
val input = findViewById<EditText>(R.id.nameInput)
val name = input.text.toString()
Toast.makeText(this, "안녕하세요, $name님!", Toast.LENGTH_SHORT).show()
```

```text
바데부: "inputType을 잘 설정하면 적절한 키보드가 나와!
       전화번호 입력할 땐 숫자 키보드, 이메일 입력할 땐 @ 포함된 키보드가 나와."
```

## 4.12 Guidelines와 Barriers

**Guideline (가이드라인):**
화면에 보이지 않는 기준선을 만들 수 있어요.

```xml
<androidx.constraintlayout.widget.Guideline
    android:id="@+id/guideline"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:orientation="vertical"
    app:layout_constraintGuide_percent="0.5" />

<!-- 이제 위젯들을 guideline에 연결 -->
<Button
    app:layout_constraintStart_toStartOf="@id/guideline" />
```

**Barrier (장벽):**
여러 위젯 중 가장 긴 것을 기준으로 하는 동적 가이드라인

```xml
<androidx.constraintlayout.widget.Barrier
    android:id="@+id/barrier"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    app:barrierDirection="end"
    app:constraint_referenced_ids="textView1,textView2" />
```

```text
바데부: "Guideline과 Barrier는 복잡한 레이아웃을 만들 때 정말 유용해!
       처음엔 어렵지만 익숙해지면 강력한 도구야."
```

## 4.13 Chain (체인)

여러 위젯을 연결하여 하나의 그룹처럼 다룰 수 있어요.

**Chain 스타일:**
- `spread`: 균등 분배
- `spread_inside`: 양끝은 붙이고 내부만 분배
- `packed`: 모두 붙여서 중앙 배치

```xml
<!-- 세 개의 버튼을 가로로 체인 -->
<Button android:id="@+id/button1"
    app:layout_constraintStart_toStartOf="parent"
    app:layout_constraintEnd_toStartOf="@id/button2"
    app:layout_constraintHorizontal_chainStyle="spread" />

<Button android:id="@+id/button2"
    app:layout_constraintStart_toEndOf="@id/button1"
    app:layout_constraintEnd_toStartOf="@id/button3" />

<Button android:id="@+id/button3"
    app:layout_constraintStart_toEndOf="@id/button2"
    app:layout_constraintEnd_toEndOf="parent" />
```

```text
바데부: "Chain을 쓰면 버튼 여러 개를 균등하게 배치할 수 있어!
       탭 메뉴 같은 걸 만들 때 정말 편해."
```

## 4.14 ViewBinding

findViewById를 안전하게 대체하는 방법!

**build.gradle에 추가:**
```gradle
android {
    buildFeatures {
        viewBinding true
    }
}
```

**Activity에서 사용:**
```kotlin
class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // 이제 binding으로 뷰에 접근!
        binding.myButton.setOnClickListener {
            val name = binding.nameInput.text.toString()
            binding.resultText.text = "안녕하세요, $name님!"
        }
    }
}
```

```text
바데부: "ViewBinding을 쓰면 findViewById보다 훨씬 안전하고 편해!
       오타로 인한 에러도 없고, 타입도 자동으로 맞춰져."
```

## 4.15 다크 모드 대응

**colors.xml 수정:**
```xml
<!-- res/values/colors.xml (Light Mode) -->
<resources>
    <color name="background">#FFFFFF</color>
    <color name="text">#000000</color>
</resources>

<!-- res/values-night/colors.xml (Dark Mode) -->
<resources>
    <color name="background">#000000</color>
    <color name="text">#FFFFFF</color>
</resources>
```

**레이아웃에서 사용:**
```xml
<TextView
    android:textColor="@color/text"
    android:background="@color/background" />
```

```text
바데부: "요즘은 다크 모드가 필수야!
       colors.xml을 잘 구성하면 자동으로 대응돼."
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Layout Editor의 구조와 사용법
- ✅ ConstraintLayout으로 화면 구성하기
- ✅ 주요 위젯들 (TextView, Button, ImageView, EditText)
- ✅ Margin, Padding, Constraint 개념
- ✅ ViewBinding으로 안전하게 뷰 접근하기

```text
바데부: "레이아웃 에디터를 마스터하면 UI 개발이 정말 재미있어져!
       다음 챕터에서는 앱의 버그를 찾는 디버깅 도구들을 배워볼 거야.
       Logcat, Debugger, Profiler 사용법을 알려줄게!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Logcat으로 로그 확인하기
- Debugger로 버그 잡기
- Profiler로 성능 분석하기
- 일반적인 에러 해결 방법

**바데부와 함께 Android Studio 마스터하기! 화이팅!**

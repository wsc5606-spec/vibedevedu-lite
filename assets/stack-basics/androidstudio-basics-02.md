# Chapter 2: 프로젝트 생성 및 구조

Android 프로젝트의 구조를 이해하면 앱 개발이 훨씬 쉬워집니다. 각 파일과 폴더가 어떤 역할을 하는지 알아봐요!

## 2.1 프로젝트 생성 옵션

Android Studio는 다양한 템플릿을 제공합니다.

**주요 템플릿:**
- **Empty Activity**: 가장 기본적인 화면 하나
- **Basic Activity**: 플로팅 액션 버튼 포함
- **Bottom Navigation Activity**: 하단 네비게이션
- **Navigation Drawer Activity**: 슬라이드 메뉴
- **Tabbed Activity**: 탭 레이아웃
- **No Activity**: Activity 없이 시작

```text
바데부: "처음 배울 때는 Empty Activity로 시작하는 게 가장 좋아!
       복잡한 기능 없이 기본부터 차근차근 배울 수 있거든."
```

## 2.2 프로젝트 설정 옵션

**Name (이름):**
- 앱의 표시 이름
- 예: "My Awesome App"

**Package name (패키지 이름):**
- 고유 식별자 (전 세계에서 유일해야 함)
- 역도메인 형식 권장: com.회사명.앱이름
- 예: com.vibedevedu.myapp

**Save location (저장 위치):**
- 프로젝트가 저장될 폴더
- 경로에 한글이나 공백 없는 게 좋음

**Language (언어):**
- Kotlin (권장)
- Java

**Minimum SDK:**
- 지원할 최소 Android 버전
- API 24 (Android 7.0) 권장
- 낮을수록 더 많은 기기 지원, 높을수록 최신 기능 사용

```text
바데부: "Minimum SDK는 보통 API 24가 적당해.
       너무 낮으면 최신 기능을 못 쓰고, 너무 높으면 사용자가 적어져."
```

## 2.3 프로젝트 전체 구조

```
MyFirstApp/
├── .gradle/              # Gradle 캐시
├── .idea/                # Android Studio 설정
├── app/                  # 메인 앱 모듈 ⭐
│   ├── build/           # 빌드 결과물
│   ├── libs/            # 외부 라이브러리
│   └── src/             # 소스 코드 ⭐
├── gradle/              # Gradle wrapper
├── build.gradle         # 프로젝트 Gradle 설정
├── settings.gradle      # 프로젝트 설정
└── local.properties     # 로컬 환경 설정
```

```text
바데부: "실제로 작업하는 곳은 app/ 폴더야!
       나머지는 빌드 시스템과 설정 파일들이야."
```

## 2.4 app 모듈 구조

```
app/
├── build/                    # 빌드 결과 (자동 생성)
├── libs/                     # JAR 라이브러리
├── src/
│   ├── main/                # 메인 소스 ⭐
│   │   ├── java/           # Kotlin/Java 코드 ⭐
│   │   ├── res/            # 리소스 파일 ⭐
│   │   └── AndroidManifest.xml  # 앱 설정 파일 ⭐
│   ├── androidTest/         # 안드로이드 테스트
│   └── test/                # 단위 테스트
├── build.gradle             # 앱 Gradle 설정 ⭐
└── proguard-rules.pro       # 난독화 규칙
```

```text
바데부: "가장 중요한 건 main/ 폴더 안의 세 가지야:
       1. java/ - 코드를 쓰는 곳
       2. res/ - 화면, 이미지, 문자열을 넣는 곳
       3. AndroidManifest.xml - 앱의 설정 파일"
```

## 2.5 java 폴더 구조

```
java/
└── com/example/myfirstapp/
    └── MainActivity.kt       # 메인 화면 코드
```

**패키지 구조 예시 (실전):**
```
java/
└── com/example/myfirstapp/
    ├── MainActivity.kt
    ├── ui/                   # UI 관련
    │   ├── home/
    │   └── profile/
    ├── data/                 # 데이터 관련
    │   ├── model/
    │   └── repository/
    └── utils/                # 유틸리티
```

```text
바데부: "프로젝트가 커지면 폴더를 나눠서 정리하는 게 중요해!
       UI, 데이터, 유틸 이렇게 나누면 찾기 쉬워."
```

## 2.6 res 폴더 구조

```
res/
├── drawable/           # 이미지, 아이콘
├── layout/            # XML 레이아웃 ⭐
│   └── activity_main.xml
├── mipmap/            # 앱 아이콘
│   ├── ic_launcher.png
│   └── ...
├── values/            # 값 리소스 ⭐
│   ├── colors.xml    # 색상 정의
│   ├── strings.xml   # 문자열 정의
│   └── themes.xml    # 테마 정의
└── xml/              # 기타 XML 설정
```

```text
바데부: "res 폴더는 코드와 디자인을 분리하는 곳이야.
       이미지, 색상, 문자열을 여기 넣으면 코드에서 쉽게 가져다 쓸 수 있어!"
```

## 2.7 AndroidManifest.xml

앱의 모든 정보를 담고 있는 **가장 중요한 설정 파일**입니다.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myfirstapp">

    <!-- 권한 설정 -->
    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/Theme.MyFirstApp">

        <!-- MainActivity 등록 -->
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

    </application>

</manifest>
```

**주요 요소:**
- `<uses-permission>`: 앱이 필요한 권한
- `<application>`: 앱 전체 설정
- `<activity>`: 각 화면(Activity) 등록
- `android:exported="true"`: 외부에서 실행 가능 (메인 Activity만)

```text
바데부: "새 Activity를 만들면 반드시 Manifest에 등록해야 해!
       요즘은 Android Studio가 자동으로 등록해주지만, 알아두는 게 좋아."
```

## 2.8 Gradle 파일

**build.gradle (Project 레벨):**
```gradle
// Top-level build file
plugins {
    id 'com.android.application' version '8.1.0' apply false
    id 'org.jetbrains.kotlin.android' version '1.9.0' apply false
}
```

**build.gradle (Module: app):**
```gradle
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace 'com.example.myfirstapp'
    compileSdk 33

    defaultConfig {
        applicationId "com.example.myfirstapp"
        minSdk 24
        targetSdk 33
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'
}
```

**주요 설정:**
- `compileSdk`: 컴파일할 때 사용할 SDK 버전
- `minSdk`: 지원할 최소 Android 버전
- `targetSdk`: 목표 Android 버전
- `versionCode`: 앱 버전 번호 (업데이트 시 증가)
- `versionName`: 사용자에게 보이는 버전 (예: "1.0")
- `dependencies`: 사용할 라이브러리

```text
바데부: "Gradle은 프로젝트를 빌드하고 라이브러리를 관리하는 도구야.
       라이브러리 추가하려면 dependencies에 한 줄만 추가하면 돼!"
```

## 2.9 MainActivity.kt 살펴보기

```kotlin
package com.example.myfirstapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
}
```

**코드 설명:**
- `package`: 패키지 이름
- `import`: 필요한 클래스 가져오기
- `MainActivity`: Activity를 상속받는 클래스
- `onCreate()`: Activity가 생성될 때 호출되는 함수
- `setContentView()`: 화면 레이아웃 설정

```text
바데부: "onCreate()는 Activity의 시작점이야!
       여기서 화면을 설정하고, 초기화 작업을 해."
```

## 2.10 activity_main.xml 살펴보기

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

**주요 속성:**
- `layout_width/height`: 너비와 높이
  - `match_parent`: 부모만큼
  - `wrap_content`: 내용물만큼
- `text`: 표시할 텍스트
- `layout_constraint*`: ConstraintLayout 제약 조건

```text
바데부: "XML은 화면 디자인을 정의하는 파일이야.
       TextView는 텍스트를 보여주는 기본 위젯이고!"
```

## 2.11 리소스 참조 방법

**코드에서 리소스 사용:**
```kotlin
// 문자열 리소스 (strings.xml)
val appName = getString(R.string.app_name)

// 색상 리소스 (colors.xml)
val color = getColor(R.color.purple_500)

// 레이아웃 리소스
setContentView(R.layout.activity_main)

// 이미지 리소스
imageView.setImageResource(R.drawable.ic_launcher)
```

**R 클래스:**
- 자동 생성되는 클래스
- 모든 리소스에 정수 ID 부여
- `R.리소스타입.리소스이름` 형식

```text
바데부: "R 클래스는 자동으로 만들어져!
       res 폴더에 파일을 추가하면 R 클래스에도 자동으로 추가돼."
```

## 2.12 Project View vs Android View

**Android Studio는 두 가지 보기 방식을 제공:**

**Android View (권장):**
- 논리적 구조로 정리
- 작업하기 편한 구조
- 자주 쓰는 파일만 표시

**Project View:**
- 실제 폴더 구조
- 모든 파일 표시
- 고급 작업 시 필요

```text
바데부: "기본적으로 Android View를 쓰는 게 편해!
       필요할 때만 Project View로 바꿔서 확인하면 돼."
```

## 2.13 프로젝트 뷰 변경하기

```text
📸 스크린샷 위치: Project 창 상단의 드롭다운
   - Android, Project, Packages 등 선택 가능
   - Android 뷰가 선택된 상태
```

**Android View에서 주요 노드:**
- manifests: AndroidManifest.xml
- java: 소스 코드
- res: 리소스 파일
- Gradle Scripts: 빌드 설정

```text
바데부: "처음엔 Android View가 복잡해 보이지만,
       익숙해지면 이게 가장 편해!"
```

## 2.14 유용한 팁

**1. 새 Activity 만들기:**
- app → java → 패키지 우클릭
- New → Activity → Empty Activity
- 이름 입력 후 Finish
- Manifest에 자동 등록됨!

**2. 새 리소스 만들기:**
- res 폴더 우클릭
- New → Android Resource File
- 파일 유형 선택 (Layout, Values 등)

**3. 코드와 레이아웃 왔다갔다 하기:**
- Ctrl + Click (Mac: Cmd + Click)
- `setContentView(R.layout.activity_main)` 에서 Ctrl+Click하면 XML로 이동

```text
바데부: "Ctrl + Click은 정말 자주 쓰는 기능이야!
       코드 어디든 Ctrl + Click하면 정의된 곳으로 바로 가!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Android 프로젝트 전체 구조
- ✅ app 모듈의 주요 폴더들
- ✅ AndroidManifest.xml의 역할
- ✅ Gradle 빌드 시스템 기초
- ✅ MainActivity와 레이아웃 파일

```text
바데부: "프로젝트 구조를 이해하면 파일을 찾기도 쉽고, 수정도 편해져!
       다음 챕터에서는 Android Studio 에디터의 강력한 기능들을 배워볼 거야.
       코딩이 훨씬 빨라질 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 코드 에디터의 강력한 기능들
- 자동완성과 코드 생성
- 리팩토링 도구
- 유용한 단축키

**바데부와 함께 Android Studio 마스터하기! 화이팅!**

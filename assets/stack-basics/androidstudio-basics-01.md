# Chapter 1: Android Studio 소개 및 설치

Android Studio는 Google이 만든 **공식 Android 앱 개발 도구**입니다. Android 앱을 만들기 위한 모든 것이 들어있는 통합 개발 환경(IDE)입니다.

## 1.1 Android Studio란?

Android Studio는 전 세계 Android 개발자들이 사용하는 필수 도구입니다.

**주요 특징:**
- 공식 Android 개발 IDE
- 강력한 코드 에디터
- 실시간 미리보기
- 빠른 에뮬레이터
- Gradle 빌드 시스템
- Google Play 배포 지원

```text
바데부: "Android 앱을 만들고 싶다면 Android Studio가 필수야!
       처음엔 좀 무거워 보이지만, 익숙해지면 정말 강력한 도구라는 걸 알게 될 거야."
```

## 1.2 Android Studio vs 다른 도구

| 도구 | 장점 | 단점 |
|------|------|------|
| Android Studio | 공식 지원, 모든 기능 | 무거움 |
| IntelliJ IDEA | 강력한 기능 | Android 전용 아님 |
| VS Code | 가볍고 빠름 | Android 개발 제한적 |
| Eclipse | 옛날 도구 | 더 이상 권장 안 함 |

**바데부의 추천:** "Android 앱 개발이라면 무조건 Android Studio! Google이 직접 만들고 지원해서 최신 기능을 가장 먼저 쓸 수 있어."

## 1.3 시스템 요구사항

Android Studio는 상당히 무거운 프로그램입니다. 충분한 사양이 필요해요.

**최소 요구사항:**
- OS: Windows 10/11 (64bit), macOS 10.14+, Linux (64bit)
- CPU: x86_64 CPU, 2세대 Intel Core 이상
- RAM: 8GB 이상 (16GB 권장)
- 디스크: 8GB 이상 (SSD 권장)
- 화면: 1280x800 이상

**권장 요구사항:**
- RAM: 16GB
- SSD: 256GB 이상
- 화면: 1920x1080 이상

```text
바데부: "Android Studio는 에뮬레이터까지 돌려야 해서 RAM이 정말 중요해!
       8GB도 되긴 하지만, 16GB면 훨씬 쾌적하게 작업할 수 있어."
```

## 1.4 Windows에서 설치하기

**Step 1: JDK 확인**
Android Studio에는 JDK가 포함되어 있지만, 최신 버전을 쓰는 게 좋아요.

```text
바데부: "요즘 Android Studio는 JDK를 자동으로 설치해줘서 따로 신경 쓸 필요 없어!"
```

**Step 2: 다운로드**
1. https://developer.android.com/studio 접속
2. "Download Android Studio" 클릭
3. 약관 동의
4. android-studio-XXXX.XX.X.XX-windows.exe 다운로드

**Step 3: 설치**
1. 다운로드한 파일 실행
2. "Next" 클릭
3. 설치 구성 요소 선택:
   - ✅ Android Studio
   - ✅ Android Virtual Device (에뮬레이터)
4. 설치 위치 선택 (기본값 권장)
5. "Install" 클릭

```text
📸 스크린샷 위치: 설치 프로그램의 구성 요소 선택 화면
   - Android Studio와 AVD가 모두 체크된 모습
   - 설치 경로 선택 화면
```

**Step 4: 첫 설정**
1. Android Studio 실행
2. "Do not import settings" 선택 (처음 설치인 경우)
3. Setup Wizard 시작
4. Install Type: "Standard" 선택 (권장)
5. SDK 다운로드 진행 (시간이 좀 걸려요!)

```text
바데부: "첫 설정에서 SDK를 다운로드하는데 시간이 꽤 걸려.
       인터넷 연결 확인하고, 커피 한 잔 하고 와도 돼!"
```

## 1.5 macOS에서 설치하기

**Step 1: 다운로드**
1. https://developer.android.com/studio 접속
2. "Download Android Studio" 클릭 (Mac용 자동 선택)
3. Intel 또는 Apple Silicon 버전 확인
4. .dmg 파일 다운로드

**Step 2: 설치**
1. .dmg 파일 실행
2. Android Studio 아이콘을 Applications 폴더로 드래그
3. Applications 폴더에서 Android Studio 실행
4. "열기" 클릭 (보안 경고 시)

```text
바데부: "M1/M2/M3 Mac이라면 Apple Silicon 버전을 받아야 해!
       Intel Mac이라면 Intel 버전을 받아야 하고."
```

**Step 3: 첫 설정**
1. Setup Wizard 시작
2. Install Type: "Standard" 선택
3. SDK 다운로드 대기
4. 완료!

## 1.6 Linux에서 설치하기

**Ubuntu/Debian:**
```bash
# 1. 다운로드 (공식 웹사이트에서)
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/XXXX.X.X.XX/android-studio-XXXX.X.X.XX-linux.tar.gz

# 2. 압축 해제
sudo tar -xvzf android-studio-*-linux.tar.gz -C /opt

# 3. 실행
cd /opt/android-studio/bin
./studio.sh
```

**또는 Snap으로 간편 설치:**
```bash
sudo snap install android-studio --classic
```

```text
바데부: "Linux 사용자라면 Snap으로 설치하는 게 가장 편해!
       업데이트도 자동으로 되니까 관리하기 쉬워."
```

## 1.7 첫 실행

Android Studio를 처음 실행하면:

1. **Welcome 화면** 표시
   - New Project (새 프로젝트)
   - Open (기존 프로젝트 열기)
   - Get from VCS (Git에서 가져오기)

```text
📸 스크린샷 위치: Android Studio Welcome 화면
   - 중앙의 세 가지 주요 버튼
   - 오른쪽 사이드바의 최근 프로젝트
   - 하단의 SDK Manager, AVD Manager 링크
```

2. **SDK 확인**
   - Tools → SDK Manager에서 설치된 SDK 확인
   - Android 최신 버전 설치 확인

```text
바데부: "처음 실행하면 SDK 다운로드가 완료됐는지 꼭 확인해봐!
       SDK가 없으면 앱을 만들 수가 없거든."
```

## 1.8 필수 SDK 구성 요소 설치

SDK Manager에서 꼭 필요한 것들을 확인하세요.

**SDK Platforms (필수):**
- ✅ Android 13.0 (API 33) - 최신 안정 버전
- ✅ Android 12.0 (API 31)
- ✅ Android 11.0 (API 30)

**SDK Tools (필수):**
- ✅ Android SDK Build-Tools
- ✅ Android SDK Platform-Tools
- ✅ Android Emulator
- ✅ Intel x86 Emulator Accelerator (HAXM) - Windows/Mac Intel만

```text
바데부: "최신 Android 버전만 설치해도 되지만,
       구형 기기 지원을 위해 API 30, 31도 설치하는 게 좋아!"
```

## 1.9 에뮬레이터 설정

실제 기기 없이도 앱을 테스트할 수 있는 에뮬레이터를 설정해봐요.

**Step 1: AVD Manager 열기**
1. Welcome 화면에서 "More Actions" 클릭
2. "Virtual Device Manager" 선택
3. "Create Virtual Device" 클릭

**Step 2: 기기 선택**
1. Phone 카테고리에서 "Pixel 6" 선택 (권장)
2. "Next" 클릭

**Step 3: 시스템 이미지 선택**
1. "Recommended" 탭에서 최신 버전 선택
2. "Download" 클릭 (처음이면 다운로드 필요)
3. 다운로드 완료 후 "Next"

**Step 4: 설정 확인**
1. AVD Name: 원하는 이름 (예: Pixel 6 API 33)
2. Graphics: Automatic (권장)
3. "Finish" 클릭

```text
바데부: "에뮬레이터는 처음 실행할 때 좀 느릴 수 있어.
       한 번 켜두면 계속 켜 놓는 게 좋아!"
```

## 1.10 첫 프로젝트 만들기

간단한 프로젝트를 만들어 설치가 잘 됐는지 확인해봐요!

**Step 1: 프로젝트 생성**
1. Welcome 화면에서 "New Project" 클릭
2. "Empty Activity" 선택
3. "Next" 클릭

**Step 2: 프로젝트 설정**
```text
Name: MyFirstApp
Package name: com.example.myfirstapp
Save location: 원하는 위치
Language: Kotlin (권장)
Minimum SDK: API 24 (Android 7.0)
```

4. "Finish" 클릭

```text
바데부: "Kotlin이 최신 권장 언어야! Java도 되지만 Kotlin이 더 간결하고 안전해."
```

**Step 3: 빌드 기다리기**
1. 프로젝트 열림
2. 하단에 "Building" 표시
3. 첫 빌드는 시간이 좀 걸려요 (Gradle 다운로드)
4. 빌드 완료까지 기다리기

```text
바데부: "첫 프로젝트는 Gradle이 필요한 파일들을 다운로드해서 시간이 오래 걸려.
       다음부터는 훨씬 빨라지니 걱정 마!"
```

## 1.11 첫 실행

**Step 1: 에뮬레이터 실행**
1. 상단 툴바에서 기기 선택 (Pixel 6 API 33)
2. 재생 버튼 (▶) 클릭
3. 에뮬레이터 부팅 대기

**Step 2: 앱 실행**
1. "Run 'app'" 클릭
2. 앱 빌드 및 설치
3. 에뮬레이터에서 앱 실행됨!

```text
📸 스크린샷 위치: 에뮬레이터에서 "Hello World!" 실행되는 화면
   - Android 기본 화면
   - 중앙에 "Hello World!" 텍스트
```

```text
바데부: "우와! 첫 Android 앱이 실행됐어!
       지금은 간단하지만, 이걸로 뭐든 만들 수 있어!"
```

## 1.12 문제 해결

**Android Studio가 느릴 때:**
1. RAM 부족 확인 (16GB 권장)
2. SSD 사용 권장
3. 바이러스 검사 프로그램 예외 추가
4. studio.vmoptions 파일 수정 (고급)

**에뮬레이터가 실행되지 않을 때:**
```text
Windows: HAXM 설치 확인, Hyper-V 충돌 확인
Mac Intel: HAXM 설치 확인
Mac M1/M2: 자동으로 되어야 함
Linux: KVM 설정 확인
```

**Gradle 빌드가 실패할 때:**
1. 인터넷 연결 확인
2. File → Invalidate Caches → Restart
3. Gradle 버전 확인

```text
바데부: "문제가 생기면 당황하지 말고, 에러 메시지를 잘 읽어봐!
       대부분 구글 검색하면 해결 방법이 나와."
```

## 1.13 유용한 초기 설정

**자동 import 설정:**
1. File → Settings (Mac: Preferences)
2. Editor → General → Auto Import
3. ✅ Add unambiguous imports on the fly
4. ✅ Optimize imports on the fly

**코드 스타일:**
1. Settings → Editor → Code Style → Kotlin
2. Scheme: Project (팀 작업 시) 또는 Default

**테마 변경:**
1. Settings → Appearance & Behavior → Appearance
2. Theme: IntelliJ Light / Darcula (어두운 테마)

```text
바데부: "자동 import를 켜두면 라이브러리를 쓸 때 자동으로 import해줘서 편해!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ Android Studio의 특징과 장점
- ✅ Windows, macOS, Linux에서 설치하는 방법
- ✅ SDK와 에뮬레이터 설정
- ✅ 첫 프로젝트 만들고 실행하기
- ✅ 기본 설정 변경하기

```text
바데부: "Android Studio 설치 완료! 생각보다 간단했지?
       다음 챕터에서는 프로젝트 구조를 자세히 알아볼 거야.
       Android 앱이 어떻게 구성되는지 배워보자!"
```

## 다음 챕터 예고

다음 챕터에서는:
- Android 프로젝트 구조 이해하기
- Manifest 파일의 역할
- Gradle 파일 기초
- 리소스 폴더 구조

**바데부와 함께 Android 개발자로 성장하자! 파이팅!**

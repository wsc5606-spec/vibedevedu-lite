# Chapter 2: 인터페이스와 기본 사용법

VS Code의 인터페이스는 매우 직관적입니다. 각 영역의 기능을 알면 훨씬 효율적으로 작업할 수 있습니다.

## 2.1 VS Code 인터페이스 구조

VS Code는 크게 5개 영역으로 나뉩니다:

```text
┌─────────────────────────────────────────┐
│  1. 메뉴 바 (Menu Bar)                  │
├───┬─────────────────────────────────────┤
│   │  3. 에디터 그룹 (Editor Group)      │
│ 2 │  ┌───────────────────────────────┐  │
│   │  │                               │  │
│ A │  │     코드 작성 영역             │  │
│ c │  │                               │  │
│ t │  └───────────────────────────────┘  │
│ i │  ──────────────────────────────────  │
│ v │  4. 패널 (Panel)                    │
│ i │     - 터미널, 문제, 출력, 디버그    │
│ t │                                     │
│ y │                                     │
│   │                                     │
│ B │                                     │
│ a │                                     │
│ r │                                     │
└───┴─────────────────────────────────────┘
     5. 상태 바 (Status Bar)
```

```text
바데부: "인터페이스가 깔끔하게 정리되어 있어서 금방 익숙해질 거야!"
```

## 2.2 Activity Bar (활동 바)

왼쪽 세로 바에 있는 아이콘들입니다.

**주요 아이콘:**

1. **Explorer (탐색기)** - `Ctrl + Shift + E`
   - 파일과 폴더 관리
   - 프로젝트 구조 확인

2. **Search (검색)** - `Ctrl + Shift + F`
   - 전체 파일에서 텍스트 검색
   - 찾기 및 바꾸기

3. **Source Control (소스 제어)** - `Ctrl + Shift + G`
   - Git 관리
   - 변경사항 확인

4. **Run and Debug (실행 및 디버그)** - `Ctrl + Shift + D`
   - 코드 디버깅
   - 브레이크포인트 설정

5. **Extensions (확장)** - `Ctrl + Shift + X`
   - 확장 프로그램 설치
   - 테마, 플러그인 관리

```text
📸 스크린샷 위치: Activity Bar 확대 이미지
   - 각 아이콘에 마우스를 올렸을 때 나타나는 툴팁
   - 현재 선택된 아이콘 하이라이트
```

```text
바데부: "Activity Bar는 VS Code의 핵심 기능들로 가는 지름길이야!"
```

## 2.3 Side Bar (사이드 바)

Activity Bar에서 선택한 뷰가 표시되는 영역입니다.

**Explorer 뷰:**
```text
EXPLORER
└─ 📁 MY_PROJECT
   ├─ 📁 src
   │  ├─ index.html
   │  ├─ style.css
   │  └─ script.js
   ├─ 📁 images
   └─ README.md
```

**유용한 기능:**
- 파일 우클릭 → 메뉴
- 드래그 앤 드롭으로 파일 이동
- 폴더 확장/축소

```text
바데부: "Side Bar에서 프로젝트의 전체 구조를 한눈에 볼 수 있어!"
```

## 2.4 Editor Group (에디터 그룹)

코드를 작성하는 메인 영역입니다.

**탭 관리:**
```text
┌────────┬────────┬────────┐
│ index  │ style  │ script │ ← 열린 파일 탭
└────────┴────────┴────────┘
```

**여러 파일 동시에 보기:**
1. **수평 분할**: 탭을 오른쪽으로 드래그
2. **수직 분할**: 탭을 아래로 드래그

```text
📸 스크린샷 위치: Split Editor 예시
   - HTML 파일과 CSS 파일이 나란히 열린 화면
   - 가운데 구분선
```

**단축키:**
- `Ctrl + \` : 에디터 분할
- `Ctrl + 1, 2, 3` : 에디터 그룹 간 이동
- `Ctrl + W` : 현재 탭 닫기
- `Ctrl + Tab` : 탭 간 이동

```text
바데부: "HTML과 CSS를 나란히 보면서 작업하면 진짜 편해!"
```

## 2.5 Panel (패널)

하단에 위치한 다목적 영역입니다.

**주요 패널:**

1. **Terminal (터미널)**
   - 통합 명령줄 인터페이스
   - 여러 터미널 동시 실행 가능

2. **Problems (문제)**
   - 코드 오류와 경고 표시
   - 실시간 코드 검사

3. **Output (출력)**
   - 확장 프로그램 로그
   - 빌드 출력

4. **Debug Console (디버그 콘솔)**
   - 디버깅 중 변수 확인
   - 표현식 평가

**패널 단축키:**
- `` Ctrl + ` `` : 터미널 열기/닫기
- `Ctrl + Shift + M` : 문제 패널
- `Ctrl + Shift + U` : 출력 패널

```text
바데부: "터미널을 VS Code 안에서 쓸 수 있어서 창을 왔다갔다 안 해도 돼!"
```

## 2.6 Status Bar (상태 바)

하단의 정보 표시줄입니다.

**왼쪽 정보:**
- 🔵 Git 브랜치 (main, develop 등)
- ↻ 동기화 상태
- ⚠️ 경고 개수
- ❌ 오류 개수

**오른쪽 정보:**
- 📄 줄:열 위치 (Ln 10, Col 5)
- 🔤 들여쓰기 (Spaces: 2)
- 📝 인코딩 (UTF-8)
- 🔚 줄 끝 형식 (LF/CRLF)
- 🔤 언어 모드 (JavaScript, Python 등)

```text
📸 스크린샷 위치: Status Bar 확대 이미지
   - 각 정보 영역 표시
   - 클릭 가능한 항목들
```

**클릭하면 변경 가능:**
- 인코딩 클릭 → 다른 인코딩 선택
- 언어 모드 클릭 → 다른 언어 설정
- 들여쓰기 클릭 → 탭/스페이스 변경

```text
바데부: "Status Bar를 보면 현재 파일의 모든 정보를 알 수 있어!"
```

## 2.7 Command Palette (커맨드 팔레트)

VS Code의 모든 기능에 접근할 수 있는 검색창입니다.

**열기:**
- `Ctrl + Shift + P` (Windows/Linux)
- `Cmd + Shift + P` (macOS)
- `F1`

**사용 예시:**

```text
> Theme
> Settings
> Format Document
> Git: Clone
> Extensions: Install Extensions
```

**자주 사용하는 명령:**
1. `>theme` → 테마 변경
2. `>format` → 코드 정리
3. `>reload` → VS Code 재시작
4. `>settings` → 설정 열기
5. `>keyboard` → 단축키 설정

```text
바데부: "메뉴를 찾아 헤매지 말고, 커맨드 팔레트에서 검색하면 빠르게 찾을 수 있어!"
```

## 2.8 Quick Open (빠른 열기)

파일을 빠르게 여는 기능입니다.

**열기:**
- `Ctrl + P`

**사용법:**
```text
프로젝트 내 파일 검색:
> index.html      ← 'index' 입력하면 자동완성
> style.css
> script.js
```

**특수 기호:**
- `@` : 심볼 검색 (함수, 클래스)
- `:` : 줄 번호로 이동
- `?` : 도움말

**예시:**
```text
Ctrl + P → "index.html"        (파일 열기)
Ctrl + P → ":50"               (50번째 줄로 이동)
Ctrl + P → "@function"         (함수 찾기)
```

```text
바데부: "Ctrl + P는 내가 제일 많이 쓰는 단축키야! 진짜 빨라!"
```

## 2.9 Breadcrumbs (브레드크럼)

에디터 상단의 경로 표시입니다.

```text
📁 my-project > 📁 src > 📄 index.html > <body> > <div>
```

**기능:**
- 현재 파일 위치 표시
- 코드 구조 탐색
- 클릭하여 빠른 이동

**켜기/끄기:**
1. 메뉴: View → Show Breadcrumbs
2. 설정: `"breadcrumbs.enabled": true`

```text
바데부: "Breadcrumbs를 보면 내가 파일의 어디에 있는지 한눈에 알 수 있어!"
```

## 2.10 Minimap (미니맵)

에디터 오른쪽의 코드 축소판입니다.

```text
┌─────────────────────────┬──┐
│                         │▓▓│
│  코드 작성 영역          │░░│ ← 미니맵
│                         │░░│
│                         │▓▓│
└─────────────────────────┴──┘
```

**기능:**
- 코드 전체 구조 한눈에 보기
- 빠른 스크롤
- 현재 위치 표시

**설정:**
```json
{
  "editor.minimap.enabled": true,
  "editor.minimap.side": "right",
  "editor.minimap.showSlider": "always"
}
```

```text
바데부: "파일이 길 때 미니맵으로 원하는 위치를 빠르게 찾을 수 있어!"
```

## 2.11 기본 단축키

바데부가 추천하는 필수 단축키:

**파일 관리:**
- `Ctrl + N` : 새 파일
- `Ctrl + O` : 파일 열기
- `Ctrl + S` : 저장
- `Ctrl + Shift + S` : 다른 이름으로 저장
- `Ctrl + W` : 탭 닫기

**편집:**
- `Ctrl + C` : 복사
- `Ctrl + X` : 잘라내기
- `Ctrl + V` : 붙여넣기
- `Ctrl + Z` : 되돌리기
- `Ctrl + Shift + Z` : 다시 실행

**검색:**
- `Ctrl + F` : 찾기
- `Ctrl + H` : 바꾸기
- `Ctrl + Shift + F` : 전체 파일에서 찾기

**탐색:**
- `Ctrl + P` : 빠른 열기
- `Ctrl + Shift + P` : 커맨드 팔레트
- `Ctrl + G` : 줄 번호로 이동
- `Alt + ←/→` : 앞/뒤로 이동

**뷰:**
- `Ctrl + B` : 사이드바 토글
- `` Ctrl + ` `` : 터미널 토글
- `Ctrl + \` : 에디터 분할
- `Ctrl + +/-` : 확대/축소

```text
바데부: "단축키를 외우면 마우스를 거의 안 써도 돼서 속도가 2배는 빨라져!"
```

## 2.12 Zen Mode (집중 모드)

코드에만 집중할 수 있는 모드입니다.

**활성화:**
- `Ctrl + K` → `Z`
- 메뉴: View → Appearance → Zen Mode

**특징:**
- 사이드바, 패널, 상태바 모두 숨김
- 전체 화면으로 에디터만 표시
- 방해 요소 제거

**종료:**
- `ESC` 두 번 누르기
- `Ctrl + K` → `Z`

```text
바데부: "집중이 안 될 때 Zen Mode를 켜면 오직 코드만 보여서 좋아!"
```

## 2.13 멀티 커서 기본

여러 위치에서 동시에 편집할 수 있습니다.

**사용법:**
1. `Alt + Click` : 클릭한 위치에 커서 추가
2. `Ctrl + Alt + ↑/↓` : 위/아래에 커서 추가
3. `Ctrl + D` : 같은 단어 선택 및 커서 추가

**예시:**
```javascript
// 바데부가 여러 변수를 한번에 수정하기
let name = "바데부";
let age = "25";
let city = "서울";

// Alt + Click으로 3군데 커서 추가하여
// 따옴표를 모두 한번에 수정
```

```text
📸 스크린샷 위치: 멀티 커서 사용 예시
   - 여러 줄에 커서가 동시에 표시된 모습
   - 동시에 입력되는 텍스트
```

```text
바데부: "멀티 커서는 정말 신기해! 한 번에 여러 곳을 수정할 수 있어!"
```

## 2.14 실습: 인터페이스 익히기

바데부와 함께 실습해봅시다!

**실습 1: Activity Bar 탐험**
1. 각 아이콘 클릭해보기
2. Side Bar 내용 확인하기
3. 단축키로 전환해보기

**실습 2: 에디터 분할**
1. 새 파일 3개 생성
2. 에디터를 좌우로 분할
3. 각 에디터에 다른 파일 열기

**실습 3: 커맨드 팔레트**
1. `Ctrl + Shift + P` 열기
2. "theme" 입력하여 테마 변경
3. "format" 입력하여 코드 정리

**실습 4: 빠른 열기**
1. `Ctrl + P` 열기
2. ":10" 입력하여 10번째 줄로 이동
3. "@" 입력하여 심볼 탐색

```text
바데부: "직접 해보면서 익히는 게 제일 빨라! 하나씩 따라해봐!"
```

## 2.15 인터페이스 커스터마이징

자신만의 작업 환경을 만들어봅시다.

**Activity Bar 위치 변경:**
```json
{
  "workbench.activityBar.location": "top"  // 또는 "bottom", "hidden"
}
```

**사이드바 위치 변경:**
- 메뉴: View → Appearance → Move Side Bar Right

**패널 위치 변경:**
- 패널 우클릭 → Move Panel Right/Left/Bottom

**글꼴 변경:**
```json
{
  "editor.fontFamily": "Consolas, 'Courier New', monospace",
  "editor.fontSize": 14,
  "editor.lineHeight": 1.6
}
```

```text
바데부: "자신에게 편한 레이아웃을 찾는 게 중요해!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ VS Code의 5가지 주요 영역
- ✅ Activity Bar와 Side Bar 사용법
- ✅ Editor Group과 Panel 활용
- ✅ Command Palette와 Quick Open
- ✅ 필수 단축키

```text
바데부: "인터페이스를 이해했으니 이제 진짜 VS Code를 쓸 수 있어!
       다음 챕터에서는 파일과 폴더를 관리하는 방법을 배울 거야!"
```

## 다음 챕터 예고

다음 챕터에서는:
- 파일과 폴더 만들기, 삭제, 이동
- 프로젝트 구조 관리
- 파일 검색과 필터링
- Workspace 설정

**바데부와 함께 VS Code 정복하기! 계속 가자!**

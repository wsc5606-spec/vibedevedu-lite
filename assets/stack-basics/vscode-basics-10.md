# Chapter 10: 설정과 커스터마이징

VS Code를 완전히 내 것으로 만드는 마지막 단계입니다. 바데부와 함께 완벽한 개발 환경을 구축해봅시다!

## 10.1 설정의 종류

VS Code는 3가지 레벨의 설정을 제공합니다.

**1. User Settings (사용자 설정)**
```text
위치: 모든 프로젝트에 적용
파일: settings.json (전역)
용도: 개인 취향 설정
```

**2. Workspace Settings (작업 영역 설정)**
```text
위치: 현재 Workspace에만 적용
파일: .vscode/settings.json
용도: 프로젝트별 설정
```

**3. Folder Settings (폴더 설정)**
```text
위치: 특정 폴더에만 적용
파일: 폴더/.vscode/settings.json
용도: 멀티 루트 Workspace
```

**우선순위:**
```text
Folder Settings > Workspace Settings > User Settings
```

```text
바데부: "프로젝트마다 다른 설정이 필요하면 Workspace Settings를 써!"
```

## 10.2 설정 UI vs settings.json

**설정 UI 열기:**
- `Ctrl + ,`
- File → Preferences → Settings

```text
SETTINGS
┌──────────────────────────────┐
│ 🔍 Search settings...        │
├──────────────────────────────┤
│ Editor                       │
│   Font Size: 14              │
│   Tab Size: 2                │
│   Word Wrap: off             │
└──────────────────────────────┘
```

**settings.json 열기:**
1. 설정 UI에서 우측 상단 `{}` 아이콘
2. 또는 `Ctrl + Shift + P` → "Preferences: Open Settings (JSON)"

```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "editor.wordWrap": "off"
}
```

**어떤 걸 써야 할까?**
```text
UI: 간단한 설정, 탐색할 때
JSON: 복잡한 설정, 빠른 수정
```

```text
바데부: "나는 JSON을 주로 써. 복사 붙여넣기가 편하거든!"
```

## 10.3 필수 에디터 설정

바데부가 추천하는 에디터 기본 설정입니다.

**글꼴과 크기:**
```json
{
  "editor.fontFamily": "Consolas, 'Courier New', monospace",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "editor.lineHeight": 1.6
}
```

**들여쓰기:**
```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": true
}
```

**자동 저장:**
```json
{
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000
}
```

**줄 번호와 표시:**
```json
{
  "editor.lineNumbers": "on",
  "editor.rulers": [80, 120],
  "editor.renderWhitespace": "boundary",
  "editor.cursorBlinking": "smooth"
}
```

**포맷팅:**
```json
{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
```

**미니맵:**
```json
{
  "editor.minimap.enabled": true,
  "editor.minimap.maxColumn": 120,
  "editor.minimap.showSlider": "always"
}
```

```text
바데부: "이 설정들은 내가 여러 프로젝트를 하면서 최적화한 거야!"
```

## 10.4 UI 커스터마이징

**워크벤치 설정:**
```json
{
  "workbench.startupEditor": "none",
  "workbench.statusBar.visible": true,
  "workbench.activityBar.visible": true,
  "workbench.sideBar.location": "left",
  "workbench.editor.enablePreview": false,
  "workbench.editor.showTabs": true
}
```

**탐색기 설정:**
```json
{
  "explorer.confirmDelete": true,
  "explorer.confirmDragAndDrop": true,
  "explorer.sortOrder": "type",
  "explorer.autoReveal": true
}
```

**브레드크럼:**
```json
{
  "breadcrumbs.enabled": true,
  "breadcrumbs.filePath": "on",
  "breadcrumbs.symbolPath": "on"
}
```

**Zen Mode:**
```json
{
  "zenMode.fullScreen": true,
  "zenMode.centerLayout": true,
  "zenMode.hideStatusBar": true,
  "zenMode.hideLineNumbers": false
}
```

```text
바데부: "UI를 내 스타일대로 바꾸면 작업이 훨씬 편해져!"
```

## 10.5 색상 테마 커스터마이징

**테마 변경:**
- `Ctrl + K` → `Ctrl + T`

**색상 직접 수정:**
```json
{
  "workbench.colorTheme": "One Dark Pro",
  "workbench.colorCustomizations": {
    "editor.background": "#1e1e1e",
    "editor.foreground": "#d4d4d4",
    "activityBar.background": "#2c2c2c",
    "sideBar.background": "#252526",
    "statusBar.background": "#007acc"
  }
}
```

**토큰 색상 커스터마이징:**
```json
{
  "editor.tokenColorCustomizations": {
    "comments": "#6A9955",
    "strings": "#CE9178",
    "keywords": "#569CD6",
    "numbers": "#B5CEA8",
    "functions": "#DCDCAA"
  }
}
```

**시맨틱 하이라이팅:**
```json
{
  "editor.semanticHighlighting.enabled": true,
  "editor.semanticTokenColorCustomizations": {
    "rules": {
      "function": "#DCDCAA",
      "variable": "#9CDCFE",
      "property": "#CE9178"
    }
  }
}
```

```text
바데부: "테마 색상을 미세 조정하면 눈에 더 편해!"
```

## 10.6 아이콘 테마

**설치 및 변경:**
```json
{
  "workbench.iconTheme": "material-icon-theme"
}
```

**Material Icon Theme 커스터마이징:**
```json
{
  "material-icon-theme.folders.color": "#90a4ae",
  "material-icon-theme.folders.theme": "specific",
  "material-icon-theme.activeIconPack": "react",
  "material-icon-theme.opacity": 1
}
```

**파일별 아이콘 연결:**
```json
{
  "material-icon-theme.files.associations": {
    "*.config.js": "config",
    "*.routes.js": "routing",
    "*.test.js": "test"
  }
}
```

```text
바데부: "아이콘 테마를 쓰면 파일 종류를 한눈에 알아볼 수 있어!"
```

## 10.7 터미널 커스터마이징

**기본 터미널:**
```json
{
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.integrated.defaultProfile.linux": "bash"
}
```

**터미널 외관:**
```json
{
  "terminal.integrated.fontFamily": "Consolas",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.lineHeight": 1.2,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.cursorBlinking": true
}
```

**터미널 동작:**
```json
{
  "terminal.integrated.scrollback": 10000,
  "terminal.integrated.confirmOnExit": "hasChildProcesses",
  "terminal.integrated.enableBell": false,
  "terminal.integrated.copyOnSelection": true
}
```

**터미널 색상:**
```json
{
  "workbench.colorCustomizations": {
    "terminal.background": "#1E1E1E",
    "terminal.foreground": "#CCCCCC",
    "terminal.ansiBlack": "#000000",
    "terminal.ansiRed": "#E06C75",
    "terminal.ansiGreen": "#98C379",
    "terminal.ansiYellow": "#E5C07B",
    "terminal.ansiBlue": "#61AFEF",
    "terminal.ansiMagenta": "#C678DD",
    "terminal.ansiCyan": "#56B6C2",
    "terminal.ansiWhite": "#ABB2BF"
  }
}
```

```text
바데부: "터미널도 예쁘게 꾸미면 기분이 좋아져!"
```

## 10.8 언어별 설정

특정 언어에만 적용되는 설정입니다.

**JavaScript/TypeScript:**
```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2,
    "editor.formatOnSave": true
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2
  }
}
```

**HTML/CSS:**
```json
{
  "[html]": {
    "editor.defaultFormatter": "vscode.html-language-features",
    "editor.tabSize": 2
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2
  }
}
```

**Python:**
```json
{
  "[python]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.python"
  }
}
```

**Markdown:**
```json
{
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": false,
    "editor.formatOnSave": false
  }
}
```

```text
바데부: "언어마다 스타일 가이드가 다르니까 언어별 설정이 필수야!"
```

## 10.9 프로젝트 설정 공유

팀원과 설정을 공유하는 방법입니다.

**.vscode/settings.json:**
```json
{
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true
  }
}
```

**.vscode/extensions.json:**
```json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "eamodio.gitlens"
  ]
}
```

**.vscode/launch.json:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/app.js"
    }
  ]
}
```

**.vscode/tasks.json:**
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "npm",
      "script": "build",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```

**Git에 포함:**
```gitignore
# .gitignore
# VS Code 프로젝트 설정은 포함
!.vscode/

# 개인 설정은 제외
.vscode/settings.json
```

```text
바데부: "팀 프로젝트에서는 .vscode 폴더를 Git에 올려서 설정을 공유해!"
```

## 10.10 바데부의 완벽한 settings.json

실전에서 사용하는 바데부의 설정 전체 공개!

```json
{
  // 에디터 기본
  "editor.fontSize": 14,
  "editor.fontFamily": "Consolas, 'Courier New', monospace",
  "editor.lineHeight": 1.6,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,

  // 자동 저장
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,

  // 포맷팅
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",

  // UI
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "none",
  "workbench.editor.enablePreview": false,

  // 미니맵
  "editor.minimap.enabled": true,
  "editor.minimap.showSlider": "always",

  // 터미널
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.scrollback": 10000,

  // Git
  "git.autofetch": true,
  "git.confirmSync": false,

  // 파일 제외
  "files.exclude": {
    "**/.git": true,
    "**/node_modules": true,
    "**/.DS_Store": true
  },

  // 검색 제외
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true
  },

  // 언어별 설정
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[python]": {
    "editor.tabSize": 4
  },
  "[markdown]": {
    "editor.wordWrap": "on"
  },

  // Emmet
  "emmet.triggerExpansionOnTab": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  },

  // Prettier
  "prettier.singleQuote": true,
  "prettier.semi": true,
  "prettier.tabWidth": 2,

  // ESLint
  "eslint.enable": true,
  "eslint.autoFixOnSave": true,

  // 기타
  "breadcrumbs.enabled": true,
  "explorer.confirmDelete": false,
  "editor.suggestSelection": "first",
  "editor.snippetSuggestions": "top"
}
```

```text
바데부: "이 설정은 수년간 다듬어온 거야. 복사해서 써도 돼!"
```

## 10.11 설정 동기화

여러 컴퓨터에서 같은 설정을 사용할 수 있습니다.

**설정 동기화 켜기:**
1. 왼쪽 하단 계정 아이콘 클릭
2. "Turn on Settings Sync" 선택
3. GitHub/Microsoft 계정으로 로그인
4. 동기화할 항목 선택

**동기화 항목:**
```text
✓ Settings (설정)
✓ Keyboard Shortcuts (단축키)
✓ Extensions (확장 프로그램)
✓ UI State (UI 상태)
✓ Snippets (스니펫)
```

**장점:**
```text
- 회사 PC와 집 PC 설정 통일
- 새 컴퓨터 설정 자동
- 백업 역할
```

```text
바데부: "집과 회사에서 똑같은 환경으로 개발할 수 있어서 편해!"
```

## 10.12 성능 최적화

VS Code를 더 빠르게 만드는 설정입니다.

**파일 감시 최적화:**
```json
{
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/node_modules/**": true,
    "**/dist/**": true
  }
}
```

**검색 최적화:**
```json
{
  "search.followSymlinks": false,
  "search.smartCase": true,
  "search.quickOpen.includeSymbols": false
}
```

**에디터 최적화:**
```json
{
  "editor.renderWhitespace": "selection",
  "editor.renderControlCharacters": false,
  "editor.smoothScrolling": false,
  "editor.cursorSmoothCaretAnimation": false
}
```

**확장 프로그램 관리:**
```text
안 쓰는 확장 비활성화
→ Extensions 뷰에서 "Disable"
→ 필요할 때만 활성화
```

**큰 파일 처리:**
```json
{
  "files.maxMemoryForLargeFilesMB": 4096
}
```

```text
바데부: "프로젝트가 커지면 성능 최적화가 중요해!"
```

## 10.13 실습: 나만의 설정 만들기

바데부와 함께 완벽한 환경 구축!

**Step 1: 기본 설정**
```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "files.autoSave": "afterDelay",
  "editor.formatOnSave": true
}
```

**Step 2: 테마 선택**
```json
{
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme"
}
```

**Step 3: 필수 확장 설치**
```text
- Prettier
- ESLint
- GitLens
- Auto Rename Tag
- Live Server
```

**Step 4: 언어별 설정**
```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

**Step 5: 단축키 커스터마이징**
```text
자주 쓰는 명령어에 단축키 추가
```

**Step 6: 설정 동기화**
```text
Settings Sync 켜기
→ GitHub 연결
→ 백업 완료!
```

```text
바데부: "이제 완벽한 개발 환경이 완성됐어!"
```

## 10.14 문제 해결

자주 발생하는 문제와 해결 방법입니다.

**느려졌을 때:**
```text
1. 확장 프로그램 확인 (비활성화 테스트)
2. 캐시 삭제 (Developer: Reload Window)
3. 큰 파일 제외 설정
4. VS Code 재설치
```

**설정이 적용 안 될 때:**
```text
1. User vs Workspace 설정 확인
2. settings.json 문법 오류 확인
3. VS Code 재시작
4. 확장 프로그램 충돌 확인
```

**확장이 작동 안 할 때:**
```text
1. 확장 재설치
2. VS Code 버전 확인
3. 로그 확인 (Output 패널)
4. 개발자 도구 (Help → Toggle Developer Tools)
```

**Git이 인식 안 될 때:**
```text
1. Git 설치 확인 (git --version)
2. PATH 환경 변수 확인
3. VS Code 재시작
4. Git 경로 수동 설정
```

```text
바데부: "문제가 생기면 당황하지 말고 하나씩 체크해봐!"
```

## 10.15 VS Code 고급 기능

**멀티 루트 Workspace:**
```json
{
  "folders": [
    { "path": "frontend" },
    { "path": "backend" },
    { "path": "mobile" }
  ]
}
```

**사용자 정의 Task:**
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Deploy",
      "type": "shell",
      "command": "npm run build && npm run deploy"
    }
  ]
}
```

**프로파일:**
```text
개발/디버깅/프레젠테이션 등
상황별 설정 프로파일 만들기
```

```text
바데부: "고급 기능까지 익히면 진정한 VS Code 마스터야!"
```

## 요약

이번 챕터에서 배운 내용:
- ✅ User/Workspace/Folder 설정
- ✅ 에디터와 UI 커스터마이징
- ✅ 색상 테마와 아이콘 커스터마이징
- ✅ 프로젝트 설정 공유
- ✅ 성능 최적화

```text
바데부: "설정을 내 취향대로 바꾸니까 VS Code가 완전히 내 것이 된 느낌이야!
       이제 VS Code의 모든 걸 배웠어!"
```

## 최종 정리

**VS Code 학습 여정:**
```text
Chapter 1: 설치 및 소개
Chapter 2: 인터페이스 이해
Chapter 3: 파일 관리
Chapter 4: 편집 기능
Chapter 5: 확장 프로그램
Chapter 6: 디버깅
Chapter 7: Git 통합
Chapter 8: 터미널
Chapter 9: 단축키
Chapter 10: 커스터마이징 ← 완료!
```

**바데부의 마지막 조언:**
```text
1. 매일 조금씩 새로운 기능 익히기
2. 단축키는 실전에서 손으로 익히기
3. 커뮤니티에서 팁 공유하기
4. 자신만의 워크플로우 만들기
5. 즐겁게 코딩하기!
```

**다음 단계:**
```text
✓ VS Code 마스터 완료
→ 실전 프로젝트에 적용
→ 팀원들에게 노하우 공유
→ 계속해서 새로운 기능 탐구
```

```text
바데부: "축하해! 이제 VS Code를 완전히 내 것으로 만들었어!
       이 지식으로 멋진 프로젝트를 많이 만들길 바라!
       코딩은 도구가 아니라 즐거움이야. 화이팅!"
```

## 부록: 유용한 리소스

**공식 문서:**
- VS Code 공식 문서: https://code.visualstudio.com/docs
- 단축키 참고: https://code.visualstudio.com/shortcuts

**커뮤니티:**
- VS Code GitHub: https://github.com/microsoft/vscode
- Stack Overflow: #visual-studio-code
- Reddit: r/vscode

**확장 마켓플레이스:**
- https://marketplace.visualstudio.com

**바데부의 추천 채널:**
- YouTube: "VS Code Tips and Tricks"
- Blog: VS Code 공식 블로그

**연락처:**
```text
질문이나 피드백:
📧 badebu@vibedev.edu
🌐 vibedev.edu
```

**끝!**

```text
바데부: "10개의 챕터를 모두 완주했어! 정말 수고 많았어!
       이제 VS Code와 함께 멋진 코딩 여정을 시작해봐!
       언제나 응원할게! 😊"
```

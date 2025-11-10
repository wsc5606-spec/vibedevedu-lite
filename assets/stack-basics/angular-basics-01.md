# Chapter 1: Angular 소개 및 시작하기

안녕하세요! 바데부입니다! 오늘은 Angular에 대해 알아볼 거예요. Angular는 구글이 만든 강력한 웹 프레임워크예요! 🎯

## 1.1 Angular란?

Angular는 구글이 개발한 TypeScript 기반의 풀스택 웹 프레임워크입니다. 대규모 엔터프라이즈 애플리케이션을 만들기에 최적화되어 있어요!

**Angular의 특징:**
- TypeScript 기반의 강력한 타입 시스템
- 컴포넌트 기반 아키텍처
- 양방향 데이터 바인딩
- 의존성 주입 (Dependency Injection)
- 강력한 CLI 도구
- 라우팅, HTTP, Forms 등 모든 기능 내장

## 1.2 Angular vs React vs Vue

### Angular의 장점
```typescript
// Angular는 모든 것이 포함되어 있어요!
@Component({
  selector: 'app-user',
  template: `<h1>{{ name }}</h1>`
})
export class UserComponent {
  name = '바데부';
}
```

**왜 Angular를 선택할까요?**
- **올인원 프레임워크**: 라우팅, HTTP, Forms 등 모두 포함
- **TypeScript 최적화**: 강력한 타입 안전성
- **엔터프라이즈 급**: 대규모 프로젝트에 적합
- **구글의 지원**: 장기적인 유지보수 보장
- **RxJS 통합**: 반응형 프로그래밍 지원

**다른 프레임워크와의 비교:**
| 특징 | Angular | React | Vue |
|------|---------|-------|-----|
| 타입 | 프레임워크 | 라이브러리 | 프레임워크 |
| 언어 | TypeScript | JavaScript | JavaScript |
| 학습 곡선 | 가파름 | 중간 | 완만함 |
| 규모 | 대규모 | 모든 규모 | 중소규모 |

## 1.3 개발 환경 설정하기

### 필수 프로그램 설치

**1단계: Node.js 설치**
```bash
# Node.js 버전 확인
node --version  # v18 이상 권장
npm --version   # v9 이상 권장
```

[nodejs.org](https://nodejs.org)에서 LTS 버전을 다운로드하세요!

**2단계: Angular CLI 설치**
```bash
# Angular CLI를 전역으로 설치
npm install -g @angular/cli

# 설치 확인
ng version
```

### Visual Studio Code 추천 확장

1. **Angular Language Service** - Angular 지원
2. **Angular Snippets** - 코드 스니펫
3. **ESLint** - 코드 품질 검사
4. **Prettier** - 코드 포맷팅

## 1.4 첫 번째 Angular 프로젝트 생성

### 프로젝트 생성하기

```bash
# 새 프로젝트 생성
ng new badb-first-app

# 질문에 답하기
? Would you like to add Angular routing? (y/N) y
? Which stylesheet format would you like to use? SCSS

# 프로젝트 폴더로 이동
cd badb-first-app

# 개발 서버 실행
ng serve
```

**브라우저에서 확인:**
[http://localhost:4200](http://localhost:4200) 접속!

## 1.5 프로젝트 구조 이해하기

```
badb-first-app/
├── src/
│   ├── app/                 # 앱 컴포넌트
│   │   ├── app.component.ts
│   │   ├── app.component.html
│   │   ├── app.component.scss
│   │   └── app.component.spec.ts
│   ├── assets/              # 이미지, 폰트 등
│   ├── environments/        # 환경 설정
│   ├── index.html          # 메인 HTML
│   ├── main.ts             # 진입점
│   └── styles.scss         # 글로벌 스타일
├── angular.json            # Angular 설정
├── package.json            # 의존성 관리
└── tsconfig.json           # TypeScript 설정
```

**주요 파일 설명:**

**app.component.ts** - 컴포넌트 로직
```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'badb-first-app';
}
```

**app.component.html** - 컴포넌트 템플릿
```html
<h1>안녕하세요, {{ title }}!</h1>
```

## 1.6 첫 번째 수정하기

### app.component.ts 수정

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = '바데부와 함께하는 Angular';
  message = 'Angular는 재미있어요!';
  count = 0;

  incrementCount() {
    this.count++;
  }
}
```

### app.component.html 수정

```html
<div class="container">
  <h1>{{ title }}</h1>
  <p>{{ message }}</p>

  <div class="counter">
    <p>클릭 횟수: {{ count }}</p>
    <button (click)="incrementCount()">클릭!</button>
  </div>
</div>
```

### app.component.scss 수정

```scss
.container {
  text-align: center;
  padding: 2rem;

  h1 {
    color: #dd0031;
    font-size: 2.5rem;
  }

  .counter {
    margin-top: 2rem;

    button {
      padding: 0.5rem 1rem;
      font-size: 1rem;
      background-color: #1976d2;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;

      &:hover {
        background-color: #1565c0;
      }
    }
  }
}
```

저장하면 브라우저가 자동으로 새로고침돼요! 🎉

## 1.7 Angular CLI 주요 명령어

### 프로젝트 관리
```bash
# 개발 서버 실행
ng serve

# 개발 서버 (다른 포트)
ng serve --port 4300

# 개발 서버 (자동 열기)
ng serve --open

# 프로덕션 빌드
ng build

# 프로덕션 빌드 (최적화)
ng build --prod
```

### 컴포넌트 생성
```bash
# 컴포넌트 생성
ng generate component user
# 또는 단축어
ng g c user

# 서비스 생성
ng generate service user
# 또는
ng g s user

# 모듈 생성
ng generate module feature
# 또는
ng g m feature
```

## 1.8 Angular의 핵심 개념

### 1. 컴포넌트 (Component)
UI의 기본 단위예요. 뷰와 로직을 포함해요!

```typescript
@Component({
  selector: 'app-user',     // HTML 태그명
  templateUrl: './user.component.html',  // 템플릿
  styleUrls: ['./user.component.scss']   // 스타일
})
export class UserComponent {
  // 컴포넌트 로직
}
```

### 2. 모듈 (Module)
관련된 컴포넌트를 그룹화해요!

```typescript
@NgModule({
  declarations: [AppComponent],  // 컴포넌트
  imports: [BrowserModule],      // 다른 모듈
  providers: [],                 // 서비스
  bootstrap: [AppComponent]      // 루트 컴포넌트
})
export class AppModule { }
```

### 3. 서비스 (Service)
비즈니스 로직과 데이터를 관리해요!

```typescript
@Injectable({
  providedIn: 'root'
})
export class UserService {
  getUsers() {
    // 사용자 데이터 가져오기
  }
}
```

## 1.9 일반적인 실수와 해결방법

### 실수 1: CLI 설치 오류

```bash
# ❌ 권한 오류가 발생하면
npm install -g @angular/cli

# ✅ 관리자 권한으로 실행 (Windows)
# PowerShell을 관리자로 실행 후:
npm install -g @angular/cli

# ✅ sudo 사용 (Mac/Linux)
sudo npm install -g @angular/cli
```

### 실수 2: 포트가 이미 사용 중

```bash
# ❌ Port 4200 is already in use
ng serve

# ✅ 다른 포트 사용
ng serve --port 4300
```

### 실수 3: 모듈 임포트 누락

```typescript
// ❌ FormsModule 임포트 없이 ngModel 사용
<input [(ngModel)]="name">

// ✅ app.module.ts에 FormsModule 추가
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule  // 추가!
  ]
})
```

## 1.10 바데부의 실전 팁

### 팁 1: Angular DevTools 사용
Chrome 확장 프로그램 "Angular DevTools"를 설치하면 디버깅이 쉬워져요!

### 팁 2: 단축키 활용
```bash
ng g c user      # 컴포넌트
ng g s user      # 서비스
ng g m feature   # 모듈
ng g d highlight # 디렉티브
ng g p uppercase # 파이프
```

### 팁 3: Live Reload 활용
파일을 저장하면 브라우저가 자동으로 새로고침돼요. 개발이 정말 빨라져요! ⚡

### 팁 4: Angular 버전 확인
```bash
# Angular 버전 확인
ng version

# 패키지 버전 확인
npm list @angular/core
```

## 연습 문제

1. Angular CLI를 설치하고 버전을 확인해보세요
2. 새 프로젝트를 생성하고 개발 서버를 실행해보세요
3. app.component.ts에 새로운 프로퍼티를 추가하고 템플릿에 표시해보세요
4. 버튼을 클릭하면 메시지가 바뀌는 기능을 만들어보세요

## 다음 단계

다음 챕터에서는 **TypeScript 기초**를 배워봅시다! Angular는 TypeScript로 작성되기 때문에, TypeScript를 알아야 Angular를 제대로 사용할 수 있어요!

## 핵심 요약

- Angular는 구글이 만든 TypeScript 기반의 풀스택 프레임워크
- Angular CLI로 프로젝트를 쉽게 생성하고 관리할 수 있음
- 컴포넌트, 모듈, 서비스가 Angular의 핵심 개념
- `ng serve`로 개발 서버를 실행하고 실시간으로 변경사항 확인
- `ng generate` 명령어로 컴포넌트, 서비스 등을 자동 생성
- 파일을 저장하면 브라우저가 자동으로 새로고침 (Live Reload)

바데부와 함께 Angular를 마스터해봅시다! 🚀

# Chapter 10: 배포 및 베스트 프랙티스

안녕하세요! 바데부입니다! 마지막 챕터예요! Angular 앱을 배포하고 최적화하는 방법을 배워봅시다! 🚀

## 10.1 프로덕션 빌드

### 개발 vs 프로덕션
```bash
# 개발 서버 (개발 중)
ng serve

# 프로덕션 빌드
ng build

# 프로덕션 최적화 빌드 (권장)
ng build --configuration production
# 또는 단축어
ng build --prod
```

### 빌드 결과물
```
dist/
└── my-app/
    ├── index.html
    ├── main.js          (압축됨)
    ├── polyfills.js
    ├── runtime.js
    ├── styles.css
    └── assets/
```

### 빌드 최적화 확인
```bash
# 빌드 통계
ng build --stats-json

# Bundle Analyzer 설치
npm install -g webpack-bundle-analyzer

# 분석
webpack-bundle-analyzer dist/my-app/stats.json
```

## 10.2 환경 설정

### 환경 파일
```
src/
└── environments/
    ├── environment.ts           (개발)
    └── environment.prod.ts      (프로덕션)
```

```typescript
// environment.ts (개발)
export const environment = {
  production: false,
  apiUrl: 'http://localhost:3000/api',
  firebase: {
    apiKey: 'dev-key',
    projectId: 'dev-project'
  }
};
```

```typescript
// environment.prod.ts (프로덕션)
export const environment = {
  production: true,
  apiUrl: 'https://api.example.com',
  firebase: {
    apiKey: 'prod-key',
    projectId: 'prod-project'
  }
};
```

### 환경 사용
```typescript
import { environment } from '../environments/environment';

export class ApiService {
  private apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) {
    console.log('Production?', environment.production);
  }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(`${this.apiUrl}/users`);
  }
}
```

## 10.3 Firebase Hosting 배포

### Firebase CLI 설치
```bash
# Firebase CLI 설치
npm install -g firebase-tools

# Firebase 로그인
firebase login

# 프로젝트 초기화
firebase init hosting
```

### firebase.json 설정
```json
{
  "hosting": {
    "public": "dist/my-app",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

### 배포
```bash
# 빌드
ng build --prod

# 배포
firebase deploy --only hosting

# 미리보기
firebase hosting:channel:deploy preview
```

## 10.4 Netlify 배포

### netlify.toml 설정
```toml
[build]
  command = "ng build --prod"
  publish = "dist/my-app"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

### 배포 방법
1. GitHub에 푸시
2. Netlify에서 저장소 연결
3. 자동 배포 설정

## 10.5 성능 최적화

### Lazy Loading (지연 로딩)
```typescript
// app-routing.module.ts
const routes: Routes = [
  { path: '', component: HomeComponent },
  {
    path: 'admin',
    loadChildren: () => import('./admin/admin.module').then(m => m.AdminModule)
  },
  {
    path: 'user',
    loadChildren: () => import('./user/user.module').then(m => m.UserModule)
  }
];
```

**장점:**
- 초기 로딩 시간 단축
- 번들 크기 감소
- 필요할 때만 로딩

### OnPush 변경 감지 전략
```typescript
import { ChangeDetectionStrategy } from '@angular/core';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush  // 최적화!
})
export class UserComponent {
  @Input() user!: User;
}
```

### TrackBy 함수 사용
```typescript
export class UserListComponent {
  users: User[] = [];

  trackByUserId(index: number, user: User): number {
    return user.id;  // 고유 식별자
  }
}
```

```html
<ul>
  <li *ngFor="let user of users; trackBy: trackByUserId">
    {{ user.name }}
  </li>
</ul>
```

### Pure Pipes 사용
```typescript
@Pipe({
  name: 'uppercase',
  pure: true  // 기본값, 입력이 변경될 때만 실행
})
export class UppercasePipe implements PipeTransform {
  transform(value: string): string {
    return value.toUpperCase();
  }
}
```

## 10.6 보안 베스트 프랙티스

### XSS 방어
```typescript
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

export class ContentComponent {
  constructor(private sanitizer: DomSanitizer) {}

  // ❌ 위험: innerHTML에 직접 바인딩
  dangerousHtml = '<script>alert("XSS")</script>';

  // ✅ 안전: Sanitizer 사용
  getSafeHtml(html: string): SafeHtml {
    return this.sanitizer.sanitize(SecurityContext.HTML, html) || '';
  }
}
```

```html
<!-- ✅ 안전: Angular가 자동으로 이스케이프 -->
<p>{{ userInput }}</p>

<!-- ❌ 위험: innerHTML 사용 시 주의 -->
<div [innerHTML]="getSafeHtml(userInput)"></div>
```

### 환경 변수 보안
```typescript
// ❌ 나쁜 방법: 코드에 직접 작성
const apiKey = 'secret-key-12345';

// ✅ 좋은 방법: 환경 변수 사용
const apiKey = environment.apiKey;
```

```bash
# .gitignore
environment.prod.ts  # 프로덕션 환경 파일 제외
.env
.env.local
```

### HTTPS 사용
```typescript
// Angular CLI는 기본적으로 HTTPS 권장

// firebase.json
{
  "hosting": {
    "headers": [
      {
        "source": "**",
        "headers": [
          {
            "key": "Strict-Transport-Security",
            "value": "max-age=31536000; includeSubDomains"
          }
        ]
      }
    ]
  }
}
```

## 10.7 SEO 최적화

### Angular Universal (SSR)
```bash
# Angular Universal 추가
ng add @nguniversal/express-engine

# SSR 빌드
npm run build:ssr

# SSR 서버 실행
npm run serve:ssr
```

### Meta 태그 추가
```typescript
import { Meta, Title } from '@angular/platform-browser';

export class HomeComponent implements OnInit {
  constructor(
    private meta: Meta,
    private title: Title
  ) {}

  ngOnInit(): void {
    // 타이틀 설정
    this.title.setTitle('바데부 - Angular 학습 플랫폼');

    // 메타 태그 설정
    this.meta.updateTag({
      name: 'description',
      content: 'Angular를 재미있게 배우는 플랫폼'
    });

    this.meta.updateTag({
      property: 'og:title',
      content: '바데부 - Angular 학습'
    });

    this.meta.updateTag({
      property: 'og:description',
      content: 'Angular를 쉽게 배워보세요'
    });
  }
}
```

## 10.8 코드 품질

### ESLint 설정
```bash
# ESLint 추가
ng add @angular-eslint/schematics

# Lint 실행
ng lint

# 자동 수정
ng lint --fix
```

```json
// .eslintrc.json
{
  "rules": {
    "@typescript-eslint/no-explicit-any": "error",
    "@angular-eslint/component-selector": [
      "error",
      {
        "type": "element",
        "prefix": "app",
        "style": "kebab-case"
      }
    ]
  }
}
```

### Prettier 설정
```bash
npm install --save-dev prettier

# .prettierrc
{
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 100,
  "semi": true
}
```

### 타입 안전성
```typescript
// ✅ 좋은 방법: 명시적 타입
interface User {
  id: number;
  name: string;
  email: string;
}

getUsers(): Observable<User[]> {
  return this.http.get<User[]>(this.apiUrl);
}

// ❌ 나쁜 방법: any 사용
getUsers(): Observable<any> {
  return this.http.get(this.apiUrl);
}
```

## 10.9 테스트

### 유닛 테스트
```typescript
// user.component.spec.ts
import { ComponentFixture, TestBed } from '@angular/core/testing';

describe('UserComponent', () => {
  let component: UserComponent;
  let fixture: ComponentFixture<UserComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UserComponent ]
    }).compileComponents();

    fixture = TestBed.createComponent(UserComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should display user name', () => {
    component.user = { id: 1, name: '바데부', age: 3 };
    fixture.detectChanges();

    const compiled = fixture.nativeElement;
    expect(compiled.querySelector('h2')?.textContent).toContain('바데부');
  });
});
```

```bash
# 테스트 실행
ng test

# 커버리지 확인
ng test --code-coverage
```

## 10.10 모니터링과 로깅

### Error Tracking (Sentry)
```bash
npm install --save @sentry/angular
```

```typescript
// app.module.ts
import * as Sentry from '@sentry/angular';

Sentry.init({
  dsn: 'your-sentry-dsn',
  environment: environment.production ? 'production' : 'development'
});

@NgModule({
  providers: [
    {
      provide: ErrorHandler,
      useValue: Sentry.createErrorHandler()
    }
  ]
})
```

### Analytics (Google Analytics)
```bash
npm install --save @angular/fire
```

```typescript
// app.module.ts
import { AngularFireModule } from '@angular/fire/compat';
import { AngularFireAnalyticsModule } from '@angular/fire/compat/analytics';

@NgModule({
  imports: [
    AngularFireModule.initializeApp(environment.firebase),
    AngularFireAnalyticsModule
  ]
})
```

```typescript
// component.ts
import { AngularFireAnalytics } from '@angular/fire/compat/analytics';

export class Component {
  constructor(private analytics: AngularFireAnalytics) {}

  trackEvent(eventName: string): void {
    this.analytics.logEvent(eventName, {
      component: 'UserComponent',
      timestamp: Date.now()
    });
  }
}
```

## 10.11 프로젝트 구조

### 추천 폴더 구조
```
src/
├── app/
│   ├── core/                  # 싱글톤 서비스
│   │   ├── services/
│   │   ├── guards/
│   │   └── interceptors/
│   ├── shared/                # 공유 컴포넌트
│   │   ├── components/
│   │   ├── directives/
│   │   └── pipes/
│   ├── features/              # 기능별 모듈
│   │   ├── user/
│   │   │   ├── components/
│   │   │   ├── services/
│   │   │   └── user.module.ts
│   │   └── admin/
│   ├── app.component.ts
│   ├── app.module.ts
│   └── app-routing.module.ts
├── assets/
├── environments/
└── styles.scss
```

### 모듈 구조
```typescript
// feature.module.ts
@NgModule({
  declarations: [
    // 이 모듈의 컴포넌트
  ],
  imports: [
    CommonModule,
    SharedModule,
    FeatureRoutingModule
  ],
  providers: [
    // 이 모듈의 서비스
  ]
})
export class FeatureModule { }
```

## 10.12 체크리스트

### 배포 전 체크리스트
```markdown
✅ 프로덕션 빌드 성공
✅ 모든 테스트 통과
✅ Lint 오류 없음
✅ 환경 변수 설정 확인
✅ API 엔드포인트 확인
✅ 보안 취약점 검사
✅ 성능 최적화 적용
✅ 브라우저 호환성 테스트
✅ 모바일 반응형 확인
✅ SEO 메타 태그 설정
```

### 성능 체크리스트
```markdown
✅ Lazy Loading 적용
✅ OnPush 전략 사용
✅ TrackBy 함수 사용
✅ Pure Pipes 사용
✅ 이미지 최적화
✅ Bundle 크기 확인
✅ Lighthouse 점수 80점 이상
```

## 10.13 유용한 명령어

### Angular CLI
```bash
# 버전 확인
ng version

# 새 컴포넌트 생성
ng g c component-name

# 새 서비스 생성
ng g s service-name

# 빌드
ng build --prod

# 테스트
ng test

# Lint
ng lint --fix

# 업데이트
ng update @angular/cli @angular/core

# 패키지 분석
ng build --stats-json
```

### npm 스크립트
```json
{
  "scripts": {
    "start": "ng serve",
    "build": "ng build --prod",
    "test": "ng test",
    "lint": "ng lint",
    "deploy": "ng build --prod && firebase deploy"
  }
}
```

## 연습 문제

1. 프로덕션 빌드를 생성하고 Firebase에 배포하세요
2. Lazy Loading을 적용하여 초기 번들 크기를 줄이세요
3. OnPush 전략을 사용하여 컴포넌트를 최적화하세요
4. 유닛 테스트를 작성하고 실행하세요

## 축하합니다! 🎉

바데부와 함께 Angular의 모든 기초를 마스터했어요!

**배운 내용:**
1. Angular 소개 및 시작하기
2. TypeScript 기초
3. 컴포넌트와 템플릿
4. 데이터 바인딩
5. 디렉티브
6. 서비스와 의존성 주입
7. 라우팅
8. HTTP 통신
9. 폼
10. 배포 및 베스트 프랙티스

**다음 단계:**
- 실제 프로젝트 만들기
- RxJS 깊이 배우기
- NgRx 상태 관리
- Angular Material 사용
- 테스트 코드 작성
- 성능 최적화 심화

## 핵심 요약

- `ng build --prod`로 프로덕션 빌드
- environment 파일로 환경별 설정 관리
- Firebase/Netlify로 간단하게 배포
- Lazy Loading으로 성능 최적화
- OnPush 전략으로 변경 감지 최적화
- XSS 방어와 HTTPS 사용
- ESLint와 Prettier로 코드 품질 유지
- 유닛 테스트 작성
- Sentry/Analytics로 모니터링
- 체계적인 프로젝트 구조 유지

바데부와 함께 Angular를 완전히 마스터했어요! 이제 멋진 앱을 만들어보세요! 🚀✨

# Chapter 7: 라우팅

안녕하세요! 바데부입니다! 이번에는 Angular의 라우팅을 배워볼 거예요. 여러 페이지를 만들고 이동하는 방법을 알아봅시다! 🗺️

## 7.1 라우팅이란?

라우팅은 URL에 따라 다른 컴포넌트를 표시하는 기능이에요. SPA(Single Page Application)에서 페이지 이동을 구현해요!

**라우팅의 장점:**
- 페이지 새로고침 없이 이동
- 브라우저 뒤로가기/앞으로가기 지원
- URL 북마크 가능
- 깔끔한 URL 구조

## 7.2 라우팅 설정하기

### 프로젝트 생성 시 라우팅 포함
```bash
ng new my-app --routing
```

### 기존 프로젝트에 라우팅 추가
```typescript
// app-routing.module.ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
```

### app.component.html에 router-outlet 추가
```html
<!-- app.component.html -->
<nav>
  <a routerLink="/">홈</a>
  <a routerLink="/about">소개</a>
</nav>

<!-- 라우팅된 컴포넌트가 여기에 표시됨 -->
<router-outlet></router-outlet>
```

## 7.3 기본 라우트 설정

### 라우트 정의
```typescript
// app-routing.module.ts
const routes: Routes = [
  // 기본 경로 (/)
  { path: '', component: HomeComponent },

  // 정적 경로
  { path: 'about', component: AboutComponent },
  { path: 'contact', component: ContactComponent },

  // 와일드카드 경로 (404 페이지)
  { path: '**', component: NotFoundComponent }
];
```

### 컴포넌트 생성
```bash
ng g c home
ng g c about
ng g c contact
ng g c not-found
```

## 7.4 라우터 링크 (RouterLink)

### 기본 사용법
```html
<!-- 문자열 경로 -->
<a routerLink="/">홈</a>
<a routerLink="/about">소개</a>
<a routerLink="/contact">연락처</a>

<!-- 배열 형식 (권장) -->
<a [routerLink]="['/']">홈</a>
<a [routerLink]="['/about']">소개</a>
<a [routerLink]="['/user', userId]">사용자</a>

<!-- 버튼에도 사용 가능 -->
<button [routerLink]="['/about']">소개 페이지로</button>
```

### routerLinkActive - 활성 링크 스타일
```html
<nav>
  <a routerLink="/"
     routerLinkActive="active"
     [routerLinkActiveOptions]="{ exact: true }">
    홈
  </a>

  <a routerLink="/about"
     routerLinkActive="active">
    소개
  </a>

  <a routerLink="/contact"
     routerLinkActive="active">
    연락처
  </a>
</nav>
```

```scss
// styles.scss
nav a {
  padding: 0.5rem 1rem;
  text-decoration: none;
  color: #333;

  &.active {
    color: #1976d2;
    border-bottom: 2px solid #1976d2;
    font-weight: bold;
  }
}
```

## 7.5 라우트 매개변수

### 동적 라우트 정의
```typescript
const routes: Routes = [
  { path: 'user/:id', component: UserDetailComponent },
  { path: 'post/:id/:slug', component: PostDetailComponent }
];
```

### 매개변수 읽기 (ActivatedRoute)
```typescript
// user-detail.component.ts
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

export class UserDetailComponent implements OnInit {
  userId: string = '';

  constructor(private route: ActivatedRoute) {}

  ngOnInit(): void {
    // 방법 1: snapshot (한 번만 읽기)
    this.userId = this.route.snapshot.paramMap.get('id') || '';

    // 방법 2: Observable (계속 감지)
    this.route.paramMap.subscribe(params => {
      this.userId = params.get('id') || '';
      console.log('User ID:', this.userId);
      this.loadUser(this.userId);
    });
  }

  loadUser(id: string): void {
    // 사용자 데이터 로딩
  }
}
```

### 매개변수로 이동
```typescript
// user-list.component.ts
export class UserListComponent {
  users = [
    { id: 1, name: '바데부' },
    { id: 2, name: '철수' }
  ];

  constructor(private router: Router) {}

  goToUserDetail(userId: number): void {
    this.router.navigate(['/user', userId]);
  }
}
```

```html
<!-- user-list.component.html -->
<div *ngFor="let user of users">
  <h3>{{ user.name }}</h3>
  <button (click)="goToUserDetail(user.id)">상세보기</button>
  <!-- 또는 routerLink 사용 -->
  <a [routerLink]="['/user', user.id]">상세보기</a>
</div>
```

## 7.6 쿼리 파라미터

### 쿼리 파라미터 전달
```typescript
// search.component.ts
export class SearchComponent {
  constructor(private router: Router) {}

  search(keyword: string): void {
    // /search?keyword=angular&page=1
    this.router.navigate(['/search'], {
      queryParams: {
        keyword: keyword,
        page: 1
      }
    });
  }
}
```

```html
<!-- routerLink로 쿼리 파라미터 전달 -->
<a [routerLink]="['/search']"
   [queryParams]="{ keyword: 'angular', page: 1 }">
  검색
</a>
```

### 쿼리 파라미터 읽기
```typescript
// search-results.component.ts
export class SearchResultsComponent implements OnInit {
  keyword = '';
  page = 1;

  constructor(private route: ActivatedRoute) {}

  ngOnInit(): void {
    // 쿼리 파라미터 읽기
    this.route.queryParamMap.subscribe(params => {
      this.keyword = params.get('keyword') || '';
      this.page = Number(params.get('page')) || 1;
      console.log('검색어:', this.keyword, '페이지:', this.page);
      this.searchItems();
    });
  }

  searchItems(): void {
    // 검색 로직
  }
}
```

## 7.7 프로그래밍 방식 네비게이션

### Router 서비스 사용
```typescript
import { Router } from '@angular/router';

export class LoginComponent {
  constructor(private router: Router) {}

  onLoginSuccess(): void {
    // 절대 경로로 이동
    this.router.navigate(['/dashboard']);

    // 상대 경로로 이동
    this.router.navigate(['../admin'], { relativeTo: this.route });

    // 쿼리 파라미터와 함께
    this.router.navigate(['/search'], {
      queryParams: { q: 'angular' }
    });

    // fragment와 함께 (#section)
    this.router.navigate(['/about'], {
      fragment: 'team'
    });
  }

  goBack(): void {
    // 뒤로가기
    window.history.back();
  }
}
```

### navigateByUrl
```typescript
// 문자열 URL로 이동
this.router.navigateByUrl('/user/123');

// 쿼리 파라미터 포함
this.router.navigateByUrl('/search?keyword=angular');
```

## 7.8 중첩 라우트 (Nested Routes)

### 라우트 설정
```typescript
const routes: Routes = [
  {
    path: 'admin',
    component: AdminComponent,
    children: [
      { path: '', component: AdminDashboardComponent },
      { path: 'users', component: AdminUsersComponent },
      { path: 'settings', component: AdminSettingsComponent }
    ]
  }
];
```

### 부모 컴포넌트에 router-outlet
```html
<!-- admin.component.html -->
<div class="admin-layout">
  <aside>
    <nav>
      <a routerLink="/admin">대시보드</a>
      <a routerLink="/admin/users">사용자 관리</a>
      <a routerLink="/admin/settings">설정</a>
    </nav>
  </aside>

  <main>
    <!-- 자식 라우트가 여기에 표시 -->
    <router-outlet></router-outlet>
  </main>
</div>
```

## 7.9 라우트 가드 (Route Guards)

### CanActivate - 접근 권한 확인
```bash
ng generate guard auth
```

```typescript
// auth.guard.ts
import { Injectable } from '@angular/core';
import { CanActivate, Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    if (this.authService.isLoggedIn()) {
      return true;  // 접근 허용
    }

    // 로그인 페이지로 리다이렉트
    this.router.navigate(['/login'], {
      queryParams: { returnUrl: state.url }
    });
    return false;  // 접근 거부
  }
}
```

### 가드 적용
```typescript
const routes: Routes = [
  { path: 'login', component: LoginComponent },
  {
    path: 'dashboard',
    component: DashboardComponent,
    canActivate: [AuthGuard]  // 가드 적용
  },
  {
    path: 'admin',
    component: AdminComponent,
    canActivate: [AuthGuard],
    children: [...]
  }
];
```

### CanDeactivate - 페이지 이탈 확인
```typescript
// can-deactivate.guard.ts
export interface CanComponentDeactivate {
  canDeactivate: () => boolean | Observable<boolean>;
}

@Injectable({
  providedIn: 'root'
})
export class CanDeactivateGuard implements CanDeactivate<CanComponentDeactivate> {
  canDeactivate(
    component: CanComponentDeactivate
  ): boolean | Observable<boolean> {
    return component.canDeactivate();
  }
}
```

```typescript
// edit-user.component.ts
export class EditUserComponent implements CanComponentDeactivate {
  hasUnsavedChanges = false;

  canDeactivate(): boolean {
    if (this.hasUnsavedChanges) {
      return confirm('저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?');
    }
    return true;
  }
}
```

## 7.10 리다이렉트와 와일드카드

### 리다이렉트
```typescript
const routes: Routes = [
  { path: '', redirectTo: '/home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },

  // 구버전 URL을 새 URL로 리다이렉트
  { path: 'old-path', redirectTo: '/new-path', pathMatch: 'full' }
];
```

### 404 페이지
```typescript
const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },

  // 모든 잘못된 경로를 404 페이지로 (맨 마지막에 위치)
  { path: '**', component: NotFoundComponent }
];
```

```html
<!-- not-found.component.html -->
<div class="not-found">
  <h1>404</h1>
  <p>페이지를 찾을 수 없습니다</p>
  <button [routerLink]="['/']">홈으로 돌아가기</button>
</div>
```

## 7.11 레이지 로딩 (Lazy Loading)

### 기능 모듈 생성
```bash
ng generate module admin --routing
ng generate component admin/dashboard
```

### 레이지 로딩 설정
```typescript
// app-routing.module.ts
const routes: Routes = [
  { path: '', component: HomeComponent },
  {
    path: 'admin',
    loadChildren: () => import('./admin/admin.module').then(m => m.AdminModule)
  }
];
```

```typescript
// admin-routing.module.ts
const routes: Routes = [
  { path: '', component: AdminDashboardComponent },
  { path: 'users', component: AdminUsersComponent }
];
```

**장점:**
- 초기 번들 크기 감소
- 빠른 초기 로딩 시간
- 필요할 때만 모듈 로딩

## 7.12 라우팅 이벤트

### 라우팅 이벤트 감지
```typescript
import { Router, NavigationStart, NavigationEnd, NavigationError } from '@angular/router';

export class AppComponent implements OnInit {
  constructor(private router: Router) {}

  ngOnInit(): void {
    this.router.events.subscribe(event => {
      if (event instanceof NavigationStart) {
        console.log('네비게이션 시작:', event.url);
      }

      if (event instanceof NavigationEnd) {
        console.log('네비게이션 완료:', event.url);
      }

      if (event instanceof NavigationError) {
        console.error('네비게이션 오류:', event.error);
      }
    });
  }
}
```

### 로딩 인디케이터
```typescript
export class AppComponent {
  loading = false;

  constructor(private router: Router) {
    this.router.events.subscribe(event => {
      if (event instanceof NavigationStart) {
        this.loading = true;
      }
      if (event instanceof NavigationEnd || event instanceof NavigationError) {
        this.loading = false;
      }
    });
  }
}
```

```html
<div class="loading-bar" *ngIf="loading">
  로딩 중...
</div>
```

## 연습 문제

1. 홈, 소개, 연락처 페이지를 만들고 라우팅을 설정하세요
2. 사용자 ID를 받는 동적 라우트를 만들어보세요
3. 로그인 가드를 만들어 보호된 라우트를 구현하세요
4. 404 페이지를 만들고 잘못된 경로를 처리하세요

## 다음 단계

다음 챕터에서는 **HTTP 통신**을 배워봅시다! API를 호출하고 데이터를 주고받는 방법을 알아볼 거예요!

## 핵심 요약

- 라우팅으로 SPA에서 페이지 전환 구현
- `RouterModule.forRoot(routes)`로 라우트 설정
- `<router-outlet>`에 라우팅된 컴포넌트 표시
- `routerLink`로 네비게이션, `routerLinkActive`로 활성 링크 스타일
- `ActivatedRoute`로 라우트 매개변수와 쿼리 파라미터 읽기
- `Router.navigate()`로 프로그래밍 방식 네비게이션
- 라우트 가드로 접근 권한 제어
- 레이지 로딩으로 성능 최적화

바데부와 함께 라우팅을 마스터해봅시다! 🚀

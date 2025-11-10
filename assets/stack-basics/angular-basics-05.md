# Chapter 5: 디렉티브

안녕하세요! 바데부입니다! 이번에는 Angular의 강력한 디렉티브를 배워볼 거예요. 템플릿을 동적으로 만들어봅시다! ✨

## 5.1 디렉티브란?

디렉티브는 DOM 요소의 동작이나 외형을 변경하는 특별한 마커예요!

**디렉티브의 종류:**
- **구조 디렉티브 (Structural)**: DOM 구조를 변경 (*ngIf, *ngFor, *ngSwitch)
- **속성 디렉티브 (Attribute)**: 요소의 외형이나 동작 변경 (ngClass, ngStyle)
- **커스텀 디렉티브**: 직접 만드는 디렉티브

## 5.2 *ngIf - 조건부 렌더링

### 기본 사용법
```typescript
export class ConditionalComponent {
  isLoggedIn = true;
  userRole = 'admin';
  count = 0;
  users: User[] = [];
}
```

```html
<!-- 기본 ngIf -->
<div *ngIf="isLoggedIn">
  <h2>환영합니다, 바데부!</h2>
</div>

<div *ngIf="!isLoggedIn">
  <h2>로그인이 필요합니다</h2>
</div>

<!-- 복잡한 조건 -->
<div *ngIf="isLoggedIn && userRole === 'admin'">
  <p>관리자 전용 메뉴</p>
</div>

<div *ngIf="count > 0">
  <p>아이템 개수: {{ count }}</p>
</div>
```

### ngIf와 else
```html
<!-- if-else 패턴 -->
<div *ngIf="isLoggedIn; else loginTemplate">
  <h2>환영합니다!</h2>
</div>

<ng-template #loginTemplate>
  <h2>로그인하세요</h2>
</ng-template>
```

### ngIf와 then/else
```html
<div *ngIf="isLoggedIn; then loggedInTemplate else loggedOutTemplate"></div>

<ng-template #loggedInTemplate>
  <h2>로그인 됨</h2>
</ng-template>

<ng-template #loggedOutTemplate>
  <h2>로그아웃 됨</h2>
</ng-template>
```

### ngIf와 as (값 저장)
```html
<!-- 비동기 데이터 처리 -->
<div *ngIf="user$ | async as user">
  <h2>{{ user.name }}</h2>
  <p>{{ user.email }}</p>
</div>

<!-- 복잡한 표현식 결과 저장 -->
<div *ngIf="users.length > 0 as hasUsers">
  <p *ngIf="hasUsers">사용자가 있습니다</p>
</div>
```

## 5.3 *ngFor - 반복 렌더링

### 기본 사용법
```typescript
export class ListComponent {
  users = [
    { id: 1, name: '바데부', age: 3 },
    { id: 2, name: '철수', age: 25 },
    { id: 3, name: '영희', age: 23 }
  ];

  colors = ['빨강', '파랑', '초록'];

  numbers = [1, 2, 3, 4, 5];
}
```

```html
<!-- 기본 ngFor -->
<ul>
  <li *ngFor="let user of users">
    {{ user.name }} ({{ user.age }}살)
  </li>
</ul>

<!-- 배열 반복 -->
<div *ngFor="let color of colors">
  <span>{{ color }}</span>
</div>

<!-- 숫자 배열 -->
<div *ngFor="let num of numbers">
  {{ num }}
</div>
```

### ngFor 인덱스와 기타 변수
```html
<ul>
  <li *ngFor="let user of users; let i = index">
    {{ i + 1 }}. {{ user.name }}
  </li>
</ul>

<!-- 첫 번째와 마지막 -->
<div *ngFor="let user of users; let first = first; let last = last">
  <span [class.first]="first" [class.last]="last">
    {{ user.name }}
  </span>
</div>

<!-- 짝수/홀수 -->
<div *ngFor="let user of users; let even = even; let odd = odd">
  <div [class.even]="even" [class.odd]="odd">
    {{ user.name }}
  </div>
</div>

<!-- 모든 변수 함께 사용 -->
<div *ngFor="let user of users;
              let i = index;
              let first = first;
              let last = last;
              let even = even;
              let odd = odd">
  <p>
    인덱스: {{ i }},
    첫번째: {{ first }},
    마지막: {{ last }},
    짝수: {{ even }},
    홀수: {{ odd }}
  </p>
</div>
```

### trackBy로 성능 최적화
```typescript
export class ListComponent {
  users = [
    { id: 1, name: '바데부', age: 3 },
    { id: 2, name: '철수', age: 25 }
  ];

  // trackBy 함수
  trackByUserId(index: number, user: User): number {
    return user.id;  // 고유한 식별자 반환
  }

  updateUsers(): void {
    // 데이터 업데이트 시 trackBy로 성능 향상
    this.users = [
      { id: 1, name: '바데부', age: 4 },  // age만 변경
      { id: 2, name: '철수', age: 25 }
    ];
  }
}
```

```html
<!-- trackBy 사용 -->
<ul>
  <li *ngFor="let user of users; trackBy: trackByUserId">
    {{ user.name }} ({{ user.age }}살)
  </li>
</ul>
```

### ngFor와 ngIf 함께 사용
```html
<!-- ❌ 나쁜 방법: 같은 요소에 함께 사용 불가 -->
<div *ngFor="let user of users" *ngIf="user.age > 18">
  {{ user.name }}
</div>

<!-- ✅ 좋은 방법 1: ng-container 사용 -->
<ng-container *ngFor="let user of users">
  <div *ngIf="user.age > 18">
    {{ user.name }}
  </div>
</ng-container>

<!-- ✅ 좋은 방법 2: 미리 필터링 -->
<div *ngFor="let user of getAdultUsers()">
  {{ user.name }}
</div>
```

```typescript
getAdultUsers(): User[] {
  return this.users.filter(user => user.age > 18);
}
```

## 5.4 *ngSwitch - 다중 조건

```typescript
export class SwitchComponent {
  userRole = 'admin';  // 'admin', 'user', 'guest'
  viewMode = 'list';   // 'list', 'grid', 'table'
}
```

```html
<!-- ngSwitch 기본 사용 -->
<div [ngSwitch]="userRole">
  <div *ngSwitchCase="'admin'">
    <h2>관리자 대시보드</h2>
    <button>사용자 관리</button>
  </div>

  <div *ngSwitchCase="'user'">
    <h2>사용자 대시보드</h2>
    <button>프로필 편집</button>
  </div>

  <div *ngSwitchCase="'guest'">
    <h2>게스트</h2>
    <button>로그인</button>
  </div>

  <div *ngSwitchDefault>
    <h2>알 수 없는 역할</h2>
  </div>
</div>

<!-- 뷰 모드 전환 -->
<div [ngSwitch]="viewMode">
  <div *ngSwitchCase="'list'">
    <ul>
      <li>목록 뷰</li>
    </ul>
  </div>

  <div *ngSwitchCase="'grid'">
    <div class="grid">
      그리드 뷰
    </div>
  </div>

  <div *ngSwitchCase="'table'">
    <table>
      <tr><td>테이블 뷰</td></tr>
    </table>
  </div>
</div>
```

## 5.5 ngClass - 클래스 바인딩

```typescript
export class StyleComponent {
  isActive = true;
  isDisabled = false;
  currentTheme = 'dark';
  userStatus = 'online';
}
```

```html
<!-- 객체 형식 -->
<div [ngClass]="{
  'active': isActive,
  'disabled': isDisabled,
  'theme-dark': currentTheme === 'dark'
}">
  다중 클래스
</div>

<!-- 배열 형식 -->
<div [ngClass]="['class-1', 'class-2', currentTheme]">
  배열 클래스
</div>

<!-- 문자열 -->
<div [ngClass]="'active disabled'">
  문자열 클래스
</div>

<!-- 메서드 사용 -->
<div [ngClass]="getUserClasses()">
  메서드로 클래스 결정
</div>
```

```typescript
getUserClasses(): object {
  return {
    'online': this.userStatus === 'online',
    'offline': this.userStatus === 'offline',
    'away': this.userStatus === 'away'
  };
}
```

## 5.6 ngStyle - 스타일 바인딩

```typescript
export class StyleComponent {
  fontSize = 16;
  color = 'blue';
  isLarge = true;
}
```

```html
<!-- 객체 형식 -->
<div [ngStyle]="{
  'color': color,
  'font-size.px': fontSize,
  'font-weight': isLarge ? 'bold' : 'normal',
  'background-color': '#f0f0f0'
}">
  다중 스타일
</div>

<!-- 메서드 사용 -->
<div [ngStyle]="getUserStyles()">
  메서드로 스타일 결정
</div>
```

```typescript
getUserStyles(): object {
  return {
    'color': this.color,
    'font-size': this.fontSize + 'px',
    'padding': '1rem',
    'border': '1px solid ' + this.color
  };
}
```

## 5.7 ng-container

ng-container는 DOM에 추가되지 않는 논리적 컨테이너예요!

```html
<!-- ✅ ng-container 사용 (DOM에 추가 안 됨) -->
<ng-container *ngIf="isLoggedIn">
  <h2>환영합니다</h2>
  <p>로그인되었습니다</p>
</ng-container>

<!-- ❌ div 사용 (불필요한 div가 DOM에 추가됨) -->
<div *ngIf="isLoggedIn">
  <h2>환영합니다</h2>
  <p>로그인되었습니다</p>
</div>

<!-- ngFor와 ngIf 함께 사용 -->
<ng-container *ngFor="let user of users">
  <div *ngIf="user.isActive">
    {{ user.name }}
  </div>
</ng-container>
```

## 5.8 ng-template

ng-template은 렌더링되지 않는 템플릿 정의예요!

```html
<!-- ngIf와 함께 -->
<div *ngIf="isLoggedIn; else loginTemplate">
  로그인됨
</div>

<ng-template #loginTemplate>
  <button (click)="login()">로그인</button>
</ng-template>

<!-- ngFor와 함께 -->
<ul>
  <li *ngFor="let user of users; else emptyTemplate">
    {{ user.name }}
  </li>
</ul>

<ng-template #emptyTemplate>
  <p>사용자가 없습니다</p>
</ng-template>
```

## 5.9 커스텀 속성 디렉티브 만들기

### 하이라이트 디렉티브
```bash
# 디렉티브 생성
ng generate directive highlight
# 또는
ng g d highlight
```

```typescript
// highlight.directive.ts
import { Directive, ElementRef, HostListener, Input } from '@angular/core';

@Directive({
  selector: '[appHighlight]'
})
export class HighlightDirective {
  @Input() appHighlight = 'yellow';
  @Input() defaultColor = 'transparent';

  constructor(private el: ElementRef) {}

  @HostListener('mouseenter') onMouseEnter() {
    this.highlight(this.appHighlight);
  }

  @HostListener('mouseleave') onMouseLeave() {
    this.highlight(this.defaultColor);
  }

  private highlight(color: string) {
    this.el.nativeElement.style.backgroundColor = color;
  }
}
```

```html
<!-- 사용 -->
<p appHighlight>마우스를 올려보세요</p>
<p [appHighlight]="'lightblue'">파란색 하이라이트</p>
<p appHighlight="pink" defaultColor="white">핑크 하이라이트</p>
```

## 5.10 커스텀 구조 디렉티브 만들기

### Unless 디렉티브 (ngIf의 반대)
```bash
ng generate directive unless
```

```typescript
// unless.directive.ts
import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appUnless]'
})
export class UnlessDirective {
  private hasView = false;

  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef
  ) {}

  @Input() set appUnless(condition: boolean) {
    if (!condition && !this.hasView) {
      // 조건이 false면 표시
      this.viewContainer.createEmbeddedView(this.templateRef);
      this.hasView = true;
    } else if (condition && this.hasView) {
      // 조건이 true면 숨김
      this.viewContainer.clear();
      this.hasView = false;
    }
  }
}
```

```html
<!-- 사용 -->
<div *appUnless="isLoggedIn">
  <p>로그인하세요</p>
</div>

<!-- ngIf와 비교 -->
<div *ngIf="!isLoggedIn">
  <p>로그인하세요</p>
</div>
```

### Repeat 디렉티브
```typescript
// repeat.directive.ts
import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';

@Directive({
  selector: '[appRepeat]'
})
export class RepeatDirective {
  constructor(
    private templateRef: TemplateRef<any>,
    private viewContainer: ViewContainerRef
  ) {}

  @Input() set appRepeat(count: number) {
    this.viewContainer.clear();
    for (let i = 0; i < count; i++) {
      this.viewContainer.createEmbeddedView(this.templateRef, {
        $implicit: i,
        index: i
      });
    }
  }
}
```

```html
<!-- 사용 -->
<div *appRepeat="3; let i = index">
  <p>{{ i + 1 }}번째 반복</p>
</div>

<!-- 결과:
1번째 반복
2번째 반복
3번째 반복
-->
```

## 5.11 디렉티브 베스트 프랙티스

### 좋은 예시
```typescript
// ✅ 재사용 가능한 디렉티브
@Directive({
  selector: '[appTooltip]'
})
export class TooltipDirective {
  @Input() appTooltip = '';

  @HostListener('mouseenter')
  showTooltip() {
    // 툴팁 표시 로직
  }
}
```

### 나쁜 예시
```typescript
// ❌ 너무 복잡한 로직은 컴포넌트로
@Directive({
  selector: '[appComplexLogic]'
})
export class ComplexLogicDirective {
  // 100줄 이상의 복잡한 로직...
  // 이런 경우 컴포넌트를 사용하세요!
}
```

## 연습 문제

1. *ngFor로 10개의 아이템을 리스트로 표시하세요
2. *ngIf와 else를 사용하여 로그인/로그아웃 UI를 만드세요
3. *ngSwitch로 여러 뷰 모드를 전환하는 기능을 만드세요
4. 커스텀 디렉티브를 만들어 호버 시 색상이 변하도록 하세요

## 다음 단계

다음 챕터에서는 **서비스와 의존성 주입**을 배워봅시다! 데이터와 로직을 재사용하는 방법을 알아볼 거예요!

## 핵심 요약

- 디렉티브는 DOM을 조작하는 특별한 마커
- 구조 디렉티브: *ngIf, *ngFor, *ngSwitch
- 속성 디렉티브: ngClass, ngStyle
- *ngIf로 조건부 렌더링, else와 함께 사용 가능
- *ngFor로 배열 반복, trackBy로 성능 최적화
- ng-container는 DOM에 추가되지 않는 컨테이너
- 커스텀 디렉티브로 재사용 가능한 기능 작성
- @HostListener로 이벤트 감지

바데부와 함께 디렉티브를 마스터해봅시다! 🎯

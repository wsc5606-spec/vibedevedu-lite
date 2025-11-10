# Chapter 3: 컴포넌트와 템플릿

안녕하세요! 바데부입니다! 이제 Angular의 핵심인 컴포넌트를 배워볼 거예요. 컴포넌트는 UI의 기본 블록이에요! 🧱

## 3.1 컴포넌트란?

컴포넌트는 화면의 일부를 담당하는 독립적인 UI 블록이에요. 템플릿(HTML), 스타일(CSS), 로직(TypeScript)을 하나로 묶어요!

**컴포넌트의 구성 요소:**
- **Template (템플릿)**: HTML로 화면 구조 정의
- **Class (클래스)**: TypeScript로 로직 작성
- **Styles (스타일)**: CSS/SCSS로 디자인
- **Metadata (메타데이터)**: @Component 데코레이터로 설정

## 3.2 컴포넌트 생성하기

### CLI로 생성
```bash
# 컴포넌트 생성
ng generate component user
# 또는 단축어
ng g c user

# 생성되는 파일들:
# - user.component.ts      (로직)
# - user.component.html    (템플릿)
# - user.component.scss    (스타일)
# - user.component.spec.ts (테스트)
```

### 수동으로 생성
```typescript
// user.component.ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss']
})
export class UserComponent {
  name = '바데부';
  age = 3;
}
```

## 3.3 컴포넌트 데코레이터

### @Component 옵션
```typescript
@Component({
  selector: 'app-user',              // CSS 선택자
  templateUrl: './user.component.html',  // 외부 템플릿
  styleUrls: ['./user.component.scss'],  // 외부 스타일
  // 또는
  template: '<h1>{{ name }}</h1>',   // 인라인 템플릿
  styles: ['h1 { color: red; }']     // 인라인 스타일
})
```

### Selector 종류
```typescript
// 요소 선택자 (가장 일반적)
selector: 'app-user'
// 사용: <app-user></app-user>

// 속성 선택자
selector: '[app-user]'
// 사용: <div app-user></div>

// 클래스 선택자
selector: '.app-user'
// 사용: <div class="app-user"></div>
```

## 3.4 템플릿 문법

### 인터폴레이션 (Interpolation)
```typescript
// user.component.ts
export class UserComponent {
  name = '바데부';
  age = 3;
  message = 'Angular는 재미있어요!';
}
```

```html
<!-- user.component.html -->
<h1>{{ name }}</h1>
<p>나이: {{ age }}살</p>
<p>{{ message }}</p>

<!-- 표현식 사용 -->
<p>내년에는 {{ age + 1 }}살이에요!</p>
<p>{{ name.toUpperCase() }}</p>
<p>{{ 10 + 20 }}</p>
```

### 프로퍼티 바인딩 (Property Binding)
```typescript
export class UserComponent {
  imageUrl = 'assets/badb.png';
  isDisabled = false;
  userClass = 'active';
}
```

```html
<!-- 이미지 src 바인딩 -->
<img [src]="imageUrl" alt="바데부">

<!-- disabled 속성 바인딩 -->
<button [disabled]="isDisabled">클릭</button>

<!-- class 바인딩 -->
<div [className]="userClass">내용</div>

<!-- 여러 클래스 바인딩 -->
<div [class.active]="isActive">내용</div>
<div [class.disabled]="isDisabled">내용</div>

<!-- 스타일 바인딩 -->
<div [style.color]="userColor">내용</div>
<div [style.font-size.px]="fontSize">내용</div>
```

### 이벤트 바인딩 (Event Binding)
```typescript
export class UserComponent {
  count = 0;
  message = '';

  onClick(): void {
    this.count++;
    console.log('버튼 클릭!');
  }

  onInput(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.message = target.value;
  }

  onKeyUp(event: KeyboardEvent): void {
    console.log('키 입력:', event.key);
  }
}
```

```html
<!-- 클릭 이벤트 -->
<button (click)="onClick()">클릭 횟수: {{ count }}</button>

<!-- 입력 이벤트 -->
<input (input)="onInput($event)" placeholder="메시지 입력">
<p>입력한 메시지: {{ message }}</p>

<!-- 키보드 이벤트 -->
<input (keyup)="onKeyUp($event)">

<!-- 이벤트 필터 -->
<input (keyup.enter)="onEnter()">  <!-- Enter 키만 -->
<input (keyup.esc)="onEscape()">   <!-- Esc 키만 -->
```

### 양방향 바인딩 (Two-way Binding)
```typescript
// app.module.ts에 FormsModule 추가 필요!
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [BrowserModule, FormsModule]
})
```

```typescript
export class UserComponent {
  username = '';
  email = '';
}
```

```html
<!-- [(ngModel)]로 양방향 바인딩 -->
<input [(ngModel)]="username" placeholder="이름">
<p>안녕하세요, {{ username }}!</p>

<input [(ngModel)]="email" type="email" placeholder="이메일">
<p>이메일: {{ email }}</p>
```

## 3.5 템플릿 참조 변수

```html
<!-- #변수명으로 요소 참조 -->
<input #userInput type="text">
<button (click)="onSubmit(userInput.value)">제출</button>

<!-- 다른 곳에서도 사용 가능 -->
<p>입력한 값: {{ userInput.value }}</p>
```

```typescript
onSubmit(value: string): void {
  console.log('제출된 값:', value);
}
```

## 3.6 컴포넌트 생명주기

Angular 컴포넌트는 생성부터 소멸까지 여러 단계를 거쳐요!

### 주요 생명주기 훅
```typescript
import { Component, OnInit, OnDestroy, OnChanges } from '@angular/core';

export class UserComponent implements OnInit, OnDestroy, OnChanges {

  // 1. 생성자 - 가장 먼저 실행
  constructor() {
    console.log('1. Constructor');
  }

  // 2. ngOnChanges - Input 프로퍼티 변경 시
  ngOnChanges(): void {
    console.log('2. ngOnChanges');
  }

  // 3. ngOnInit - 초기화 완료 (데이터 로딩에 사용)
  ngOnInit(): void {
    console.log('3. ngOnInit');
    // API 호출, 초기 데이터 로딩
  }

  // 4. ngDoCheck - 변경 감지 실행 시마다
  ngDoCheck(): void {
    console.log('4. ngDoCheck');
  }

  // 5. ngAfterViewInit - 뷰 초기화 완료
  ngAfterViewInit(): void {
    console.log('5. ngAfterViewInit');
  }

  // 6. ngOnDestroy - 컴포넌트 소멸 전
  ngOnDestroy(): void {
    console.log('6. ngOnDestroy');
    // 구독 해제, 타이머 정리
  }
}
```

### 실전 사용 예시
```typescript
export class UserComponent implements OnInit, OnDestroy {
  users: User[] = [];
  private subscription: Subscription;

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    // 데이터 로딩
    this.subscription = this.userService.getUsers().subscribe(
      users => this.users = users
    );
  }

  ngOnDestroy(): void {
    // 메모리 누수 방지
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }
}
```

## 3.7 Input과 Output

### @Input - 부모에서 자식으로 데이터 전달
```typescript
// child.component.ts
import { Component, Input } from '@angular/core';

export class ChildComponent {
  @Input() userName: string = '';
  @Input() userAge: number = 0;
}
```

```html
<!-- child.component.html -->
<div class="child">
  <h3>{{ userName }}</h3>
  <p>나이: {{ userAge }}살</p>
</div>
```

```html
<!-- parent.component.html -->
<app-child [userName]="'바데부'" [userAge]="3"></app-child>
```

### @Output - 자식에서 부모로 이벤트 전달
```typescript
// child.component.ts
import { Component, Output, EventEmitter } from '@angular/core';

export class ChildComponent {
  @Output() userClicked = new EventEmitter<string>();

  onClick(): void {
    this.userClicked.emit('바데부가 클릭됨!');
  }
}
```

```html
<!-- child.component.html -->
<button (click)="onClick()">클릭</button>
```

```typescript
// parent.component.ts
export class ParentComponent {
  onUserClicked(message: string): void {
    console.log(message);
  }
}
```

```html
<!-- parent.component.html -->
<app-child (userClicked)="onUserClicked($event)"></app-child>
```

## 3.8 ViewChild와 ContentChild

### @ViewChild - 템플릿의 자식 요소 접근
```typescript
import { Component, ViewChild, ElementRef, AfterViewInit } from '@angular/core';

export class ParentComponent implements AfterViewInit {
  @ViewChild('userInput') inputElement!: ElementRef<HTMLInputElement>;

  ngAfterViewInit(): void {
    // 뷰 초기화 후에 접근
    this.inputElement.nativeElement.focus();
  }

  getValue(): string {
    return this.inputElement.nativeElement.value;
  }
}
```

```html
<input #userInput type="text">
<button (click)="getValue()">값 가져오기</button>
```

### @ContentChild - ng-content의 자식 요소 접근
```typescript
import { Component, ContentChild, AfterContentInit } from '@angular/core';

export class CardComponent implements AfterContentInit {
  @ContentChild('cardHeader') header!: ElementRef;

  ngAfterContentInit(): void {
    console.log('헤더:', this.header);
  }
}
```

```html
<!-- card.component.html -->
<div class="card">
  <ng-content></ng-content>
</div>
```

```html
<!-- 사용하는 곳 -->
<app-card>
  <h2 #cardHeader>바데부 카드</h2>
  <p>내용...</p>
</app-card>
```

## 3.9 템플릿 표현식의 제약

### 허용되는 것
```html
<!-- ✅ 변수, 프로퍼티 접근 -->
{{ name }}
{{ user.name }}

<!-- ✅ 메서드 호출 -->
{{ getName() }}

<!-- ✅ 연산자 -->
{{ age + 1 }}
{{ isActive ? '활성' : '비활성' }}

<!-- ✅ 파이프 -->
{{ date | date:'yyyy-MM-dd' }}
```

### 허용되지 않는 것
```html
<!-- ❌ 할당 -->
{{ name = '새 이름' }}

<!-- ❌ new, typeof, instanceof -->
{{ new Date() }}

<!-- ❌ ;로 표현식 연결 -->
{{ a = 1; b = 2 }}

<!-- ❌ 증가/감소 연산자 -->
{{ count++ }}
{{ count-- }}
```

## 3.10 스타일 캡슐화

Angular는 컴포넌트의 스타일을 캡슐화해요!

### ViewEncapsulation 모드
```typescript
import { Component, ViewEncapsulation } from '@angular/core';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.scss'],
  encapsulation: ViewEncapsulation.Emulated  // 기본값
  // ViewEncapsulation.None     - 캡슐화 없음 (전역 스타일)
  // ViewEncapsulation.ShadowDom - Shadow DOM 사용
})
```

### 스타일 적용 방법
```scss
// user.component.scss

// 일반 스타일 (이 컴포넌트에만 적용)
h1 {
  color: blue;
}

// :host - 호스트 요소 (app-user)
:host {
  display: block;
  padding: 1rem;
}

// :host-context - 부모의 클래스에 따라
:host-context(.dark-theme) {
  background: black;
  color: white;
}

// ::ng-deep - 자식 컴포넌트까지 적용 (비권장)
::ng-deep .child-class {
  color: red;
}
```

## 연습 문제

1. 새 컴포넌트를 만들고 name 프로퍼티를 템플릿에 표시하세요
2. 버튼 클릭 시 카운터가 증가하는 기능을 만드세요
3. input에 입력한 값을 실시간으로 화면에 표시하세요 (양방향 바인딩)
4. @Input과 @Output을 사용하여 부모-자식 통신을 구현하세요

## 다음 단계

다음 챕터에서는 **데이터 바인딩**을 더 깊이 배워봅시다! 다양한 바인딩 기법과 파이프를 알아볼 거예요!

## 핵심 요약

- 컴포넌트는 템플릿, 클래스, 스타일, 메타데이터로 구성
- `ng generate component` 명령어로 컴포넌트 생성
- 인터폴레이션 `{{ }}`, 프로퍼티 바인딩 `[]`, 이벤트 바인딩 `()`
- 양방향 바인딩 `[(ngModel)]`은 FormsModule 필요
- 생명주기 훅: ngOnInit (초기화), ngOnDestroy (정리)
- @Input으로 데이터 받기, @Output으로 이벤트 전달
- @ViewChild로 자식 요소 접근
- ViewEncapsulation으로 스타일 캡슐화

바데부와 함께 컴포넌트를 마스터해봅시다! 🎨

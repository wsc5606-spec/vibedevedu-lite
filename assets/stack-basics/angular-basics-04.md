# Chapter 4: 데이터 바인딩

안녕하세요! 바데부입니다! 이번에는 Angular의 강력한 데이터 바인딩을 자세히 배워볼 거예요! 🔗

## 4.1 데이터 바인딩이란?

데이터 바인딩은 컴포넌트의 데이터와 템플릿을 연결하는 메커니즘이에요!

**바인딩의 종류:**
- **Interpolation (보간법)**: `{{ }}` - 데이터를 텍스트로 표시
- **Property Binding (프로퍼티 바인딩)**: `[property]` - DOM 속성에 데이터 바인딩
- **Event Binding (이벤트 바인딩)**: `(event)` - 이벤트를 컴포넌트 메서드에 연결
- **Two-way Binding (양방향 바인딩)**: `[(ngModel)]` - 데이터와 뷰를 동기화

## 4.2 인터폴레이션 (Interpolation)

### 기본 사용법
```typescript
export class UserComponent {
  name = '바데부';
  age = 3;
  score = 95.5;
  isActive = true;
}
```

```html
<!-- 변수 표시 -->
<h1>{{ name }}</h1>
<p>나이: {{ age }}살</p>
<p>점수: {{ score }}점</p>

<!-- 표현식 -->
<p>내년 나이: {{ age + 1 }}살</p>
<p>{{ score >= 90 ? '합격' : '불합격' }}</p>

<!-- 메서드 호출 -->
<p>{{ getName() }}</p>
<p>{{ calculateTotal() }}</p>

<!-- 문자열 메서드 -->
<p>{{ name.toUpperCase() }}</p>
<p>{{ name.toLowerCase() }}</p>
<p>{{ name.length }}</p>
```

### 연산과 표현식
```html
<!-- 산술 연산 -->
<p>{{ 10 + 20 }}</p>
<p>{{ score * 2 }}</p>

<!-- 문자열 연결 -->
<p>{{ '안녕하세요, ' + name + '입니다!' }}</p>
<p>{{ `안녕하세요, ${name}입니다!` }}</p>

<!-- 삼항 연산자 -->
<p>{{ isActive ? '활성' : '비활성' }}</p>
<p>{{ age >= 18 ? '성인' : '미성년자' }}</p>

<!-- null 체크 -->
<p>{{ user?.name }}</p>
<p>{{ user?.address?.city }}</p>
```

## 4.3 프로퍼티 바인딩 (Property Binding)

### HTML 속성 바인딩
```typescript
export class ImageComponent {
  imageUrl = 'assets/badb.png';
  imageAlt = '바데부';
  isDisabled = false;
  placeholderText = '이름을 입력하세요';
}
```

```html
<!-- img src 바인딩 -->
<img [src]="imageUrl" [alt]="imageAlt">

<!-- input 바인딩 -->
<input [value]="name" [placeholder]="placeholderText">
<button [disabled]="isDisabled">클릭</button>

<!-- href 바인딩 -->
<a [href]="linkUrl">링크</a>
```

### 클래스 바인딩
```typescript
export class StyleComponent {
  isActive = true;
  isPrimary = false;
  currentClass = 'highlight';
}
```

```html
<!-- 단일 클래스 바인딩 -->
<div [class.active]="isActive">Active 클래스</div>
<div [class.primary]="isPrimary">Primary 클래스</div>

<!-- 전체 클래스 바인딩 -->
<div [className]="currentClass">클래스 교체</div>

<!-- 다중 클래스 바인딩 (객체) -->
<div [ngClass]="{
  'active': isActive,
  'disabled': !isActive,
  'primary': isPrimary
}">다중 클래스</div>

<!-- 다중 클래스 바인딩 (배열) -->
<div [ngClass]="['class-1', 'class-2', currentClass]">배열 클래스</div>
```

### 스타일 바인딩
```typescript
export class StyleComponent {
  color = 'blue';
  fontSize = 20;
  isLarge = true;
}
```

```html
<!-- 단일 스타일 바인딩 -->
<p [style.color]="color">색상 변경</p>
<p [style.font-size.px]="fontSize">폰트 크기</p>
<p [style.font-weight]="isLarge ? 'bold' : 'normal'">굵기</p>

<!-- 다중 스타일 바인딩 (객체) -->
<div [ngStyle]="{
  'color': color,
  'font-size.px': fontSize,
  'background-color': isActive ? 'yellow' : 'white',
  'padding': '1rem'
}">다중 스타일</div>
```

### 속성 바인딩 (Attribute Binding)
```html
<!-- HTML 속성이 아닌 DOM 속성 -->
<button [attr.aria-label]="buttonLabel">버튼</button>
<img [attr.data-id]="userId">
<table>
  <tr>
    <td [attr.colspan]="columnSpan">셀</td>
  </tr>
</table>
```

## 4.4 이벤트 바인딩 (Event Binding)

### 기본 이벤트
```typescript
export class EventComponent {
  message = '';
  count = 0;

  onClick(): void {
    this.count++;
    console.log('버튼 클릭!', this.count);
  }

  onInput(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.message = target.value;
  }

  onMouseEnter(): void {
    console.log('마우스 진입!');
  }

  onMouseLeave(): void {
    console.log('마우스 떠남!');
  }
}
```

```html
<!-- 클릭 이벤트 -->
<button (click)="onClick()">클릭: {{ count }}</button>

<!-- 입력 이벤트 -->
<input (input)="onInput($event)">
<p>{{ message }}</p>

<!-- 마우스 이벤트 -->
<div
  (mouseenter)="onMouseEnter()"
  (mouseleave)="onMouseLeave()">
  마우스를 올려보세요
</div>

<!-- 폼 이벤트 -->
<form (submit)="onSubmit($event)">
  <button type="submit">제출</button>
</form>
```

### 키보드 이벤트
```typescript
export class KeyboardComponent {
  value = '';

  onKeyUp(event: KeyboardEvent): void {
    console.log('키 입력:', event.key);
  }

  onEnter(): void {
    console.log('Enter 키 입력!');
  }

  onEscape(): void {
    console.log('Esc 키 입력!');
  }
}
```

```html
<!-- 키보드 이벤트 -->
<input (keyup)="onKeyUp($event)">

<!-- 특정 키 이벤트 -->
<input (keyup.enter)="onEnter()">
<input (keyup.esc)="onEscape()">
<input (keyup.space)="onSpace()">

<!-- 조합 키 -->
<input (keyup.control.s)="onSave()">
<input (keyup.shift.enter)="onShiftEnter()">
```

### 이벤트 전달과 방지
```typescript
export class EventComponent {
  onLinkClick(event: Event): void {
    event.preventDefault();  // 기본 동작 방지
    console.log('링크 클릭');
  }

  onButtonClick(event: Event): void {
    event.stopPropagation();  // 이벤트 전파 중단
    console.log('버튼 클릭');
  }
}
```

```html
<!-- 기본 동작 방지 -->
<a href="https://example.com" (click)="onLinkClick($event)">링크</a>

<!-- 이벤트 전파 중단 -->
<div (click)="onDivClick()">
  <button (click)="onButtonClick($event)">버튼</button>
</div>
```

## 4.5 양방향 바인딩 (Two-way Binding)

### FormsModule 설정
```typescript
// app.module.ts
import { FormsModule } from '@angular/forms';

@NgModule({
  imports: [
    BrowserModule,
    FormsModule  // 추가!
  ]
})
export class AppModule { }
```

### ngModel 사용
```typescript
export class FormComponent {
  username = '';
  email = '';
  age = 0;
  isAgree = false;
  selectedColor = 'red';
  selectedCountry = '';
}
```

```html
<!-- 텍스트 입력 -->
<input [(ngModel)]="username" placeholder="이름">
<p>안녕하세요, {{ username }}!</p>

<!-- 이메일 입력 -->
<input [(ngModel)]="email" type="email" placeholder="이메일">
<p>이메일: {{ email }}</p>

<!-- 숫자 입력 -->
<input [(ngModel)]="age" type="number">
<p>나이: {{ age }}살</p>

<!-- 체크박스 -->
<label>
  <input [(ngModel)]="isAgree" type="checkbox">
  동의합니다
</label>
<p>동의 여부: {{ isAgree }}</p>

<!-- 라디오 버튼 -->
<label>
  <input [(ngModel)]="selectedColor" type="radio" value="red">
  빨강
</label>
<label>
  <input [(ngModel)]="selectedColor" type="radio" value="blue">
  파랑
</label>
<p>선택한 색상: {{ selectedColor }}</p>

<!-- 셀렉트 -->
<select [(ngModel)]="selectedCountry">
  <option value="">선택하세요</option>
  <option value="kr">한국</option>
  <option value="us">미국</option>
  <option value="jp">일본</option>
</select>
<p>선택한 국가: {{ selectedCountry }}</p>
```

### 양방향 바인딩 분해
```html
<!-- [(ngModel)]="username"은 이것과 같아요 -->
<input
  [ngModel]="username"
  (ngModelChange)="username = $event">

<!-- 또는 메서드로 처리 -->
<input
  [ngModel]="username"
  (ngModelChange)="onUsernameChange($event)">
```

```typescript
onUsernameChange(value: string): void {
  this.username = value;
  console.log('이름 변경:', value);
}
```

## 4.6 파이프 (Pipes)

파이프는 템플릿에서 데이터를 변환해요!

### 내장 파이프
```typescript
export class PipeComponent {
  name = '바데부';
  price = 12345.67;
  date = new Date();
  ratio = 0.456;
  user = { name: '바데부', age: 3 };
}
```

```html
<!-- 대문자/소문자 -->
<p>{{ name | uppercase }}</p>        <!-- 바데부 -->
<p>{{ name | lowercase }}</p>        <!-- 바데부 -->

<!-- 숫자 포맷 -->
<p>{{ price | number }}</p>          <!-- 12,345.67 -->
<p>{{ price | number:'1.0-0' }}</p>  <!-- 12,346 (반올림) -->
<p>{{ price | number:'1.2-2' }}</p>  <!-- 12,345.67 -->

<!-- 통화 -->
<p>{{ price | currency:'KRW' }}</p>  <!-- ₩12,346 -->
<p>{{ price | currency:'USD' }}</p>  <!-- $12,345.67 -->

<!-- 퍼센트 -->
<p>{{ ratio | percent }}</p>         <!-- 45.6% -->
<p>{{ ratio | percent:'1.0-0' }}</p> <!-- 46% -->

<!-- 날짜 -->
<p>{{ date | date }}</p>                    <!-- Sep 15, 2024 -->
<p>{{ date | date:'yyyy-MM-dd' }}</p>       <!-- 2024-09-15 -->
<p>{{ date | date:'yyyy년 MM월 dd일' }}</p>  <!-- 2024년 09월 15일 -->
<p>{{ date | date:'HH:mm:ss' }}</p>         <!-- 14:30:45 -->

<!-- JSON -->
<pre>{{ user | json }}</pre>
<!-- {
  "name": "바데부",
  "age": 3
} -->

<!-- 슬라이스 -->
<p>{{ name | slice:0:2 }}</p>  <!-- 바데 -->

<!-- 비동기 (async) -->
<p>{{ observableData | async }}</p>
```

### 파이프 체이닝
```html
<!-- 여러 파이프를 연결 -->
<p>{{ name | uppercase | slice:0:2 }}</p>
<p>{{ price | currency:'KRW' | uppercase }}</p>
<p>{{ date | date:'yyyy-MM-dd' | uppercase }}</p>
```

### 커스텀 파이프 만들기
```bash
# 파이프 생성
ng generate pipe reverse
# 또는
ng g p reverse
```

```typescript
// reverse.pipe.ts
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'reverse'
})
export class ReversePipe implements PipeTransform {
  transform(value: string): string {
    return value.split('').reverse().join('');
  }
}
```

```html
<!-- 사용 -->
<p>{{ '바데부' | reverse }}</p>  <!-- 부데바 -->
```

### 매개변수가 있는 커스텀 파이프
```typescript
// truncate.pipe.ts
@Pipe({
  name: 'truncate'
})
export class TruncatePipe implements PipeTransform {
  transform(value: string, limit: number = 10, ellipsis: string = '...'): string {
    if (value.length <= limit) {
      return value;
    }
    return value.substring(0, limit) + ellipsis;
  }
}
```

```html
<!-- 사용 -->
<p>{{ longText | truncate:20 }}</p>
<p>{{ longText | truncate:15:'…' }}</p>
```

## 4.7 안전한 네비게이션 연산자

### 옵셔널 체이닝 (?)
```typescript
export class UserComponent {
  user?: {
    name: string;
    address?: {
      city: string;
      street: string;
    };
  };
}
```

```html
<!-- ❌ 오류 발생 가능 -->
<p>{{ user.name }}</p>
<p>{{ user.address.city }}</p>

<!-- ✅ 안전한 방법 -->
<p>{{ user?.name }}</p>
<p>{{ user?.address?.city }}</p>

<!-- 기본값 제공 -->
<p>{{ user?.name || '이름 없음' }}</p>
<p>{{ user?.address?.city || '도시 없음' }}</p>
```

### Nullish Coalescing (??)
```typescript
export class Component {
  count = 0;
  name = '';
}
```

```html
<!-- || 연산자 (0, false, ''도 대체) -->
<p>{{ count || 10 }}</p>    <!-- 10 (0은 falsy) -->
<p>{{ name || '이름' }}</p>  <!-- 이름 (''는 falsy) -->

<!-- ?? 연산자 (null, undefined만 대체) -->
<p>{{ count ?? 10 }}</p>    <!-- 0 (0은 유효한 값) -->
<p>{{ name ?? '이름' }}</p>  <!-- '' (''는 유효한 값) -->
```

## 4.8 템플릿 표현식 베스트 프랙티스

### 좋은 예시
```typescript
export class GoodComponent {
  users: User[] = [];

  // 간단한 getter
  get userCount(): number {
    return this.users.length;
  }

  // 메서드는 짧고 명확하게
  getUserName(user: User): string {
    return user.name;
  }
}
```

```html
<!-- ✅ 좋은 방법 -->
<p>사용자 수: {{ userCount }}</p>
<p>{{ getUserName(user) }}</p>
```

### 나쁜 예시
```html
<!-- ❌ 복잡한 로직은 템플릿에 넣지 않기 -->
<p>{{ users.filter(u => u.age > 18).map(u => u.name).join(', ') }}</p>

<!-- ❌ 부수 효과가 있는 메서드 호출 -->
<p>{{ saveToDatabase() }}</p>
```

## 4.9 성능 최적화

### Pure vs Impure 파이프
```typescript
// Pure 파이프 (기본) - 입력이 변경될 때만 실행
@Pipe({
  name: 'pure',
  pure: true  // 기본값
})

// Impure 파이프 - 매 변경 감지마다 실행 (성능 주의!)
@Pipe({
  name: 'impure',
  pure: false
})
```

### 변경 감지 최적화
```typescript
import { ChangeDetectionStrategy } from '@angular/core';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush  // 최적화
})
```

## 연습 문제

1. 양방향 바인딩으로 간단한 계산기를 만들어보세요
2. 커스텀 파이프를 만들어 전화번호를 포맷팅하세요 (010-1234-5678)
3. 여러 input의 값을 실시간으로 화면에 표시하세요
4. 날짜 파이프를 사용하여 현재 날짜를 다양한 형식으로 표시하세요

## 다음 단계

다음 챕터에서는 **디렉티브**를 배워봅시다! *ngIf, *ngFor 등 강력한 템플릿 기능을 알아볼 거예요!

## 핵심 요약

- 데이터 바인딩: Interpolation, Property, Event, Two-way
- `{{ }}` - 데이터를 텍스트로 표시
- `[property]` - DOM 속성에 데이터 바인딩
- `(event)` - 이벤트를 메서드에 연결
- `[(ngModel)]` - 양방향 바인딩 (FormsModule 필요)
- 파이프로 데이터 변환 (date, currency, uppercase 등)
- 커스텀 파이프 생성 가능
- `?.` 옵셔널 체이닝으로 안전하게 접근

바데부와 함께 데이터 바인딩을 마스터해봅시다! 🔥

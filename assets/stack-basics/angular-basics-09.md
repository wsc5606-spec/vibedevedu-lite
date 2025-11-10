# Chapter 9: 폼

안녕하세요! 바데부입니다! 이번에는 Angular의 폼을 배워볼 거예요. Template-driven Forms와 Reactive Forms 두 가지 방법을 알아봅시다! 📝

## 9.1 폼이란?

Angular는 두 가지 폼 접근 방식을 제공해요!

**Template-driven Forms:**
- 템플릿에서 폼 로직 정의
- ngModel 사용
- 간단한 폼에 적합
- FormsModule 필요

**Reactive Forms:**
- 컴포넌트에서 폼 로직 정의
- FormControl, FormGroup 사용
- 복잡한 폼에 적합
- ReactiveFormsModule 필요

## 9.2 Template-driven Forms

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

### 기본 사용법
```typescript
// login.component.ts
export class LoginComponent {
  user = {
    email: '',
    password: ''
  };

  onSubmit(): void {
    console.log('폼 제출:', this.user);
    // 로그인 로직
  }
}
```

```html
<!-- login.component.html -->
<form #loginForm="ngForm" (ngSubmit)="onSubmit()">
  <div>
    <label>이메일:</label>
    <input
      type="email"
      name="email"
      [(ngModel)]="user.email"
      required
      email>
  </div>

  <div>
    <label>비밀번호:</label>
    <input
      type="password"
      name="password"
      [(ngModel)]="user.password"
      required
      minlength="6">
  </div>

  <button type="submit" [disabled]="!loginForm.valid">
    로그인
  </button>
</form>

<!-- 폼 상태 표시 -->
<div *ngIf="loginForm.submitted">
  <p>폼이 제출되었습니다!</p>
</div>
```

### 유효성 검사
```html
<form #signupForm="ngForm" (ngSubmit)="onSubmit()">
  <!-- 이메일 필드 -->
  <div>
    <label>이메일:</label>
    <input
      type="email"
      name="email"
      [(ngModel)]="user.email"
      #email="ngModel"
      required
      email>

    <!-- 에러 메시지 -->
    <div *ngIf="email.invalid && (email.dirty || email.touched)">
      <p *ngIf="email.errors?.['required']">이메일은 필수입니다</p>
      <p *ngIf="email.errors?.['email']">올바른 이메일 형식이 아닙니다</p>
    </div>
  </div>

  <!-- 비밀번호 필드 -->
  <div>
    <label>비밀번호:</label>
    <input
      type="password"
      name="password"
      [(ngModel)]="user.password"
      #password="ngModel"
      required
      minlength="6"
      maxlength="20">

    <div *ngIf="password.invalid && (password.dirty || password.touched)">
      <p *ngIf="password.errors?.['required']">비밀번호는 필수입니다</p>
      <p *ngIf="password.errors?.['minlength']">
        최소 6자 이상이어야 합니다
      </p>
    </div>
  </div>

  <button type="submit" [disabled]="!signupForm.valid">
    가입하기
  </button>
</form>
```

### CSS 클래스 활용
```scss
// styles.scss
input.ng-invalid.ng-touched {
  border-color: red;
}

input.ng-valid.ng-touched {
  border-color: green;
}
```

## 9.3 Reactive Forms

### ReactiveFormsModule 설정
```typescript
// app.module.ts
import { ReactiveFormsModule } from '@angular/forms';

@NgModule({
  imports: [
    BrowserModule,
    ReactiveFormsModule  // 추가!
  ]
})
export class AppModule { }
```

### 기본 사용법
```typescript
// login.component.ts
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

export class LoginComponent implements OnInit {
  loginForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]]
    });
  }

  onSubmit(): void {
    if (this.loginForm.valid) {
      console.log('폼 값:', this.loginForm.value);
      // { email: '...', password: '...' }
    }
  }

  // getter로 쉽게 접근
  get email() {
    return this.loginForm.get('email');
  }

  get password() {
    return this.loginForm.get('password');
  }
}
```

```html
<!-- login.component.html -->
<form [formGroup]="loginForm" (ngSubmit)="onSubmit()">
  <div>
    <label>이메일:</label>
    <input type="email" formControlName="email">

    <div *ngIf="email?.invalid && (email?.dirty || email?.touched)">
      <p *ngIf="email?.errors?.['required']">이메일은 필수입니다</p>
      <p *ngIf="email?.errors?.['email']">올바른 이메일 형식이 아닙니다</p>
    </div>
  </div>

  <div>
    <label>비밀번호:</label>
    <input type="password" formControlName="password">

    <div *ngIf="password?.invalid && (password?.dirty || password?.touched)">
      <p *ngIf="password?.errors?.['required']">비밀번호는 필수입니다</p>
      <p *ngIf="password?.errors?.['minlength']">
        최소 6자 이상이어야 합니다
      </p>
    </div>
  </div>

  <button type="submit" [disabled]="!loginForm.valid">
    로그인
  </button>
</form>
```

## 9.4 FormControl과 FormGroup

### FormControl 직접 사용
```typescript
import { FormControl } from '@angular/forms';

export class SearchComponent {
  searchControl = new FormControl('');

  ngOnInit(): void {
    // 값 변경 감지
    this.searchControl.valueChanges.subscribe(value => {
      console.log('검색어:', value);
    });
  }
}
```

```html
<input [formControl]="searchControl" placeholder="검색...">
<p>입력한 값: {{ searchControl.value }}</p>
```

### FormGroup 중첩
```typescript
export class ProfileComponent implements OnInit {
  profileForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.profileForm = this.fb.group({
      name: ['바데부', Validators.required],
      age: [3, [Validators.required, Validators.min(0)]],
      address: this.fb.group({
        city: ['서울', Validators.required],
        street: [''],
        zipCode: ['']
      }),
      contact: this.fb.group({
        email: ['', [Validators.required, Validators.email]],
        phone: ['', Validators.pattern(/^\d{3}-\d{4}-\d{4}$/)]
      })
    });
  }

  onSubmit(): void {
    console.log(this.profileForm.value);
    // {
    //   name: '바데부',
    //   age: 3,
    //   address: { city: '서울', street: '', zipCode: '' },
    //   contact: { email: '...', phone: '...' }
    // }
  }
}
```

```html
<form [formGroup]="profileForm" (ngSubmit)="onSubmit()">
  <div>
    <label>이름:</label>
    <input formControlName="name">
  </div>

  <div>
    <label>나이:</label>
    <input type="number" formControlName="age">
  </div>

  <!-- 중첩된 FormGroup -->
  <div formGroupName="address">
    <h3>주소</h3>
    <div>
      <label>도시:</label>
      <input formControlName="city">
    </div>
    <div>
      <label>거리:</label>
      <input formControlName="street">
    </div>
    <div>
      <label>우편번호:</label>
      <input formControlName="zipCode">
    </div>
  </div>

  <div formGroupName="contact">
    <h3>연락처</h3>
    <div>
      <label>이메일:</label>
      <input type="email" formControlName="email">
    </div>
    <div>
      <label>전화번호:</label>
      <input formControlName="phone">
    </div>
  </div>

  <button type="submit" [disabled]="!profileForm.valid">
    저장
  </button>
</form>
```

## 9.5 FormArray - 동적 폼

### FormArray 사용
```typescript
import { FormArray } from '@angular/forms';

export class SkillsComponent implements OnInit {
  skillsForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.skillsForm = this.fb.group({
      skills: this.fb.array([
        this.createSkill()
      ])
    });
  }

  get skills(): FormArray {
    return this.skillsForm.get('skills') as FormArray;
  }

  createSkill(): FormGroup {
    return this.fb.group({
      name: ['', Validators.required],
      level: [1, [Validators.required, Validators.min(1), Validators.max(5)]]
    });
  }

  addSkill(): void {
    this.skills.push(this.createSkill());
  }

  removeSkill(index: number): void {
    this.skills.removeAt(index);
  }

  onSubmit(): void {
    console.log(this.skillsForm.value);
    // { skills: [{ name: 'Angular', level: 5 }, ...] }
  }
}
```

```html
<form [formGroup]="skillsForm" (ngSubmit)="onSubmit()">
  <div formArrayName="skills">
    <div *ngFor="let skill of skills.controls; let i = index" [formGroupName]="i">
      <h4>스킬 {{ i + 1 }}</h4>

      <div>
        <label>스킬명:</label>
        <input formControlName="name">
      </div>

      <div>
        <label>숙련도 (1-5):</label>
        <input type="number" formControlName="level" min="1" max="5">
      </div>

      <button type="button" (click)="removeSkill(i)">삭제</button>
    </div>
  </div>

  <button type="button" (click)="addSkill()">스킬 추가</button>
  <button type="submit" [disabled]="!skillsForm.valid">저장</button>
</form>
```

## 9.6 커스텀 Validator

### 커스텀 검증기 만들기
```typescript
// validators/custom-validators.ts
import { AbstractControl, ValidationErrors, ValidatorFn } from '@angular/forms';

export class CustomValidators {
  // 한글만 허용
  static koreanOnly(): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      const value = control.value;
      if (!value) return null;

      const korean = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+$/;
      return korean.test(value) ? null : { koreanOnly: true };
    };
  }

  // 비밀번호 확인
  static passwordMatch(passwordField: string, confirmField: string): ValidatorFn {
    return (formGroup: AbstractControl): ValidationErrors | null => {
      const password = formGroup.get(passwordField);
      const confirm = formGroup.get(confirmField);

      if (!password || !confirm) return null;

      return password.value === confirm.value ? null : { passwordMatch: true };
    };
  }

  // 금지된 단어
  static forbiddenWords(words: string[]): ValidatorFn {
    return (control: AbstractControl): ValidationErrors | null => {
      const value = control.value?.toLowerCase() || '';
      const hasForbiddenWord = words.some(word => value.includes(word.toLowerCase()));

      return hasForbiddenWord ? { forbiddenWords: true } : null;
    };
  }
}
```

### 사용 예시
```typescript
export class SignupComponent implements OnInit {
  signupForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.signupForm = this.fb.group({
      username: ['', [
        Validators.required,
        Validators.minLength(3),
        CustomValidators.koreanOnly()
      ]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['', Validators.required],
      bio: ['', [
        CustomValidators.forbiddenWords(['스팸', '광고'])
      ]]
    }, {
      validators: CustomValidators.passwordMatch('password', 'confirmPassword')
    });
  }
}
```

```html
<form [formGroup]="signupForm" (ngSubmit)="onSubmit()">
  <div>
    <label>사용자명 (한글):</label>
    <input formControlName="username">

    <div *ngIf="signupForm.get('username')?.invalid && signupForm.get('username')?.touched">
      <p *ngIf="signupForm.get('username')?.errors?.['required']">
        사용자명은 필수입니다
      </p>
      <p *ngIf="signupForm.get('username')?.errors?.['koreanOnly']">
        한글만 입력 가능합니다
      </p>
    </div>
  </div>

  <div>
    <label>비밀번호:</label>
    <input type="password" formControlName="password">
  </div>

  <div>
    <label>비밀번호 확인:</label>
    <input type="password" formControlName="confirmPassword">

    <p *ngIf="signupForm.errors?.['passwordMatch'] && signupForm.get('confirmPassword')?.touched">
      비밀번호가 일치하지 않습니다
    </p>
  </div>

  <div>
    <label>소개:</label>
    <textarea formControlName="bio"></textarea>

    <p *ngIf="signupForm.get('bio')?.errors?.['forbiddenWords']">
      금지된 단어가 포함되어 있습니다
    </p>
  </div>

  <button type="submit" [disabled]="!signupForm.valid">
    가입하기
  </button>
</form>
```

## 9.7 비동기 Validator

### 비동기 검증기 (API 호출)
```typescript
import { AsyncValidatorFn, AbstractControl, ValidationErrors } from '@angular/forms';
import { Observable, of, map, delay } from 'rxjs';

export class AsyncValidators {
  // 사용자명 중복 확인
  static usernameExists(userService: UserService): AsyncValidatorFn {
    return (control: AbstractControl): Observable<ValidationErrors | null> => {
      if (!control.value) {
        return of(null);
      }

      return userService.checkUsername(control.value).pipe(
        map(exists => exists ? { usernameExists: true } : null)
      );
    };
  }
}
```

```typescript
// user.service.ts
export class UserService {
  checkUsername(username: string): Observable<boolean> {
    // 실제로는 API 호출
    return of(username === '바데부').pipe(delay(1000));
  }
}
```

```typescript
// signup.component.ts
export class SignupComponent implements OnInit {
  signupForm!: FormGroup;

  constructor(
    private fb: FormBuilder,
    private userService: UserService
  ) {}

  ngOnInit(): void {
    this.signupForm = this.fb.group({
      username: ['',
        [Validators.required],
        [AsyncValidators.usernameExists(this.userService)]
      ]
    });
  }
}
```

```html
<div>
  <label>사용자명:</label>
  <input formControlName="username">

  <p *ngIf="signupForm.get('username')?.pending">확인 중...</p>

  <p *ngIf="signupForm.get('username')?.errors?.['usernameExists']">
    이미 사용 중인 사용자명입니다
  </p>
</div>
```

## 9.8 폼 값 설정과 가져오기

### setValue와 patchValue
```typescript
export class ProfileComponent {
  profileForm!: FormGroup;

  ngOnInit(): void {
    this.profileForm = this.fb.group({
      name: [''],
      age: [0],
      email: ['']
    });

    // setValue - 모든 값 설정 (필수)
    this.profileForm.setValue({
      name: '바데부',
      age: 3,
      email: 'badb@example.com'
    });

    // patchValue - 일부 값만 설정 (선택)
    this.profileForm.patchValue({
      name: '바데부'
      // age와 email은 생략 가능
    });

    // 개별 컨트롤 값 설정
    this.profileForm.get('name')?.setValue('바데부');

    // 값 가져오기
    console.log(this.profileForm.value);
    console.log(this.profileForm.get('name')?.value);
  }

  reset(): void {
    // 폼 초기화
    this.profileForm.reset();

    // 특정 값으로 초기화
    this.profileForm.reset({
      name: '',
      age: 0,
      email: ''
    });
  }
}
```

## 9.9 폼 상태 모니터링

### 상태 확인
```typescript
export class FormComponent implements OnInit {
  form!: FormGroup;

  ngOnInit(): void {
    this.form = this.fb.group({
      name: ['']
    });

    // 값 변경 감지
    this.form.valueChanges.subscribe(value => {
      console.log('값 변경:', value);
    });

    // 상태 변경 감지
    this.form.statusChanges.subscribe(status => {
      console.log('상태 변경:', status);  // VALID, INVALID, PENDING
    });

    // 특정 컨트롤 감지
    this.form.get('name')?.valueChanges.subscribe(value => {
      console.log('이름 변경:', value);
    });
  }

  checkStatus(): void {
    console.log('유효함:', this.form.valid);
    console.log('유효하지 않음:', this.form.invalid);
    console.log('변경됨:', this.form.dirty);
    console.log('터치됨:', this.form.touched);
    console.log('제출됨:', this.form.submitted);
  }
}
```

## 9.10 폼 베스트 프랙티스

### 좋은 예시
```typescript
// ✅ Reactive Forms 사용 (복잡한 폼)
export class ComplexFormComponent {
  form = this.fb.group({
    // 명시적 타입과 검증
    name: ['', [Validators.required, Validators.minLength(2)]],
    age: [0, [Validators.required, Validators.min(0)]]
  });

  // getter로 쉽게 접근
  get name() {
    return this.form.get('name');
  }
}

// ✅ 에러 메시지 중앙화
getErrorMessage(control: AbstractControl | null): string {
  if (!control || !control.errors) return '';

  if (control.errors['required']) return '필수 항목입니다';
  if (control.errors['email']) return '올바른 이메일 형식이 아닙니다';
  if (control.errors['minlength']) {
    return `최소 ${control.errors['minlength'].requiredLength}자 이상이어야 합니다`;
  }

  return '유효하지 않은 값입니다';
}
```

## 연습 문제

1. Template-driven Form으로 회원가입 폼을 만들어보세요
2. Reactive Form으로 프로필 편집 폼을 만들어보세요
3. FormArray를 사용하여 취미 목록을 추가/삭제하는 폼을 만드세요
4. 커스텀 Validator를 만들어 전화번호 형식을 검증하세요

## 다음 단계

다음 챕터에서는 **배포 및 베스트 프랙티스**를 배워봅시다! Angular 앱을 프로덕션에 배포하는 방법을 알아볼 거예요!

## 핵심 요약

- Template-driven Forms: ngModel, 간단한 폼에 적합
- Reactive Forms: FormControl/FormGroup, 복잡한 폼에 적합
- Validators로 유효성 검사 (required, email, minLength 등)
- 커스텀 Validator로 특수한 검증 로직 구현
- FormArray로 동적 폼 요소 추가/삭제
- valueChanges로 실시간 값 변경 감지
- setValue (전체), patchValue (일부) 로 값 설정
- async validator로 서버 검증

바데부와 함께 폼을 마스터해봅시다! 📋

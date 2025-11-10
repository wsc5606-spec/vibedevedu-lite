# Chapter 6: 서비스와 의존성 주입

안녕하세요! 바데부입니다! 이번에는 Angular의 강력한 서비스와 의존성 주입을 배워볼 거예요. 코드를 재사용하는 마법을 배워봅시다! 🎩

## 6.1 서비스란?

서비스는 특정 기능을 수행하는 클래스예요. 데이터, 로직, 외부 API 통신 등을 담당해요!

**서비스를 사용하는 이유:**
- 코드 재사용
- 관심사의 분리 (컴포넌트는 UI, 서비스는 로직)
- 테스트 용이성
- 여러 컴포넌트 간 데이터 공유

## 6.2 서비스 생성하기

### CLI로 생성
```bash
# 서비스 생성
ng generate service user
# 또는 단축어
ng g s user

# 특정 폴더에 생성
ng g s services/user
```

### 서비스 구조
```typescript
// user.service.ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'  // 루트 레벨에서 제공 (싱글톤)
})
export class UserService {
  private users: User[] = [
    { id: 1, name: '바데부', age: 3 },
    { id: 2, name: '철수', age: 25 }
  ];

  constructor() {
    console.log('UserService 생성됨!');
  }

  getUsers(): User[] {
    return this.users;
  }

  getUserById(id: number): User | undefined {
    return this.users.find(user => user.id === id);
  }

  addUser(user: User): void {
    this.users.push(user);
  }
}
```

## 6.3 의존성 주입 (Dependency Injection)

### 컴포넌트에서 서비스 사용
```typescript
// user-list.component.ts
import { Component, OnInit } from '@angular/core';
import { UserService } from './user.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html'
})
export class UserListComponent implements OnInit {
  users: User[] = [];

  // 생성자를 통한 의존성 주입
  constructor(private userService: UserService) {}

  ngOnInit(): void {
    // 서비스 메서드 호출
    this.users = this.userService.getUsers();
  }

  addUser(name: string, age: number): void {
    const newUser = {
      id: Date.now(),
      name,
      age
    };
    this.userService.addUser(newUser);
    this.users = this.userService.getUsers();
  }
}
```

```html
<!-- user-list.component.html -->
<div class="user-list">
  <h2>사용자 목록</h2>

  <ul>
    <li *ngFor="let user of users">
      {{ user.name }} ({{ user.age }}살)
    </li>
  </ul>

  <button (click)="addUser('영희', 23)">사용자 추가</button>
</div>
```

## 6.4 서비스 제공 범위

### providedIn: 'root' (기본, 권장)
```typescript
@Injectable({
  providedIn: 'root'  // 앱 전체에서 하나의 인스턴스만 존재 (싱글톤)
})
export class UserService {
  // 모든 컴포넌트가 같은 인스턴스를 공유
}
```

### 모듈 레벨 제공
```typescript
// app.module.ts
@NgModule({
  providers: [UserService]  // 이 모듈에서만 사용
})
export class AppModule { }
```

### 컴포넌트 레벨 제공
```typescript
@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  providers: [UserService]  // 이 컴포넌트와 자식에게만 새 인스턴스 제공
})
export class UserComponent {
  constructor(private userService: UserService) {}
}
```

## 6.5 데이터 공유 서비스

### BehaviorSubject를 사용한 상태 관리
```typescript
// data.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  // 초기값을 가진 BehaviorSubject
  private messageSource = new BehaviorSubject<string>('초기 메시지');

  // Observable로 노출 (외부에서 구독만 가능)
  currentMessage$ = this.messageSource.asObservable();

  constructor() {}

  // 메시지 변경 메서드
  changeMessage(message: string): void {
    this.messageSource.next(message);
  }
}
```

### 여러 컴포넌트에서 공유
```typescript
// component-a.component.ts
export class ComponentAComponent implements OnInit {
  message = '';

  constructor(private dataService: DataService) {}

  ngOnInit(): void {
    // 메시지 구독
    this.dataService.currentMessage$.subscribe(
      message => this.message = message
    );
  }

  updateMessage(): void {
    this.dataService.changeMessage('A에서 보낸 메시지');
  }
}
```

```typescript
// component-b.component.ts
export class ComponentBComponent implements OnInit {
  message = '';

  constructor(private dataService: DataService) {}

  ngOnInit(): void {
    // 같은 메시지를 받음
    this.dataService.currentMessage$.subscribe(
      message => this.message = message
    );
  }

  updateMessage(): void {
    this.dataService.changeMessage('B에서 보낸 메시지');
  }
}
```

## 6.6 HTTP 서비스

### API 통신 서비스
```typescript
// api.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private apiUrl = 'https://api.example.com';

  constructor(private http: HttpClient) {}

  // GET 요청
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(`${this.apiUrl}/users`);
  }

  // GET 요청 (ID로 조회)
  getUserById(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/users/${id}`);
  }

  // POST 요청
  createUser(user: User): Observable<User> {
    return this.http.post<User>(`${this.apiUrl}/users`, user);
  }

  // PUT 요청
  updateUser(id: number, user: User): Observable<User> {
    return this.http.put<User>(`${this.apiUrl}/users/${id}`, user);
  }

  // DELETE 요청
  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/users/${id}`);
  }
}
```

### 컴포넌트에서 사용
```typescript
export class UserComponent implements OnInit {
  users: User[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.apiService.getUsers().subscribe({
      next: (users) => {
        this.users = users;
        console.log('사용자 로딩 완료:', users);
      },
      error: (error) => {
        console.error('오류 발생:', error);
      },
      complete: () => {
        console.log('요청 완료');
      }
    });
  }

  createUser(name: string, age: number): void {
    const newUser = { name, age };
    this.apiService.createUser(newUser).subscribe({
      next: (user) => {
        this.users.push(user);
        console.log('사용자 생성됨:', user);
      },
      error: (error) => {
        console.error('생성 실패:', error);
      }
    });
  }
}
```

## 6.7 인터셉터 서비스

### HTTP 인터셉터 생성
```typescript
// auth.interceptor.ts
import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // 토큰 가져오기
    const token = localStorage.getItem('token');

    // 요청에 토큰 추가
    if (token) {
      const clonedReq = req.clone({
        headers: req.headers.set('Authorization', `Bearer ${token}`)
      });
      return next.handle(clonedReq);
    }

    return next.handle(req);
  }
}
```

### 모듈에 등록
```typescript
// app.module.ts
import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { AuthInterceptor } from './auth.interceptor';

@NgModule({
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    }
  ]
})
export class AppModule { }
```

## 6.8 로깅 서비스

### 로거 서비스 만들기
```typescript
// logger.service.ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class LoggerService {
  log(message: string): void {
    console.log(`[LOG] ${new Date().toISOString()}: ${message}`);
  }

  warn(message: string): void {
    console.warn(`[WARN] ${new Date().toISOString()}: ${message}`);
  }

  error(message: string, error?: any): void {
    console.error(`[ERROR] ${new Date().toISOString()}: ${message}`, error);
  }

  info(message: string): void {
    console.info(`[INFO] ${new Date().toISOString()}: ${message}`);
  }
}
```

### 사용 예시
```typescript
export class UserComponent {
  constructor(
    private userService: UserService,
    private logger: LoggerService
  ) {}

  loadUsers(): void {
    this.logger.info('사용자 로딩 시작');

    this.userService.getUsers().subscribe({
      next: (users) => {
        this.logger.log(`${users.length}명의 사용자 로딩 완료`);
      },
      error: (error) => {
        this.logger.error('사용자 로딩 실패', error);
      }
    });
  }
}
```

## 6.9 로컬 스토리지 서비스

### 스토리지 서비스
```typescript
// storage.service.ts
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class StorageService {
  // 저장
  set(key: string, value: any): void {
    try {
      localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
      console.error('저장 실패:', error);
    }
  }

  // 가져오기
  get<T>(key: string): T | null {
    try {
      const item = localStorage.getItem(key);
      return item ? JSON.parse(item) : null;
    } catch (error) {
      console.error('가져오기 실패:', error);
      return null;
    }
  }

  // 삭제
  remove(key: string): void {
    localStorage.removeItem(key);
  }

  // 전체 삭제
  clear(): void {
    localStorage.clear();
  }

  // 존재 여부 확인
  has(key: string): boolean {
    return localStorage.getItem(key) !== null;
  }
}
```

### 사용 예시
```typescript
export class AuthComponent {
  constructor(private storage: StorageService) {}

  login(token: string): void {
    this.storage.set('token', token);
    this.storage.set('user', { name: '바데부', id: 1 });
  }

  logout(): void {
    this.storage.remove('token');
    this.storage.remove('user');
  }

  isLoggedIn(): boolean {
    return this.storage.has('token');
  }

  getUser(): User | null {
    return this.storage.get<User>('user');
  }
}
```

## 6.10 서비스 간 의존성

### 서비스가 다른 서비스를 사용
```typescript
// auth.service.ts
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  constructor(
    private http: HttpClient,
    private storage: StorageService,
    private logger: LoggerService
  ) {}

  login(email: string, password: string): Observable<any> {
    this.logger.info('로그인 시도');

    return this.http.post('/api/login', { email, password }).pipe(
      tap(response => {
        // 토큰 저장
        this.storage.set('token', response.token);
        this.logger.log('로그인 성공');
      }),
      catchError(error => {
        this.logger.error('로그인 실패', error);
        throw error;
      })
    );
  }

  logout(): void {
    this.storage.remove('token');
    this.logger.info('로그아웃');
  }

  isAuthenticated(): boolean {
    return this.storage.has('token');
  }
}
```

## 6.11 서비스 베스트 프랙티스

### 좋은 예시
```typescript
// ✅ 단일 책임 원칙
@Injectable({
  providedIn: 'root'
})
export class UserService {
  // 사용자 관련 로직만 담당
  getUsers() { }
  createUser() { }
  updateUser() { }
}

// ✅ 인터페이스 사용
interface User {
  id: number;
  name: string;
  age: number;
}

// ✅ Observable 반환
getUsers(): Observable<User[]> {
  return this.http.get<User[]>('/api/users');
}
```

### 나쁜 예시
```typescript
// ❌ 너무 많은 책임
@Injectable({
  providedIn: 'root'
})
export class GodService {
  // 사용자, 제품, 주문, 결제 모두 처리...
  // 여러 서비스로 분리하세요!
}

// ❌ Promise 대신 Observable 사용
getUsersPromise(): Promise<User[]> {
  // Angular에서는 Observable을 권장
}
```

## 연습 문제

1. 간단한 TodoService를 만들어 할 일 목록을 관리하세요
2. BehaviorSubject를 사용하여 카운터 상태를 공유하세요
3. LocalStorage를 사용하는 서비스를 만들어보세요
4. HTTP 요청을 시뮬레이션하는 MockApiService를 만들어보세요

## 다음 단계

다음 챕터에서는 **라우팅**을 배워봅시다! 여러 페이지 간 이동하는 방법을 알아볼 거예요!

## 핵심 요약

- 서비스는 재사용 가능한 로직과 데이터를 담당
- `@Injectable({ providedIn: 'root' })`로 싱글톤 서비스 생성
- 생성자를 통한 의존성 주입 (Dependency Injection)
- BehaviorSubject로 컴포넌트 간 데이터 공유
- HttpClient로 API 통신 처리
- 인터셉터로 HTTP 요청/응답 가로채기
- 서비스는 단일 책임 원칙을 따라야 함
- Observable을 반환하여 비동기 처리

바데부와 함께 서비스를 마스터해봅시다! 💼

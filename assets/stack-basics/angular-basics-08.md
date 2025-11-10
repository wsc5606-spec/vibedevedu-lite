# Chapter 8: HTTP 통신

안녕하세요! 바데부입니다! 이번에는 Angular에서 API를 호출하고 데이터를 주고받는 방법을 배워볼 거예요! 🌐

## 8.1 HttpClient란?

HttpClient는 Angular에서 HTTP 요청을 보내는 서비스예요. REST API와 통신할 때 사용해요!

**HttpClient의 특징:**
- Observable 기반 (RxJS)
- 타입 안전성
- 인터셉터 지원
- 테스트 용이성
- 자동 JSON 변환

## 8.2 HttpClientModule 설정

### 모듈 임포트
```typescript
// app.module.ts
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  imports: [
    BrowserModule,
    HttpClientModule  // 추가!
  ]
})
export class AppModule { }
```

## 8.3 GET 요청

### 기본 GET 요청
```typescript
// user.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private apiUrl = 'https://api.example.com/users';

  constructor(private http: HttpClient) {}

  // 모든 사용자 가져오기
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl);
  }

  // ID로 사용자 가져오기
  getUserById(id: number): Observable<User> {
    return this.http.get<User>(`${this.apiUrl}/${id}`);
  }
}
```

### 컴포넌트에서 사용
```typescript
// user-list.component.ts
export class UserListComponent implements OnInit {
  users: User[] = [];
  loading = false;
  error = '';

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.loading = true;

    this.userService.getUsers().subscribe({
      next: (users) => {
        this.users = users;
        this.loading = false;
        console.log('사용자 로딩 완료:', users);
      },
      error: (error) => {
        this.error = '사용자를 불러오는데 실패했습니다';
        this.loading = false;
        console.error('오류 발생:', error);
      },
      complete: () => {
        console.log('요청 완료');
      }
    });
  }
}
```

```html
<!-- user-list.component.html -->
<div class="user-list">
  <h2>사용자 목록</h2>

  <!-- 로딩 중 -->
  <div *ngIf="loading">
    <p>로딩 중...</p>
  </div>

  <!-- 오류 -->
  <div *ngIf="error" class="error">
    {{ error }}
  </div>

  <!-- 사용자 목록 -->
  <ul *ngIf="!loading && !error">
    <li *ngFor="let user of users">
      {{ user.name }} ({{ user.email }})
    </li>
  </ul>
</div>
```

## 8.4 POST 요청

### 데이터 생성
```typescript
// user.service.ts
export class UserService {
  // 사용자 생성
  createUser(user: Omit<User, 'id'>): Observable<User> {
    return this.http.post<User>(this.apiUrl, user);
  }
}
```

```typescript
// create-user.component.ts
export class CreateUserComponent {
  newUser = {
    name: '',
    email: '',
    age: 0
  };

  constructor(private userService: UserService) {}

  onSubmit(): void {
    this.userService.createUser(this.newUser).subscribe({
      next: (user) => {
        console.log('사용자 생성 성공:', user);
        alert(`${user.name}님이 등록되었습니다!`);
      },
      error: (error) => {
        console.error('생성 실패:', error);
        alert('사용자 생성에 실패했습니다');
      }
    });
  }
}
```

```html
<!-- create-user.component.html -->
<form (ngSubmit)="onSubmit()">
  <div>
    <label>이름:</label>
    <input [(ngModel)]="newUser.name" name="name" required>
  </div>

  <div>
    <label>이메일:</label>
    <input [(ngModel)]="newUser.email" name="email" type="email" required>
  </div>

  <div>
    <label>나이:</label>
    <input [(ngModel)]="newUser.age" name="age" type="number" required>
  </div>

  <button type="submit">생성</button>
</form>
```

## 8.5 PUT 요청

### 데이터 수정
```typescript
// user.service.ts
export class UserService {
  // 사용자 수정 (전체 교체)
  updateUser(id: number, user: User): Observable<User> {
    return this.http.put<User>(`${this.apiUrl}/${id}`, user);
  }

  // 사용자 수정 (부분 수정)
  patchUser(id: number, updates: Partial<User>): Observable<User> {
    return this.http.patch<User>(`${this.apiUrl}/${id}`, updates);
  }
}
```

```typescript
// edit-user.component.ts
export class EditUserComponent implements OnInit {
  userId = 1;
  user: User = {
    id: 0,
    name: '',
    email: '',
    age: 0
  };

  constructor(
    private userService: UserService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    this.userId = Number(this.route.snapshot.paramMap.get('id'));
    this.loadUser();
  }

  loadUser(): void {
    this.userService.getUserById(this.userId).subscribe({
      next: (user) => {
        this.user = user;
      }
    });
  }

  onSubmit(): void {
    this.userService.updateUser(this.userId, this.user).subscribe({
      next: (updatedUser) => {
        console.log('수정 성공:', updatedUser);
        alert('사용자 정보가 수정되었습니다');
      },
      error: (error) => {
        console.error('수정 실패:', error);
      }
    });
  }
}
```

## 8.6 DELETE 요청

### 데이터 삭제
```typescript
// user.service.ts
export class UserService {
  // 사용자 삭제
  deleteUser(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
```

```typescript
// user-list.component.ts
export class UserListComponent {
  users: User[] = [];

  constructor(private userService: UserService) {}

  deleteUser(id: number): void {
    if (!confirm('정말 삭제하시겠습니까?')) {
      return;
    }

    this.userService.deleteUser(id).subscribe({
      next: () => {
        console.log('삭제 성공');
        // 목록에서 제거
        this.users = this.users.filter(u => u.id !== id);
        alert('사용자가 삭제되었습니다');
      },
      error: (error) => {
        console.error('삭제 실패:', error);
        alert('삭제에 실패했습니다');
      }
    });
  }
}
```

```html
<ul>
  <li *ngFor="let user of users">
    {{ user.name }}
    <button (click)="deleteUser(user.id)">삭제</button>
  </li>
</ul>
```

## 8.7 HTTP 옵션

### 헤더 추가
```typescript
import { HttpHeaders } from '@angular/common/http';

export class UserService {
  getUsers(): Observable<User[]> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + this.getToken()
    });

    return this.http.get<User[]>(this.apiUrl, { headers });
  }

  private getToken(): string {
    return localStorage.getItem('token') || '';
  }
}
```

### 쿼리 파라미터
```typescript
import { HttpParams } from '@angular/common/http';

export class UserService {
  searchUsers(keyword: string, page: number = 1): Observable<User[]> {
    const params = new HttpParams()
      .set('keyword', keyword)
      .set('page', page.toString())
      .set('limit', '10');

    // GET /users?keyword=바데부&page=1&limit=10
    return this.http.get<User[]>(this.apiUrl, { params });
  }

  // 객체로 전달
  searchUsersV2(keyword: string, page: number = 1): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl, {
      params: {
        keyword,
        page: page.toString(),
        limit: '10'
      }
    });
  }
}
```

### 전체 응답 받기
```typescript
import { HttpResponse } from '@angular/common/http';

export class UserService {
  getUsersWithResponse(): Observable<HttpResponse<User[]>> {
    return this.http.get<User[]>(this.apiUrl, {
      observe: 'response'
    });
  }
}
```

```typescript
this.userService.getUsersWithResponse().subscribe({
  next: (response) => {
    console.log('상태 코드:', response.status);
    console.log('헤더:', response.headers.get('Content-Type'));
    console.log('데이터:', response.body);
    this.users = response.body || [];
  }
});
```

## 8.8 에러 처리

### 에러 핸들링
```typescript
import { catchError, throwError } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';

export class UserService {
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      catchError(this.handleError)
    );
  }

  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = '';

    if (error.error instanceof ErrorEvent) {
      // 클라이언트 에러
      errorMessage = `클라이언트 오류: ${error.error.message}`;
    } else {
      // 서버 에러
      errorMessage = `서버 오류: ${error.status}\n메시지: ${error.message}`;

      switch (error.status) {
        case 400:
          errorMessage = '잘못된 요청입니다';
          break;
        case 401:
          errorMessage = '인증이 필요합니다';
          break;
        case 403:
          errorMessage = '권한이 없습니다';
          break;
        case 404:
          errorMessage = '리소스를 찾을 수 없습니다';
          break;
        case 500:
          errorMessage = '서버 오류가 발생했습니다';
          break;
      }
    }

    console.error(errorMessage);
    return throwError(() => new Error(errorMessage));
  }
}
```

## 8.9 HTTP 인터셉터

### 인터셉터 생성
```bash
ng generate interceptor auth
```

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

    // 토큰이 있으면 헤더에 추가
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

### 로깅 인터셉터
```typescript
// logging.interceptor.ts
import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpResponse } from '@angular/common/http';
import { Observable, tap } from 'rxjs';

@Injectable()
export class LoggingInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const startTime = Date.now();
    console.log(`요청 시작: ${req.method} ${req.url}`);

    return next.handle(req).pipe(
      tap({
        next: (event) => {
          if (event instanceof HttpResponse) {
            const elapsedTime = Date.now() - startTime;
            console.log(`요청 완료: ${req.method} ${req.url} (${elapsedTime}ms)`);
          }
        },
        error: (error) => {
          const elapsedTime = Date.now() - startTime;
          console.error(`요청 실패: ${req.method} ${req.url} (${elapsedTime}ms)`, error);
        }
      })
    );
  }
}
```

### 인터셉터 등록
```typescript
// app.module.ts
import { HTTP_INTERCEPTORS } from '@angular/common/http';
import { AuthInterceptor } from './auth.interceptor';
import { LoggingInterceptor } from './logging.interceptor';

@NgModule({
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: LoggingInterceptor,
      multi: true
    }
  ]
})
export class AppModule { }
```

## 8.10 RxJS 연산자 활용

### map - 데이터 변환
```typescript
import { map } from 'rxjs/operators';

export class UserService {
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      map(users => users.map(user => ({
        ...user,
        displayName: `${user.name} (${user.age}살)`
      })))
    );
  }
}
```

### retry - 재시도
```typescript
import { retry, catchError } from 'rxjs/operators';

export class UserService {
  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(this.apiUrl).pipe(
      retry(3),  // 실패 시 3번 재시도
      catchError(this.handleError)
    );
  }
}
```

### debounceTime - 검색 최적화
```typescript
import { Subject, debounceTime, switchMap } from 'rxjs';

export class SearchComponent implements OnInit {
  searchTerm = new Subject<string>();
  results: User[] = [];

  constructor(private userService: UserService) {}

  ngOnInit(): void {
    this.searchTerm.pipe(
      debounceTime(300),  // 300ms 대기
      switchMap(term => this.userService.searchUsers(term))
    ).subscribe(results => {
      this.results = results;
    });
  }

  onSearch(term: string): void {
    this.searchTerm.next(term);
  }
}
```

```html
<input (input)="onSearch($event.target.value)" placeholder="검색...">

<ul>
  <li *ngFor="let user of results">
    {{ user.name }}
  </li>
</ul>
```

## 8.11 파일 업로드

### 파일 업로드 서비스
```typescript
export class FileService {
  private uploadUrl = 'https://api.example.com/upload';

  constructor(private http: HttpClient) {}

  uploadFile(file: File): Observable<any> {
    const formData = new FormData();
    formData.append('file', file, file.name);

    return this.http.post(this.uploadUrl, formData, {
      reportProgress: true,
      observe: 'events'
    });
  }
}
```

### 업로드 컴포넌트
```typescript
import { HttpEventType } from '@angular/common/http';

export class UploadComponent {
  selectedFile: File | null = null;
  uploadProgress = 0;

  constructor(private fileService: FileService) {}

  onFileSelected(event: Event): void {
    const target = event.target as HTMLInputElement;
    if (target.files && target.files.length > 0) {
      this.selectedFile = target.files[0];
    }
  }

  upload(): void {
    if (!this.selectedFile) return;

    this.fileService.uploadFile(this.selectedFile).subscribe({
      next: (event) => {
        if (event.type === HttpEventType.UploadProgress) {
          // 업로드 진행률
          this.uploadProgress = Math.round(100 * event.loaded / (event.total || 1));
        } else if (event.type === HttpEventType.Response) {
          // 업로드 완료
          console.log('업로드 완료:', event.body);
          alert('파일이 업로드되었습니다!');
        }
      },
      error: (error) => {
        console.error('업로드 실패:', error);
      }
    });
  }
}
```

```html
<div>
  <input type="file" (change)="onFileSelected($event)">
  <button (click)="upload()" [disabled]="!selectedFile">업로드</button>

  <div *ngIf="uploadProgress > 0">
    <progress [value]="uploadProgress" max="100"></progress>
    <span>{{ uploadProgress }}%</span>
  </div>
</div>
```

## 연습 문제

1. JSONPlaceholder API를 사용하여 게시글 목록을 가져오세요
2. 새 게시글을 작성하는 폼을 만들고 POST 요청을 보내세요
3. 검색 기능을 구현하고 debounceTime을 사용하세요
4. HTTP 인터셉터를 만들어 모든 요청에 로깅을 추가하세요

## 다음 단계

다음 챕터에서는 **폼**을 배워봅시다! Template-driven Forms와 Reactive Forms를 알아볼 거예요!

## 핵심 요약

- HttpClientModule을 임포트하여 HTTP 통신 사용
- HttpClient로 GET, POST, PUT, DELETE 요청
- Observable 기반의 비동기 처리
- HttpHeaders로 헤더 추가, HttpParams로 쿼리 파라미터 추가
- catchError로 에러 처리
- HTTP 인터셉터로 요청/응답 가로채기
- RxJS 연산자로 데이터 변환 및 최적화
- FormData로 파일 업로드

바데부와 함께 HTTP 통신을 마스터해봅시다! 📡

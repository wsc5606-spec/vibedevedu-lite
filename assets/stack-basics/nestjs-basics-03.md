# Chapter 3: 프로바이더와 의존성 주입

## 프로바이더란?

프로바이더(Provider)는 NestJS의 핵심 개념으로, 서비스, 리포지토리, 팩토리, 헬퍼 등 다양한 역할을 수행할 수 있는 클래스입니다.

```typescript
// 바데부: "프로바이더는 재사용 가능한 비즈니스 로직을 담는 상자예요!"
// 컨트롤러는 요청을 받고, 프로바이더가 실제 일을 처리합니다.
```

### 왜 프로바이더를 사용할까?

1. **관심사의 분리**: 컨트롤러는 라우팅만, 서비스는 비즈니스 로직만
2. **재사용성**: 여러 컨트롤러에서 같은 서비스 사용 가능
3. **테스트 용이성**: 서비스를 독립적으로 테스트 가능
4. **유지보수**: 코드 수정이 쉬워집니다

## 서비스 생성하기

### CLI로 생성

```bash
# users 서비스 생성
nest g service users

# 축약형
nest g s users
```

생성된 파일:
- `users.service.ts` - 서비스 로직
- `users.service.spec.ts` - 테스트 파일

### 기본 서비스 구조

```typescript
// src/users/users.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()  // 의존성 주입이 가능하도록 표시
export class UsersService {

  private users = [
    { id: 1, name: '바데부', email: 'badebu@example.com' },
    { id: 2, name: '김코딩', email: 'coding@example.com' }
  ];

  // 모든 사용자 조회
  findAll() {
    return this.users;
  }

  // 특정 사용자 조회
  findOne(id: number) {
    return this.users.find(user => user.id === id);
  }

  // 사용자 생성
  create(user: any) {
    const newUser = {
      id: this.users.length + 1,
      ...user
    };
    this.users.push(newUser);
    return newUser;
  }

  // 사용자 수정
  update(id: number, updateData: any) {
    const index = this.users.findIndex(user => user.id === id);
    if (index !== -1) {
      this.users[index] = { ...this.users[index], ...updateData };
      return this.users[index];
    }
    return null;
  }

  // 사용자 삭제
  remove(id: number) {
    const index = this.users.findIndex(user => user.id === id);
    if (index !== -1) {
      return this.users.splice(index, 1)[0];
    }
    return null;
  }
}
```

## 의존성 주입(Dependency Injection)

### 컨트롤러에서 서비스 사용하기

```typescript
// src/users/users.controller.ts
import { Controller, Get, Post, Put, Delete, Param, Body } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {

  // 생성자에서 서비스 주입
  constructor(private readonly usersService: UsersService) {
    // 바데부: "usersService를 자동으로 주입받았어요!"
  }

  @Get()
  findAll() {
    return {
      message: '바데부: 모든 사용자 조회',
      data: this.usersService.findAll()
    };
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    const user = this.usersService.findOne(+id);
    return {
      message: `바데부: ${id}번 사용자 조회`,
      data: user
    };
  }

  @Post()
  create(@Body() createUserDto: any) {
    const user = this.usersService.create(createUserDto);
    return {
      message: '바데부: 사용자 생성 완료',
      data: user
    };
  }

  @Put(':id')
  update(@Param('id') id: string, @Body() updateUserDto: any) {
    const user = this.usersService.update(+id, updateUserDto);
    return {
      message: '바데부: 사용자 수정 완료',
      data: user
    };
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    const user = this.usersService.remove(+id);
    return {
      message: '바데부: 사용자 삭제 완료',
      data: user
    };
  }
}
```

### 의존성 주입의 장점

```typescript
// 나쁜 예: 직접 인스턴스 생성
export class UsersController {
  private usersService = new UsersService();  // ❌ 테스트 어려움
}

// 좋은 예: 의존성 주입
export class UsersController {
  constructor(private usersService: UsersService) {}  // ✅ 테스트 쉬움
}
```

## 프로바이더 등록하기

### 모듈에 등록

```typescript
// src/users/users.module.ts
import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  controllers: [UsersController],
  providers: [UsersService],  // 프로바이더 등록
  exports: [UsersService]     // 다른 모듈에서 사용 가능하도록 export
})
export class UsersModule {}
```

## 프로바이더 스코프

### 기본 스코프 (SINGLETON)

```typescript
import { Injectable, Scope } from '@nestjs/common';

// 기본값: 싱글톤 (애플리케이션 전체에서 하나의 인스턴스)
@Injectable()
export class BadebuService {
  private count = 0;

  increment() {
    this.count++;
    return this.count;
  }
}
```

### REQUEST 스코프

```typescript
// 각 요청마다 새로운 인스턴스 생성
@Injectable({ scope: Scope.REQUEST })
export class RequestScopedService {
  constructor() {
    console.log('바데부: 새 요청마다 생성됩니다!');
  }
}
```

### TRANSIENT 스코프

```typescript
// 주입될 때마다 새로운 인스턴스 생성
@Injectable({ scope: Scope.TRANSIENT })
export class TransientService {
  constructor() {
    console.log('바데부: 주입될 때마다 생성됩니다!');
  }
}
```

## 커스텀 프로바이더

### 값 프로바이더 (Value Provider)

```typescript
// 상수나 설정값 제공
const CONFIG = {
  appName: '바데부 API',
  version: '1.0.0',
  port: 3000
};

@Module({
  providers: [
    {
      provide: 'CONFIG',
      useValue: CONFIG
    }
  ]
})
export class AppModule {}

// 사용하기
@Injectable()
export class BadebuService {
  constructor(@Inject('CONFIG') private config: any) {
    console.log(`바데부: ${this.config.appName} 시작!`);
  }
}
```

### 클래스 프로바이더 (Class Provider)

```typescript
// 인터페이스를 구현한 다른 클래스 제공
abstract class LoggerService {
  abstract log(message: string): void;
}

class ConsoleLogger implements LoggerService {
  log(message: string) {
    console.log(`바데부: ${message}`);
  }
}

@Module({
  providers: [
    {
      provide: LoggerService,
      useClass: ConsoleLogger  // 실제로 주입될 클래스
    }
  ]
})
export class AppModule {}
```

### 팩토리 프로바이더 (Factory Provider)

```typescript
// 동적으로 프로바이더 생성
@Module({
  providers: [
    {
      provide: 'DATABASE_CONNECTION',
      useFactory: async () => {
        console.log('바데부: 데이터베이스 연결 중...');
        // 비동기 작업 수행
        return {
          host: 'localhost',
          port: 5432,
          connected: true
        };
      }
    }
  ]
})
export class AppModule {}

// 다른 프로바이더에 의존하는 팩토리
@Module({
  providers: [
    ConfigService,
    {
      provide: 'DATABASE_CONNECTION',
      useFactory: (configService: ConfigService) => {
        return {
          host: configService.get('DB_HOST'),
          port: configService.get('DB_PORT')
        };
      },
      inject: [ConfigService]  // 의존성 주입
    }
  ]
})
export class AppModule {}
```

## 실전 예제: 바데부의 블로그 시스템

### PostsService

```typescript
// posts.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';

interface Post {
  id: number;
  title: string;
  content: string;
  author: string;
  createdAt: Date;
  views: number;
}

@Injectable()
export class PostsService {
  private posts: Post[] = [
    {
      id: 1,
      title: '바데부의 NestJS 시작하기',
      content: 'NestJS는 정말 멋진 프레임워크입니다!',
      author: '바데부',
      createdAt: new Date(),
      views: 0
    }
  ];

  findAll(): Post[] {
    return this.posts;
  }

  findOne(id: number): Post {
    const post = this.posts.find(p => p.id === id);
    if (!post) {
      throw new NotFoundException(`바데부: ${id}번 게시글을 찾을 수 없습니다`);
    }
    return post;
  }

  create(createPostDto: Omit<Post, 'id' | 'createdAt' | 'views'>): Post {
    const newPost: Post = {
      id: this.posts.length + 1,
      ...createPostDto,
      createdAt: new Date(),
      views: 0
    };
    this.posts.push(newPost);
    return newPost;
  }

  incrementViews(id: number): Post {
    const post = this.findOne(id);
    post.views++;
    return post;
  }

  findByAuthor(author: string): Post[] {
    return this.posts.filter(p => p.author === author);
  }

  getStatistics() {
    return {
      totalPosts: this.posts.length,
      totalViews: this.posts.reduce((sum, p) => sum + p.views, 0),
      authors: [...new Set(this.posts.map(p => p.author))]
    };
  }
}
```

### 서비스 간 의존성

```typescript
// analytics.service.ts
import { Injectable } from '@nestjs/common';
import { PostsService } from './posts.service';

@Injectable()
export class AnalyticsService {
  constructor(private postsService: PostsService) {
    // 바데부: PostsService를 주입받았어요!
  }

  getPopularPosts(limit: number = 5) {
    const allPosts = this.postsService.findAll();
    return allPosts
      .sort((a, b) => b.views - a.views)
      .slice(0, limit);
  }

  getAuthorStats(author: string) {
    const authorPosts = this.postsService.findByAuthor(author);
    const totalViews = authorPosts.reduce((sum, p) => sum + p.views, 0);

    return {
      author,
      postCount: authorPosts.length,
      totalViews,
      averageViews: totalViews / authorPosts.length || 0
    };
  }
}
```

### 모듈 구성

```typescript
// posts.module.ts
import { Module } from '@nestjs/common';
import { PostsController } from './posts.controller';
import { PostsService } from './posts.service';
import { AnalyticsService } from './analytics.service';

@Module({
  controllers: [PostsController],
  providers: [PostsService, AnalyticsService],
  exports: [PostsService]  // 다른 모듈에서 사용 가능
})
export class PostsModule {}
```

## 선택적 의존성

```typescript
import { Injectable, Optional, Inject } from '@nestjs/common';

@Injectable()
export class BadebuService {
  constructor(
    @Optional()
    @Inject('OPTIONAL_CONFIG')
    private config?: any
  ) {
    if (this.config) {
      console.log('바데부: 설정이 제공되었습니다!');
    } else {
      console.log('바데부: 기본 설정을 사용합니다!');
    }
  }
}
```

## 프로퍼티 기반 주입

```typescript
import { Injectable, Inject } from '@nestjs/common';

@Injectable()
export class BadebuService {
  // 생성자 대신 프로퍼티로 주입
  @Inject('CONFIG')
  private config: any;

  getConfig() {
    return this.config;
  }
}
```

## 순환 의존성 해결

```typescript
// 순환 의존성이 발생할 때
import { Injectable, forwardRef, Inject } from '@nestjs/common';

@Injectable()
export class AService {
  constructor(
    @Inject(forwardRef(() => BService))
    private bService: BService
  ) {}
}

@Injectable()
export class BService {
  constructor(
    @Inject(forwardRef(() => AService))
    private aService: AService
  ) {}
}
```

## 비동기 프로바이더

```typescript
@Module({
  providers: [
    {
      provide: 'ASYNC_CONNECTION',
      useFactory: async () => {
        console.log('바데부: 비동기 연결 시작...');
        await new Promise(resolve => setTimeout(resolve, 2000));
        return { status: 'connected' };
      }
    }
  ]
})
export class AppModule {}
```

## 프로바이더 모범 사례

### 1. 단일 책임 원칙

```typescript
// ❌ 나쁜 예: 너무 많은 책임
@Injectable()
export class UserService {
  createUser() { }
  sendEmail() { }
  uploadFile() { }
  generatePDF() { }
}

// ✅ 좋은 예: 각자의 책임 분리
@Injectable()
export class UserService {
  createUser() { }
}

@Injectable()
export class EmailService {
  sendEmail() { }
}

@Injectable()
export class FileService {
  uploadFile() { }
}
```

### 2. 인터페이스 사용

```typescript
// user.interface.ts
export interface User {
  id: number;
  name: string;
  email: string;
}

// users.service.ts
@Injectable()
export class UsersService {
  findAll(): User[] {
    // 타입 안정성 확보
  }
}
```

## 연습 문제

1. `TasksService`를 만들고 할 일 CRUD 기능을 구현해보세요
2. `TasksService`를 사용하는 `TasksController`를 만들어보세요
3. `StatisticsService`를 만들어 `TasksService`에 의존하도록 구성해보세요

## 다음 챕터 예고

다음 챕터에서는 **모듈과 애플리케이션 구조**를 배워 대규모 앱을 체계적으로 구성하는 방법을 알아봅니다!

## 핵심 정리

- 프로바이더는 `@Injectable()` 데코레이터로 정의
- 생성자를 통한 의존성 주입 (Constructor Injection)
- 모듈의 `providers` 배열에 등록
- 기본적으로 싱글톤 스코프
- 커스텀 프로바이더: 값, 클래스, 팩토리
- `exports`로 다른 모듈에서 사용 가능

바데부와 함께 의존성 주입을 마스터했습니다!

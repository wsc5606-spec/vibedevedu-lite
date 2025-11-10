# Chapter 4: 모듈과 애플리케이션 구조

## 모듈이란?

모듈은 NestJS 애플리케이션의 기본 구성 단위입니다. `@Module()` 데코레이터로 정의되며, 관련된 기능들을 하나로 묶어 조직화합니다.

```typescript
// 바데부: "모듈은 레고 블록 같아요!"
// 각 블록(모듈)을 조립해서 큰 작품(애플리케이션)을 만듭니다.
```

### 왜 모듈을 사용할까?

1. **코드 조직화**: 관련 기능을 함께 그룹화
2. **재사용성**: 모듈을 다른 프로젝트에서도 사용 가능
3. **캡슐화**: 모듈 내부 구현을 숨기고 필요한 것만 공개
4. **확장성**: 기능 추가가 쉬워집니다

## 기본 모듈 구조

### @Module() 데코레이터

```typescript
import { Module } from '@nestjs/common';

@Module({
  imports: [],      // 다른 모듈 가져오기
  controllers: [],  // 이 모듈의 컨트롤러
  providers: [],    // 이 모듈의 프로바이더
  exports: []       // 다른 모듈에 제공할 프로바이더
})
export class BadebuModule {}
```

## 모듈 생성하기

### CLI로 생성

```bash
# users 모듈 생성
nest g module users

# 축약형
nest g mo users
```

### 전체 리소스 한 번에 생성

```bash
# 모듈, 컨트롤러, 서비스 한 번에 생성
nest g resource users

# REST API 선택
? What transport layer do you use? REST API
? Would you like to generate CRUD entry points? Yes
```

## 기본 모듈 예제

```typescript
// users.module.ts
import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService]  // 다른 모듈에서 사용 가능
})
export class UsersModule {}
```

## 루트 모듈 (AppModule)

모든 NestJS 애플리케이션은 하나의 루트 모듈을 가집니다.

```typescript
// app.module.ts
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { PostsModule } from './posts/posts.module';

@Module({
  imports: [
    UsersModule,   // 바데부: 사용자 모듈 추가!
    PostsModule    // 바데부: 게시글 모듈 추가!
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
```

## 모듈 간 의존성

### 다른 모듈의 프로바이더 사용하기

```typescript
// posts.module.ts
import { Module } from '@nestjs/common';
import { PostsController } from './posts.controller';
import { PostsService } from './posts.service';
import { UsersModule } from '../users/users.module';  // import

@Module({
  imports: [UsersModule],  // UsersModule에서 export한 것 사용 가능
  controllers: [PostsController],
  providers: [PostsService]
})
export class PostsModule {}

// posts.service.ts
import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';

@Injectable()
export class PostsService {
  constructor(private usersService: UsersService) {
    // 바데부: UsersService를 사용할 수 있어요!
  }

  getPostWithAuthor(postId: number) {
    const author = this.usersService.findOne(1);
    return {
      postId,
      title: '바데부의 NestJS 가이드',
      author
    };
  }
}
```

## 전역 모듈

### @Global() 데코레이터

어디서나 사용할 수 있는 전역 모듈을 만들 수 있습니다.

```typescript
// common.module.ts
import { Module, Global } from '@nestjs/common';
import { LoggerService } from './logger.service';
import { ConfigService } from './config.service';

@Global()  // 전역 모듈로 설정
@Module({
  providers: [LoggerService, ConfigService],
  exports: [LoggerService, ConfigService]
})
export class CommonModule {}

// 이제 다른 모듈에서 import 없이 사용 가능!
@Injectable()
export class BadebuService {
  constructor(private loggerService: LoggerService) {
    // 바데부: 전역 모듈이라 바로 사용 가능해요!
  }
}
```

## 동적 모듈

런타임에 설정 가능한 모듈을 만들 수 있습니다.

```typescript
// database.module.ts
import { Module, DynamicModule } from '@nestjs/common';

interface DatabaseConfig {
  host: string;
  port: number;
  username: string;
  password: string;
}

@Module({})
export class DatabaseModule {
  static forRoot(config: DatabaseConfig): DynamicModule {
    return {
      module: DatabaseModule,
      providers: [
        {
          provide: 'DATABASE_CONFIG',
          useValue: config
        },
        {
          provide: 'DATABASE_CONNECTION',
          useFactory: (config: DatabaseConfig) => {
            console.log(`바데부: ${config.host}:${config.port}에 연결합니다`);
            return { connected: true, config };
          },
          inject: ['DATABASE_CONFIG']
        }
      ],
      exports: ['DATABASE_CONNECTION']
    };
  }
}

// app.module.ts에서 사용
@Module({
  imports: [
    DatabaseModule.forRoot({
      host: 'localhost',
      port: 5432,
      username: 'badebu',
      password: 'password123'
    })
  ]
})
export class AppModule {}
```

## 실전 예제: 바데부의 블로그 애플리케이션

### 프로젝트 구조

```
src/
├── app.module.ts              # 루트 모듈
├── app.controller.ts
├── app.service.ts
├── main.ts
├── common/                    # 공통 모듈
│   ├── common.module.ts
│   ├── logger/
│   │   └── logger.service.ts
│   └── config/
│       └── config.service.ts
├── users/                     # 사용자 모듈
│   ├── users.module.ts
│   ├── users.controller.ts
│   ├── users.service.ts
│   └── dto/
│       └── create-user.dto.ts
├── posts/                     # 게시글 모듈
│   ├── posts.module.ts
│   ├── posts.controller.ts
│   ├── posts.service.ts
│   └── dto/
│       └── create-post.dto.ts
└── comments/                  # 댓글 모듈
    ├── comments.module.ts
    ├── comments.controller.ts
    ├── comments.service.ts
    └── dto/
        └── create-comment.dto.ts
```

### Common Module (전역 유틸리티)

```typescript
// common/logger/logger.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class LoggerService {
  log(message: string) {
    console.log(`[바데부 LOG] ${new Date().toISOString()} - ${message}`);
  }

  error(message: string, trace: string) {
    console.error(`[바데부 ERROR] ${new Date().toISOString()} - ${message}`);
    console.error(trace);
  }
}

// common/common.module.ts
import { Module, Global } from '@nestjs/common';
import { LoggerService } from './logger/logger.service';
import { ConfigService } from './config/config.service';

@Global()
@Module({
  providers: [LoggerService, ConfigService],
  exports: [LoggerService, ConfigService]
})
export class CommonModule {}
```

### Users Module

```typescript
// users/users.service.ts
import { Injectable } from '@nestjs/common';
import { LoggerService } from '../common/logger/logger.service';

interface User {
  id: number;
  name: string;
  email: string;
}

@Injectable()
export class UsersService {
  private users: User[] = [
    { id: 1, name: '바데부', email: 'badebu@example.com' }
  ];

  constructor(private logger: LoggerService) {}

  findAll(): User[] {
    this.logger.log('모든 사용자 조회');
    return this.users;
  }

  findOne(id: number): User | undefined {
    this.logger.log(`사용자 ${id} 조회`);
    return this.users.find(user => user.id === id);
  }

  create(user: Omit<User, 'id'>): User {
    const newUser = {
      id: this.users.length + 1,
      ...user
    };
    this.users.push(newUser);
    this.logger.log(`새 사용자 생성: ${newUser.name}`);
    return newUser;
  }
}

// users/users.module.ts
import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService]  // 다른 모듈에서 사용 가능
})
export class UsersModule {}
```

### Posts Module (Users Module 의존)

```typescript
// posts/posts.service.ts
import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { LoggerService } from '../common/logger/logger.service';

interface Post {
  id: number;
  title: string;
  content: string;
  authorId: number;
}

@Injectable()
export class PostsService {
  private posts: Post[] = [
    {
      id: 1,
      title: '바데부의 첫 게시글',
      content: 'NestJS 모듈 시스템은 정말 멋져요!',
      authorId: 1
    }
  ];

  constructor(
    private usersService: UsersService,
    private logger: LoggerService
  ) {}

  findAll() {
    this.logger.log('모든 게시글 조회');
    return this.posts;
  }

  findWithAuthor(id: number) {
    this.logger.log(`게시글 ${id} 및 작성자 정보 조회`);
    const post = this.posts.find(p => p.id === id);
    if (!post) return null;

    const author = this.usersService.findOne(post.authorId);
    return {
      ...post,
      author
    };
  }

  create(createPostDto: Omit<Post, 'id'>): Post {
    const newPost = {
      id: this.posts.length + 1,
      ...createPostDto
    };
    this.posts.push(newPost);
    this.logger.log(`새 게시글 생성: ${newPost.title}`);
    return newPost;
  }
}

// posts/posts.module.ts
import { Module } from '@nestjs/common';
import { PostsController } from './posts.controller';
import { PostsService } from './posts.service';
import { UsersModule } from '../users/users.module';

@Module({
  imports: [UsersModule],  // UsersService를 사용하기 위해 import
  controllers: [PostsController],
  providers: [PostsService],
  exports: [PostsService]
})
export class PostsModule {}
```

### Comments Module (Users + Posts 의존)

```typescript
// comments/comments.service.ts
import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { PostsService } from '../posts/posts.service';
import { LoggerService } from '../common/logger/logger.service';

interface Comment {
  id: number;
  content: string;
  postId: number;
  authorId: number;
}

@Injectable()
export class CommentsService {
  private comments: Comment[] = [];

  constructor(
    private usersService: UsersService,
    private postsService: PostsService,
    private logger: LoggerService
  ) {}

  create(createCommentDto: Omit<Comment, 'id'>): Comment {
    const newComment = {
      id: this.comments.length + 1,
      ...createCommentDto
    };
    this.comments.push(newComment);
    this.logger.log(`새 댓글 생성: ID ${newComment.id}`);
    return newComment;
  }

  findByPost(postId: number) {
    this.logger.log(`게시글 ${postId}의 댓글 조회`);
    return this.comments
      .filter(comment => comment.postId === postId)
      .map(comment => ({
        ...comment,
        author: this.usersService.findOne(comment.authorId)
      }));
  }
}

// comments/comments.module.ts
import { Module } from '@nestjs/common';
import { CommentsController } from './comments.controller';
import { CommentsService } from './comments.service';
import { UsersModule } from '../users/users.module';
import { PostsModule } from '../posts/posts.module';

@Module({
  imports: [UsersModule, PostsModule],  // 두 모듈 모두 import
  controllers: [CommentsController],
  providers: [CommentsService]
})
export class CommentsModule {}
```

### App Module (모든 것을 통합)

```typescript
// app.module.ts
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CommonModule } from './common/common.module';
import { UsersModule } from './users/users.module';
import { PostsModule } from './posts/posts.module';
import { CommentsModule } from './comments/comments.module';

@Module({
  imports: [
    CommonModule,    // 전역 모듈
    UsersModule,     // 바데부: 사용자 기능
    PostsModule,     // 바데부: 게시글 기능
    CommentsModule   // 바데부: 댓글 기능
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
```

## 모듈 재export

```typescript
// core.module.ts
import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';

@Module({
  imports: [UsersModule, AuthModule],
  exports: [UsersModule, AuthModule]  // 재export
})
export class CoreModule {}

// 이제 CoreModule만 import하면 UsersModule과 AuthModule을 모두 사용 가능
@Module({
  imports: [CoreModule]
})
export class AppModule {}
```

## 비동기 모듈 초기화

```typescript
// database.module.ts
@Module({})
export class DatabaseModule {
  static async forRootAsync(): Promise<DynamicModule> {
    const connection = await createConnection();

    return {
      module: DatabaseModule,
      providers: [
        {
          provide: 'DATABASE_CONNECTION',
          useValue: connection
        }
      ],
      exports: ['DATABASE_CONNECTION']
    };
  }
}
```

## 모듈 모범 사례

### 1. 기능별 모듈 구성

```typescript
// ✅ 좋은 예: 기능별로 명확하게 분리
src/
├── users/
├── posts/
├── comments/
├── auth/
└── common/
```

### 2. Barrel Exports 사용

```typescript
// users/index.ts
export * from './users.module';
export * from './users.service';
export * from './users.controller';

// 다른 곳에서 간단하게 import
import { UsersModule, UsersService } from './users';
```

### 3. 순환 의존성 피하기

```typescript
// ❌ 나쁜 예: 순환 의존성
// users.module imports posts.module
// posts.module imports users.module

// ✅ 좋은 예: 공통 모듈로 분리
// users.module
// posts.module
// common.module (공통 기능)
```

## 연습 문제

1. `CategoriesModule`을 만들고 `PostsModule`에서 사용해보세요
2. 전역 `UtilsModule`을 만들어 날짜 포맷팅 서비스를 제공해보세요
3. 동적 모듈 `CacheModule.forRoot({ ttl: 60 })`을 구현해보세요

## 다음 챕터 예고

다음 챕터에서는 **TypeORM과 데이터베이스**를 배워 실제 데이터베이스와 연동하는 방법을 알아봅니다!

## 핵심 정리

- 모듈은 `@Module()` 데코레이터로 정의
- `imports`: 다른 모듈 가져오기
- `providers`: 서비스 등록
- `controllers`: 컨트롤러 등록
- `exports`: 다른 모듈에 제공
- `@Global()`: 전역 모듈 생성
- 동적 모듈로 런타임 설정 가능

바데부와 함께 모듈 시스템을 마스터했습니다!

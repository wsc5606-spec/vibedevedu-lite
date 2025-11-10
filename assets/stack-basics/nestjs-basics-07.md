# Chapter 7: 미들웨어와 가드

## 미들웨어란?

미들웨어는 라우트 핸들러가 실행되기 전에 호출되는 함수입니다. 요청과 응답 객체에 접근하여 다양한 작업을 수행할 수 있습니다.

```typescript
// 바데부: "미들웨어는 보안 검색대 같아요!"
// 요청이 컨트롤러에 도달하기 전에 검사하고 처리합니다.
```

### 미들웨어로 할 수 있는 것

1. 코드 실행
2. 요청/응답 객체 수정
3. 요청-응답 사이클 종료
4. 다음 미들웨어 호출

## 미들웨어 생성하기

### 함수형 미들웨어

```typescript
// middleware/logger.middleware.ts
import { Request, Response, NextFunction } from 'express';

export function logger(req: Request, res: Response, next: NextFunction) {
  console.log(`바데부 LOG: ${req.method} ${req.path}`);
  next();  // 다음 미들웨어 또는 라우트 핸들러로 전달
}
```

### 클래스 미들웨어

```typescript
// middleware/logger.middleware.ts
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const { method, originalUrl, ip } = req;
    const userAgent = req.get('user-agent') || '';

    console.log(`바데부 LOG: ${method} ${originalUrl} - ${ip} - ${userAgent}`);

    // 응답이 완료될 때 실행
    res.on('finish', () => {
      const { statusCode } = res;
      console.log(`바데부 LOG: ${method} ${originalUrl} ${statusCode}`);
    });

    next();
  }
}
```

## 미들웨어 적용하기

### 모듈에서 적용

```typescript
// app.module.ts
import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { LoggerMiddleware } from './middleware/logger.middleware';
import { UsersModule } from './users/users.module';

@Module({
  imports: [UsersModule],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    // 바데부: 모든 라우트에 적용
    consumer
      .apply(LoggerMiddleware)
      .forRoutes('*');
  }
}
```

### 특정 라우트에만 적용

```typescript
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .forRoutes('users');  // /users 경로에만 적용
  }
}
```

### 특정 HTTP 메서드

```typescript
import { RequestMethod } from '@nestjs/common';

export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .forRoutes(
        { path: 'users', method: RequestMethod.GET },
        { path: 'users/:id', method: RequestMethod.DELETE }
      );
  }
}
```

### 컨트롤러 단위 적용

```typescript
import { UsersController } from './users/users.controller';

export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .forRoutes(UsersController);  // UsersController의 모든 라우트
  }
}
```

### 특정 라우트 제외

```typescript
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LoggerMiddleware)
      .exclude(
        { path: 'users', method: RequestMethod.GET },
        'users/profile'
      )
      .forRoutes('users');
  }
}
```

### 여러 미들웨어 연결

```typescript
consumer
  .apply(LoggerMiddleware, CorsMiddleware, AuthMiddleware)
  .forRoutes('*');
```

## 가드(Guard)란?

가드는 인증, 권한 확인 등을 담당하는 특수한 클래스입니다. 미들웨어와 달리 실행 컨텍스트에 접근할 수 있습니다.

```typescript
// 바데부: "가드는 출입증 검사원 같아요!"
// 권한이 있는 사용자만 통과시킵니다.
```

### 가드 생성하기

```bash
nest g guard auth
```

## 인증 가드

### 기본 인증 가드

```typescript
// guards/auth.guard.ts
import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { Observable } from 'rxjs';

@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = request.headers.authorization;

    if (!token) {
      throw new UnauthorizedException('바데부: 토큰이 없습니다');
    }

    // 토큰 검증 로직
    if (token !== 'valid-token') {
      throw new UnauthorizedException('바데부: 유효하지 않은 토큰입니다');
    }

    // 사용자 정보를 request에 추가
    request.user = { id: 1, name: '바데부' };

    return true;
  }
}
```

## 가드 적용하기

### 컨트롤러 레벨

```typescript
import { Controller, Get, UseGuards } from '@nestjs/common';
import { AuthGuard } from './guards/auth.guard';

@Controller('users')
@UseGuards(AuthGuard)  // 바데부: 전체 컨트롤러에 적용
export class UsersController {
  @Get()
  findAll() {
    return '인증된 사용자만 접근 가능';
  }
}
```

### 메서드 레벨

```typescript
@Controller('users')
export class UsersController {
  @Get()
  findAll() {
    return '누구나 접근 가능';
  }

  @Get('profile')
  @UseGuards(AuthGuard)  // 바데부: 특정 메서드에만 적용
  getProfile() {
    return '인증된 사용자만 접근 가능';
  }
}
```

### 전역 가드

```typescript
// main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AuthGuard } from './guards/auth.guard';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalGuards(new AuthGuard());  // 바데부: 전역 적용
  await app.listen(3000);
}
bootstrap();

// 또는 app.module.ts에서
import { APP_GUARD } from '@nestjs/core';

@Module({
  providers: [
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AppModule {}
```

## 역할 기반 가드 (RBAC)

### 역할 데코레이터

```typescript
// decorators/roles.decorator.ts
import { SetMetadata } from '@nestjs/common';

export const ROLES_KEY = 'roles';
export const Roles = (...roles: string[]) => SetMetadata(ROLES_KEY, roles);
```

### 역할 가드

```typescript
// guards/roles.guard.ts
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { ROLES_KEY } from '../decorators/roles.decorator';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    // 메서드에 설정된 역할 가져오기
    const requiredRoles = this.reflector.getAllAndOverride<string[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!requiredRoles) {
      return true;  // 역할 설정이 없으면 통과
    }

    const { user } = context.switchToHttp().getRequest();

    if (!user) {
      return false;
    }

    // 바데부: 사용자가 필요한 역할을 가지고 있는지 확인
    return requiredRoles.some((role) => user.roles?.includes(role));
  }
}
```

### 사용하기

```typescript
@Controller('admin')
@UseGuards(AuthGuard, RolesGuard)
export class AdminController {
  @Get('users')
  @Roles('admin')  // 바데부: admin 역할만 접근 가능
  getAllUsers() {
    return '관리자만 접근 가능';
  }

  @Get('dashboard')
  @Roles('admin', 'moderator')  // 바데부: admin 또는 moderator
  getDashboard() {
    return '관리자 또는 운영자 접근 가능';
  }
}
```

## 실전 예제: 바데부의 인증 시스템

### JWT 인증 미들웨어

```typescript
// middleware/jwt.middleware.ts
import { Injectable, NestMiddleware, UnauthorizedException } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class JwtMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const token = req.headers.authorization?.replace('Bearer ', '');

    if (!token) {
      return next();  // 토큰이 없어도 계속 진행 (가드에서 처리)
    }

    try {
      const decoded = jwt.verify(token, 'badebu-secret-key');
      req['user'] = decoded;
      console.log('바데부: 토큰 검증 성공', decoded);
    } catch (error) {
      console.log('바데부: 토큰 검증 실패', error.message);
    }

    next();
  }
}
```

### 사용자 데코레이터

```typescript
// decorators/user.decorator.ts
import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    return request.user;
  },
);
```

### 인증 가드

```typescript
// guards/jwt-auth.guard.ts
import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';

@Injectable()
export class JwtAuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest();
    const user = request.user;

    if (!user) {
      throw new UnauthorizedException('바데부: 로그인이 필요합니다');
    }

    return true;
  }
}
```

### 프로필 컨트롤러

```typescript
// profile/profile.controller.ts
import { Controller, Get, Put, Body, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../guards/jwt-auth.guard';
import { CurrentUser } from '../decorators/user.decorator';

@Controller('profile')
@UseGuards(JwtAuthGuard)
export class ProfileController {
  @Get()
  getProfile(@CurrentUser() user: any) {
    return {
      message: '바데부: 프로필 조회',
      user
    };
  }

  @Put()
  updateProfile(@CurrentUser() user: any, @Body() updateData: any) {
    return {
      message: `바데부: ${user.name}님의 프로필 업데이트`,
      userId: user.id,
      updateData
    };
  }
}
```

## 퍼블릭 라우트 (가드 우회)

### Public 데코레이터

```typescript
// decorators/public.decorator.ts
import { SetMetadata } from '@nestjs/common';

export const IS_PUBLIC_KEY = 'isPublic';
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
```

### 개선된 가드

```typescript
// guards/jwt-auth.guard.ts
import { Injectable, CanActivate, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { IS_PUBLIC_KEY } from '../decorators/public.decorator';

@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    // 바데부: Public 데코레이터가 있으면 인증 우회
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    if (!user) {
      throw new UnauthorizedException('바데부: 로그인이 필요합니다');
    }

    return true;
  }
}
```

### 사용하기

```typescript
@Controller('posts')
@UseGuards(JwtAuthGuard)
export class PostsController {
  @Get()
  @Public()  // 바데부: 로그인 없이 접근 가능
  findAll() {
    return '누구나 게시글을 볼 수 있습니다';
  }

  @Post()
  create(@CurrentUser() user: any, @Body() createPostDto: any) {
    return `바데부: ${user.name}님이 게시글을 작성했습니다`;
  }
}
```

## 소유권 검증 가드

```typescript
// guards/ownership.guard.ts
import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { PostsService } from '../posts/posts.service';

@Injectable()
export class OwnershipGuard implements CanActivate {
  constructor(private postsService: PostsService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const user = request.user;
    const postId = parseInt(request.params.id);

    const post = await this.postsService.findOne(postId);

    if (!post) {
      throw new ForbiddenException('바데부: 게시글을 찾을 수 없습니다');
    }

    // 바데부: 작성자와 현재 사용자가 같은지 확인
    if (post.authorId !== user.id && !user.roles?.includes('admin')) {
      throw new ForbiddenException('바데부: 권한이 없습니다');
    }

    return true;
  }
}

// 사용
@Controller('posts')
export class PostsController {
  @Put(':id')
  @UseGuards(JwtAuthGuard, OwnershipGuard)
  update(@Param('id') id: string, @Body() updatePostDto: any) {
    return '본인의 게시글만 수정 가능';
  }
}
```

## 실행 순서

```
요청 → 미들웨어 → 가드 → 인터셉터(before) → 파이프 → 컨트롤러 → 서비스
                                                              ↓
응답 ← 인터셉터(after) ← 필터(에러 발생 시) ←────────────────────┘
```

## 미들웨어 vs 가드

### 미들웨어 사용 시기
- 로깅
- CORS
- 요청 바디 파싱
- 세션 처리

### 가드 사용 시기
- 인증 확인
- 권한 확인
- 특정 조건 검사

## 연습 문제

1. 요청 시간을 측정하는 미들웨어를 만들어보세요
2. IP 주소 기반 접근 제한 가드를 구현해보세요
3. 관리자 전용 가드를 만들고 관리자 패널을 구현해보세요

## 다음 챕터 예고

다음 챕터에서는 **인터셉터와 파이프**를 배워 요청/응답을 변환하고 처리하는 방법을 알아봅니다!

## 핵심 정리

- 미들웨어: 요청 처리 전 실행되는 함수
- 가드: 인증/권한 확인 담당
- `@UseGuards()`: 가드 적용
- `@SetMetadata()`: 메타데이터 설정
- Reflector: 메타데이터 읽기
- ExecutionContext: 실행 컨텍스트 접근

바데부와 함께 인증과 권한 관리를 마스터했습니다!

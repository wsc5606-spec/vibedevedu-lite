# Chapter 9: 예외 처리와 필터

## 예외란?

예외(Exception)는 애플리케이션 실행 중 발생하는 오류입니다. NestJS는 체계적인 예외 처리 시스템을 제공합니다.

```typescript
// 바데부: "예외 처리는 안전망 같아요!"
// 오류가 발생해도 사용자에게 친절한 메시지를 보여줄 수 있습니다.
```

## HTTP 예외

### 내장 HTTP 예외

NestJS는 다양한 HTTP 예외를 제공합니다:

```typescript
import {
  BadRequestException,       // 400
  UnauthorizedException,      // 401
  ForbiddenException,         // 403
  NotFoundException,          // 404
  RequestTimeoutException,    // 408
  ConflictException,          // 409
  InternalServerErrorException, // 500
  NotImplementedException,    // 501
  BadGatewayException,        // 502
  ServiceUnavailableException // 503
} from '@nestjs/common';
```

### 기본 사용법

```typescript
@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    const user = this.usersService.findOne(id);

    if (!user) {
      // 바데부: 사용자를 찾을 수 없을 때
      throw new NotFoundException(`바데부: ${id}번 사용자를 찾을 수 없습니다`);
    }

    return user;
  }

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    const existingUser = this.usersService.findByEmail(createUserDto.email);

    if (existingUser) {
      // 바데부: 이미 존재하는 이메일
      throw new ConflictException('바데부: 이미 사용중인 이메일입니다');
    }

    return this.usersService.create(createUserDto);
  }
}
```

### 커스텀 응답

```typescript
@Get(':id')
findOne(@Param('id', ParseIntPipe) id: number) {
  const user = this.usersService.findOne(id);

  if (!user) {
    throw new NotFoundException({
      statusCode: 404,
      message: '바데부: 사용자를 찾을 수 없습니다',
      error: 'User Not Found',
      timestamp: new Date().toISOString(),
      userId: id
    });
  }

  return user;
}
```

## 커스텀 예외

### 비즈니스 예외 만들기

```typescript
// exceptions/business.exception.ts
import { HttpException, HttpStatus } from '@nestjs/common';

export class InsufficientBalanceException extends HttpException {
  constructor(balance: number, required: number) {
    super(
      {
        statusCode: HttpStatus.BAD_REQUEST,
        message: '바데부: 잔액이 부족합니다',
        error: 'Insufficient Balance',
        details: {
          currentBalance: balance,
          requiredAmount: required,
          shortage: required - balance
        }
      },
      HttpStatus.BAD_REQUEST
    );
  }
}

// 사용
@Post('purchase')
purchase(@Body() purchaseDto: PurchaseDto, @CurrentUser() user: any) {
  const balance = this.usersService.getBalance(user.id);

  if (balance < purchaseDto.amount) {
    throw new InsufficientBalanceException(balance, purchaseDto.amount);
  }

  return this.purchaseService.create(purchaseDto);
}
```

### 도메인 예외

```typescript
// exceptions/post.exception.ts
export class PostNotFoundException extends NotFoundException {
  constructor(postId: number) {
    super(`바데부: ${postId}번 게시글을 찾을 수 없습니다`);
  }
}

export class PostAlreadyPublishedException extends BadRequestException {
  constructor(postId: number) {
    super(`바데부: ${postId}번 게시글은 이미 발행되었습니다`);
  }
}

// 사용
@Put(':id/publish')
publish(@Param('id', ParseIntPipe) id: number) {
  const post = this.postsService.findOne(id);

  if (!post) {
    throw new PostNotFoundException(id);
  }

  if (post.published) {
    throw new PostAlreadyPublishedException(id);
  }

  return this.postsService.publish(id);
}
```

## 예외 필터

예외 필터는 예외를 가로채서 커스텀 응답을 생성합니다.

### 기본 예외 필터

```typescript
// filters/http-exception.filter.ts
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger
} from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger('HttpException');

  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    const exceptionResponse = exception.getResponse();

    const error = typeof exceptionResponse === 'string'
      ? { message: exceptionResponse }
      : (exceptionResponse as object);

    // 바데부: 에러 로깅
    this.logger.error(
      `바데부 에러: ${request.method} ${request.url}`,
      JSON.stringify(error)
    );

    // 표준화된 에러 응답
    response.status(status).json({
      success: false,
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      method: request.method,
      ...error
    });
  }
}
```

### 모든 예외 처리

```typescript
// filters/all-exceptions.filter.ts
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
  Logger
} from '@nestjs/common';

@Catch()  // 바데부: 모든 예외를 처리합니다
export class AllExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger('Exception');

  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();

    const status = exception instanceof HttpException
      ? exception.getStatus()
      : HttpStatus.INTERNAL_SERVER_ERROR;

    const message = exception instanceof HttpException
      ? exception.getResponse()
      : '바데부: 서버 내부 오류가 발생했습니다';

    // 에러 로깅
    this.logger.error(
      `바데부 시스템 에러: ${request.method} ${request.url}`,
      exception instanceof Error ? exception.stack : exception
    );

    response.status(status).json({
      success: false,
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      error: message
    });
  }
}
```

## 필터 적용하기

### 메서드 레벨

```typescript
@Post()
@UseFilters(HttpExceptionFilter)
create(@Body() createUserDto: CreateUserDto) {
  return this.usersService.create(createUserDto);
}
```

### 컨트롤러 레벨

```typescript
@Controller('users')
@UseFilters(HttpExceptionFilter)
export class UsersController {
  // 모든 메서드에 적용
}
```

### 전역 필터

```typescript
// main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AllExceptionsFilter } from './filters/all-exceptions.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalFilters(new AllExceptionsFilter());
  await app.listen(3000);
}
bootstrap();

// 또는 app.module.ts에서
import { APP_FILTER } from '@nestjs/core';

@Module({
  providers: [
    {
      provide: APP_FILTER,
      useClass: AllExceptionsFilter,
    },
  ],
})
export class AppModule {}
```

## 실전 예제: 바데부의 에러 처리 시스템

### 커스텀 에러 코드

```typescript
// constants/error-codes.ts
export const ErrorCodes = {
  USER_NOT_FOUND: 'USER_001',
  USER_ALREADY_EXISTS: 'USER_002',
  INVALID_CREDENTIALS: 'AUTH_001',
  TOKEN_EXPIRED: 'AUTH_002',
  POST_NOT_FOUND: 'POST_001',
  UNAUTHORIZED_POST_ACCESS: 'POST_002',
  INSUFFICIENT_BALANCE: 'PAYMENT_001',
} as const;
```

### 비즈니스 예외 기본 클래스

```typescript
// exceptions/business-exception.base.ts
import { HttpException, HttpStatus } from '@nestjs/common';

export interface BusinessExceptionResponse {
  code: string;
  message: string;
  details?: any;
  timestamp: string;
}

export class BusinessException extends HttpException {
  constructor(
    code: string,
    message: string,
    status: HttpStatus = HttpStatus.BAD_REQUEST,
    details?: any
  ) {
    const response: BusinessExceptionResponse = {
      code,
      message: `바데부: ${message}`,
      timestamp: new Date().toISOString(),
      ...(details && { details })
    };

    super(response, status);
  }
}
```

### 구체적인 예외들

```typescript
// exceptions/user.exceptions.ts
import { ErrorCodes } from '../constants/error-codes';
import { BusinessException } from './business-exception.base';
import { HttpStatus } from '@nestjs/common';

export class UserNotFoundException extends BusinessException {
  constructor(userId: number) {
    super(
      ErrorCodes.USER_NOT_FOUND,
      `${userId}번 사용자를 찾을 수 없습니다`,
      HttpStatus.NOT_FOUND,
      { userId }
    );
  }
}

export class UserAlreadyExistsException extends BusinessException {
  constructor(email: string) {
    super(
      ErrorCodes.USER_ALREADY_EXISTS,
      '이미 존재하는 사용자입니다',
      HttpStatus.CONFLICT,
      { email }
    );
  }
}

// exceptions/auth.exceptions.ts
export class InvalidCredentialsException extends BusinessException {
  constructor() {
    super(
      ErrorCodes.INVALID_CREDENTIALS,
      '이메일 또는 비밀번호가 올바르지 않습니다',
      HttpStatus.UNAUTHORIZED
    );
  }
}

export class TokenExpiredException extends BusinessException {
  constructor() {
    super(
      ErrorCodes.TOKEN_EXPIRED,
      '토큰이 만료되었습니다. 다시 로그인해주세요',
      HttpStatus.UNAUTHORIZED
    );
  }
}
```

### 비즈니스 예외 필터

```typescript
// filters/business-exception.filter.ts
import { ExceptionFilter, Catch, ArgumentsHost, Logger } from '@nestjs/common';
import { BusinessException, BusinessExceptionResponse } from '../exceptions/business-exception.base';
import { Request, Response } from 'express';

@Catch(BusinessException)
export class BusinessExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger('BusinessException');

  catch(exception: BusinessException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    const exceptionResponse = exception.getResponse() as BusinessExceptionResponse;

    // 바데부: 비즈니스 예외 로깅
    this.logger.warn(
      `바데부 비즈니스 예외: [${exceptionResponse.code}] ${exceptionResponse.message}`,
      JSON.stringify({
        method: request.method,
        url: request.url,
        details: exceptionResponse.details
      })
    );

    response.status(status).json({
      success: false,
      error: {
        code: exceptionResponse.code,
        message: exceptionResponse.message,
        details: exceptionResponse.details,
        timestamp: exceptionResponse.timestamp,
        path: request.url,
        method: request.method
      }
    });
  }
}
```

### TypeORM 에러 필터

```typescript
// filters/typeorm-exception.filter.ts
import { ExceptionFilter, Catch, ArgumentsHost, HttpStatus, Logger } from '@nestjs/common';
import { QueryFailedError } from 'typeorm';

@Catch(QueryFailedError)
export class TypeOrmExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger('DatabaseException');

  catch(exception: QueryFailedError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();

    let message = '바데부: 데이터베이스 오류가 발생했습니다';
    let status = HttpStatus.INTERNAL_SERVER_ERROR;

    // PostgreSQL 에러 코드 처리
    const error = exception as any;

    switch (error.code) {
      case '23505': // unique_violation
        message = '바데부: 중복된 데이터입니다';
        status = HttpStatus.CONFLICT;
        break;
      case '23503': // foreign_key_violation
        message = '바데부: 참조 무결성 위반입니다';
        status = HttpStatus.BAD_REQUEST;
        break;
      case '23502': // not_null_violation
        message = '바데부: 필수 값이 누락되었습니다';
        status = HttpStatus.BAD_REQUEST;
        break;
    }

    this.logger.error(
      `바데부 DB 에러: ${request.method} ${request.url}`,
      error.message
    );

    response.status(status).json({
      success: false,
      statusCode: status,
      message,
      timestamp: new Date().toISOString(),
      path: request.url
    });
  }
}
```

### 유효성 검증 에러 필터

```typescript
// filters/validation-exception.filter.ts
import { ExceptionFilter, Catch, ArgumentsHost, BadRequestException } from '@nestjs/common';

@Catch(BadRequestException)
export class ValidationExceptionFilter implements ExceptionFilter {
  catch(exception: BadRequestException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();
    const status = exception.getStatus();
    const exceptionResponse: any = exception.getResponse();

    // class-validator 에러 처리
    if (exceptionResponse.message && Array.isArray(exceptionResponse.message)) {
      const validationErrors = exceptionResponse.message.map((msg: string) => {
        // "바데부: " 접두사 제거하고 깔끔하게 정리
        return msg.replace('바데부: ', '');
      });

      return response.status(status).json({
        success: false,
        statusCode: status,
        error: 'Validation Failed',
        message: '바데부: 입력값 검증에 실패했습니다',
        validationErrors,
        timestamp: new Date().toISOString(),
        path: request.url
      });
    }

    // 일반 BadRequestException
    response.status(status).json({
      success: false,
      statusCode: status,
      message: exceptionResponse.message || '바데부: 잘못된 요청입니다',
      timestamp: new Date().toISOString(),
      path: request.url
    });
  }
}
```

## 통합 예제: 사용자 서비스

```typescript
// users/users.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import { UserNotFoundException, UserAlreadyExistsException } from '../exceptions/user.exceptions';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>
  ) {}

  async findOne(id: number): Promise<User> {
    const user = await this.usersRepository.findOne({ where: { id } });

    if (!user) {
      throw new UserNotFoundException(id);
    }

    return user;
  }

  async create(createUserDto: CreateUserDto): Promise<User> {
    const existingUser = await this.usersRepository.findOne({
      where: { email: createUserDto.email }
    });

    if (existingUser) {
      throw new UserAlreadyExistsException(createUserDto.email);
    }

    const user = this.usersRepository.create(createUserDto);
    return this.usersRepository.save(user);
  }

  async delete(id: number): Promise<void> {
    const user = await this.findOne(id);  // UserNotFoundException 발생 가능
    await this.usersRepository.remove(user);
  }
}
```

## 에러 로깅 서비스

```typescript
// services/error-logger.service.ts
import { Injectable, Logger } from '@nestjs/common';

interface ErrorLog {
  message: string;
  stack?: string;
  context?: any;
  timestamp: Date;
}

@Injectable()
export class ErrorLoggerService {
  private readonly logger = new Logger('ErrorLogger');
  private errorLogs: ErrorLog[] = [];

  logError(error: Error, context?: any) {
    const errorLog: ErrorLog = {
      message: error.message,
      stack: error.stack,
      context,
      timestamp: new Date()
    };

    this.errorLogs.push(errorLog);
    this.logger.error(`바데부 에러: ${error.message}`, error.stack);

    // 실제 환경에서는 외부 로깅 서비스로 전송
    // (예: Sentry, LogRocket, CloudWatch 등)
  }

  getRecentErrors(limit: number = 10): ErrorLog[] {
    return this.errorLogs.slice(-limit);
  }
}
```

## 실행 순서

```
요청
 ↓
미들웨어
 ↓
가드
 ↓
인터셉터 (before)
 ↓
파이프
 ↓
컨트롤러/서비스 (예외 발생 가능)
 ↓
예외 필터 ← 예외 처리
 ↓
인터셉터 (after)
 ↓
응답
```

## 모범 사례

### 1. 계층화된 예외 처리

```typescript
// 하위 레벨: 도메인 예외
throw new UserNotFoundException(id);

// 상위 레벨: 예외 필터에서 처리
@Catch(BusinessException)
export class BusinessExceptionFilter { }
```

### 2. 의미있는 에러 메시지

```typescript
// ❌ 나쁜 예
throw new NotFoundException('Not found');

// ✅ 좋은 예
throw new UserNotFoundException(id);
```

### 3. 민감한 정보 숨기기

```typescript
// 프로덕션 환경에서는 상세 에러 숨기기
if (process.env.NODE_ENV === 'production') {
  return { message: '바데부: 서버 오류가 발생했습니다' };
} else {
  return { message: error.message, stack: error.stack };
}
```

## 연습 문제

1. `CommentNotFoundException` 예외를 만들어보세요
2. 파일 업로드 실패를 처리하는 커스텀 예외를 만들어보세요
3. API 호출 횟수 제한 초과 예외와 필터를 구현해보세요

## 다음 챕터 예고

다음 챕터에서는 **테스트와 배포**를 배워 안정적인 애플리케이션을 만드는 방법을 알아봅니다!

## 핵심 정리

- HTTP 예외: 다양한 상태 코드 예외 제공
- 커스텀 예외: HttpException 상속
- 예외 필터: `@Catch()` 데코레이터로 정의
- `ExceptionFilter` 인터페이스 구현
- 전역/컨트롤러/메서드 레벨 적용 가능
- 비즈니스 예외와 시스템 예외 분리

바데부와 함께 예외 처리를 마스터했습니다!

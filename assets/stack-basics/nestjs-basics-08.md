# Chapter 8: 인터셉터와 파이프

## 인터셉터란?

인터셉터(Interceptor)는 요청/응답을 가로채서 변환하거나 추가 로직을 실행할 수 있는 강력한 도구입니다.

```typescript
// 바데부: "인터셉터는 요청과 응답 사이의 통역사예요!"
// 데이터를 변환하고, 로깅하고, 캐싱도 할 수 있습니다.
```

### 인터셉터로 할 수 있는 것

1. 메서드 실행 전/후 추가 로직 실행
2. 함수에서 반환된 결과 변환
3. 예외 변환
4. 기본 함수 동작 확장
5. 특정 조건에 따라 함수 완전히 재정의

## 인터셉터 생성하기

### 기본 인터셉터

```bash
nest g interceptor logging
```

```typescript
// interceptors/logging.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const { method, url } = request;
    const now = Date.now();

    console.log(`바데부 LOG: ${method} ${url} 시작`);

    return next
      .handle()
      .pipe(
        tap(() => {
          const duration = Date.now() - now;
          console.log(`바데부 LOG: ${method} ${url} 완료 (${duration}ms)`);
        })
      );
  }
}
```

## 응답 변환 인터셉터

### 응답 포맷 통일

```typescript
// interceptors/transform.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

export interface Response<T> {
  success: boolean;
  data: T;
  message: string;
  timestamp: string;
}

@Injectable()
export class TransformInterceptor<T> implements NestInterceptor<T, Response<T>> {
  intercept(context: ExecutionContext, next: CallHandler): Observable<Response<T>> {
    return next.handle().pipe(
      map(data => ({
        success: true,
        data,
        message: '바데부: 요청 성공',
        timestamp: new Date().toISOString()
      }))
    );
  }
}
```

사용 전:
```json
{
  "id": 1,
  "name": "바데부"
}
```

사용 후:
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "바데부"
  },
  "message": "바데부: 요청 성공",
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

## 인터셉터 적용하기

### 메서드 레벨

```typescript
import { UseInterceptors } from '@nestjs/common';

@Controller('users')
export class UsersController {
  @Get()
  @UseInterceptors(LoggingInterceptor)
  findAll() {
    return '사용자 목록';
  }
}
```

### 컨트롤러 레벨

```typescript
@Controller('users')
@UseInterceptors(LoggingInterceptor, TransformInterceptor)
export class UsersController {
  // 모든 메서드에 적용
}
```

### 전역 인터셉터

```typescript
// main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { TransformInterceptor } from './interceptors/transform.interceptor';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalInterceptors(new TransformInterceptor());
  await app.listen(3000);
}
bootstrap();

// 또는 app.module.ts에서
import { APP_INTERCEPTOR } from '@nestjs/core';

@Module({
  providers: [
    {
      provide: APP_INTERCEPTOR,
      useClass: TransformInterceptor,
    },
  ],
})
export class AppModule {}
```

## 타임아웃 인터셉터

```typescript
// interceptors/timeout.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler, RequestTimeoutException } from '@nestjs/common';
import { Observable, throwError, TimeoutError } from 'rxjs';
import { catchError, timeout } from 'rxjs/operators';

@Injectable()
export class TimeoutInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      timeout(5000),  // 5초 타임아웃
      catchError(err => {
        if (err instanceof TimeoutError) {
          return throwError(() => new RequestTimeoutException('바데부: 요청 시간 초과'));
        }
        return throwError(() => err);
      }),
    );
  }
}
```

## 캐시 인터셉터

```typescript
// interceptors/cache.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable, of } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class CacheInterceptor implements NestInterceptor {
  private cache = new Map<string, any>();

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const request = context.switchToHttp().getRequest();
    const key = `${request.method}-${request.url}`;

    // 캐시에 있으면 반환
    if (this.cache.has(key)) {
      console.log('바데부: 캐시에서 반환');
      return of(this.cache.get(key));
    }

    // 캐시에 없으면 실행하고 저장
    return next.handle().pipe(
      tap(response => {
        console.log('바데부: 캐시에 저장');
        this.cache.set(key, response);

        // 1분 후 캐시 삭제
        setTimeout(() => {
          this.cache.delete(key);
          console.log('바데부: 캐시 만료');
        }, 60000);
      })
    );
  }
}
```

## 파이프란?

파이프(Pipe)는 입력 데이터를 변환하거나 검증하는 역할을 합니다.

```typescript
// 바데부: "파이프는 데이터 정수기예요!"
// 들어오는 데이터를 깨끗하게 정제합니다.
```

### 내장 파이프

NestJS는 다양한 내장 파이프를 제공합니다:

- `ValidationPipe`: 유효성 검증
- `ParseIntPipe`: 문자열을 정수로 변환
- `ParseFloatPipe`: 문자열을 실수로 변환
- `ParseBoolPipe`: 문자열을 불린으로 변환
- `ParseArrayPipe`: 문자열을 배열로 변환
- `ParseUUIDPipe`: UUID 검증
- `ParseEnumPipe`: Enum 값 검증
- `DefaultValuePipe`: 기본값 설정

## 내장 파이프 사용하기

### ParseIntPipe

```typescript
import { ParseIntPipe } from '@nestjs/common';

@Controller('users')
export class UsersController {
  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    // 바데부: id가 자동으로 숫자로 변환됩니다!
    console.log(typeof id);  // number
    return `사용자 ${id}`;
  }
}
```

### ParseBoolPipe

```typescript
@Get()
findAll(@Query('active', ParseBoolPipe) active: boolean) {
  // GET /users?active=true
  console.log(typeof active);  // boolean
  return `활성 상태: ${active}`;
}
```

### ParseUUIDPipe

```typescript
@Get(':uuid')
findOne(@Param('uuid', ParseUUIDPipe) uuid: string) {
  // 바데부: UUID 형식이 아니면 에러!
  return `UUID: ${uuid}`;
}
```

### ParseEnumPipe

```typescript
enum Status {
  PENDING = 'pending',
  APPROVED = 'approved',
  REJECTED = 'rejected'
}

@Get()
findByStatus(@Query('status', new ParseEnumPipe(Status)) status: Status) {
  // GET /posts?status=approved
  return `상태: ${status}`;
}
```

### DefaultValuePipe

```typescript
import { DefaultValuePipe } from '@nestjs/common';

@Get()
findAll(
  @Query('page', new DefaultValuePipe(1), ParseIntPipe) page: number,
  @Query('limit', new DefaultValuePipe(10), ParseIntPipe) limit: number
) {
  // 바데부: 값이 없으면 기본값 사용!
  return { page, limit };
}
```

## 커스텀 파이프 만들기

### 값 변환 파이프

```typescript
// pipes/trim.pipe.ts
import { PipeTransform, Injectable, ArgumentMetadata } from '@nestjs/common';

@Injectable()
export class TrimPipe implements PipeTransform {
  transform(value: any, metadata: ArgumentMetadata) {
    if (typeof value === 'string') {
      return value.trim();  // 바데부: 앞뒤 공백 제거
    }
    if (typeof value === 'object') {
      // 객체의 모든 문자열 값 trim
      Object.keys(value).forEach(key => {
        if (typeof value[key] === 'string') {
          value[key] = value[key].trim();
        }
      });
    }
    return value;
  }
}

// 사용
@Post()
create(@Body(TrimPipe) createUserDto: CreateUserDto) {
  // 바데부: 공백이 자동으로 제거됩니다!
  return this.usersService.create(createUserDto);
}
```

### 검증 파이프

```typescript
// pipes/positive-int.pipe.ts
import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';

@Injectable()
export class PositiveIntPipe implements PipeTransform<string, number> {
  transform(value: string): number {
    const val = parseInt(value, 10);

    if (isNaN(val)) {
      throw new BadRequestException('바데부: 숫자여야 합니다');
    }

    if (val <= 0) {
      throw new BadRequestException('바데부: 양수여야 합니다');
    }

    return val;
  }
}

// 사용
@Get(':id')
findOne(@Param('id', PositiveIntPipe) id: number) {
  return `사용자 ${id}`;
}
```

## 실전 예제: 바데부의 API 응답 표준화

### 성공 응답 인터셉터

```typescript
// interceptors/success-response.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler } from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

interface SuccessResponse<T> {
  statusCode: number;
  success: true;
  data: T;
  message: string;
  timestamp: string;
  path: string;
}

@Injectable()
export class SuccessResponseInterceptor<T> implements NestInterceptor<T, SuccessResponse<T>> {
  intercept(context: ExecutionContext, next: CallHandler): Observable<SuccessResponse<T>> {
    const ctx = context.switchToHttp();
    const response = ctx.getResponse();
    const request = ctx.getRequest();

    return next.handle().pipe(
      map(data => ({
        statusCode: response.statusCode,
        success: true,
        data,
        message: data?.message || '바데부: 요청이 성공적으로 처리되었습니다',
        timestamp: new Date().toISOString(),
        path: request.url
      }))
    );
  }
}
```

### 페이지네이션 파이프

```typescript
// pipes/pagination.pipe.ts
import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';

export interface PaginationParams {
  page: number;
  limit: number;
  skip: number;
}

@Injectable()
export class PaginationPipe implements PipeTransform<any, PaginationParams> {
  transform(query: any): PaginationParams {
    const page = parseInt(query.page) || 1;
    const limit = parseInt(query.limit) || 10;

    if (page < 1) {
      throw new BadRequestException('바데부: 페이지는 1 이상이어야 합니다');
    }

    if (limit < 1 || limit > 100) {
      throw new BadRequestException('바데부: limit은 1~100 사이여야 합니다');
    }

    return {
      page,
      limit,
      skip: (page - 1) * limit
    };
  }
}

// 사용
@Get()
findAll(@Query(PaginationPipe) pagination: PaginationParams) {
  return this.postsService.findAll(pagination);
}
```

### 파일 크기 검증 파이프

```typescript
// pipes/file-size-validation.pipe.ts
import { PipeTransform, Injectable, BadRequestException } from '@nestjs/common';

@Injectable()
export class FileSizeValidationPipe implements PipeTransform {
  constructor(private readonly maxSize: number) {}

  transform(value: any) {
    if (!value) {
      throw new BadRequestException('바데부: 파일이 없습니다');
    }

    const fileSize = value.size;  // 바이트 단위
    const maxSizeInBytes = this.maxSize * 1024 * 1024;  // MB를 바이트로 변환

    if (fileSize > maxSizeInBytes) {
      throw new BadRequestException(
        `바데부: 파일 크기는 ${this.maxSize}MB를 초과할 수 없습니다`
      );
    }

    return value;
  }
}

// 사용
@Post('upload')
uploadFile(
  @UploadedFile(new FileSizeValidationPipe(5)) file: Express.Multer.File
) {
  return `바데부: ${file.originalname} 업로드 완료`;
}
```

## 성능 모니터링 인터셉터

```typescript
// interceptors/performance.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler, Logger } from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class PerformanceInterceptor implements NestInterceptor {
  private readonly logger = new Logger('Performance');

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const ctx = context.switchToHttp();
    const request = ctx.getRequest();
    const { method, url } = request;
    const className = context.getClass().name;
    const handlerName = context.getHandler().name;

    const now = Date.now();

    return next.handle().pipe(
      tap(() => {
        const duration = Date.now() - now;

        // 바데부: 느린 요청 경고
        if (duration > 1000) {
          this.logger.warn(
            `바데부 경고: 느린 응답 - ${method} ${url} (${className}.${handlerName}) - ${duration}ms`
          );
        } else {
          this.logger.log(
            `바데부: ${method} ${url} (${className}.${handlerName}) - ${duration}ms`
          );
        }
      })
    );
  }
}
```

## 에러 로깅 인터셉터

```typescript
// interceptors/error-logging.interceptor.ts
import { Injectable, NestInterceptor, ExecutionContext, CallHandler, Logger } from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable()
export class ErrorLoggingInterceptor implements NestInterceptor {
  private readonly logger = new Logger('ErrorLog');

  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      catchError(error => {
        const ctx = context.switchToHttp();
        const request = ctx.getRequest();
        const { method, url, body, query, params } = request;

        this.logger.error(
          `바데부 에러: ${method} ${url}`,
          JSON.stringify({
            error: error.message,
            stack: error.stack,
            body,
            query,
            params,
            timestamp: new Date().toISOString()
          }, null, 2)
        );

        return throwError(() => error);
      })
    );
  }
}
```

## 여러 파이프 조합

```typescript
@Get(':id')
findOne(
  @Param('id', ParseIntPipe, PositiveIntPipe) id: number
) {
  // 바데부: ParseIntPipe → PositiveIntPipe 순서로 실행
  return this.usersService.findOne(id);
}
```

## 파이프 예외 처리 커스터마이징

```typescript
@Get(':id')
findOne(
  @Param('id', new ParseIntPipe({
    errorHttpStatusCode: HttpStatus.NOT_ACCEPTABLE,
    exceptionFactory: (error) => {
      return new NotAcceptableException('바데부: ID는 숫자여야 합니다');
    }
  }))
  id: number
) {
  return this.usersService.findOne(id);
}
```

## 연습 문제

1. 응답 시간을 헤더에 추가하는 인터셉터를 만들어보세요
2. 이메일 형식을 검증하는 커스텀 파이프를 만들어보세요
3. 요청 횟수를 제한하는 rate-limiting 인터셉터를 구현해보세요

## 다음 챕터 예고

다음 챕터에서는 **예외 처리와 필터**를 배워 에러를 우아하게 처리하는 방법을 알아봅니다!

## 핵심 정리

- 인터셉터: 요청/응답 변환 및 추가 로직
- `intercept()`: 메서드 실행 전/후 처리
- RxJS 연산자: `map`, `tap`, `catchError`
- 파이프: 데이터 변환 및 검증
- 내장 파이프: ParseInt, ParseBool, ParseUUID 등
- 커스텀 파이프: `PipeTransform` 인터페이스 구현

바데부와 함께 데이터 처리를 마스터했습니다!

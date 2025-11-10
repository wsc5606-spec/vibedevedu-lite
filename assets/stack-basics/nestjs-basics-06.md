# Chapter 6: DTO와 유효성 검증

## DTO란?

DTO(Data Transfer Object)는 계층 간 데이터 전송을 위한 객체입니다. 클라이언트와 서버 간 데이터 교환 시 사용됩니다.

```typescript
// 바데부: "DTO는 데이터의 설계도예요!"
// 어떤 데이터가 들어와야 하는지 명확하게 정의합니다.
```

### DTO를 사용하는 이유

1. **타입 안정성**: TypeScript 타입 체크
2. **데이터 검증**: 잘못된 데이터 방지
3. **문서화**: API 문서 자동 생성
4. **변환**: 입력 데이터 변환 및 정제

## 기본 DTO 만들기

### 간단한 DTO

```typescript
// dto/create-user.dto.ts
export class CreateUserDto {
  name: string;
  email: string;
  age: number;
}

// 컨트롤러에서 사용
@Post()
create(@Body() createUserDto: CreateUserDto) {
  return this.usersService.create(createUserDto);
}
```

### 인터페이스 vs 클래스

```typescript
// ❌ 인터페이스: 런타임에 제거되어 검증 불가
export interface CreateUserDto {
  name: string;
  email: string;
}

// ✅ 클래스: 런타임에 존재하여 검증 가능
export class CreateUserDto {
  name: string;
  email: string;
}
```

## 유효성 검증 설정

### 필수 패키지 설치

```bash
npm install class-validator class-transformer
```

### 전역 ValidationPipe 설정

```typescript
// main.ts
import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // 바데부: 전역 유효성 검증 활성화!
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,        // DTO에 없는 속성 제거
    forbidNonWhitelisted: true,  // DTO에 없는 속성 있으면 에러
    transform: true,        // 자동 타입 변환
  }));

  await app.listen(3000);
}
bootstrap();
```

## class-validator 데코레이터

### 기본 검증

```typescript
import { IsString, IsEmail, IsInt, IsNotEmpty, MinLength, MaxLength, Min, Max } from 'class-validator';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty({ message: '바데부: 이름은 필수입니다!' })
  @MinLength(2, { message: '바데부: 이름은 최소 2글자입니다' })
  @MaxLength(50, { message: '바데부: 이름은 최대 50글자입니다' })
  name: string;

  @IsEmail({}, { message: '바데부: 올바른 이메일 형식이 아닙니다' })
  @IsNotEmpty()
  email: string;

  @IsInt({ message: '바데부: 나이는 정수여야 합니다' })
  @Min(1, { message: '바데부: 나이는 1 이상이어야 합니다' })
  @Max(150, { message: '바데부: 나이는 150 이하여야 합니다' })
  age: number;
}
```

### 문자열 검증

```typescript
import { IsString, Length, Matches, IsAlphanumeric, IsUrl, IsUUID } from 'class-validator';

export class UserProfileDto {
  @IsString()
  @Length(3, 20)  // 3~20자
  username: string;

  @IsString()
  @Matches(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/, {
    message: '바데부: 비밀번호는 8자 이상, 문자와 숫자를 포함해야 합니다'
  })
  password: string;

  @IsAlphanumeric()
  nickname: string;

  @IsUrl()
  website: string;

  @IsUUID()
  userId: string;
}
```

### 숫자 검증

```typescript
import { IsNumber, IsPositive, IsNegative, IsInt, Min, Max } from 'class-validator';

export class ProductDto {
  @IsString()
  name: string;

  @IsNumber()
  @IsPositive({ message: '바데부: 가격은 양수여야 합니다' })
  price: number;

  @IsInt()
  @Min(0)
  @Max(999999)
  stock: number;

  @IsNumber()
  @Min(0)
  @Max(100)
  discount: number;  // 할인율 (%)
}
```

### 날짜 검증

```typescript
import { IsDate, MinDate, MaxDate } from 'class-validator';
import { Type } from 'class-transformer';

export class EventDto {
  @IsString()
  title: string;

  @IsDate({ message: '바데부: 올바른 날짜 형식이 아닙니다' })
  @Type(() => Date)
  @MinDate(new Date())
  startDate: Date;

  @IsDate()
  @Type(() => Date)
  @MinDate(new Date())
  endDate: Date;
}
```

### 배열 검증

```typescript
import { IsArray, ArrayMinSize, ArrayMaxSize, ArrayNotEmpty, IsString } from 'class-validator';

export class CreatePostDto {
  @IsString()
  title: string;

  @IsString()
  content: string;

  @IsArray({ message: '바데부: 태그는 배열이어야 합니다' })
  @ArrayNotEmpty({ message: '바데부: 태그는 최소 1개 이상이어야 합니다' })
  @ArrayMinSize(1)
  @ArrayMaxSize(10)
  @IsString({ each: true })  // 배열의 각 요소가 문자열
  tags: string[];
}
```

### 중첩 객체 검증

```typescript
import { ValidateNested, IsObject } from 'class-validator';
import { Type } from 'class-transformer';

export class AddressDto {
  @IsString()
  city: string;

  @IsString()
  street: string;

  @IsString()
  zipCode: string;
}

export class CreateUserDto {
  @IsString()
  name: string;

  @IsEmail()
  email: string;

  @ValidateNested()
  @Type(() => AddressDto)
  @IsObject()
  address: AddressDto;
}
```

## 선택적 필드

```typescript
import { IsOptional, IsString, IsInt } from 'class-validator';

export class UpdateUserDto {
  @IsOptional()  // 선택적 필드
  @IsString()
  name?: string;

  @IsOptional()
  @IsString()
  bio?: string;

  @IsOptional()
  @IsInt()
  age?: number;
}
```

## 조건부 검증

```typescript
import { ValidateIf, IsString, IsEmail } from 'class-validator';

export class ContactDto {
  @IsString()
  contactMethod: 'email' | 'phone';

  @ValidateIf(o => o.contactMethod === 'email')
  @IsEmail()
  email?: string;

  @ValidateIf(o => o.contactMethod === 'phone')
  @IsString()
  @Matches(/^[0-9]{10,11}$/)
  phone?: string;
}
```

## 커스텀 검증

```typescript
import { registerDecorator, ValidationOptions, ValidationArguments } from 'class-validator';

// 커스텀 데코레이터 생성
export function IsStrongPassword(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      name: 'isStrongPassword',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: any, args: ValidationArguments) {
          // 최소 8자, 대문자, 소문자, 숫자, 특수문자 포함
          const strongPasswordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
          return typeof value === 'string' && strongPasswordRegex.test(value);
        },
        defaultMessage(args: ValidationArguments) {
          return '바데부: 비밀번호는 8자 이상, 대소문자, 숫자, 특수문자를 포함해야 합니다';
        }
      }
    });
  };
}

// 사용
export class RegisterDto {
  @IsEmail()
  email: string;

  @IsStrongPassword()
  password: string;
}
```

## 실전 예제: 바데부의 블로그 DTO

### CreatePostDto

```typescript
// posts/dto/create-post.dto.ts
import { IsString, IsNotEmpty, MinLength, MaxLength, IsArray, ArrayMinSize, ArrayMaxSize, IsInt, IsPositive } from 'class-validator';

export class CreatePostDto {
  @IsString({ message: '바데부: 제목은 문자열이어야 합니다' })
  @IsNotEmpty({ message: '바데부: 제목은 필수입니다' })
  @MinLength(5, { message: '바데부: 제목은 최소 5글자입니다' })
  @MaxLength(200, { message: '바데부: 제목은 최대 200글자입니다' })
  title: string;

  @IsString({ message: '바데부: 내용은 문자열이어야 합니다' })
  @IsNotEmpty({ message: '바데부: 내용은 필수입니다' })
  @MinLength(10, { message: '바데부: 내용은 최소 10글자입니다' })
  content: string;

  @IsInt({ message: '바데부: 작성자 ID는 정수여야 합니다' })
  @IsPositive({ message: '바데부: 작성자 ID는 양수여야 합니다' })
  authorId: number;

  @IsArray({ message: '바데부: 태그는 배열이어야 합니다' })
  @ArrayMinSize(1, { message: '바데부: 태그는 최소 1개 이상이어야 합니다' })
  @ArrayMaxSize(10, { message: '바데부: 태그는 최대 10개까지 가능합니다' })
  @IsString({ each: true, message: '바데부: 각 태그는 문자열이어야 합니다' })
  tags: string[];
}
```

### UpdatePostDto

```typescript
// posts/dto/update-post.dto.ts
import { PartialType } from '@nestjs/mapped-types';
import { CreatePostDto } from './create-post.dto';

// 바데부: CreatePostDto의 모든 필드를 선택적으로 만듭니다
export class UpdatePostDto extends PartialType(CreatePostDto) {}

// 또는 수동으로
export class UpdatePostDto {
  @IsOptional()
  @IsString()
  @MinLength(5)
  @MaxLength(200)
  title?: string;

  @IsOptional()
  @IsString()
  @MinLength(10)
  content?: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  tags?: string[];
}
```

### QueryDto (검색, 페이지네이션)

```typescript
// posts/dto/query-post.dto.ts
import { IsOptional, IsString, IsInt, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';

export class QueryPostDto {
  @IsOptional()
  @IsString()
  search?: string;

  @IsOptional()
  @IsString()
  tag?: string;

  @IsOptional()
  @IsString()
  author?: string;

  @IsOptional()
  @Type(() => Number)  // 쿼리 파라미터를 숫자로 변환
  @IsInt()
  @Min(1)
  page?: number = 1;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 10;

  @IsOptional()
  @IsString()
  sortBy?: 'createdAt' | 'views' | 'likes' = 'createdAt';

  @IsOptional()
  @IsString()
  order?: 'ASC' | 'DESC' = 'DESC';
}
```

### 컨트롤러에서 사용

```typescript
// posts/posts.controller.ts
import { Controller, Get, Post, Put, Delete, Body, Param, Query, ParseIntPipe } from '@nestjs/common';

@Controller('posts')
export class PostsController {
  constructor(private postsService: PostsService) {}

  @Get()
  findAll(@Query() queryDto: QueryPostDto) {
    // 바데부: queryDto가 자동으로 검증됩니다!
    return this.postsService.findAll(queryDto);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    // ParseIntPipe: 문자열을 숫자로 변환
    return this.postsService.findOne(id);
  }

  @Post()
  create(@Body() createPostDto: CreatePostDto) {
    // 바데부: createPostDto가 자동으로 검증됩니다!
    return this.postsService.create(createPostDto);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updatePostDto: UpdatePostDto
  ) {
    return this.postsService.update(id, updatePostDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.postsService.remove(id);
  }
}
```

## Mapped Types

NestJS는 DTO 변환을 위한 유틸리티를 제공합니다.

```bash
npm install @nestjs/mapped-types
```

### PartialType

```typescript
import { PartialType } from '@nestjs/mapped-types';

// 모든 필드를 선택적으로
export class UpdateUserDto extends PartialType(CreateUserDto) {}
```

### PickType

```typescript
import { PickType } from '@nestjs/mapped-types';

// 특정 필드만 선택
export class LoginDto extends PickType(CreateUserDto, ['email', 'password'] as const) {}
```

### OmitType

```typescript
import { OmitType } from '@nestjs/mapped-types';

// 특정 필드 제외
export class CreateUserWithoutPasswordDto extends OmitType(CreateUserDto, ['password'] as const) {}
```

### IntersectionType

```typescript
import { IntersectionType } from '@nestjs/mapped-types';

// 여러 DTO 결합
export class CreateUserWithProfileDto extends IntersectionType(
  CreateUserDto,
  CreateProfileDto
) {}
```

## 커스텀 에러 메시지

```typescript
export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(2, {
    message: (args) => {
      // 바데부: 동적 에러 메시지
      return `바데부: ${args.property}는 최소 ${args.constraints[0]}글자여야 합니다. 현재: ${args.value?.length || 0}글자`;
    }
  })
  name: string;
}
```

## ValidationPipe 옵션

```typescript
// main.ts
app.useGlobalPipes(new ValidationPipe({
  // DTO에 없는 속성 제거
  whitelist: true,

  // DTO에 없는 속성 있으면 에러
  forbidNonWhitelisted: true,

  // 자동 타입 변환
  transform: true,

  // 변환 옵션
  transformOptions: {
    enableImplicitConversion: true,  // 암시적 변환 활성화
  },

  // 에러 메시지 커스터마이징
  exceptionFactory: (errors) => {
    const messages = errors.map(error => ({
      field: error.property,
      errors: Object.values(error.constraints || {})
    }));
    return new BadRequestException({
      message: '바데부: 유효성 검증 실패',
      errors: messages
    });
  }
}));
```

## 그룹 검증

```typescript
import { IsString, IsEmail, MinLength } from 'class-validator';

export class CreateUserDto {
  @IsString({ groups: ['create'] })
  @IsEmail({}, { groups: ['create', 'update'] })
  email: string;

  @IsString({ groups: ['create'] })
  @MinLength(8, { groups: ['create'] })
  password: string;
}

// 컨트롤러에서
@Post()
create(@Body(new ValidationPipe({ groups: ['create'] })) dto: CreateUserDto) {
  // 'create' 그룹 검증만 실행
}
```

## 연습 문제

1. `CreateCommentDto`를 만들고 적절한 검증을 추가해보세요
2. 비밀번호 확인 필드를 추가하고 두 필드가 일치하는지 검증하는 커스텀 데코레이터를 만들어보세요
3. 검색 필터 DTO를 만들고 페이지네이션, 정렬 기능을 구현해보세요

## 다음 챕터 예고

다음 챕터에서는 **미들웨어와 가드**를 배워 요청 처리 흐름을 제어하는 방법을 알아봅니다!

## 핵심 정리

- DTO: 데이터 전송 객체 (클래스 사용)
- class-validator: 다양한 검증 데코레이터 제공
- ValidationPipe: 전역 또는 개별 검증
- Mapped Types: PartialType, PickType, OmitType
- 커스텀 검증: registerDecorator로 생성
- transform: 자동 타입 변환

바데부와 함께 안전한 데이터 검증을 마스터했습니다!

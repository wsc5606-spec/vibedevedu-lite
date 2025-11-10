# Chapter 2: 컨트롤러와 라우팅

## 컨트롤러란?

컨트롤러는 클라이언트의 HTTP 요청을 받아 처리하고 응답을 반환하는 역할을 합니다. NestJS에서 컨트롤러는 `@Controller()` 데코레이터로 정의됩니다.

```typescript
// 바데부: "컨트롤러는 식당의 웨이터 같은 역할이에요!"
// 손님(클라이언트)의 주문(요청)을 받아서 주방(서비스)에 전달하고
// 완성된 음식(응답)을 손님에게 가져다줍니다!
```

## 기본 컨트롤러 생성

### CLI로 생성하기

```bash
# users 컨트롤러 생성
nest g controller users

# 축약형
nest g co users
```

생성된 파일:
- `users.controller.ts` - 컨트롤러 로직
- `users.controller.spec.ts` - 테스트 파일

### 수동으로 생성하기

```typescript
// src/users/users.controller.ts
import { Controller, Get } from '@nestjs/common';

@Controller('users')  // /users 경로의 기본 prefix
export class UsersController {

  @Get()  // GET /users
  findAll(): string {
    return '바데부: 모든 사용자 목록을 조회합니다!';
  }
}
```

## HTTP 메서드 데코레이터

NestJS는 모든 HTTP 메서드를 지원합니다:

```typescript
import { Controller, Get, Post, Put, Delete, Patch } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  @Get()  // GET /badebu
  findAll() {
    return '바데부: GET 요청 - 목록 조회';
  }

  @Post()  // POST /badebu
  create() {
    return '바데부: POST 요청 - 새 데이터 생성';
  }

  @Put()  // PUT /badebu
  update() {
    return '바데부: PUT 요청 - 전체 수정';
  }

  @Patch()  // PATCH /badebu
  partialUpdate() {
    return '바데부: PATCH 요청 - 부분 수정';
  }

  @Delete()  // DELETE /badebu
  remove() {
    return '바데부: DELETE 요청 - 삭제';
  }
}
```

## 라우트 경로 설정

### 기본 경로

```typescript
@Controller('api/v1/badebu')  // 기본 경로 prefix
export class BadebuController {

  @Get()  // GET /api/v1/badebu
  getInfo() {
    return { name: '바데부', version: '1.0' };
  }

  @Get('profile')  // GET /api/v1/badebu/profile
  getProfile() {
    return { name: '바데부', role: 'Developer' };
  }

  @Get('skills')  // GET /api/v1/badebu/skills
  getSkills() {
    return ['NestJS', 'TypeScript', 'React'];
  }
}
```

## 동적 라우트 파라미터

### @Param() 데코레이터

```typescript
import { Controller, Get, Param } from '@nestjs/common';

@Controller('users')
export class UsersController {

  @Get(':id')  // GET /users/1, /users/2, etc.
  findOne(@Param('id') id: string) {
    return `바데부: ${id}번 사용자를 조회합니다`;
  }

  @Get(':id/posts/:postId')  // 여러 파라미터
  findUserPost(
    @Param('id') userId: string,
    @Param('postId') postId: string
  ) {
    return `바데부: ${userId}번 사용자의 ${postId}번 게시글`;
  }

  // 전체 파라미터 객체 받기
  @Get(':userId/comments/:commentId')
  findComment(@Param() params: { userId: string; commentId: string }) {
    return `사용자 ${params.userId}의 댓글 ${params.commentId}`;
  }
}
```

## 쿼리 파라미터

### @Query() 데코레이터

```typescript
import { Controller, Get, Query } from '@nestjs/common';

@Controller('search')
export class SearchController {

  // GET /search?keyword=nestjs
  @Get()
  search(@Query('keyword') keyword: string) {
    return `바데부: "${keyword}" 검색 결과`;
  }

  // 여러 쿼리 파라미터
  // GET /search/users?name=바데부&age=25&city=서울
  @Get('users')
  searchUsers(
    @Query('name') name: string,
    @Query('age') age: string,
    @Query('city') city: string
  ) {
    return {
      message: '바데부: 사용자 검색',
      filters: { name, age, city }
    };
  }

  // 전체 쿼리 객체 받기
  @Get('advanced')
  advancedSearch(@Query() query: any) {
    return {
      message: '바데부: 고급 검색',
      filters: query
    };
  }
}
```

## 요청 본문(Body) 처리

### @Body() 데코레이터

```typescript
import { Controller, Post, Body } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  // POST /badebu
  @Post()
  create(@Body() body: any) {
    return {
      message: '바데부: 새 데이터를 생성했습니다!',
      data: body
    };
  }

  // 특정 필드만 받기
  @Post('profile')
  updateProfile(
    @Body('name') name: string,
    @Body('email') email: string
  ) {
    return {
      message: '바데부: 프로필을 업데이트했습니다',
      name,
      email
    };
  }
}
```

### 인터페이스로 타입 정의

```typescript
// create-user.dto.ts
export interface CreateUserDto {
  name: string;
  email: string;
  age: number;
}

// users.controller.ts
@Post()
create(@Body() createUserDto: CreateUserDto) {
  return {
    message: `바데부: ${createUserDto.name}님을 환영합니다!`,
    user: createUserDto
  };
}
```

## 헤더 처리

### @Headers() 데코레이터

```typescript
import { Controller, Get, Headers } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  @Get('info')
  getInfo(@Headers() headers: any) {
    return {
      message: '바데부: 헤더 정보',
      userAgent: headers['user-agent']
    };
  }

  @Get('auth')
  checkAuth(@Headers('authorization') auth: string) {
    return {
      message: '바데부: 인증 확인',
      token: auth
    };
  }
}
```

## HTTP 상태 코드 설정

### @HttpCode() 데코레이터

```typescript
import { Controller, Post, HttpCode, HttpStatus } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  @Post()
  @HttpCode(HttpStatus.CREATED)  // 201
  create() {
    return '바데부: 생성 완료 (201)';
  }

  @Post('no-content')
  @HttpCode(HttpStatus.NO_CONTENT)  // 204
  updateNoContent() {
    // 204는 응답 본문이 없습니다
  }
}
```

## 응답 헤더 설정

### @Header() 데코레이터

```typescript
import { Controller, Get, Header } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  @Get('file')
  @Header('Content-Type', 'application/json')
  @Header('X-Custom-Header', 'Badebu-Value')
  getFile() {
    return { message: '바데부: 커스텀 헤더가 포함된 응답' };
  }
}
```

## 리다이렉트

### @Redirect() 데코레이터

```typescript
import { Controller, Get, Redirect } from '@nestjs/common';

@Controller('badebu')
export class BadebuController {

  @Get('old-page')
  @Redirect('https://badebu.com/new-page', 301)
  oldPage() {
    // 이 메서드의 반환값은 무시됩니다
  }

  // 동적 리다이렉트
  @Get('search')
  @Redirect()
  search(@Query('term') term: string) {
    return {
      url: `https://google.com/search?q=${term}`,
      statusCode: 302
    };
  }
}
```

## 실전 예제: 바데부의 블로그 API

```typescript
import { Controller, Get, Post, Put, Delete, Param, Body, Query } from '@nestjs/common';

interface Post {
  id: number;
  title: string;
  content: string;
  author: string;
}

@Controller('api/blog')
export class BlogController {
  private posts: Post[] = [
    { id: 1, title: 'NestJS 입문', content: '바데부와 함께 배워요', author: '바데부' }
  ];

  // 모든 게시글 조회 (페이지네이션)
  @Get('posts')
  getAllPosts(@Query('page') page: number = 1, @Query('limit') limit: number = 10) {
    return {
      message: '바데부: 게시글 목록',
      page,
      limit,
      data: this.posts
    };
  }

  // 특정 게시글 조회
  @Get('posts/:id')
  getPost(@Param('id') id: string) {
    const post = this.posts.find(p => p.id === parseInt(id));
    if (!post) {
      return { message: `바데부: ${id}번 게시글을 찾을 수 없습니다` };
    }
    return { message: '바데부: 게시글 조회 완료', data: post };
  }

  // 게시글 생성
  @Post('posts')
  createPost(@Body() post: Omit<Post, 'id'>) {
    const newPost = {
      id: this.posts.length + 1,
      ...post
    };
    this.posts.push(newPost);
    return {
      message: '바데부: 게시글이 생성되었습니다',
      data: newPost
    };
  }

  // 게시글 수정
  @Put('posts/:id')
  updatePost(@Param('id') id: string, @Body() post: Partial<Post>) {
    const index = this.posts.findIndex(p => p.id === parseInt(id));
    if (index === -1) {
      return { message: `바데부: ${id}번 게시글을 찾을 수 없습니다` };
    }
    this.posts[index] = { ...this.posts[index], ...post };
    return {
      message: '바데부: 게시글이 수정되었습니다',
      data: this.posts[index]
    };
  }

  // 게시글 삭제
  @Delete('posts/:id')
  deletePost(@Param('id') id: string) {
    const index = this.posts.findIndex(p => p.id === parseInt(id));
    if (index === -1) {
      return { message: `바데부: ${id}번 게시글을 찾을 수 없습니다` };
    }
    this.posts.splice(index, 1);
    return { message: '바데부: 게시글이 삭제되었습니다' };
  }

  // 작성자별 게시글 검색
  @Get('posts/author/:name')
  getPostsByAuthor(@Param('name') name: string) {
    const authorPosts = this.posts.filter(p => p.author === name);
    return {
      message: `바데부: ${name}의 게시글 목록`,
      count: authorPosts.length,
      data: authorPosts
    };
  }
}
```

## 서브 도메인 라우팅

```typescript
@Controller({ host: 'admin.badebu.com' })
export class AdminController {
  @Get()
  adminPanel() {
    return '바데부: 관리자 패널';
  }
}

@Controller({ host: ':account.badebu.com' })
export class AccountController {
  @Get()
  getAccount(@HostParam('account') account: string) {
    return `바데부: ${account} 계정 페이지`;
  }
}
```

## 비동기 처리

```typescript
@Controller('async')
export class AsyncController {

  // Promise 반환
  @Get('promise')
  async getDataPromise(): Promise<string> {
    return '바데부: Promise 응답';
  }

  // Observable 반환
  @Get('observable')
  getDataObservable(): Observable<string> {
    return of('바데부: Observable 응답');
  }

  // 실제 비동기 작업 예제
  @Get('users/:id')
  async findUser(@Param('id') id: string): Promise<any> {
    // 데이터베이스 조회 등의 비동기 작업
    await new Promise(resolve => setTimeout(resolve, 1000));
    return { id, name: '바데부', message: '1초 후 응답' };
  }
}
```

## 연습 문제

1. `ProductsController`를 만들고 CRUD 엔드포인트를 구현해보세요
2. 쿼리 파라미터로 제품 필터링 기능을 추가해보세요 (가격, 카테고리)
3. `/products/:id/reviews/:reviewId` 형태의 중첩 라우트를 만들어보세요

## 다음 챕터 예고

다음 챕터에서는 **프로바이더와 의존성 주입**을 배워 비즈니스 로직을 서비스로 분리하는 방법을 알아봅니다!

## 핵심 정리

- 컨트롤러는 `@Controller()` 데코레이터로 정의
- HTTP 메서드: `@Get()`, `@Post()`, `@Put()`, `@Delete()`, `@Patch()`
- 파라미터: `@Param()`, `@Query()`, `@Body()`, `@Headers()`
- 응답 제어: `@HttpCode()`, `@Header()`, `@Redirect()`
- 경로는 조합 가능: 컨트롤러 prefix + 메서드 경로

바데부와 함께 라우팅을 마스터했습니다!

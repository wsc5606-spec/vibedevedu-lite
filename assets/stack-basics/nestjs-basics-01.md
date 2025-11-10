# Chapter 1: NestJS 소개 및 프로젝트 설정

## NestJS란?

NestJS는 효율적이고 확장 가능한 Node.js 서버 사이드 애플리케이션을 구축하기 위한 프레임워크입니다. TypeScript를 기본으로 사용하며, Express 또는 Fastify 위에서 동작합니다.

### 주요 특징

1. **TypeScript 우선**: 타입 안정성과 최신 JavaScript 기능 지원
2. **모듈식 아키텍처**: 코드 재사용과 유지보수 용이
3. **의존성 주입**: 테스트 가능하고 느슨하게 결합된 코드
4. **데코레이터 기반**: 깔끔하고 선언적인 코드 작성

## 왜 NestJS를 배워야 할까?

```typescript
// 바데부의 고민
// "Node.js로 백엔드를 만들고 싶은데, 어디서부터 시작해야 할까?"
// "코드가 점점 복잡해지고 관리가 어려워..."

// NestJS는 이런 문제를 해결해줍니다!
```

NestJS는 Angular에서 영감을 받아 체계적인 구조를 제공하므로, 대규모 애플리케이션도 쉽게 관리할 수 있습니다.

## 사전 준비사항

### 필수 설치

1. **Node.js** (v16 이상)
2. **npm** 또는 **yarn**
3. 코드 에디터 (**VS Code** 권장)

### Node.js 설치 확인

```bash
node --version  # v16.0.0 이상
npm --version   # 8.0.0 이상
```

## NestJS CLI 설치

NestJS CLI는 프로젝트 생성과 개발을 쉽게 해주는 도구입니다.

```bash
# NestJS CLI 전역 설치
npm install -g @nestjs/cli

# 설치 확인
nest --version
```

## 첫 프로젝트 만들기

### 1. 프로젝트 생성

```bash
# 바데부의 첫 프로젝트 생성
nest new badebu-api

# 패키지 매니저 선택 (npm 또는 yarn)
? Which package manager would you ❤️  to use? npm
```

### 2. 프로젝트 구조 살펴보기

```
badebu-api/
├── src/
│   ├── app.controller.ts      # 컨트롤러 (라우트 처리)
│   ├── app.controller.spec.ts # 테스트 파일
│   ├── app.module.ts           # 루트 모듈
│   ├── app.service.ts          # 서비스 (비즈니스 로직)
│   └── main.ts                 # 애플리케이션 진입점
├── test/                       # E2E 테스트
├── node_modules/               # 의존성 패키지
├── nest-cli.json               # NestJS CLI 설정
├── package.json                # 프로젝트 정보
├── tsconfig.json               # TypeScript 설정
└── README.md
```

## main.ts - 애플리케이션 시작점

```typescript
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  // NestJS 애플리케이션 인스턴스 생성
  const app = await NestFactory.create(AppModule);

  // 바데부의 API가 3000번 포트에서 실행됩니다
  await app.listen(3000);
  console.log('바데부 API 서버가 http://localhost:3000 에서 실행중입니다!');
}

bootstrap();
```

## 개발 서버 실행

```bash
# 프로젝트 디렉토리로 이동
cd badebu-api

# 개발 모드로 실행 (파일 변경 시 자동 재시작)
npm run start:dev

# 또는
yarn start:dev
```

### 서버 실행 확인

브라우저에서 `http://localhost:3000` 접속하면:

```
Hello World!
```

축하합니다! 바데부의 첫 NestJS 서버가 실행되었습니다!

## 기본 코드 이해하기

### app.controller.ts

```typescript
import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()  // 이 클래스가 컨트롤러임을 표시
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()  // GET / 경로 처리
  getHello(): string {
    return this.appService.getHello();
  }
}
```

### app.service.ts

```typescript
import { Injectable } from '@nestjs/common';

@Injectable()  // 의존성 주입이 가능한 서비스
export class AppService {
  getHello(): string {
    return '안녕하세요, 바데부입니다!';
  }
}
```

### app.module.ts

```typescript
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [],      // 다른 모듈 import
  controllers: [AppController],  // 컨트롤러 등록
  providers: [AppService],       // 서비스 등록
})
export class AppModule {}
```

## 바데부의 첫 API 수정하기

`app.service.ts`를 수정해봅시다:

```typescript
import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return '안녕하세요! 바데부와 함께하는 NestJS 학습에 오신 것을 환영합니다!';
  }

  getInfo(): object {
    return {
      name: '바데부',
      role: 'NestJS 학습 가이드',
      message: 'NestJS로 멋진 백엔드를 만들어봅시다!'
    };
  }
}
```

저장하면 자동으로 서버가 재시작됩니다! (`start:dev` 모드)

## 유용한 NestJS CLI 명령어

```bash
# 새 컨트롤러 생성
nest generate controller users
nest g co users  # 축약형

# 새 서비스 생성
nest generate service users
nest g s users

# 새 모듈 생성
nest generate module users
nest g mo users

# 전체 리소스 생성 (CRUD 보일러플레이트)
nest generate resource users

# 도움말
nest --help
```

## 개발 팁

### 1. Hot Reload 설정

더 빠른 개발을 위해 Webpack HMR(Hot Module Replacement)을 사용할 수 있습니다.

```bash
npm install --save-dev webpack-node-externals run-script-webpack-plugin webpack
```

### 2. VS Code 확장 프로그램

- **NestJS Snippets**: 코드 자동완성
- **ESLint**: 코드 품질 검사
- **Prettier**: 코드 포맷팅

### 3. 환경 변수 설정

```bash
npm install @nestjs/config
```

## 문제 해결

### 포트가 이미 사용중일 때

```typescript
// main.ts
await app.listen(3000);  // 3001, 3002 등으로 변경
```

또는 환경변수 사용:

```typescript
const port = process.env.PORT || 3000;
await app.listen(port);
```

### TypeScript 컴파일 에러

```bash
# node_modules 삭제 후 재설치
rm -rf node_modules package-lock.json
npm install
```

## 연습 문제

1. 새로운 프로젝트 `badebu-blog`를 생성해보세요
2. 포트를 4000으로 변경해보세요
3. AppService에 `getDate()` 메서드를 추가하여 현재 날짜를 반환하도록 해보세요

## 다음 챕터 예고

다음 챕터에서는 **컨트롤러와 라우팅**을 배우며, 바데부가 다양한 API 엔드포인트를 만드는 방법을 알아봅니다!

```typescript
// 다음 챕터에서 배울 내용
@Get('/users')      // 사용자 목록
@Post('/users')     // 사용자 생성
@Get('/users/:id')  // 특정 사용자 조회
```

## 핵심 정리

- NestJS는 TypeScript 기반의 서버 사이드 프레임워크
- CLI로 쉽게 프로젝트 생성 가능
- 모듈, 컨트롤러, 서비스로 구성된 구조
- `start:dev`로 개발 서버 실행 (자동 재시작)
- 데코레이터를 사용한 선언적 프로그래밍

바데부와 함께 NestJS 여정을 시작했습니다! 화이팅!

# Chapter 10: 테스트와 배포

## 테스트란?

테스트는 코드가 예상대로 작동하는지 확인하는 과정입니다. NestJS는 Jest를 기본 테스팅 프레임워크로 사용합니다.

```typescript
// 바데부: "테스트는 안전벨트 같아요!"
// 코드를 수정해도 기존 기능이 잘 작동하는지 확인할 수 있습니다.
```

### 테스트의 종류

1. **단위 테스트(Unit Test)**: 개별 함수/메서드 테스트
2. **통합 테스트(Integration Test)**: 여러 모듈 함께 테스트
3. **E2E 테스트(End-to-End Test)**: 전체 애플리케이션 테스트

## Jest 설정

NestJS 프로젝트는 Jest가 기본으로 설정되어 있습니다.

```json
// package.json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:cov": "jest --coverage",
    "test:e2e": "jest --config ./test/jest-e2e.json"
  }
}
```

## 단위 테스트

### 서비스 테스트

```typescript
// users/users.service.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { UsersService } from './users.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository } from 'typeorm';

describe('UsersService', () => {
  let service: UsersService;
  let repository: Repository<User>;

  // 바데부: 테스트 전에 모듈 설정
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UsersService,
        {
          provide: getRepositoryToken(User),
          useValue: {
            find: jest.fn(),
            findOne: jest.fn(),
            create: jest.fn(),
            save: jest.fn(),
            remove: jest.fn(),
          },
        },
      ],
    }).compile();

    service = module.get<UsersService>(UsersService);
    repository = module.get<Repository<User>>(getRepositoryToken(User));
  });

  // 바데부: 서비스가 제대로 생성되는지 확인
  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('findAll', () => {
    it('모든 사용자를 반환해야 합니다', async () => {
      const users = [
        { id: 1, name: '바데부', email: 'badebu@example.com' },
        { id: 2, name: '김코딩', email: 'coding@example.com' }
      ];

      jest.spyOn(repository, 'find').mockResolvedValue(users as User[]);

      const result = await service.findAll();

      expect(result).toEqual(users);
      expect(repository.find).toHaveBeenCalledTimes(1);
    });
  });

  describe('findOne', () => {
    it('특정 사용자를 반환해야 합니다', async () => {
      const user = { id: 1, name: '바데부', email: 'badebu@example.com' };

      jest.spyOn(repository, 'findOne').mockResolvedValue(user as User);

      const result = await service.findOne(1);

      expect(result).toEqual(user);
      expect(repository.findOne).toHaveBeenCalledWith({ where: { id: 1 } });
    });

    it('사용자가 없으면 예외를 발생시켜야 합니다', async () => {
      jest.spyOn(repository, 'findOne').mockResolvedValue(null);

      await expect(service.findOne(999)).rejects.toThrow();
    });
  });

  describe('create', () => {
    it('새 사용자를 생성해야 합니다', async () => {
      const createUserDto = {
        name: '바데부',
        email: 'badebu@example.com',
        age: 25
      };

      const savedUser = { id: 1, ...createUserDto };

      jest.spyOn(repository, 'create').mockReturnValue(savedUser as User);
      jest.spyOn(repository, 'save').mockResolvedValue(savedUser as User);

      const result = await service.create(createUserDto);

      expect(result).toEqual(savedUser);
      expect(repository.create).toHaveBeenCalledWith(createUserDto);
      expect(repository.save).toHaveBeenCalledWith(savedUser);
    });
  });
});
```

### 컨트롤러 테스트

```typescript
// users/users.controller.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

describe('UsersController', () => {
  let controller: UsersController;
  let service: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [
        {
          provide: UsersService,
          useValue: {
            findAll: jest.fn(),
            findOne: jest.fn(),
            create: jest.fn(),
            update: jest.fn(),
            remove: jest.fn(),
          },
        },
      ],
    }).compile();

    controller = module.get<UsersController>(UsersController);
    service = module.get<UsersService>(UsersService);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('findAll', () => {
    it('모든 사용자를 반환해야 합니다', async () => {
      const users = [
        { id: 1, name: '바데부', email: 'badebu@example.com' }
      ];

      jest.spyOn(service, 'findAll').mockResolvedValue(users as any);

      const result = await controller.findAll();

      expect(result).toEqual(users);
      expect(service.findAll).toHaveBeenCalled();
    });
  });

  describe('create', () => {
    it('새 사용자를 생성해야 합니다', async () => {
      const createUserDto = {
        name: '바데부',
        email: 'badebu@example.com',
        age: 25
      };

      const createdUser = { id: 1, ...createUserDto };

      jest.spyOn(service, 'create').mockResolvedValue(createdUser as any);

      const result = await controller.create(createUserDto);

      expect(result).toEqual(createdUser);
      expect(service.create).toHaveBeenCalledWith(createUserDto);
    });
  });
});
```

## E2E 테스트

전체 애플리케이션을 테스트합니다.

```typescript
// test/app.e2e-spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from './../src/app.module';

describe('UsersController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(new ValidationPipe());
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  describe('/users (GET)', () => {
    it('모든 사용자를 반환해야 합니다', () => {
      return request(app.getHttpServer())
        .get('/users')
        .expect(200)
        .expect((res) => {
          expect(Array.isArray(res.body)).toBe(true);
        });
    });
  });

  describe('/users (POST)', () => {
    it('새 사용자를 생성해야 합니다', () => {
      const createUserDto = {
        name: '바데부',
        email: 'badebu@test.com',
        age: 25
      };

      return request(app.getHttpServer())
        .post('/users')
        .send(createUserDto)
        .expect(201)
        .expect((res) => {
          expect(res.body.name).toBe(createUserDto.name);
          expect(res.body.email).toBe(createUserDto.email);
        });
    });

    it('유효하지 않은 데이터는 거부해야 합니다', () => {
      const invalidDto = {
        name: 'A',  // 너무 짧음
        email: 'invalid-email',  // 잘못된 이메일
        age: -1  // 음수
      };

      return request(app.getHttpServer())
        .post('/users')
        .send(invalidDto)
        .expect(400);
    });
  });

  describe('/users/:id (GET)', () => {
    it('특정 사용자를 반환해야 합니다', () => {
      return request(app.getHttpServer())
        .get('/users/1')
        .expect(200)
        .expect((res) => {
          expect(res.body).toHaveProperty('id');
          expect(res.body).toHaveProperty('name');
        });
    });

    it('존재하지 않는 사용자는 404를 반환해야 합니다', () => {
      return request(app.getHttpServer())
        .get('/users/999999')
        .expect(404);
    });
  });
});
```

## 테스트 커버리지

```bash
# 커버리지 리포트 생성
npm run test:cov

# 바데부: coverage 폴더에 리포트 생성됨
# coverage/lcov-report/index.html 을 브라우저로 열어보세요
```

## 모킹(Mocking)

### 의존성 모킹

```typescript
describe('PostsService', () => {
  let service: PostsService;
  let usersService: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PostsService,
        {
          provide: UsersService,
          useValue: {
            findOne: jest.fn().mockResolvedValue({
              id: 1,
              name: '바데부'
            })
          }
        }
      ]
    }).compile();

    service = module.get<PostsService>(PostsService);
    usersService = module.get<UsersService>(UsersService);
  });

  it('작성자 정보를 포함한 게시글을 반환해야 합니다', async () => {
    const result = await service.findWithAuthor(1);

    expect(result.author.name).toBe('바데부');
    expect(usersService.findOne).toHaveBeenCalledWith(1);
  });
});
```

## 테스트 유틸리티

### 테스트 데이터 팩토리

```typescript
// test/factories/user.factory.ts
export class UserFactory {
  static create(override?: Partial<User>): User {
    return {
      id: 1,
      name: '바데부',
      email: 'badebu@test.com',
      age: 25,
      createdAt: new Date(),
      updatedAt: new Date(),
      ...override
    };
  }

  static createMany(count: number): User[] {
    return Array.from({ length: count }, (_, i) =>
      this.create({ id: i + 1, name: `바데부${i + 1}` })
    );
  }
}

// 사용
const user = UserFactory.create({ name: '김코딩' });
const users = UserFactory.createMany(5);
```

## 배포 준비

### 환경 변수 설정

```bash
# .env.production
NODE_ENV=production
PORT=3000
DATABASE_HOST=your-database-host
DATABASE_PORT=5432
DATABASE_USERNAME=your-username
DATABASE_PASSWORD=your-password
DATABASE_NAME=your-database
JWT_SECRET=your-super-secret-key
```

### 환경 변수 사용

```typescript
// config/configuration.ts
export default () => ({
  port: parseInt(process.env.PORT, 10) || 3000,
  database: {
    host: process.env.DATABASE_HOST,
    port: parseInt(process.env.DATABASE_PORT, 10) || 5432,
    username: process.env.DATABASE_USERNAME,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME,
  },
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: '1d'
  }
});

// app.module.ts
import { ConfigModule } from '@nestjs/config';
import configuration from './config/configuration';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [configuration],
      isGlobal: true,
    }),
    // ...
  ],
})
export class AppModule {}
```

## 프로덕션 빌드

```bash
# TypeScript를 JavaScript로 컴파일
npm run build

# dist 폴더에 빌드 결과 생성됨
```

### 프로덕션 실행

```bash
# 프로덕션 모드로 실행
npm run start:prod

# 또는
node dist/main
```

## Docker로 배포

### Dockerfile

```dockerfile
# 바데부의 NestJS Dockerfile
FROM node:18-alpine

# 작업 디렉토리 설정
WORKDIR /app

# package.json과 package-lock.json 복사
COPY package*.json ./

# 의존성 설치
RUN npm ci --only=production

# 소스 코드 복사
COPY . .

# TypeScript 빌드
RUN npm run build

# 포트 노출
EXPOSE 3000

# 애플리케이션 실행
CMD ["node", "dist/main"]
```

### .dockerignore

```
node_modules
dist
.git
.env
.env.local
*.log
coverage
.vscode
```

### Docker 이미지 빌드 및 실행

```bash
# 이미지 빌드
docker build -t badebu-api .

# 컨테이너 실행
docker run -p 3000:3000 -e DATABASE_HOST=host.docker.internal badebu-api
```

### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  # 바데부 API 서버
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_HOST=postgres
      - DATABASE_PORT=5432
      - DATABASE_USERNAME=badebu
      - DATABASE_PASSWORD=password123
      - DATABASE_NAME=badebu_db
    depends_on:
      - postgres
    restart: unless-stopped

  # PostgreSQL 데이터베이스
  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=badebu
      - POSTGRES_PASSWORD=password123
      - POSTGRES_DB=badebu_db
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped

volumes:
  postgres_data:
```

```bash
# Docker Compose 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f api

# 중지
docker-compose down
```

## 헬스체크

```typescript
// health/health.controller.ts
import { Controller, Get } from '@nestjs/common';
import { HealthCheck, HealthCheckService, TypeOrmHealthIndicator } from '@nestjs/terminus';

@Controller('health')
export class HealthController {
  constructor(
    private health: HealthCheckService,
    private db: TypeOrmHealthIndicator,
  ) {}

  @Get()
  @HealthCheck()
  check() {
    return this.health.check([
      () => this.db.pingCheck('database'),
    ]);
  }
}
```

설치:
```bash
npm install @nestjs/terminus
```

## PM2로 프로세스 관리

```bash
# PM2 설치
npm install -g pm2

# PM2로 실행
pm2 start dist/main.js --name badebu-api

# 상태 확인
pm2 status

# 로그 확인
pm2 logs badebu-api

# 재시작
pm2 restart badebu-api

# 중지
pm2 stop badebu-api
```

### PM2 설정 파일

```javascript
// ecosystem.config.js
module.exports = {
  apps: [{
    name: 'badebu-api',
    script: 'dist/main.js',
    instances: 2,  // 클러스터 모드
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    error_file: 'logs/error.log',
    out_file: 'logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss'
  }]
};
```

```bash
pm2 start ecosystem.config.js
```

## Vercel 배포

```json
// vercel.json
{
  "version": 2,
  "builds": [
    {
      "src": "src/main.ts",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "src/main.ts",
      "methods": ["GET", "POST", "PUT", "DELETE", "PATCH"]
    }
  ]
}
```

```bash
# Vercel CLI 설치
npm install -g vercel

# 배포
vercel --prod
```

## Heroku 배포

```json
// Procfile
web: npm run start:prod
```

```bash
# Heroku CLI로 배포
heroku login
heroku create badebu-api
git push heroku main

# 환경 변수 설정
heroku config:set DATABASE_URL=your-database-url
heroku config:set JWT_SECRET=your-secret
```

## 성능 최적화

### 1. 캐싱

```typescript
import { CacheModule } from '@nestjs/cache-manager';

@Module({
  imports: [
    CacheModule.register({
      ttl: 60, // 60초
      max: 100, // 최대 100개
    }),
  ],
})
export class AppModule {}
```

### 2. 압축

```typescript
// main.ts
import * as compression from 'compression';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.use(compression());
  await app.listen(3000);
}
```

### 3. Rate Limiting

```bash
npm install @nestjs/throttler
```

```typescript
import { ThrottlerModule } from '@nestjs/throttler';

@Module({
  imports: [
    ThrottlerModule.forRoot([{
      ttl: 60000, // 1분
      limit: 10, // 최대 10회
    }]),
  ],
})
export class AppModule {}
```

## 모니터링

### 로깅

```typescript
// main.ts
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    logger: ['error', 'warn', 'log', 'debug', 'verbose'],
  });

  const logger = new Logger('Bootstrap');
  await app.listen(3000);
  logger.log('바데부 API 서버가 시작되었습니다!');
}
```

## 보안 체크리스트

- [ ] 환경 변수로 민감한 정보 관리
- [ ] HTTPS 사용
- [ ] CORS 설정
- [ ] Helmet 사용 (보안 헤더)
- [ ] Rate Limiting
- [ ] 입력 검증 (ValidationPipe)
- [ ] SQL Injection 방지 (TypeORM 사용)
- [ ] JWT 토큰 만료 시간 설정
- [ ] 에러 메시지에 민감한 정보 포함하지 않기

## 연습 문제

1. UsersService의 update 메서드에 대한 단위 테스트를 작성해보세요
2. E2E 테스트로 로그인 플로우를 테스트해보세요
3. Docker Compose로 NestJS + PostgreSQL + Redis 스택을 구성해보세요

## 마무리

축하합니다! 바데부와 함께 NestJS의 모든 기초를 학습했습니다!

### 학습한 내용 요약

1. **NestJS 소개**: 프로젝트 설정과 CLI
2. **컨트롤러**: HTTP 요청 처리
3. **프로바이더**: 의존성 주입과 서비스
4. **모듈**: 애플리케이션 구조화
5. **TypeORM**: 데이터베이스 연동
6. **DTO**: 데이터 검증
7. **미들웨어와 가드**: 인증과 권한
8. **인터셉터와 파이프**: 데이터 변환
9. **예외 처리**: 에러 관리
10. **테스트와 배포**: 안정적인 운영

### 다음 단계

- GraphQL API 구축
- 마이크로서비스 아키텍처
- WebSocket 실시간 통신
- 큐(Queue)와 작업 스케줄링
- 고급 보안 및 인증

바데부와 함께한 NestJS 학습 여정을 완료했습니다! 계속해서 멋진 백엔드를 만들어가세요!

# Chapter 5: TypeORM과 데이터베이스

## TypeORM이란?

TypeORM은 TypeScript와 JavaScript를 위한 ORM(Object-Relational Mapping) 라이브러리입니다. 데이터베이스와 객체 지향 프로그래밍을 연결해줍니다.

```typescript
// 바데부: "SQL을 직접 작성하지 않고도 데이터베이스를 사용할 수 있어요!"
// TypeScript 클래스 = 데이터베이스 테이블
```

### 지원 데이터베이스

- PostgreSQL
- MySQL / MariaDB
- SQLite
- Microsoft SQL Server
- MongoDB
- Oracle

## 설치하기

```bash
# TypeORM과 NestJS 통합 패키지
npm install --save @nestjs/typeorm typeorm

# PostgreSQL 드라이버 (PostgreSQL 사용 시)
npm install --save pg

# MySQL 드라이버 (MySQL 사용 시)
npm install --save mysql2

# SQLite 드라이버 (SQLite 사용 시)
npm install --save sqlite3
```

## TypeORM 설정

### app.module.ts에서 설정

```typescript
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',           // 데이터베이스 종류
      host: 'localhost',          // 호스트
      port: 5432,                 // 포트
      username: 'badebu',         // 사용자명
      password: 'password123',    // 비밀번호
      database: 'badebu_db',      // 데이터베이스명
      entities: [],               // 엔티티 목록
      synchronize: true,          // 개발 환경에서만 true
    }),
  ],
})
export class AppModule {}
```

### SQLite 사용 (연습용으로 적합)

```typescript
TypeOrmModule.forRoot({
  type: 'sqlite',
  database: 'badebu.db',  // 파일명
  entities: [],
  synchronize: true,
})
```

## 엔티티 생성하기

엔티티는 데이터베이스 테이블에 매핑되는 클래스입니다.

### 기본 엔티티

```typescript
// users/entities/user.entity.ts
import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity('users')  // 테이블 이름
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  name: string;

  @Column({ unique: true })
  email: string;

  @Column()
  age: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
```

### 컬럼 타입과 옵션

```typescript
@Entity('badebu_profiles')
export class Profile {
  @PrimaryGeneratedColumn('uuid')  // UUID 타입 ID
  id: string;

  @Column({ type: 'varchar', length: 255 })
  bio: string;

  @Column({ type: 'text', nullable: true })  // NULL 허용
  description: string;

  @Column({ type: 'int', default: 0 })  // 기본값 설정
  followers: number;

  @Column({ type: 'boolean', default: false })
  isVerified: boolean;

  @Column({ type: 'json', nullable: true })  // JSON 타입
  settings: object;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  lastLogin: Date;
}
```

## 엔티티 등록하기

### 모듈에 등록

```typescript
// users/users.module.ts
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([User])  // 바데부: User 엔티티 등록!
  ],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService]
})
export class UsersModule {}
```

### app.module.ts에 엔티티 추가

```typescript
import { User } from './users/entities/user.entity';

TypeOrmModule.forRoot({
  // ... 다른 설정
  entities: [User],  // 모든 엔티티 등록
  synchronize: true,
})
```

## Repository 사용하기

Repository는 데이터베이스 작업을 위한 메서드를 제공합니다.

```typescript
// users/users.service.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {
    // 바데부: Repository를 주입받았어요!
  }

  // 모든 사용자 조회
  async findAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

  // 특정 사용자 조회
  async findOne(id: number): Promise<User> {
    return this.usersRepository.findOne({
      where: { id }
    });
  }

  // 이메일로 사용자 찾기
  async findByEmail(email: string): Promise<User> {
    return this.usersRepository.findOne({
      where: { email }
    });
  }

  // 사용자 생성
  async create(userData: Partial<User>): Promise<User> {
    const user = this.usersRepository.create(userData);
    return this.usersRepository.save(user);
  }

  // 사용자 수정
  async update(id: number, userData: Partial<User>): Promise<User> {
    await this.usersRepository.update(id, userData);
    return this.findOne(id);
  }

  // 사용자 삭제
  async remove(id: number): Promise<void> {
    await this.usersRepository.delete(id);
  }
}
```

## 고급 쿼리

### 조건부 조회

```typescript
// 나이가 20세 이상인 사용자
async findAdults(): Promise<User[]> {
  return this.usersRepository.find({
    where: {
      age: MoreThan(20)
    }
  });
}

// 이름에 '바데부'가 포함된 사용자
async searchByName(name: string): Promise<User[]> {
  return this.usersRepository.find({
    where: {
      name: Like(`%${name}%`)
    }
  });
}

// 여러 조건
import { Between, In } from 'typeorm';

async findByConditions(): Promise<User[]> {
  return this.usersRepository.find({
    where: {
      age: Between(20, 30),
      name: In(['바데부', '김코딩', '박개발'])
    }
  });
}
```

### 정렬과 페이지네이션

```typescript
async findWithPagination(page: number = 1, limit: number = 10) {
  const [users, total] = await this.usersRepository.findAndCount({
    skip: (page - 1) * limit,
    take: limit,
    order: {
      createdAt: 'DESC'  // 최신순
    }
  });

  return {
    data: users,
    total,
    page,
    lastPage: Math.ceil(total / limit)
  };
}
```

### QueryBuilder 사용

```typescript
async findWithCustomQuery(name: string): Promise<User[]> {
  return this.usersRepository
    .createQueryBuilder('user')
    .where('user.name LIKE :name', { name: `%${name}%` })
    .andWhere('user.age > :age', { age: 20 })
    .orderBy('user.createdAt', 'DESC')
    .take(10)
    .getMany();
}

// 복잡한 쿼리
async getUserStats() {
  return this.usersRepository
    .createQueryBuilder('user')
    .select('COUNT(*)', 'total')
    .addSelect('AVG(user.age)', 'averageAge')
    .addSelect('MAX(user.age)', 'maxAge')
    .addSelect('MIN(user.age)', 'minAge')
    .getRawOne();
}
```

## 관계(Relations)

### One-to-Many / Many-to-One

```typescript
// users/entities/user.entity.ts
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { Post } from '../../posts/entities/post.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  email: string;

  // 바데부: 한 사용자는 여러 게시글을 가질 수 있어요
  @OneToMany(() => Post, post => post.author)
  posts: Post[];
}

// posts/entities/post.entity.ts
import { Entity, Column, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { User } from '../../users/entities/user.entity';

@Entity('posts')
export class Post {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column('text')
  content: string;

  // 바데부: 여러 게시글은 한 사용자에게 속해요
  @ManyToOne(() => User, user => user.posts)
  @JoinColumn({ name: 'author_id' })
  author: User;

  @Column({ name: 'author_id' })
  authorId: number;
}
```

### 관계 데이터 조회

```typescript
// 게시글과 작성자 함께 조회
async findPostsWithAuthor(): Promise<Post[]> {
  return this.postsRepository.find({
    relations: ['author']  // 바데부: author 관계도 함께 가져와요
  });
}

// 사용자와 모든 게시글 조회
async findUserWithPosts(userId: number): Promise<User> {
  return this.usersRepository.findOne({
    where: { id: userId },
    relations: ['posts']
  });
}
```

### Many-to-Many

```typescript
// posts/entities/post.entity.ts
import { Entity, Column, PrimaryGeneratedColumn, ManyToMany, JoinTable } from 'typeorm';
import { Tag } from '../../tags/entities/tag.entity';

@Entity('posts')
export class Post {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  // 바데부: 게시글은 여러 태그를 가질 수 있고, 태그도 여러 게시글에 속할 수 있어요
  @ManyToMany(() => Tag, tag => tag.posts)
  @JoinTable({
    name: 'post_tags',  // 중간 테이블 이름
    joinColumn: { name: 'post_id' },
    inverseJoinColumn: { name: 'tag_id' }
  })
  tags: Tag[];
}

// tags/entities/tag.entity.ts
@Entity('tags')
export class Tag {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  name: string;

  @ManyToMany(() => Post, post => post.tags)
  posts: Post[];
}
```

## 실전 예제: 바데부의 블로그 시스템

### 엔티티 정의

```typescript
// users/entities/user.entity.ts
@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  name: string;

  @Column({ unique: true })
  email: string;

  @Column()
  password: string;

  @Column({ default: '' })
  bio: string;

  @OneToMany(() => Post, post => post.author)
  posts: Post[];

  @OneToMany(() => Comment, comment => comment.author)
  comments: Comment[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}

// posts/entities/post.entity.ts
@Entity('posts')
export class Post {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 200 })
  title: string;

  @Column('text')
  content: string;

  @Column({ default: 0 })
  views: number;

  @Column({ default: 0 })
  likes: number;

  @ManyToOne(() => User, user => user.posts)
  @JoinColumn({ name: 'author_id' })
  author: User;

  @Column({ name: 'author_id' })
  authorId: number;

  @OneToMany(() => Comment, comment => comment.post)
  comments: Comment[];

  @ManyToMany(() => Tag, tag => tag.posts)
  @JoinTable()
  tags: Tag[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}

// comments/entities/comment.entity.ts
@Entity('comments')
export class Comment {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('text')
  content: string;

  @ManyToOne(() => User, user => user.comments)
  @JoinColumn({ name: 'author_id' })
  author: User;

  @Column({ name: 'author_id' })
  authorId: number;

  @ManyToOne(() => Post, post => post.comments)
  @JoinColumn({ name: 'post_id' })
  post: Post;

  @Column({ name: 'post_id' })
  postId: number;

  @CreateDateColumn()
  createdAt: Date;
}
```

### 서비스 구현

```typescript
// posts/posts.service.ts
@Injectable()
export class PostsService {
  constructor(
    @InjectRepository(Post)
    private postsRepository: Repository<Post>,
    @InjectRepository(Tag)
    private tagsRepository: Repository<Tag>,
  ) {}

  // 게시글 생성 (태그 포함)
  async create(createPostDto: CreatePostDto): Promise<Post> {
    const { title, content, authorId, tagNames } = createPostDto;

    // 태그 찾기 또는 생성
    const tags = await Promise.all(
      tagNames.map(async (name) => {
        let tag = await this.tagsRepository.findOne({ where: { name } });
        if (!tag) {
          tag = this.tagsRepository.create({ name });
          await this.tagsRepository.save(tag);
        }
        return tag;
      })
    );

    // 게시글 생성
    const post = this.postsRepository.create({
      title,
      content,
      authorId,
      tags
    });

    return this.postsRepository.save(post);
  }

  // 게시글 상세 조회 (작성자, 댓글, 태그 포함)
  async findOne(id: number): Promise<Post> {
    return this.postsRepository.findOne({
      where: { id },
      relations: ['author', 'comments', 'comments.author', 'tags']
    });
  }

  // 인기 게시글 조회
  async findPopular(limit: number = 10): Promise<Post[]> {
    return this.postsRepository.find({
      relations: ['author', 'tags'],
      order: { views: 'DESC', likes: 'DESC' },
      take: limit
    });
  }

  // 태그별 게시글 검색
  async findByTag(tagName: string): Promise<Post[]> {
    return this.postsRepository
      .createQueryBuilder('post')
      .leftJoinAndSelect('post.author', 'author')
      .leftJoinAndSelect('post.tags', 'tag')
      .where('tag.name = :tagName', { tagName })
      .getMany();
  }

  // 조회수 증가
  async incrementViews(id: number): Promise<void> {
    await this.postsRepository.increment({ id }, 'views', 1);
  }
}
```

## 트랜잭션

여러 데이터베이스 작업을 하나의 단위로 처리합니다.

```typescript
import { DataSource } from 'typeorm';

@Injectable()
export class PostsService {
  constructor(
    private dataSource: DataSource,
    @InjectRepository(Post)
    private postsRepository: Repository<Post>,
  ) {}

  async createPostWithTransaction(createPostDto: CreatePostDto) {
    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      // 바데부: 트랜잭션 내에서 여러 작업 수행
      const post = queryRunner.manager.create(Post, createPostDto);
      await queryRunner.manager.save(post);

      // 사용자 포인트 증가 등 추가 작업
      await queryRunner.manager.increment(User, { id: post.authorId }, 'points', 10);

      await queryRunner.commitTransaction();
      return post;
    } catch (error) {
      // 바데부: 에러 발생 시 롤백!
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }
  }
}
```

## 마이그레이션

### 설정 파일 생성

```typescript
// ormconfig.ts
import { DataSource } from 'typeorm';

export default new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'badebu',
  password: 'password123',
  database: 'badebu_db',
  entities: ['src/**/*.entity.ts'],
  migrations: ['src/migrations/*.ts'],
  synchronize: false,  // 프로덕션에서는 false
});
```

### 마이그레이션 명령어

```bash
# 마이그레이션 생성
npm run typeorm migration:generate -- -n CreateUsersTable

# 마이그레이션 실행
npm run typeorm migration:run

# 마이그레이션 되돌리기
npm run typeorm migration:revert
```

## 연습 문제

1. `Category` 엔티티를 만들고 `Post`와 Many-to-One 관계를 설정해보세요
2. 게시글 검색 기능을 구현해보세요 (제목, 내용, 작성자)
3. 좋아요 기능을 위한 Many-to-Many 관계를 추가해보세요 (`User` ↔ `Post`)

## 다음 챕터 예고

다음 챕터에서는 **DTO와 유효성 검증**을 배워 안전한 데이터 처리 방법을 알아봅니다!

## 핵심 정리

- TypeORM: TypeScript ORM 라이브러리
- Entity: `@Entity()` 데코레이터로 테이블 정의
- Repository: 데이터베이스 작업 수행
- Relations: OneToMany, ManyToOne, ManyToMany
- QueryBuilder: 복잡한 쿼리 작성
- Transaction: 여러 작업을 하나의 단위로

바데부와 함께 데이터베이스를 마스터했습니다!

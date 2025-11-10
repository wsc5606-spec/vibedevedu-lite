# Chapter 7: Docker Compose

## 학습 목표
- Docker Compose가 무엇인지 이해하기
- docker-compose.yml 작성 방법 배우기
- 멀티 컨테이너 애플리케이션 관리하기
- 개발 환경 효율적으로 구축하기

---

## Docker Compose란?

바데부와 함께 편리한 도구를 배워봅시다! 🎼

### 문제점: 복잡한 명령어

```bash
# 데이터베이스
docker run -d --name db --network mynet -e POSTGRES_PASSWORD=secret postgres

# 백엔드
docker run -d --name api --network mynet -p 3000:3000 -v $(pwd):/app myapi

# 프론트엔드
docker run -d --name web --network mynet -p 80:80 nginx

# 매번 이렇게 타이핑...? 😫
```

### 해결책: Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret

  api:
    build: ./api
    ports:
      - "3000:3000"
    volumes:
      - ./api:/app

  web:
    image: nginx
    ports:
      - "80:80"
```

```bash
# 한 줄로 실행! ✨
docker compose up
```

---

## Docker Compose 설치

### Docker Desktop (Windows/Mac)

Docker Compose는 Docker Desktop에 포함되어 있습니다!

```bash
# 버전 확인
docker compose version
# Docker Compose version v2.23.0
```

### Linux 설치

```bash
# 최신 버전 다운로드
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 실행 권한 부여
sudo chmod +x /usr/local/bin/docker-compose

# 확인
docker-compose --version
```

---

## docker-compose.yml 기본 구조

바데부의 YAML 가이드! 📝

### 기본 템플릿

```yaml
version: '3.8'  # Compose 파일 버전

services:       # 컨테이너 정의
  service1:     # 서비스 이름
    # 설정...
  service2:
    # 설정...

networks:       # 네트워크 정의 (선택)
  # 설정...

volumes:        # 볼륨 정의 (선택)
  # 설정...
```

### 첫 번째 예제

```yaml
version: '3.8'

services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
```

**실행:**
```bash
# 시작
docker compose up

# 백그라운드 실행
docker compose up -d

# 중지 및 삭제
docker compose down
```

---

## 서비스 정의하기

### image - 이미지 지정

```yaml
services:
  db:
    image: postgres:15

  cache:
    image: redis:7-alpine

  web:
    image: nginx:latest
```

### build - 이미지 빌드

```yaml
services:
  api:
    build: .  # 현재 디렉토리의 Dockerfile 사용

  frontend:
    build:
      context: ./frontend      # 빌드 컨텍스트
      dockerfile: Dockerfile   # Dockerfile 이름
      args:                    # 빌드 인자
        NODE_VERSION: 18
```

### container_name - 컨테이너 이름

```yaml
services:
  db:
    image: postgres
    container_name: badebu-postgres  # 이름 지정
```

### ports - 포트 매핑

```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"              # 호스트:컨테이너
      - "8443:443"
      - "127.0.0.1:3000:3000"  # IP 지정
```

### environment - 환경 변수

```yaml
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret
      POSTGRES_USER: badebu
      POSTGRES_DB: myapp

    # 또는 리스트 형식
    # environment:
    #   - POSTGRES_PASSWORD=secret
    #   - POSTGRES_USER=badebu
```

### env_file - 환경 변수 파일

**.env:**
```
DB_PASSWORD=secret
DB_USER=badebu
DB_NAME=myapp
```

**docker-compose.yml:**
```yaml
services:
  db:
    image: postgres
    env_file:
      - .env
```

### volumes - 볼륨 마운트

```yaml
services:
  web:
    image: nginx
    volumes:
      # 명명된 볼륨
      - data:/var/lib/data

      # 바인드 마운트
      - ./html:/usr/share/nginx/html

      # 읽기 전용
      - ./config:/etc/nginx:ro

volumes:
  data:  # 명명된 볼륨 정의
```

### depends_on - 의존성

```yaml
services:
  web:
    image: nginx
    depends_on:
      - api
      - db

  api:
    image: myapi
    depends_on:
      - db

  db:
    image: postgres
```

**주의:**
- 시작 순서만 보장
- 서비스가 준비되었는지는 보장 안 함

### networks - 네트워크

```yaml
services:
  web:
    image: nginx
    networks:
      - frontend

  api:
    image: myapi
    networks:
      - frontend
      - backend

  db:
    image: postgres
    networks:
      - backend

networks:
  frontend:
  backend:
```

### restart - 재시작 정책

```yaml
services:
  web:
    image: nginx
    restart: always
    # no: 재시작 안 함 (기본값)
    # always: 항상 재시작
    # on-failure: 실패 시만
    # unless-stopped: 수동 중지 전까지
```

### command - 명령어 오버라이드

```yaml
services:
  app:
    image: node:18
    command: npm start

    # 또는 리스트 형식
    # command: ["npm", "start"]
```

---

## 실전 예제

### 예제 1: WordPress + MySQL

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  db:
    image: mysql:8
    container_name: badebu-wp-db
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppass
    restart: always

  wordpress:
    image: wordpress:latest
    container_name: badebu-wordpress
    depends_on:
      - db
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppass
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp_data:/var/www/html
    restart: always

volumes:
  db_data:
  wp_data:
```

**실행:**
```bash
docker compose up -d
# http://localhost:8080 접속
```

### 예제 2: MERN 스택

**프로젝트 구조:**
```
badebu-mern/
├── docker-compose.yml
├── frontend/
│   ├── Dockerfile
│   └── package.json
├── backend/
│   ├── Dockerfile
│   └── server.js
└── .env
```

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  # MongoDB
  mongo:
    image: mongo:7
    container_name: badebu-mongo
    volumes:
      - mongo_data:/data/db
    environment:
      MONGO_INITDB_ROOT_USERNAME: badebu
      MONGO_INITDB_ROOT_PASSWORD: secret
    networks:
      - backend

  # Express Backend
  backend:
    build: ./backend
    container_name: badebu-backend
    depends_on:
      - mongo
    ports:
      - "5000:5000"
    environment:
      NODE_ENV: development
      MONGO_URL: mongodb://badebu:secret@mongo:27017/myapp
    volumes:
      - ./backend:/app
      - /app/node_modules
    networks:
      - backend
      - frontend
    command: npm run dev

  # React Frontend
  frontend:
    build: ./frontend
    container_name: badebu-frontend
    depends_on:
      - backend
    ports:
      - "3000:3000"
    environment:
      REACT_APP_API_URL: http://localhost:5000
    volumes:
      - ./frontend:/app
      - /app/node_modules
    networks:
      - frontend
    command: npm start

networks:
  frontend:
  backend:

volumes:
  mongo_data:
```

**backend/Dockerfile:**
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 5000
CMD ["npm", "run", "dev"]
```

**frontend/Dockerfile:**
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["npm", "start"]
```

**.env:**
```
MONGO_USERNAME=badebu
MONGO_PASSWORD=secret
NODE_ENV=development
```

**실행:**
```bash
docker compose up -d
# Frontend: http://localhost:3000
# Backend: http://localhost:5000
```

### 예제 3: 마이크로서비스 아키텍처

```yaml
version: '3.8'

services:
  # Nginx 리버스 프록시
  nginx:
    image: nginx:alpine
    container_name: badebu-gateway
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - user-service
      - product-service
      - order-service
    networks:
      - frontend

  # 사용자 서비스
  user-service:
    build: ./services/user
    container_name: badebu-user-service
    environment:
      DB_HOST: user-db
      REDIS_HOST: cache
    depends_on:
      - user-db
      - cache
    networks:
      - frontend
      - backend

  # 상품 서비스
  product-service:
    build: ./services/product
    container_name: badebu-product-service
    environment:
      DB_HOST: product-db
      REDIS_HOST: cache
    depends_on:
      - product-db
      - cache
    networks:
      - frontend
      - backend

  # 주문 서비스
  order-service:
    build: ./services/order
    container_name: badebu-order-service
    environment:
      DB_HOST: order-db
      REDIS_HOST: cache
    depends_on:
      - order-db
      - cache
    networks:
      - frontend
      - backend

  # 데이터베이스들
  user-db:
    image: postgres:15
    environment:
      POSTGRES_DB: users
      POSTGRES_PASSWORD: secret
    volumes:
      - user_db_data:/var/lib/postgresql/data
    networks:
      - backend

  product-db:
    image: postgres:15
    environment:
      POSTGRES_DB: products
      POSTGRES_PASSWORD: secret
    volumes:
      - product_db_data:/var/lib/postgresql/data
    networks:
      - backend

  order-db:
    image: postgres:15
    environment:
      POSTGRES_DB: orders
      POSTGRES_PASSWORD: secret
    volumes:
      - order_db_data:/var/lib/postgresql/data
    networks:
      - backend

  # Redis 캐시
  cache:
    image: redis:7-alpine
    networks:
      - backend

networks:
  frontend:
  backend:

volumes:
  user_db_data:
  product_db_data:
  order_db_data:
```

---

## Docker Compose 명령어

바데부의 Compose 명령어 모음! 🎯

### 기본 명령어

```bash
# 시작 (포어그라운드)
docker compose up

# 시작 (백그라운드)
docker compose up -d

# 특정 서비스만 시작
docker compose up web db

# 빌드 후 시작
docker compose up --build

# 강제 재생성
docker compose up --force-recreate

# 중지
docker compose stop

# 중지 및 삭제
docker compose down

# 볼륨도 함께 삭제
docker compose down -v

# 이미지도 함께 삭제
docker compose down --rmi all
```

### 서비스 관리

```bash
# 서비스 시작
docker compose start

# 서비스 중지
docker compose stop

# 서비스 재시작
docker compose restart

# 특정 서비스만
docker compose restart web
```

### 로그 확인

```bash
# 전체 로그
docker compose logs

# 실시간 로그
docker compose logs -f

# 특정 서비스 로그
docker compose logs web

# 마지막 n줄
docker compose logs --tail 50 web
```

### 실행 중인 서비스 확인

```bash
# 프로세스 목록
docker compose ps

# 상세 정보
docker compose ps -a
```

### 명령어 실행

```bash
# 서비스에서 명령어 실행
docker compose exec web bash

# 새 컨테이너로 실행
docker compose run web npm install

# 일회성 실행 (자동 삭제)
docker compose run --rm web npm test
```

### 스케일링

```bash
# 서비스 복제
docker compose up -d --scale web=3

# web 서비스가 3개 실행됨
```

### 설정 확인

```bash
# 설정 파일 유효성 검사
docker compose config

# 최종 설정 출력
docker compose config
```

---

## 환경별 설정

바데부의 환경 분리 전략! 🌍

### docker-compose.override.yml

**docker-compose.yml (공통):**
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
```

**docker-compose.override.yml (개발, 자동 로드):**
```yaml
version: '3.8'

services:
  web:
    volumes:
      - ./src:/app/src
    environment:
      NODE_ENV: development
    command: npm run dev
```

**docker-compose.prod.yml (프로덕션):**
```yaml
version: '3.8'

services:
  web:
    environment:
      NODE_ENV: production
    restart: always
    command: npm start
```

**사용:**
```bash
# 개발 (자동으로 override 적용)
docker compose up

# 프로덕션
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

### .env 파일 활용

**.env:**
```
# 데이터베이스
DB_HOST=db
DB_PORT=5432
DB_NAME=myapp
DB_USER=badebu
DB_PASSWORD=secret

# 애플리케이션
NODE_ENV=development
PORT=3000
```

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}

  api:
    build: .
    environment:
      NODE_ENV: ${NODE_ENV}
      DB_HOST: ${DB_HOST}
      DB_PORT: ${DB_PORT}
    ports:
      - "${PORT}:3000"
```

---

## 실습 문제

### 문제 1: Flask + Redis 카운터

**app.py:**
```python
from flask import Flask
import redis

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = cache.incr('hits')
    return f'바데부 방문자: {count}명'

if __name__ == '__main__':
    app.run(host='0.0.0.0')
```

**docker-compose.yml 작성:**
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis

  redis:
    image: redis:7-alpine
```

### 문제 2: Nginx + PHP-FPM

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/var/www/html
      - ./nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - php

  php:
    image: php:8-fpm-alpine
    volumes:
      - ./html:/var/www/html
```

---

## 바데부의 팁! 💡

### 1. 파일명 규칙

```
docker-compose.yml           # 기본 설정
docker-compose.override.yml  # 개발 오버라이드
docker-compose.prod.yml      # 프로덕션
docker-compose.test.yml      # 테스트
```

### 2. 개발 환경 최적화

```yaml
services:
  app:
    build:
      target: development  # 멀티 스테이지 빌드
    volumes:
      - ./src:/app/src
      - /app/node_modules  # 호스트 node_modules 제외
    environment:
      - NODE_ENV=development
```

### 3. 헬스체크 추가

```yaml
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 3s
      retries: 3
      start_period: 40s
```

### 4. 리소스 제한

```yaml
services:
  web:
    image: nginx
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
```

### 5. 빠른 별칭

```bash
# ~/.bashrc
alias dcup='docker compose up -d'
alias dcdown='docker compose down'
alias dclogs='docker compose logs -f'
alias dcps='docker compose ps'
alias dcexec='docker compose exec'
```

---

## 핵심 요약

1. **Docker Compose**
   - 멀티 컨테이너 앱 관리
   - YAML로 정의
   - 한 번에 시작/중지

2. **주요 설정**
   - `image` / `build`: 이미지
   - `ports`: 포트 매핑
   - `volumes`: 볼륨
   - `environment`: 환경 변수
   - `depends_on`: 의존성
   - `networks`: 네트워크

3. **주요 명령어**
   - `up`: 시작
   - `down`: 중지 및 삭제
   - `logs`: 로그 확인
   - `exec`: 명령어 실행

4. **베스트 프랙티스**
   - 환경별 파일 분리
   - .env 활용
   - 헬스체크 추가
   - 볼륨으로 데이터 영구화

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **멀티 스테이지 빌드**를 배워보겠습니다!
- 이미지 크기 최적화
- 빌드와 런타임 분리
- 보안 향상
- 프로덕션 배포

계속 화이팅! 🚀

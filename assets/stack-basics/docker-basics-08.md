# Chapter 8: 멀티 스테이지 빌드

## 학습 목표
- 멀티 스테이지 빌드 개념 이해하기
- 이미지 크기 최적화하기
- 빌드와 런타임 환경 분리하기
- 보안과 성능 향상시키기

---

## 멀티 스테이지 빌드란?

바데부와 함께 효율적인 이미지를 만들어봅시다! 🏗️

### 문제: 비대한 이미지

**기존 방식:**
```dockerfile
FROM node:18

WORKDIR /app

# 빌드 도구 설치
RUN apt-get update && apt-get install -y python3 make g++

# 소스 복사
COPY package*.json ./
RUN npm install

COPY . .

# 빌드
RUN npm run build

# 실행
CMD ["node", "dist/server.js"]
```

**문제점:**
```
- 이미지 크기: 1.5GB 😱
- 빌드 도구 포함 (불필요)
- node_modules 전체 포함
- 소스 코드 포함 (보안 위험)
```

### 해결: 멀티 스테이지 빌드

```dockerfile
# 빌드 스테이지
FROM node:18 AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# 프로덕션 스테이지
FROM node:18-alpine

WORKDIR /app

# 빌드된 결과물만 복사
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

CMD ["node", "dist/server.js"]
```

**결과:**
```
- 이미지 크기: 180MB ✨
- 빌드 도구 제외
- 프로덕션 의존성만
- 소스 코드 제외
```

---

## 기본 문법

### FROM ... AS

```dockerfile
# 스테이지 이름 지정
FROM 이미지명 AS 스테이지명

# 예시
FROM node:18 AS build
FROM golang:1.21 AS builder
FROM python:3.11 AS compile
```

### COPY --from

```dockerfile
# 다른 스테이지에서 복사
COPY --from=스테이지명 소스 목적지

# 예시
COPY --from=builder /app/dist ./dist
COPY --from=build /app/build ./public
```

---

## 실전 예제

### 예제 1: Node.js 애플리케이션

**프로젝트 구조:**
```
badebu-node-app/
├── Dockerfile
├── package.json
├── tsconfig.json
└── src/
    └── server.ts
```

**기존 방식 (비효율):**
```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 3000
CMD ["node", "dist/server.js"]

# 결과: 1.2GB
```

**멀티 스테이지 (최적화):**
```dockerfile
# 스테이지 1: 빌드
FROM node:18 AS builder

WORKDIR /app

# 의존성 설치
COPY package*.json ./
RUN npm ci --only=production && \
    npm ci --only=development

# 소스 빌드
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

# 스테이지 2: 프로덕션
FROM node:18-alpine

WORKDIR /app

# 프로덕션 의존성만
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

# 빌드된 파일만 복사
COPY --from=builder /app/dist ./dist

# 비루트 사용자
USER node

EXPOSE 3000
CMD ["node", "dist/server.js"]

# 결과: 180MB ✨
```

**빌드 및 실행:**
```bash
docker build -t badebu/node-app:optimized .
docker run -d -p 3000:3000 badebu/node-app:optimized

# 크기 비교
docker images badebu/node-app
```

### 예제 2: React 애플리케이션

**프로젝트 구조:**
```
badebu-react-app/
├── Dockerfile
├── package.json
├── public/
└── src/
```

**Dockerfile (3단계):**
```dockerfile
# 스테이지 1: 의존성 설치
FROM node:18-alpine AS dependencies

WORKDIR /app

COPY package*.json ./
RUN npm ci --production=false

# 스테이지 2: 빌드
FROM node:18-alpine AS builder

WORKDIR /app

# 의존성 복사
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

# 빌드
RUN npm run build

# 스테이지 3: 프로덕션 서빙
FROM nginx:alpine

# Nginx 설정
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 빌드된 정적 파일만 복사
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# 결과: 25MB! 🎉
```

**nginx.conf:**
```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 예제 3: Go 애플리케이션

**main.go:**
```go
package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "안녕하세요, 바데부입니다! (Go 버전)")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("서버 시작: http://localhost:8080")
    http.ListenAndServe(":8080", nil)
}
```

**Dockerfile (초최적화):**
```dockerfile
# 스테이지 1: 빌드
FROM golang:1.21-alpine AS builder

WORKDIR /app

# 의존성 다운로드
COPY go.mod go.sum ./
RUN go mod download

# 소스 복사 및 빌드
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

# 스테이지 2: 프로덕션
FROM scratch

# CA 인증서 (HTTPS 요청용)
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# 빌드된 바이너리만 복사
COPY --from=builder /app/server /server

EXPOSE 8080
CMD ["/server"]

# 결과: 6MB! 😱✨
```

**빌드:**
```bash
docker build -t badebu/go-app:minimal .
docker images badebu/go-app

# REPOSITORY        TAG       SIZE
# badebu/go-app    minimal   6MB
```

### 예제 4: Python Flask 애플리케이션

**app.py:**
```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({
        'message': '안녕하세요!',
        'developer': '바데부',
        'framework': 'Flask'
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

**requirements.txt:**
```
Flask==3.0.0
gunicorn==21.2.0
```

**Dockerfile:**
```dockerfile
# 스테이지 1: 빌드
FROM python:3.11 AS builder

WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# 스테이지 2: 프로덕션
FROM python:3.11-slim

WORKDIR /app

# 빌드된 패키지 복사
COPY --from=builder /root/.local /root/.local

# 소스 복사
COPY app.py .

# PATH 설정
ENV PATH=/root/.local/bin:$PATH

# 비루트 사용자
RUN useradd -m badebu
USER badebu

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

# python:3.11 = 1GB
# python:3.11-slim = 180MB ✨
```

---

## 고급 패턴

### 패턴 1: 의존성 캐싱

```dockerfile
# 의존성 변경 시에만 재설치
FROM node:18 AS deps

WORKDIR /app

# package.json만 먼저 복사
COPY package*.json ./
RUN npm ci

# 빌드 스테이지
FROM node:18 AS builder

WORKDIR /app

# 의존성 복사 (캐시 활용)
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build

# 프로덕션
FROM node:18-alpine

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD ["node", "dist/server.js"]
```

### 패턴 2: 개발 vs 프로덕션

```dockerfile
# 공통 베이스
FROM node:18 AS base

WORKDIR /app
COPY package*.json ./

# 개발 스테이지
FROM base AS development

RUN npm install
COPY . .
CMD ["npm", "run", "dev"]

# 빌드 스테이지
FROM base AS builder

RUN npm ci
COPY . .
RUN npm run build

# 프로덕션 스테이지
FROM node:18-alpine AS production

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

CMD ["node", "dist/server.js"]
```

**사용:**
```bash
# 개발
docker build --target development -t myapp:dev .

# 프로덕션
docker build --target production -t myapp:prod .
```

### 패턴 3: 테스트 스테이지

```dockerfile
# 의존성
FROM node:18 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# 테스트 스테이지
FROM deps AS test
COPY . .
RUN npm run lint
RUN npm run test

# 빌드 스테이지
FROM deps AS builder
COPY . .
RUN npm run build

# 프로덕션 (테스트 통과 후에만 도달)
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/server.js"]
```

---

## 외부 이미지에서 복사

```dockerfile
# 다른 이미지에서 파일 복사
FROM alpine

# Nginx 이미지에서 바이너리 복사
COPY --from=nginx:alpine /usr/sbin/nginx /usr/sbin/nginx
COPY --from=nginx:alpine /usr/lib/ /usr/lib/

# 사용 예시
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
```

---

## Docker Compose에서 멀티 스테이지

```yaml
version: '3.8'

services:
  # 개발 환경
  app-dev:
    build:
      context: .
      target: development
    volumes:
      - ./src:/app/src
    ports:
      - "3000:3000"

  # 프로덕션 환경
  app-prod:
    build:
      context: .
      target: production
    ports:
      - "3000:3000"
    restart: always
```

---

## 크기 비교

바데부의 최적화 결과! 📊

### Node.js 앱

```
일반 빌드:        1.2GB
슬림 베이스:      400MB
멀티 스테이지:    180MB
Alpine 기반:      150MB

86% 감소! 🎉
```

### Go 앱

```
일반 빌드:        800MB
멀티 스테이지:    15MB
Scratch 기반:     6MB

99% 감소! 😱
```

### Python 앱

```
python:3.11:      1GB
python:3.11-slim: 180MB
멀티 스테이지:    150MB

85% 감소! 🚀
```

---

## 실습 문제

### 문제 1: Java Spring Boot 최적화

**원본 (비효율):**
```dockerfile
FROM openjdk:17

WORKDIR /app
COPY . .

RUN ./mvnw package
CMD ["java", "-jar", "target/app.jar"]
```

**최적화 버전:**
```dockerfile
# 빌드
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

# 프로덕션
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

### 문제 2: Rust 애플리케이션

```dockerfile
# 빌드
FROM rust:1.74 AS builder

WORKDIR /app
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release

COPY src ./src
RUN cargo build --release

# 프로덕션
FROM debian:bookworm-slim

COPY --from=builder /app/target/release/myapp /usr/local/bin/

CMD ["myapp"]
```

---

## 바데부의 팁! 💡

### 1. 레이어 순서 최적화

```dockerfile
# 나쁜 예
FROM node:18
COPY . .
RUN npm install

# 좋은 예
FROM node:18
COPY package*.json ./
RUN npm install
COPY . .
```

### 2. .dockerignore 활용

```
node_modules
npm-debug.log
.git
.env
*.md
tests/
.vscode/
```

### 3. 빌드 캐시 활용

```bash
# 레지스트리에서 캐시 가져오기
docker build --cache-from myapp:latest -t myapp:new .

# 빌드킷 사용 (더 효율적)
DOCKER_BUILDKIT=1 docker build -t myapp .
```

### 4. 보안 스캔

```bash
# 취약점 스캔
docker scan badebu/app:latest

# Trivy 사용
trivy image badebu/app:latest
```

### 5. 크기 분석

```bash
# 레이어별 크기 확인
docker history badebu/app:latest

# Dive 도구 사용
dive badebu/app:latest
```

---

## 베스트 프랙티스

### 1. 적절한 베이스 이미지

```dockerfile
# 일반 개발
FROM node:18

# 프로덕션 (권장)
FROM node:18-alpine

# 초경량 (가능하면)
FROM alpine
# 또는
FROM scratch
```

### 2. 최소 권한 원칙

```dockerfile
FROM node:18-alpine

# 비루트 사용자 생성
RUN addgroup -S badebu && adduser -S badebu -G badebu

# 권한 설정
COPY --chown=badebu:badebu . .

USER badebu
```

### 3. 멀티 아키텍처 지원

```dockerfile
# ARM64, AMD64 모두 지원
FROM --platform=$BUILDPLATFORM node:18-alpine AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN echo "빌드 플랫폼: $BUILDPLATFORM"
RUN echo "타겟 플랫폼: $TARGETPLATFORM"
```

```bash
# 빌드
docker buildx build --platform linux/amd64,linux/arm64 -t myapp .
```

### 4. 헬스체크 추가

```dockerfile
FROM node:18-alpine

COPY . .

HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js || exit 1

CMD ["node", "server.js"]
```

---

## 핵심 요약

1. **멀티 스테이지 빌드**
   - 여러 FROM 사용
   - COPY --from으로 선택적 복사
   - 이미지 크기 대폭 감소

2. **주요 장점**
   - 크기 최적화 (80-99% 감소)
   - 보안 향상 (불필요한 도구 제외)
   - 빌드 캐시 효율
   - 명확한 단계 분리

3. **일반적인 패턴**
   - 빌드 → 프로덕션
   - 의존성 → 빌드 → 프로덕션
   - 의존성 → 테스트 → 빌드 → 프로덕션

4. **베스트 프랙티스**
   - Alpine 또는 Slim 베이스
   - 의존성 캐싱
   - .dockerignore 활용
   - 비루트 사용자

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **Docker Hub와 레지스트리**를 배워보겠습니다!
- 이미지 저장소
- 이미지 푸시/풀
- 프라이빗 레지스트리
- CI/CD 연동

계속 화이팅! 🚀

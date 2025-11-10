# Chapter 3: Dockerfile 작성하기

## 학습 목표
- Dockerfile이 무엇인지 이해하기
- Dockerfile 기본 문법 배우기
- 나만의 Docker 이미지 만들기
- 효율적인 이미지 빌드 방법 익히기

---

## Dockerfile이란?

바데부와 함께 나만의 이미지를 만들어봅시다! 🏗️

### Dockerfile의 정의

Dockerfile은 Docker 이미지를 만들기 위한 **레시피(설명서)**입니다.

```
Dockerfile = 이미지 빌드 자동화 스크립트
           = 재현 가능한 빌드 프로세스
           = 인프라를 코드로 관리 (IaC)
```

### 왜 Dockerfile을 사용할까?

**수동 방식:**
```bash
# 매번 반복...
1. 베이스 이미지로 컨테이너 실행
2. 필요한 패키지 설치
3. 애플리케이션 복사
4. 설정 변경
5. 컨테이너를 이미지로 커밋
```

**Dockerfile 방식:**
```bash
# 한 번만 작성
1. Dockerfile 작성
2. docker build 실행
3. 완료! ✨

# 재빌드도 간단
docker build .
```

---

## 첫 Dockerfile 만들기

바데부의 간단한 Python 앱으로 시작해봅시다!

### 1. 프로젝트 폴더 생성

```bash
mkdir badebu-python-app
cd badebu-python-app
```

### 2. Python 애플리케이션 작성

**app.py**
```python
# 바데부의 간단한 웹 서버
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return '''
    <h1>안녕하세요! 바데부입니다! 👋</h1>
    <p>Docker로 실행되는 Flask 앱이에요!</p>
    '''

@app.route('/about')
def about():
    return '바데부와 함께하는 Docker 학습'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### 3. 의존성 파일 작성

**requirements.txt**
```
Flask==3.0.0
```

### 4. Dockerfile 작성

**Dockerfile**
```dockerfile
# 베이스 이미지 지정
FROM python:3.11-slim

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일 복사
COPY requirements.txt .

# 의존성 설치
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션 코드 복사
COPY app.py .

# 컨테이너 실행 시 사용할 포트
EXPOSE 5000

# 컨테이너 시작 명령어
CMD ["python", "app.py"]
```

### 5. 이미지 빌드

```bash
docker build -t badebu/python-app:1.0 .
```

**명령어 설명:**
- `build`: 이미지 빌드
- `-t badebu/python-app:1.0`: 태그 지정
- `.`: 현재 디렉토리의 Dockerfile 사용

### 6. 컨테이너 실행

```bash
docker run -d -p 5000:5000 --name badebu-app badebu/python-app:1.0
```

### 7. 테스트

```bash
# 브라우저에서 열기
# http://localhost:5000

# 또는 curl로 테스트
curl http://localhost:5000
```

성공! 🎉

---

## Dockerfile 기본 명령어

바데부의 Dockerfile 치트시트! 📋

### FROM - 베이스 이미지

```dockerfile
# 기본 형식
FROM 이미지명:태그

# 예시
FROM python:3.11
FROM node:18-alpine
FROM ubuntu:22.04

# 멀티 스테이지 빌드 (나중에 배울 거예요!)
FROM python:3.11 AS builder
```

**특징:**
- Dockerfile의 첫 번째 명령어 (주석 제외)
- 모든 이미지는 베이스 이미지 위에 구축됨

### WORKDIR - 작업 디렉토리

```dockerfile
# 기본 형식
WORKDIR /경로

# 예시
WORKDIR /app
WORKDIR /home/badebu/project

# 상대 경로 사용 가능
WORKDIR /app
WORKDIR backend  # 실제 경로: /app/backend
```

**특징:**
- 이후 명령어의 실행 위치 지정
- 디렉토리가 없으면 자동 생성
- `cd` 대신 사용

### COPY - 파일 복사

```dockerfile
# 기본 형식
COPY 소스 목적지

# 예시
COPY app.py .
COPY requirements.txt /app/
COPY . /app
COPY src/ /app/src/

# 여러 파일 복사
COPY package*.json ./

# 특정 파일만 복사
COPY ["app.py", "config.json", "/app/"]
```

**특징:**
- 호스트의 파일/디렉토리를 이미지에 복사
- 빌드 컨텍스트 내의 파일만 복사 가능

### ADD - 파일 추가

```dockerfile
# 기본 형식
ADD 소스 목적지

# 예시
ADD app.py /app/
ADD archive.tar.gz /app/  # 자동으로 압축 해제!
ADD https://example.com/file.txt /app/  # URL에서 다운로드
```

**COPY vs ADD:**
- `COPY`: 단순 복사만 (권장)
- `ADD`: 압축 해제, URL 다운로드 기능 (특별한 경우만)

### RUN - 명령어 실행

```dockerfile
# 기본 형식
RUN 명령어

# 예시
RUN apt-get update && apt-get install -y curl
RUN pip install -r requirements.txt
RUN npm install

# 여러 줄로 작성 (가독성 향상)
RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        vim && \
    rm -rf /var/lib/apt/lists/*
```

**특징:**
- 이미지 빌드 시 실행
- 각 RUN 명령어는 새로운 레이어 생성
- 레이어 최소화를 위해 명령어 합치기 권장

### CMD - 기본 실행 명령어

```dockerfile
# 형식 1: exec 형식 (권장)
CMD ["실행파일", "매개변수1", "매개변수2"]

# 형식 2: shell 형식
CMD 명령어 매개변수

# 예시
CMD ["python", "app.py"]
CMD ["node", "server.js"]
CMD ["npm", "start"]
CMD python app.py  # shell 형식
```

**특징:**
- 컨테이너 시작 시 실행할 기본 명령어
- Dockerfile에 하나만 존재 (마지막 CMD가 적용)
- `docker run` 시 덮어쓰기 가능

### ENTRYPOINT - 실행 진입점

```dockerfile
# 형식 1: exec 형식 (권장)
ENTRYPOINT ["실행파일", "매개변수"]

# 형식 2: shell 형식
ENTRYPOINT 명령어

# 예시
ENTRYPOINT ["python", "app.py"]
ENTRYPOINT ["node"]

# CMD와 함께 사용
ENTRYPOINT ["python"]
CMD ["app.py"]
# 실행: python app.py
```

**CMD vs ENTRYPOINT:**

```dockerfile
# CMD만 사용
CMD ["python", "app.py"]
# docker run 시: 전체 명령어 변경 가능

# ENTRYPOINT 사용
ENTRYPOINT ["python", "app.py"]
# docker run 시: 추가 인자만 전달 가능
# docker run image --debug
# 실행: python app.py --debug
```

### ENV - 환경 변수

```dockerfile
# 기본 형식
ENV 키=값

# 예시
ENV NODE_ENV=production
ENV PORT=3000
ENV APP_HOME=/app

# 여러 개 설정
ENV NODE_ENV=production \
    PORT=3000 \
    DEBUG=false
```

**사용 예시:**
```dockerfile
ENV APP_HOME=/app
WORKDIR $APP_HOME
# 실제 경로: /app
```

### EXPOSE - 포트 노출

```dockerfile
# 기본 형식
EXPOSE 포트번호

# 예시
EXPOSE 80
EXPOSE 3000
EXPOSE 8080/tcp
EXPOSE 53/udp
```

**주의:**
- 문서화 목적 (실제로 포트를 열진 않음)
- 실제 포트 매핑은 `docker run -p` 사용

### LABEL - 메타데이터

```dockerfile
# 기본 형식
LABEL 키=값

# 예시
LABEL maintainer="badebu@example.com"
LABEL version="1.0"
LABEL description="바데부의 Python 앱"

# 여러 개 설정
LABEL maintainer="badebu@example.com" \
      version="1.0" \
      description="Docker 학습용 앱"
```

### USER - 실행 사용자

```dockerfile
# 기본 형식
USER 사용자명 또는 UID

# 예시
USER node
USER 1001
USER badebu:badebu  # 사용자:그룹
```

**보안 모범 사례:**
```dockerfile
# root로 실행하지 않기!
FROM node:18-alpine

# 비특권 사용자 생성
RUN addgroup -S badebu && adduser -S badebu -G badebu

# 사용자 변경
USER badebu

# 이후 명령어는 badebu 권한으로 실행
```

### VOLUME - 볼륨 마운트

```dockerfile
# 기본 형식
VOLUME ["경로"]

# 예시
VOLUME ["/data"]
VOLUME ["/app/logs", "/app/uploads"]
```

### ARG - 빌드 인자

```dockerfile
# 기본 형식
ARG 변수명=기본값

# 예시
ARG PYTHON_VERSION=3.11
ARG APP_ENV=development

FROM python:${PYTHON_VERSION}

ENV APP_ENVIRONMENT=${APP_ENV}
```

**빌드 시 값 전달:**
```bash
docker build --build-arg PYTHON_VERSION=3.12 -t myapp .
```

---

## 실전 예제

바데부의 다양한 Dockerfile 예제들! 💼

### 예제 1: Node.js 앱

**프로젝트 구조:**
```
badebu-node-app/
├── Dockerfile
├── package.json
├── package-lock.json
└── server.js
```

**server.js**
```javascript
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({
        message: '안녕하세요, 바데부입니다!',
        environment: process.env.NODE_ENV
    });
});

app.listen(PORT, () => {
    console.log(`바데부의 서버가 포트 ${PORT}에서 실행 중입니다!`);
});
```

**package.json**
```json
{
  "name": "badebu-node-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
```

**Dockerfile**
```dockerfile
FROM node:18-alpine

# 바데부 정보
LABEL maintainer="badebu@example.com"
LABEL description="바데부의 Node.js Express 앱"

# 작업 디렉토리
WORKDIR /app

# 의존성 파일 복사 (캐시 활용)
COPY package*.json ./

# 의존성 설치
RUN npm ci --only=production

# 소스 코드 복사
COPY server.js .

# 환경 변수
ENV NODE_ENV=production \
    PORT=3000

# 포트 노출
EXPOSE 3000

# 비특권 사용자로 전환
USER node

# 앱 실행
CMD ["npm", "start"]
```

**빌드 및 실행:**
```bash
docker build -t badebu/node-app:1.0 .
docker run -d -p 3000:3000 --name badebu-node badebu/node-app:1.0
curl http://localhost:3000
```

### 예제 2: Python FastAPI 앱

**프로젝트 구조:**
```
badebu-fastapi/
├── Dockerfile
├── requirements.txt
└── main.py
```

**main.py**
```python
from fastapi import FastAPI
import uvicorn

app = FastAPI(title="바데부의 FastAPI")

@app.get("/")
def read_root():
    return {
        "message": "안녕하세요!",
        "developer": "바데부",
        "framework": "FastAPI"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

**requirements.txt**
```
fastapi==0.104.1
uvicorn[standard]==0.24.0
```

**Dockerfile**
```dockerfile
FROM python:3.11-slim

# 메타데이터
LABEL maintainer="badebu@example.com"
LABEL description="바데부의 FastAPI 애플리케이션"

# 환경 변수
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# 작업 디렉토리
WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 소스 코드 복사
COPY main.py .

# 비루트 사용자 생성 및 전환
RUN useradd -m -u 1000 badebu && \
    chown -R badebu:badebu /app
USER badebu

# 포트 노출
EXPOSE 8000

# 헬스체크
HEALTHCHECK --interval=30s --timeout=3s \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

# 앱 실행
CMD ["python", "main.py"]
```

**빌드 및 실행:**
```bash
docker build -t badebu/fastapi:1.0 .
docker run -d -p 8000:8000 --name badebu-api badebu/fastapi:1.0

# API 문서 확인
# http://localhost:8000/docs
```

### 예제 3: Static 웹사이트 (Nginx)

**프로젝트 구조:**
```
badebu-website/
├── Dockerfile
└── html/
    ├── index.html
    └── style.css
```

**html/index.html**
```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>바데부의 웹사이트</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>안녕하세요! 바데부입니다! 👋</h1>
    <p>Docker로 배포한 정적 웹사이트입니다.</p>
</body>
</html>
```

**html/style.css**
```css
body {
    font-family: Arial, sans-serif;
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f0f0f0;
}

h1 {
    color: #2196F3;
}
```

**Dockerfile**
```dockerfile
FROM nginx:alpine

# 메타데이터
LABEL maintainer="badebu@example.com"

# 정적 파일 복사
COPY html/ /usr/share/nginx/html/

# Nginx 설정 (선택사항)
# COPY nginx.conf /etc/nginx/nginx.conf

# 포트 노출
EXPOSE 80

# Nginx는 자동으로 실행됨 (베이스 이미지에 정의)
```

**빌드 및 실행:**
```bash
docker build -t badebu/website:1.0 .
docker run -d -p 8080:80 --name badebu-site badebu/website:1.0
```

---

## .dockerignore 파일

바데부가 불필요한 파일을 제외하는 방법을 알려드릴게요!

### .dockerignore란?

`.gitignore`와 비슷하게, Docker 빌드 시 제외할 파일을 지정합니다.

**프로젝트 구조:**
```
badebu-app/
├── .dockerignore   ← 이거!
├── Dockerfile
├── node_modules/
├── .git/
├── README.md
└── src/
```

### .dockerignore 예시

```
# 의존성 디렉토리
node_modules/
__pycache__/
*.pyc

# Git
.git/
.gitignore

# 환경 변수 (보안!)
.env
.env.local
*.env

# 로그
*.log
logs/

# 테스트
tests/
*.test.js

# 문서
README.md
docs/

# IDE 설정
.vscode/
.idea/
*.swp

# OS 파일
.DS_Store
Thumbs.db

# Docker 관련
Dockerfile*
docker-compose*.yml
```

### 효과

```bash
# .dockerignore 없이
빌드 컨텍스트: 500MB (node_modules 포함)

# .dockerignore 사용
빌드 컨텍스트: 5MB (소스 코드만)

# 빌드 속도 10배 향상! ⚡
```

---

## 이미지 최적화 팁

바데부의 효율적인 Dockerfile 작성 비법! 🎯

### 1. 레이어 캐싱 활용

**나쁜 예:**
```dockerfile
FROM python:3.11-slim
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
```

코드 변경 시 의존성까지 재설치! 😢

**좋은 예:**
```dockerfile
FROM python:3.11-slim
WORKDIR /app

# 의존성만 먼저 복사
COPY requirements.txt .
RUN pip install -r requirements.txt

# 소스 코드는 나중에
COPY . .
```

코드 변경 시 의존성은 캐시 사용! ✨

### 2. 명령어 합치기

**나쁜 예:**
```dockerfile
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get clean
```

레이어 4개 생성! 😢

**좋은 예:**
```dockerfile
RUN apt-get update && \
    apt-get install -y \
        curl \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

레이어 1개로 줄임! ✨

### 3. 경량 베이스 이미지 사용

```dockerfile
# 일반 이미지
FROM node:18          # 1.1GB

# Slim 이미지
FROM node:18-slim     # 240MB

# Alpine 이미지
FROM node:18-alpine   # 180MB
```

### 4. 멀티 스테이지 빌드 (다음 챕터에서!)

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
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/server.js"]
```

---

## 실습 문제

### 문제 1: Go 웹 서버 Dockerfile

**main.go**
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

**작성할 Dockerfile:**
```dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY main.go .

RUN go build -o server main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/server .

EXPOSE 8080
CMD ["./server"]
```

### 문제 2: 개선하기

다음 Dockerfile을 최적화하세요:

**원본:**
```dockerfile
FROM ubuntu:latest
COPY . /app
RUN apt-get update
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN pip3 install flask
WORKDIR /app
CMD python3 app.py
```

**개선안:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# 의존성 먼저
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 소스 코드는 나중에
COPY . .

# 비루트 사용자
USER nobody

CMD ["python", "app.py"]
```

---

## 바데부의 팁! 💡

### 1. 빌드 캐시 무시

```bash
# 캐시 사용 안 함
docker build --no-cache -t myapp .

# 특정 시점부터 캐시 무시
docker build --pull -t myapp .
```

### 2. 빌드 로그 상세히 보기

```bash
docker build --progress=plain -t myapp .
```

### 3. 빌드 아규먼트 활용

```dockerfile
ARG PYTHON_VERSION=3.11
FROM python:${PYTHON_VERSION}-slim
```

```bash
docker build --build-arg PYTHON_VERSION=3.12 -t myapp .
```

---

## 핵심 요약

1. **Dockerfile = 이미지 빌드 레시피**
   - 재현 가능한 빌드 프로세스
   - 버전 관리 가능

2. **주요 명령어**
   - `FROM`: 베이스 이미지
   - `COPY`: 파일 복사
   - `RUN`: 명령어 실행
   - `CMD`: 컨테이너 시작 명령어
   - `EXPOSE`: 포트 문서화

3. **최적화 원칙**
   - 레이어 캐싱 활용
   - 명령어 합치기
   - 경량 베이스 이미지
   - .dockerignore 사용

4. **보안**
   - 비루트 사용자 사용
   - 민감 정보 제외
   - 최신 베이스 이미지

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **Docker 명령어**를 깊이 있게 배워보겠습니다!
- run, stop, remove, exec
- 컨테이너 로그 관리
- 리소스 제한
- 디버깅 기법

계속 화이팅! 🚀

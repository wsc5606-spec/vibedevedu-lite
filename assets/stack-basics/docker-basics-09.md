# Chapter 9: Docker Hub와 레지스트리

## 학습 목표
- Docker Hub 사용법 익히기
- 이미지 태깅과 버전 관리하기
- 프라이빗 레지스트리 구축하기
- CI/CD 파이프라인과 연동하기

---

## Docker Hub란?

바데부와 함께 이미지 저장소를 배워봅시다! 🐳

### Docker Hub의 역할

```
Docker Hub = Docker 이미지의 GitHub
           = 공유 및 배포 플랫폼
           = 퍼블릭 + 프라이빗 저장소
```

**주요 기능:**
- 이미지 호스팅
- 자동 빌드
- 버전 관리
- 팀 협업
- 웹훅 연동

**주소:**
```
https://hub.docker.com
```

---

## Docker Hub 시작하기

### 1. 계정 생성

```bash
# 회원가입
https://hub.docker.com/signup

# 바데부의 계정
Username: badebu
Email: badebu@example.com
```

### 2. 로그인

```bash
# CLI에서 로그인
docker login

# 출력:
# Username: badebu
# Password: ****
# Login Succeeded
```

### 3. 로그아웃

```bash
docker logout
```

---

## 이미지 태깅

바데부의 태깅 전략! 🏷️

### 기본 태그 형식

```
레지스트리/사용자명/이미지명:태그

예시:
docker.io/badebu/myapp:latest
docker.io/badebu/myapp:1.0.0
docker.io/badebu/myapp:1.0.0-alpine
```

**구성 요소:**
- `docker.io`: 레지스트리 (기본값, 생략 가능)
- `badebu`: 사용자명 또는 조직명
- `myapp`: 이미지명
- `latest`: 태그 (생략 시 기본값)

### 이미지 태깅하기

```bash
# 방법 1: 빌드 시 태그
docker build -t badebu/myapp:1.0 .

# 방법 2: 기존 이미지에 태그 추가
docker tag myapp:latest badebu/myapp:1.0

# 방법 3: 여러 태그 동시에
docker build -t badebu/myapp:latest -t badebu/myapp:1.0 -t badebu/myapp:stable .
```

### 태그 명명 규칙

**시맨틱 버저닝:**
```bash
badebu/myapp:1.0.0        # 메이저.마이너.패치
badebu/myapp:1.0          # 마이너 버전
badebu/myapp:1            # 메이저 버전
badebu/myapp:latest       # 최신 (권장 안 함 in production)
```

**환경별:**
```bash
badebu/myapp:prod
badebu/myapp:staging
badebu/myapp:dev
```

**날짜 기반:**
```bash
badebu/myapp:2024-01-15
badebu/myapp:20240115-abc123
```

**Git 커밋 기반:**
```bash
badebu/myapp:abc123         # 짧은 커밋 해시
badebu/myapp:main-abc123    # 브랜치-커밋
badebu/myapp:v1.0.0         # Git 태그
```

**베이스 이미지 변형:**
```bash
badebu/myapp:1.0-alpine
badebu/myapp:1.0-slim
badebu/myapp:1.0-debian
```

---

## 이미지 푸시 (Push)

### 기본 푸시

```bash
# 1. 로그인
docker login

# 2. 이미지 빌드 및 태그
docker build -t badebu/myapp:1.0 .

# 3. Docker Hub에 푸시
docker push badebu/myapp:1.0
```

**출력:**
```
The push refers to repository [docker.io/badebu/myapp]
abc123def456: Pushed
789ghi012jkl: Pushed
345mno678pqr: Pushed
1.0: digest: sha256:abc123... size: 1234
```

### 여러 태그 푸시

```bash
# 여러 태그 생성
docker tag badebu/myapp:1.0 badebu/myapp:latest
docker tag badebu/myapp:1.0 badebu/myapp:stable

# 모두 푸시
docker push badebu/myapp:1.0
docker push badebu/myapp:latest
docker push badebu/myapp:stable

# 또는 --all-tags 사용
docker push --all-tags badebu/myapp
```

---

## 이미지 풀 (Pull)

### 기본 풀

```bash
# 최신 버전
docker pull badebu/myapp

# 특정 버전
docker pull badebu/myapp:1.0

# 다이제스트로 풀 (불변)
docker pull badebu/myapp@sha256:abc123def456...
```

### 자동 풀

```bash
# run 시 자동 풀
docker run badebu/myapp:1.0

# 이미지가 로컬에 없으면 자동으로 Docker Hub에서 다운로드
```

---

## 실전 예제: 완전한 워크플로우

바데부의 프로젝트 배포! 🚀

### 프로젝트 구조

```
badebu-web-app/
├── Dockerfile
├── package.json
├── src/
└── .dockerignore
```

### 1. Dockerfile 작성

```dockerfile
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### 2. 이미지 빌드

```bash
# 버전 정보
VERSION="1.0.0"
GIT_COMMIT=$(git rev-parse --short HEAD)

# 빌드
docker build -t badebu/web-app:$VERSION \
             -t badebu/web-app:$VERSION-$GIT_COMMIT \
             -t badebu/web-app:latest .
```

### 3. 로컬 테스트

```bash
# 실행
docker run -d -p 3000:3000 --name test-app badebu/web-app:$VERSION

# 테스트
curl http://localhost:3000

# 중지
docker stop test-app
docker rm test-app
```

### 4. Docker Hub에 푸시

```bash
# 로그인
docker login

# 푸시
docker push badebu/web-app:$VERSION
docker push badebu/web-app:$VERSION-$GIT_COMMIT
docker push badebu/web-app:latest
```

### 5. 서버에서 배포

```bash
# 서버에 SSH 접속
ssh user@production-server

# 풀 및 실행
docker pull badebu/web-app:1.0.0
docker stop old-app || true
docker rm old-app || true
docker run -d \
  --name production-app \
  --restart unless-stopped \
  -p 80:3000 \
  badebu/web-app:1.0.0
```

---

## 자동 빌드 (Automated Builds)

### Docker Hub 자동 빌드 설정

**1. GitHub 연동:**
```
Docker Hub → Account Settings → Linked Accounts → GitHub
```

**2. 자동 빌드 설정:**
```
Repositories → Create → Create Automated Build
- GitHub 저장소 선택
- 빌드 규칙 설정
```

**3. 빌드 규칙 예시:**
```
Source Type   | Source         | Docker Tag     | Dockerfile
------------- | -------------- | -------------- | -----------
Branch        | main           | latest         | Dockerfile
Branch        | develop        | dev            | Dockerfile
Tag           | /^v[0-9.]+$/   | {sourceref}    | Dockerfile
```

---

## 프라이빗 레지스트리

바데부의 자체 레지스트리 구축! 🏢

### 방법 1: Docker Hub 프라이빗 저장소

```bash
# 프라이빗 저장소 생성 (Docker Hub 웹에서)
# Free plan: 1개 프라이빗 저장소
# Pro plan: 무제한 프라이빗 저장소

# 푸시 (동일한 방식)
docker push badebu/private-app:1.0

# 풀 (로그인 필요)
docker login
docker pull badebu/private-app:1.0
```

### 방법 2: 로컬 레지스트리 구축

```bash
# 1. 레지스트리 컨테이너 실행
docker run -d \
  -p 5000:5000 \
  --name badebu-registry \
  --restart always \
  -v registry-data:/var/lib/registry \
  registry:2

# 2. 이미지 태그
docker tag myapp localhost:5000/myapp:1.0

# 3. 로컬 레지스트리에 푸시
docker push localhost:5000/myapp:1.0

# 4. 로컬 레지스트리에서 풀
docker pull localhost:5000/myapp:1.0
```

### 방법 3: 보안 레지스트리 (HTTPS)

**htpasswd 인증:**
```bash
# 1. 인증 파일 생성
mkdir -p auth
docker run --rm \
  --entrypoint htpasswd \
  registry:2 -Bbn badebu password > auth/htpasswd

# 2. SSL 인증서 준비
mkdir -p certs
# SSL 인증서를 certs/ 디렉토리에 배치

# 3. 보안 레지스트리 실행
docker run -d \
  -p 443:443 \
  --name secure-registry \
  --restart always \
  -v $(pwd)/auth:/auth \
  -v $(pwd)/certs:/certs \
  -v registry-data:/var/lib/registry \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Badebu Registry" \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2

# 4. 로그인
docker login registry.badebu.com
```

---

## 레지스트리 API

### 이미지 목록 조회

```bash
# 로컬 레지스트리 이미지 목록
curl http://localhost:5000/v2/_catalog

# 출력:
# {"repositories":["myapp","web-app","api"]}
```

### 태그 목록 조회

```bash
# 특정 이미지의 태그 목록
curl http://localhost:5000/v2/myapp/tags/list

# 출력:
# {"name":"myapp","tags":["1.0","1.1","latest"]}
```

### 이미지 삭제

```bash
# 1. 다이제스트 확인
curl -I -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
  http://localhost:5000/v2/myapp/manifests/1.0

# 2. 삭제
curl -X DELETE http://localhost:5000/v2/myapp/manifests/sha256:abc123...
```

---

## CI/CD 연동

바데부의 자동화 파이프라인! 🔄

### GitHub Actions 예시

**.github/workflows/docker.yml:**
```yaml
name: Docker Build and Push

on:
  push:
    branches: [ main ]
    tags: [ 'v*' ]

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Docker 메타데이터
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: badebu/myapp
          tags: |
            type=ref,event=branch
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha,prefix={{branch}}-

      - name: Docker Hub 로그인
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: 빌드 및 푸시
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```

### GitLab CI 예시

**.gitlab-ci.yml:**
```yaml
stages:
  - build
  - deploy

variables:
  IMAGE_NAME: badebu/myapp

build:
  stage: build
  image: docker:latest
  services:
    - docker:dind
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD
  script:
    - docker build -t $IMAGE_NAME:$CI_COMMIT_SHORT_SHA .
    - docker tag $IMAGE_NAME:$CI_COMMIT_SHORT_SHA $IMAGE_NAME:latest
    - docker push $IMAGE_NAME:$CI_COMMIT_SHORT_SHA
    - docker push $IMAGE_NAME:latest
  only:
    - main
```

### Jenkins Pipeline 예시

**Jenkinsfile:**
```groovy
pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'badebu/myapp'
        DOCKER_CREDENTIALS = credentials('docker-hub')
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
                    sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    sh "echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
```

---

## Docker Compose로 레지스트리 구축

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  registry:
    image: registry:2
    container_name: badebu-registry
    ports:
      - "5000:5000"
    volumes:
      - registry-data:/var/lib/registry
      - ./auth:/auth
    environment:
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: "Badebu Registry"
    restart: always

  registry-ui:
    image: joxit/docker-registry-ui:latest
    container_name: badebu-registry-ui
    ports:
      - "8080:80"
    environment:
      REGISTRY_TITLE: "바데부의 프라이빗 레지스트리"
      REGISTRY_URL: http://registry:5000
      SINGLE_REGISTRY: "true"
    depends_on:
      - registry

volumes:
  registry-data:
```

**실행:**
```bash
docker compose up -d

# UI 접속
# http://localhost:8080
```

---

## 다른 레지스트리 사용

### AWS ECR (Elastic Container Registry)

```bash
# 1. 로그인
aws ecr get-login-password --region ap-northeast-2 | \
  docker login --username AWS --password-stdin \
  123456789012.dkr.ecr.ap-northeast-2.amazonaws.com

# 2. 푸시
docker tag myapp:latest \
  123456789012.dkr.ecr.ap-northeast-2.amazonaws.com/badebu/myapp:latest

docker push \
  123456789012.dkr.ecr.ap-northeast-2.amazonaws.com/badebu/myapp:latest
```

### Google Container Registry (GCR)

```bash
# 1. 인증
gcloud auth configure-docker

# 2. 푸시
docker tag myapp:latest gcr.io/my-project/badebu/myapp:latest
docker push gcr.io/my-project/badebu/myapp:latest
```

### Azure Container Registry (ACR)

```bash
# 1. 로그인
az acr login --name myregistry

# 2. 푸시
docker tag myapp:latest myregistry.azurecr.io/badebu/myapp:latest
docker push myregistry.azurecr.io/badebu/myapp:latest
```

### GitHub Container Registry (GHCR)

```bash
# 1. 로그인
echo $GITHUB_TOKEN | docker login ghcr.io -u badebu --password-stdin

# 2. 푸시
docker tag myapp:latest ghcr.io/badebu/myapp:latest
docker push ghcr.io/badebu/myapp:latest
```

---

## 실습 문제

### 문제 1: 버전 태깅 자동화

**tag-and-push.sh:**
```bash
#!/bin/bash

IMAGE_NAME="badebu/myapp"
VERSION=$(cat package.json | grep version | cut -d'"' -f4)
GIT_COMMIT=$(git rev-parse --short HEAD)

echo "빌드 중: $IMAGE_NAME:$VERSION"

docker build \
  -t $IMAGE_NAME:$VERSION \
  -t $IMAGE_NAME:$VERSION-$GIT_COMMIT \
  -t $IMAGE_NAME:latest .

echo "Docker Hub에 푸시 중..."
docker push $IMAGE_NAME:$VERSION
docker push $IMAGE_NAME:$VERSION-$GIT_COMMIT
docker push $IMAGE_NAME:latest

echo "완료! 🎉"
```

### 문제 2: 레지스트리 미러 설정

```bash
# /etc/docker/daemon.json
{
  "registry-mirrors": ["https://mirror.gcr.io"]
}

# Docker 재시작
sudo systemctl restart docker
```

---

## 바데부의 팁! 💡

### 1. latest 태그 주의

```bash
# 프로덕션에서는 명시적 버전 사용
docker pull badebu/myapp:1.0.0  # ✅ 좋음
docker pull badebu/myapp:latest # ❌ 나쁨 (예측 불가)
```

### 2. 이미지 서명

```bash
# Docker Content Trust 활성화
export DOCKER_CONTENT_TRUST=1

# 푸시 시 자동 서명
docker push badebu/myapp:1.0
```

### 3. 태그 정리

```bash
# 오래된 태그 정리 스크립트
#!/bin/bash
REPO="badebu/myapp"
KEEP_LAST=10

docker images --format "{{.Tag}}" $REPO | \
  tail -n +$((KEEP_LAST+1)) | \
  xargs -I {} docker rmi $REPO:{}
```

### 4. 멀티 아키텍처 이미지

```bash
# buildx로 멀티 플랫폼 빌드
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t badebu/myapp:1.0 \
  --push .
```

---

## 핵심 요약

1. **Docker Hub**
   - 공개 이미지 저장소
   - 무료 퍼블릭 무제한
   - 프라이빗 저장소 (유료)
   - 자동 빌드 지원

2. **태깅 전략**
   - 시맨틱 버저닝
   - Git 커밋 해시
   - latest는 개발 환경만

3. **프라이빗 레지스트리**
   - 자체 구축 가능
   - 클라우드 레지스트리
   - 보안 인증 필수

4. **CI/CD 연동**
   - 자동 빌드 및 푸시
   - 버전 관리 자동화
   - 배포 파이프라인

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **프로덕션 배포와 모범 사례**를 배워보겠습니다!
- 보안 강화
- 모니터링
- 로깅
- 성능 최적화

마지막 챕터! 화이팅! 🚀

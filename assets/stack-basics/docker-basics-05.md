# Chapter 5: 볼륨과 데이터 관리

## 학습 목표
- Docker 볼륨의 필요성 이해하기
- 볼륨, 바인드 마운트, tmpfs 차이점 알기
- 컨테이너 데이터 영구 저장하기
- 백업 및 복원 전략 배우기

---

## 왜 볼륨이 필요한가?

바데부가 컨테이너의 데이터 문제를 설명해드릴게요! 🗄️

### 컨테이너의 임시성

```bash
# 컨테이너 생성 및 데이터 작성
docker run -it --name badebu-test ubuntu bash
echo "바데부의 중요한 데이터" > /data.txt
exit

# 컨테이너 삭제
docker rm badebu-test

# 데이터도 함께 사라짐! 😱
```

**문제점:**
- 컨테이너는 임시적
- 삭제하면 내부 데이터도 사라짐
- 컨테이너 업데이트 시 데이터 손실

**해결책: 볼륨!**
```
컨테이너 (임시) → 볼륨 (영구)
데이터를 호스트에 저장! ✨
```

---

## 데이터 저장 방법 3가지

### 1. 볼륨 (Volume) - 추천! ⭐

```
Docker가 관리하는 영역
/var/lib/docker/volumes/

장점:
✓ Docker가 관리
✓ 크로스 플랫폼 호환
✓ 백업 쉬움
✓ 여러 컨테이너 공유 가능
```

### 2. 바인드 마운트 (Bind Mount)

```
호스트의 특정 경로를 그대로 마운트

장점:
✓ 호스트 파일 시스템 직접 접근
✓ 개발 중 실시간 반영

단점:
✗ 호스트 경로에 의존
✗ 이식성 낮음
```

### 3. tmpfs 마운트 (메모리)

```
메모리에 임시 저장

사용 사례:
- 민감한 정보 임시 저장
- 성능이 중요한 캐시
```

---

## 볼륨 (Volume) 사용하기

바데부와 함께 볼륨을 만들어봅시다!

### 볼륨 생성

```bash
# 볼륨 생성
docker volume create badebu-data

# 볼륨 목록 확인
docker volume ls

# 출력:
# DRIVER    VOLUME NAME
# local     badebu-data
```

### 볼륨 상세 정보

```bash
docker volume inspect badebu-data
```

**출력:**
```json
[
    {
        "CreatedAt": "2024-01-15T10:30:00Z",
        "Driver": "local",
        "Mountpoint": "/var/lib/docker/volumes/badebu-data/_data",
        "Name": "badebu-data",
        "Options": {},
        "Scope": "local"
    }
]
```

### 볼륨 사용

```bash
# 볼륨 마운트
docker run -d \
  --name badebu-web \
  -v badebu-data:/app/data \
  nginx

# 여러 볼륨 마운트
docker run -d \
  --name badebu-app \
  -v badebu-data:/app/data \
  -v badebu-logs:/app/logs \
  -v badebu-config:/app/config \
  myapp
```

### 실전 예제: PostgreSQL

```bash
# 1. 볼륨 생성
docker volume create badebu-postgres-data

# 2. 데이터베이스 컨테이너 실행
docker run -d \
  --name badebu-db \
  -e POSTGRES_PASSWORD=mysecret \
  -e POSTGRES_USER=badebu \
  -v badebu-postgres-data:/var/lib/postgresql/data \
  postgres:15

# 3. 데이터베이스 사용
docker exec -it badebu-db psql -U badebu

# 4. 테이블 생성 및 데이터 입력
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO users (name, email)
VALUES ('바데부', 'badebu@example.com');

# 5. 컨테이너 삭제
docker stop badebu-db
docker rm badebu-db

# 6. 새 컨테이너로 다시 실행
docker run -d \
  --name badebu-db-new \
  -e POSTGRES_PASSWORD=mysecret \
  -e POSTGRES_USER=badebu \
  -v badebu-postgres-data:/var/lib/postgresql/data \
  postgres:15

# 7. 데이터 확인 - 살아있음! ✨
docker exec -it badebu-db-new psql -U badebu -c "SELECT * FROM users;"
```

### 익명 볼륨

```bash
# 이름 없는 볼륨 자동 생성
docker run -v /app/data nginx

# 볼륨 확인
docker volume ls
# DRIVER    VOLUME NAME
# local     a1b2c3d4e5f6...  ← 랜덤 이름
```

**주의:**
- 컨테이너 삭제 시 볼륨 남아있음
- `docker rm -v`로 함께 삭제 가능

---

## 바인드 마운트 (Bind Mount)

바데부의 개발 환경 설정법! 💻

### 기본 사용법

```bash
# 절대 경로로 마운트
docker run -v /host/path:/container/path image

# Windows
docker run -v C:/Users/badebu/project:/app node

# Linux/Mac
docker run -v /home/badebu/project:/app node
```

### 실전 예제: Node.js 개발

**프로젝트 구조:**
```
badebu-node-project/
├── package.json
├── server.js
└── node_modules/
```

**개발 환경 실행:**
```bash
# 1. 현재 디렉토리 마운트
docker run -it --rm \
  --name badebu-dev \
  -v $(pwd):/app \
  -w /app \
  -p 3000:3000 \
  node:18 \
  bash

# 2. 컨테이너 내부에서
npm install
npm start

# 3. 호스트에서 코드 수정 → 즉시 반영! ✨
```

**더 나은 방법 (nodemon 사용):**
```bash
docker run -d \
  --name badebu-dev \
  -v $(pwd):/app \
  -w /app \
  -p 3000:3000 \
  node:18 \
  bash -c "npm install && npm install -g nodemon && nodemon server.js"
```

### 읽기 전용 마운트

```bash
# 읽기 전용 (:ro)
docker run -v $(pwd)/config:/app/config:ro nginx

# 컨테이너 내부에서 수정 불가
docker exec badebu-web sh -c "echo 'test' > /app/config/app.conf"
# 에러: Read-only file system
```

### 실전 예제: Nginx 정적 사이트

```bash
# 1. HTML 파일 생성
mkdir -p ~/badebu-site/html
cat > ~/badebu-site/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>바데부의 사이트</title>
</head>
<body>
    <h1>안녕하세요, 바데부입니다!</h1>
    <p>바인드 마운트로 실시간 업데이트!</p>
</body>
</html>
EOF

# 2. Nginx 실행
docker run -d \
  --name badebu-site \
  -p 8080:80 \
  -v ~/badebu-site/html:/usr/share/nginx/html:ro \
  nginx

# 3. 브라우저에서 확인
# http://localhost:8080

# 4. HTML 수정 → 즉시 반영! ✨
echo "<h2>업데이트됨!</h2>" >> ~/badebu-site/html/index.html
```

---

## tmpfs 마운트 (메모리)

### 사용법

```bash
# tmpfs 마운트
docker run -d \
  --name badebu-cache \
  --tmpfs /app/cache:rw,size=100m \
  myapp

# 또는 --mount 문법
docker run -d \
  --name badebu-cache \
  --mount type=tmpfs,destination=/app/cache,tmpfs-size=100m \
  myapp
```

### 사용 사례

```bash
# 1. 세션 캐시
docker run -d \
  --tmpfs /tmp:size=500m \
  redis

# 2. 빌드 캐시
docker run --rm \
  --tmpfs /tmp:size=2g \
  -v $(pwd):/app \
  -w /app \
  node:18 \
  npm run build
```

---

## --mount 플래그 (권장 문법)

바데부가 추천하는 명시적 문법! 📝

### 볼륨 마운트

```bash
docker run -d \
  --name badebu-app \
  --mount type=volume,source=badebu-data,target=/app/data \
  myapp
```

### 바인드 마운트

```bash
docker run -d \
  --name badebu-dev \
  --mount type=bind,source=$(pwd),target=/app,readonly \
  myapp
```

### tmpfs 마운트

```bash
docker run -d \
  --name badebu-cache \
  --mount type=tmpfs,target=/app/cache,tmpfs-size=100m \
  myapp
```

### -v vs --mount 비교

**-v (간단)**
```bash
docker run -v badebu-data:/app/data myapp
```

**--mount (명시적, 권장)**
```bash
docker run --mount type=volume,source=badebu-data,target=/app/data myapp
```

---

## 볼륨 관리

바데부의 볼륨 관리 가이드! 🗂️

### 볼륨 목록

```bash
# 전체 볼륨
docker volume ls

# 필터링
docker volume ls --filter dangling=true  # 사용되지 않는 볼륨
docker volume ls --filter name=badebu    # 이름으로 검색
```

### 볼륨 삭제

```bash
# 특정 볼륨 삭제
docker volume rm badebu-data

# 사용되지 않는 모든 볼륨 삭제
docker volume prune

# 확인 없이 삭제
docker volume prune -f

# 특정 기간 이상 사용 안 한 볼륨만
docker volume prune --filter "label!=keep"
```

### 볼륨 사용 확인

```bash
# 어느 컨테이너가 사용 중인지 확인
docker ps -a --filter volume=badebu-data
```

---

## 데이터 백업 및 복원

바데부의 백업 전략! 💾

### 방법 1: 컨테이너를 통한 백업

```bash
# 1. 볼륨 백업
docker run --rm \
  -v badebu-data:/data \
  -v $(pwd):/backup \
  ubuntu \
  tar czf /backup/badebu-data-backup.tar.gz -C /data .

# 설명:
# - badebu-data 볼륨을 /data에 마운트
# - 현재 디렉토리를 /backup에 마운트
# - tar로 압축하여 백업
```

### 방법 2: 컨테이너를 통한 복원

```bash
# 1. 새 볼륨 생성
docker volume create badebu-data-restored

# 2. 백업 파일에서 복원
docker run --rm \
  -v badebu-data-restored:/data \
  -v $(pwd):/backup \
  ubuntu \
  tar xzf /backup/badebu-data-backup.tar.gz -C /data
```

### 실전 예제: PostgreSQL 백업

```bash
# 1. 데이터베이스 백업 (SQL 덤프)
docker exec badebu-db pg_dump -U badebu myapp > backup.sql

# 2. 데이터베이스 복원
docker exec -i badebu-db psql -U badebu myapp < backup.sql

# 3. 볼륨 전체 백업 (파일 시스템 레벨)
docker run --rm \
  -v badebu-postgres-data:/data \
  -v $(pwd):/backup \
  ubuntu \
  tar czf /backup/postgres-backup-$(date +%Y%m%d).tar.gz -C /data .
```

### 백업 자동화 스크립트

```bash
#!/bin/bash
# backup-volumes.sh

VOLUME_NAME=$1
BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -z "$VOLUME_NAME" ]; then
    echo "사용법: ./backup-volumes.sh 볼륨명"
    exit 1
fi

mkdir -p $BACKUP_DIR

echo "백업 시작: $VOLUME_NAME"
docker run --rm \
  -v $VOLUME_NAME:/data \
  -v $(pwd)/$BACKUP_DIR:/backup \
  ubuntu \
  tar czf /backup/${VOLUME_NAME}-${TIMESTAMP}.tar.gz -C /data .

echo "백업 완료: $BACKUP_DIR/${VOLUME_NAME}-${TIMESTAMP}.tar.gz"
```

**사용:**
```bash
chmod +x backup-volumes.sh
./backup-volumes.sh badebu-data
```

---

## 컨테이너 간 데이터 공유

### 볼륨 공유

```bash
# 1. 공유 볼륨 생성
docker volume create badebu-shared

# 2. 첫 번째 컨테이너 (쓰기)
docker run -d \
  --name writer \
  -v badebu-shared:/data \
  alpine \
  sh -c "while true; do date > /data/timestamp.txt; sleep 5; done"

# 3. 두 번째 컨테이너 (읽기)
docker run -d \
  --name reader \
  -v badebu-shared:/data:ro \
  alpine \
  sh -c "while true; do cat /data/timestamp.txt; sleep 5; done"

# 4. 로그 확인
docker logs -f reader
```

### 데이터 볼륨 컨테이너 (레거시)

```bash
# 데이터 전용 컨테이너 (구식 방법, 권장 안 함)
docker create -v /data --name badebu-data-container alpine

# 다른 컨테이너에서 볼륨 사용
docker run --volumes-from badebu-data-container alpine ls /data
```

---

## 실전 시나리오

### 시나리오 1: 개발 환경 설정

```bash
# 바데부의 풀스택 개발 환경

# 1. 프론트엔드 (React)
docker run -d \
  --name badebu-frontend \
  -v $(pwd)/frontend:/app \
  -w /app \
  -p 3000:3000 \
  node:18 \
  bash -c "npm install && npm start"

# 2. 백엔드 (Node.js)
docker run -d \
  --name badebu-backend \
  -v $(pwd)/backend:/app \
  -v badebu-node-modules:/app/node_modules \
  -w /app \
  -p 5000:5000 \
  node:18 \
  bash -c "npm install && npm run dev"

# 3. 데이터베이스 (PostgreSQL)
docker run -d \
  --name badebu-db \
  -v badebu-postgres-data:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=dev \
  -p 5432:5432 \
  postgres:15
```

### 시나리오 2: 프로덕션 배포

```bash
# 바데부의 프로덕션 설정

# 1. 애플리케이션
docker run -d \
  --name badebu-app-prod \
  --restart unless-stopped \
  -v badebu-app-data:/app/data \
  -v badebu-app-logs:/app/logs \
  --mount type=bind,source=/etc/ssl/certs,target=/certs,readonly \
  -e NODE_ENV=production \
  -p 3000:3000 \
  badebu/app:latest

# 2. 정기 백업 (cron)
# crontab -e
# 0 2 * * * /usr/local/bin/backup-volumes.sh badebu-app-data
```

---

## 바데부의 팁! 💡

### 1. 볼륨 명명 규칙

```bash
# 프로젝트-용도-환경
badebu-web-data-prod
badebu-db-data-dev
badebu-cache-staging

# 또는
prod-badebu-web-data
dev-badebu-db-data
```

### 2. 개발 vs 프로덕션

**개발:**
```bash
# 바인드 마운트 (실시간 반영)
docker run -v $(pwd):/app myapp
```

**프로덕션:**
```bash
# 볼륨 (성능, 안정성)
docker run -v myapp-data:/app/data myapp
```

### 3. node_modules 문제 해결

```bash
# 문제: 호스트의 node_modules와 충돌

# 해결: 익명 볼륨으로 덮어쓰기
docker run -d \
  -v $(pwd):/app \
  -v /app/node_modules \
  node:18
```

### 4. 볼륨 크기 확인

```bash
# 볼륨이 사용하는 디스크 공간
docker system df -v

# 특정 볼륨 크기
docker volume inspect badebu-data --format '{{.Mountpoint}}' | xargs du -sh
```

### 5. 데이터 마이그레이션

```bash
# 볼륨 간 데이터 복사
docker run --rm \
  -v old-volume:/from \
  -v new-volume:/to \
  alpine \
  sh -c "cp -av /from/. /to/"
```

---

## 핵심 요약

1. **볼륨 (Volume) - 권장**
   - Docker가 관리
   - 영구 데이터 저장
   - 컨테이너 간 공유
   - 백업 쉬움

2. **바인드 마운트**
   - 호스트 파일 시스템 직접 마운트
   - 개발 환경에 유용
   - 실시간 코드 반영

3. **tmpfs**
   - 메모리 저장
   - 임시 데이터, 캐시
   - 컨테이너 종료 시 사라짐

4. **데이터 관리**
   - 정기 백업 필수
   - `docker volume prune`로 정리
   - 명명 규칙 준수

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **네트워킹**을 배워보겠습니다!
- 컨테이너 간 통신
- 네트워크 종류
- 포트 매핑
- DNS 및 서비스 디스커버리

계속 화이팅! 🚀

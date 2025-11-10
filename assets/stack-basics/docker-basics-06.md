# Chapter 6: 네트워킹 (Networks, Port mapping)

## 학습 목표
- Docker 네트워킹 개념 이해하기
- 네트워크 드라이버 종류 알기
- 컨테이너 간 통신 설정하기
- 포트 매핑 마스터하기

---

## Docker 네트워킹 기초

바데부와 함께 컨테이너 통신을 배워봅시다! 🌐

### 왜 네트워킹이 중요한가?

```
실제 애플리케이션 구조:
프론트엔드 ←→ 백엔드 ←→ 데이터베이스
   ↓           ↓           ↓
컨테이너 간 통신이 필요!
```

**예시:**
```bash
# 바데부의 웹 앱
- 웹 서버 (Nginx)
- API 서버 (Node.js)
- 데이터베이스 (PostgreSQL)
- 캐시 (Redis)

모두 통신이 필요! 🔗
```

---

## 네트워크 드라이버 종류

### 1. Bridge (기본값) 🌉

**특징:**
- 가장 일반적인 네트워크 타입
- 같은 호스트의 컨테이너 간 통신
- 기본 bridge 또는 사용자 정의 bridge

```bash
# 자동으로 기본 bridge 네트워크 사용
docker run -d nginx

# 기본 bridge 네트워크 확인
docker network inspect bridge
```

### 2. Host 🏠

**특징:**
- 컨테이너가 호스트 네트워크 직접 사용
- 포트 매핑 불필요
- 성능 좋음

```bash
# 호스트 네트워크 사용
docker run -d --network host nginx

# 포트 80이 직접 호스트에 바인딩됨
curl http://localhost
```

### 3. None 🚫

**특징:**
- 네트워크 없음
- 완전 격리
- 테스트나 보안이 중요한 경우

```bash
docker run -d --network none alpine
```

### 4. Overlay 🌐

**특징:**
- 여러 Docker 호스트 간 통신
- Docker Swarm에서 사용
- 분산 환경

### 5. Macvlan

**특징:**
- 컨테이너에 MAC 주소 할당
- 물리적 네트워크 장치처럼 동작

---

## 기본 bridge vs 사용자 정의 bridge

### 기본 bridge의 한계

```bash
# 컨테이너 2개 실행
docker run -d --name web1 nginx
docker run -d --name web2 nginx

# 컨테이너명으로 통신 불가! ❌
docker exec web1 ping web2
# ping: bad address 'web2'

# IP로만 통신 가능
docker exec web1 ping 172.17.0.3
```

### 사용자 정의 bridge의 장점

```bash
# 1. 네트워크 생성
docker network create badebu-net

# 2. 컨테이너 실행
docker run -d --name web1 --network badebu-net nginx
docker run -d --name web2 --network badebu-net nginx

# 3. 컨테이너명으로 통신 가능! ✅
docker exec web1 ping web2
# PING web2 (172.18.0.3): 56 data bytes
```

**바데부의 추천:**
- 항상 사용자 정의 네트워크 사용
- 자동 DNS 해석
- 더 나은 격리

---

## 네트워크 관리

### 네트워크 생성

```bash
# 기본 생성
docker network create badebu-net

# 서브넷 지정
docker network create --subnet=172.20.0.0/16 badebu-net

# 게이트웨이 지정
docker network create \
  --subnet=172.20.0.0/16 \
  --gateway=172.20.0.1 \
  badebu-net

# 드라이버 지정
docker network create --driver bridge badebu-net
```

### 네트워크 목록

```bash
# 전체 네트워크
docker network ls

# 출력:
# NETWORK ID     NAME          DRIVER    SCOPE
# abc123def456   bridge        bridge    local
# 789ghi012jkl   host          host      local
# 345mno678pqr   badebu-net    bridge    local
```

### 네트워크 상세 정보

```bash
docker network inspect badebu-net
```

**출력 예시:**
```json
[
    {
        "Name": "badebu-net",
        "Driver": "bridge",
        "IPAM": {
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Containers": {
            "abc123": {
                "Name": "web1",
                "IPv4Address": "172.20.0.2/16"
            }
        }
    }
]
```

### 네트워크 삭제

```bash
# 특정 네트워크 삭제
docker network rm badebu-net

# 사용하지 않는 네트워크 정리
docker network prune

# 확인 없이 삭제
docker network prune -f
```

---

## 컨테이너를 네트워크에 연결

### 실행 시 연결

```bash
# --network 옵션 사용
docker run -d --name web --network badebu-net nginx
```

### 기존 컨테이너 연결

```bash
# 네트워크에 연결
docker network connect badebu-net web

# 네트워크에서 연결 해제
docker network disconnect badebu-net web
```

### 여러 네트워크에 연결

```bash
# 컨테이너는 여러 네트워크에 동시 연결 가능
docker network connect frontend-net web
docker network connect backend-net web

# web 컨테이너는 이제 두 네트워크에서 통신 가능
```

---

## 포트 매핑 완벽 가이드

바데부의 포트 매핑 마스터 클래스! 🔌

### 기본 포트 매핑

```bash
# 호스트:컨테이너
docker run -d -p 8080:80 nginx

# 설명:
# 호스트의 8080 포트 → 컨테이너의 80 포트
```

### 여러 포트 매핑

```bash
docker run -d \
  -p 8080:80 \
  -p 8443:443 \
  nginx

# HTTP: 8080 → 80
# HTTPS: 8443 → 443
```

### IP 주소 지정

```bash
# localhost에만 바인딩
docker run -d -p 127.0.0.1:8080:80 nginx

# 특정 IP에 바인딩
docker run -d -p 192.168.1.100:8080:80 nginx

# 모든 IP (기본값)
docker run -d -p 0.0.0.0:8080:80 nginx
```

### 랜덤 포트 할당

```bash
# 호스트 포트 생략
docker run -d -p 80 nginx

# 할당된 포트 확인
docker port 컨테이너명
# 80/tcp -> 0.0.0.0:32768
```

### 모든 EXPOSE 포트 매핑

```bash
# -P (대문자): 모든 EXPOSE 포트를 랜덤 포트에 매핑
docker run -d -P nginx

# 매핑 확인
docker port 컨테이너명
```

### UDP 포트

```bash
# TCP (기본값)
docker run -d -p 8080:80 nginx

# UDP
docker run -d -p 53:53/udp dns-server

# TCP와 UDP 모두
docker run -d -p 53:53/tcp -p 53:53/udp dns-server
```

---

## 실전 예제: 마이크로서비스

바데부의 3-tier 아키텍처! 🏗️

### 프로젝트 구조

```
Frontend (Nginx)
    ↓
Backend (Node.js API)
    ↓
Database (PostgreSQL)
    ↓
Cache (Redis)
```

### 1. 네트워크 생성

```bash
# 프론트엔드-백엔드 네트워크
docker network create frontend-net

# 백엔드-데이터베이스 네트워크
docker network create backend-net
```

### 2. 데이터베이스 실행

```bash
docker run -d \
  --name badebu-db \
  --network backend-net \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_USER=badebu \
  -e POSTGRES_DB=myapp \
  -v badebu-db-data:/var/lib/postgresql/data \
  postgres:15
```

### 3. Redis 캐시 실행

```bash
docker run -d \
  --name badebu-redis \
  --network backend-net \
  redis:7-alpine
```

### 4. 백엔드 API 실행

**api/server.js:**
```javascript
const express = require('express');
const { Pool } = require('pg');
const redis = require('redis');

const app = express();

// PostgreSQL 연결
const pool = new Pool({
  host: 'badebu-db',  // 컨테이너명으로 연결!
  user: 'badebu',
  password: 'secret',
  database: 'myapp'
});

// Redis 연결
const redisClient = redis.createClient({
  url: 'redis://badebu-redis:6379'  // 컨테이너명으로 연결!
});

app.get('/api/users', async (req, res) => {
  const result = await pool.query('SELECT * FROM users');
  res.json(result.rows);
});

app.listen(3000, () => {
  console.log('바데부 API 서버 실행 중: 3000');
});
```

```bash
docker run -d \
  --name badebu-api \
  --network frontend-net \
  --network backend-net \
  -v $(pwd)/api:/app \
  -w /app \
  -e NODE_ENV=production \
  node:18 \
  node server.js
```

### 5. 프론트엔드 실행

**nginx.conf:**
```nginx
upstream api_backend {
    server badebu-api:3000;  # 컨테이너명으로 연결!
}

server {
    listen 80;

    location / {
        root /usr/share/nginx/html;
    }

    location /api/ {
        proxy_pass http://api_backend;
    }
}
```

```bash
docker run -d \
  --name badebu-web \
  --network frontend-net \
  -p 80:80 \
  -v $(pwd)/html:/usr/share/nginx/html \
  -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
  nginx
```

### 6. 통신 테스트

```bash
# 프론트엔드 → 백엔드
curl http://localhost/api/users

# 백엔드 → 데이터베이스
docker exec badebu-api ping badebu-db

# 백엔드 → 캐시
docker exec badebu-api ping badebu-redis
```

---

## DNS와 서비스 디스커버리

### 자동 DNS 해석

```bash
# 사용자 정의 네트워크에서
docker network create badebu-net

docker run -d --name service1 --network badebu-net alpine sleep 1000
docker run -d --name service2 --network badebu-net alpine sleep 1000

# service1에서 service2로 통신
docker exec service1 ping service2
# ✅ 자동으로 IP 해석!
```

### 네트워크 별칭

```bash
# 별칭 지정
docker run -d \
  --name badebu-api \
  --network badebu-net \
  --network-alias api \
  --network-alias backend \
  node:18

# 여러 이름으로 접근 가능
docker exec client ping badebu-api  # ✅
docker exec client ping api         # ✅
docker exec client ping backend     # ✅
```

### 링크 (레거시, 권장 안 함)

```bash
# 구식 방법 (사용 금지)
docker run --link db:database myapp

# 대신 사용자 정의 네트워크 사용!
```

---

## 네트워크 격리와 보안

### 네트워크 분리

```bash
# 프론트엔드만 외부 노출
docker network create public-net
docker network create private-net

# 웹 서버 (외부 접근 가능)
docker run -d \
  --name web \
  --network public-net \
  -p 80:80 \
  nginx

# 데이터베이스 (외부 접근 불가)
docker run -d \
  --name db \
  --network private-net \
  postgres

# API는 양쪽 네트워크에 연결
docker run -d \
  --name api \
  --network public-net \
  --network private-net \
  myapi
```

### 포트 노출 최소화

```bash
# 나쁜 예: 데이터베이스를 외부에 노출
docker run -d -p 5432:5432 postgres  # ❌

# 좋은 예: 네트워크 내부에서만 통신
docker run -d --network backend-net postgres  # ✅
```

---

## 네트워크 디버깅

바데부의 문제 해결 가이드! 🔧

### 1. 네트워크 연결 확인

```bash
# 컨테이너가 어느 네트워크에 연결되어 있나?
docker inspect 컨테이너명 | grep -A 10 Networks

# 또는
docker network inspect 네트워크명
```

### 2. DNS 해석 테스트

```bash
# nslookup 설치 및 테스트
docker exec -it 컨테이너명 sh -c "apk add bind-tools && nslookup 다른컨테이너명"
```

### 3. 연결 테스트

```bash
# ping
docker exec 컨테이너명 ping 다른컨테이너명

# telnet (포트 테스트)
docker exec 컨테이너명 telnet 다른컨테이너명 포트

# curl
docker exec 컨테이너명 curl http://다른컨테이너명:포트
```

### 4. 네트워크 인터페이스 확인

```bash
# 컨테이너 내부에서
docker exec 컨테이너명 ip addr show

# 라우팅 테이블
docker exec 컨테이너명 ip route
```

### 5. 포트 리스닝 확인

```bash
# netstat
docker exec 컨테이너명 netstat -tulpn

# ss (더 빠름)
docker exec 컨테이너명 ss -tulpn
```

---

## 실습 문제

### 문제 1: WordPress + MySQL

WordPress와 MySQL을 네트워크로 연결하세요.

```bash
# 1. 네트워크 생성
docker network create wordpress-net

# 2. MySQL 실행
docker run -d \
  --name wp-mysql \
  --network wordpress-net \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=wppass \
  mysql:8

# 3. WordPress 실행
docker run -d \
  --name wp-site \
  --network wordpress-net \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=wp-mysql \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppass \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress

# 4. 접속 테스트
# http://localhost:8080
```

### 문제 2: 로드 밸런서 설정

Nginx로 여러 백엔드 서버를 로드 밸런싱하세요.

```nginx
# nginx.conf
upstream backend {
    server backend1:3000;
    server backend2:3000;
    server backend3:3000;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend;
    }
}
```

```bash
# 네트워크 생성
docker network create lb-net

# 백엔드 서버 3개
for i in 1 2 3; do
  docker run -d \
    --name backend$i \
    --network lb-net \
    -e SERVER_ID=$i \
    node:18 \
    node -e "
      require('http').createServer((req, res) => {
        res.end('Server $i');
      }).listen(3000);
    "
done

# Nginx 로드 밸런서
docker run -d \
  --name lb \
  --network lb-net \
  -p 80:80 \
  -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
  nginx

# 테스트
for i in {1..6}; do curl http://localhost; echo; done
```

---

## 바데부의 팁! 💡

### 1. 네트워크 명명 규칙

```bash
# 프로젝트-계층-환경
badebu-frontend-prod
badebu-backend-dev
badebu-database-staging
```

### 2. 개발 환경 설정

```bash
# docker-compose.yml (다음 챕터에서!)
networks:
  frontend:
  backend:
```

### 3. 성능 최적화

```bash
# 호스트 네트워크 사용 (성능 중요)
docker run --network host myapp

# 하지만 보안과 격리 trade-off!
```

### 4. 문제 해결 체크리스트

```
1. 컨테이너가 같은 네트워크에 있나?
   → docker network inspect

2. 포트가 올바르게 매핑되었나?
   → docker port

3. 방화벽이 막고 있나?
   → iptables -L

4. DNS가 작동하나?
   → docker exec ping

5. 애플리케이션이 리스닝 중인가?
   → docker exec netstat -tulpn
```

---

## 핵심 요약

1. **네트워크 드라이버**
   - Bridge: 기본, 단일 호스트
   - Host: 호스트 네트워크 직접 사용
   - None: 네트워크 없음

2. **사용자 정의 네트워크**
   - 자동 DNS 해석
   - 컨테이너명으로 통신
   - 더 나은 격리

3. **포트 매핑**
   - `-p 호스트:컨테이너`
   - 필요한 것만 노출
   - 보안 고려

4. **베스트 프랙티스**
   - 항상 사용자 정의 네트워크
   - 네트워크 분리 (보안)
   - 포트 노출 최소화

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **Docker Compose**를 배워보겠습니다!
- 여러 컨테이너 한번에 관리
- YAML로 인프라 정의
- 개발 환경 간편 설정
- 프로덕션 배포

계속 화이팅! 🚀

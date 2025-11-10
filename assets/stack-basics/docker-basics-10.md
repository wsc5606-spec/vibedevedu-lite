# Chapter 10: 프로덕션 배포와 모범 사례

## 학습 목표
- 프로덕션 환경 구성하기
- Docker 보안 강화하기
- 모니터링과 로깅 설정하기
- 성능 최적화 및 트러블슈팅하기

---

## 프로덕션 배포 체크리스트

바데부의 프로덕션 준비 가이드! ✅

### 필수 체크 항목

```
☐ 보안
  ☐ 비루트 사용자 실행
  ☐ 민감 정보 분리 (secrets)
  ☐ 이미지 취약점 스캔
  ☐ 네트워크 격리
  ☐ 읽기 전용 파일시스템

☐ 안정성
  ☐ 재시작 정책 설정
  ☐ 헬스체크 구현
  ☐ 리소스 제한
  ☐ 로깅 설정
  ☐ 백업 전략

☐ 성능
  ☐ 이미지 최적화
  ☐ 레이어 캐싱
  ☐ 멀티 스테이지 빌드
  ☐ 경량 베이스 이미지

☐ 모니터링
  ☐ 컨테이너 메트릭
  ☐ 애플리케이션 로그
  ☐ 알림 설정
  ☐ 성능 추적
```

---

## 보안 강화

### 1. 비루트 사용자 실행

**나쁜 예:**
```dockerfile
FROM node:18
COPY . /app
WORKDIR /app
CMD ["node", "server.js"]
# root로 실행됨! ❌
```

**좋은 예:**
```dockerfile
FROM node:18-alpine

# 애플리케이션 사용자 생성
RUN addgroup -S badebu && adduser -S badebu -G badebu

WORKDIR /app

# 파일 복사 (소유권 설정)
COPY --chown=badebu:badebu package*.json ./
RUN npm ci --only=production

COPY --chown=badebu:badebu . .

# 비루트 사용자로 전환
USER badebu

EXPOSE 3000
CMD ["node", "server.js"]
```

### 2. 읽기 전용 파일시스템

```bash
# 읽기 전용으로 실행
docker run -d \
  --read-only \
  --tmpfs /tmp \
  --name badebu-app \
  badebu/myapp

# 설명:
# --read-only: 파일시스템 읽기 전용
# --tmpfs /tmp: 임시 디렉토리만 쓰기 가능
```

### 3. 민감 정보 관리

**Docker Secrets 사용 (Swarm):**
```bash
# Secret 생성
echo "mysecretpassword" | docker secret create db_password -

# Compose 파일
version: '3.8'

services:
  db:
    image: postgres
    secrets:
      - db_password
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password

secrets:
  db_password:
    external: true
```

**환경 변수 파일:**
```bash
# .env 파일 (Git에 커밋 안 함!)
DB_PASSWORD=secret
API_KEY=abc123

# docker-compose.yml
services:
  app:
    env_file: .env
```

### 4. 컨테이너 권한 제한

```bash
# 불필요한 권한 제거
docker run -d \
  --cap-drop=ALL \
  --cap-add=NET_BIND_SERVICE \
  --security-opt=no-new-privileges \
  badebu/myapp
```

### 5. 이미지 취약점 스캔

```bash
# Docker Hub에서 스캔
docker scan badebu/myapp:1.0

# Trivy 사용
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image badebu/myapp:1.0

# Clair 사용
clair-scanner badebu/myapp:1.0
```

---

## 헬스체크 구현

바데부의 건강 확인 전략! 🏥

### Dockerfile에 헬스체크 추가

```dockerfile
FROM node:18-alpine

WORKDIR /app
COPY . .

EXPOSE 3000

# 헬스체크 설정
HEALTHCHECK --interval=30s \
            --timeout=3s \
            --start-period=5s \
            --retries=3 \
  CMD node healthcheck.js || exit 1

CMD ["node", "server.js"]
```

**healthcheck.js:**
```javascript
const http = require('http');

const options = {
  host: 'localhost',
  port: 3000,
  path: '/health',
  timeout: 2000
};

const request = http.request(options, (res) => {
  if (res.statusCode === 200) {
    process.exit(0);
  } else {
    process.exit(1);
  }
});

request.on('error', () => {
  process.exit(1);
});

request.end();
```

### 헬스체크 엔드포인트

**server.js:**
```javascript
const express = require('express');
const app = express();

// 헬스체크 엔드포인트
app.get('/health', (req, res) => {
  // 데이터베이스 연결 확인
  if (database.isConnected()) {
    res.status(200).json({
      status: 'healthy',
      uptime: process.uptime(),
      timestamp: Date.now()
    });
  } else {
    res.status(503).json({
      status: 'unhealthy',
      error: 'Database connection failed'
    });
  }
});

app.listen(3000);
```

### 헬스체크 상태 확인

```bash
# 컨테이너 상태 확인
docker ps

# CONTAINER ID   STATUS
# abc123         Up 5 minutes (healthy)

# 헬스체크 로그
docker inspect --format='{{json .State.Health}}' badebu-app
```

---

## 리소스 관리

### CPU 제한

```bash
# CPU 개수 제한
docker run -d \
  --cpus=2 \
  badebu/myapp

# CPU 사용률 제한 (50%)
docker run -d \
  --cpus=0.5 \
  badebu/myapp

# CPU 우선순위
docker run -d \
  --cpu-shares=512 \
  badebu/myapp
```

### 메모리 제한

```bash
# 메모리 제한
docker run -d \
  --memory=1g \
  --memory-swap=2g \
  badebu/myapp

# OOM 킬러 비활성화
docker run -d \
  --memory=1g \
  --oom-kill-disable \
  badebu/myapp
```

### Docker Compose에서 리소스 제한

```yaml
version: '3.8'

services:
  web:
    image: badebu/myapp
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
```

---

## 로깅 전략

바데부의 로깅 모범 사례! 📝

### 1. 로깅 드라이버 설정

```bash
# JSON 파일 (기본값)
docker run -d \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  badebu/myapp
```

**daemon.json 설정:**
```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3",
    "labels": "production"
  }
}
```

### 2. 중앙 로깅 (ELK Stack)

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  # 애플리케이션
  app:
    image: badebu/myapp
    logging:
      driver: fluentd
      options:
        fluentd-address: localhost:24224
        tag: badebu.app

  # Elasticsearch
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.11.0
    environment:
      - discovery.type=single-node
    ports:
      - "9200:9200"
    volumes:
      - es-data:/usr/share/elasticsearch/data

  # Kibana
  kibana:
    image: docker.elastic.co/kibana/kibana:8.11.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch

  # Fluentd
  fluentd:
    build: ./fluentd
    ports:
      - "24224:24224"
    depends_on:
      - elasticsearch

volumes:
  es-data:
```

**fluentd/fluent.conf:**
```
<source>
  @type forward
  port 24224
</source>

<match badebu.**>
  @type elasticsearch
  host elasticsearch
  port 9200
  logstash_format true
  logstash_prefix badebu
</match>
```

### 3. 애플리케이션 로깅 모범 사례

```javascript
// Winston 로거 설정
const winston = require('winston');

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    // 콘솔 출력 (Docker가 캡처)
    new winston.transports.Console()
  ]
});

// 사용
logger.info('바데부 서버 시작', {
  port: 3000,
  environment: process.env.NODE_ENV
});

logger.error('데이터베이스 연결 실패', {
  error: err.message,
  stack: err.stack
});
```

---

## 모니터링

### 1. 프로메테우스 + 그라파나

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  # 애플리케이션
  app:
    image: badebu/myapp
    ports:
      - "3000:3000"
      - "9090:9090"  # 메트릭 엔드포인트

  # Prometheus
  prometheus:
    image: prom/prometheus
    ports:
      - "9091:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus-data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'

  # Grafana
  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"
    volumes:
      - grafana-data:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

  # cAdvisor (컨테이너 메트릭)
  cadvisor:
    image: gcr.io/cadvisor/cadvisor
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro

volumes:
  prometheus-data:
  grafana-data:
```

**prometheus.yml:**
```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'badebu-app'
    static_configs:
      - targets: ['app:9090']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
```

### 2. 메트릭 수집

**Node.js 예시 (prom-client):**
```javascript
const express = require('express');
const promClient = require('prom-client');

const app = express();

// 기본 메트릭 수집
const register = new promClient.Registry();
promClient.collectDefaultMetrics({ register });

// 커스텀 메트릭
const httpRequestDuration = new promClient.Histogram({
  name: 'http_request_duration_seconds',
  help: 'HTTP 요청 지속 시간',
  labelNames: ['method', 'route', 'status'],
  registers: [register]
});

// 메트릭 엔드포인트
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// 미들웨어
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    httpRequestDuration
      .labels(req.method, req.route?.path || req.path, res.statusCode)
      .observe(duration / 1000);
  });
  next();
});

app.listen(3000);
```

---

## 배포 전략

바데부의 무중단 배포! 🔄

### 1. 블루-그린 배포

```bash
# 1. 그린 버전 배포
docker run -d \
  --name app-green \
  --network app-net \
  badebu/myapp:2.0

# 2. 헬스체크 확인
docker exec app-green curl http://localhost:3000/health

# 3. 로드 밸런서 전환 (Nginx)
# upstream을 app-blue → app-green으로 변경

# 4. 블루 버전 제거
docker stop app-blue
docker rm app-blue
```

### 2. 롤링 업데이트 (Compose)

```yaml
version: '3.8'

services:
  app:
    image: badebu/myapp:2.0
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
        order: start-first
```

### 3. 카나리 배포

```nginx
# nginx.conf
upstream backend {
    # 90% → 기존 버전
    server app-v1:3000 weight=9;
    # 10% → 새 버전
    server app-v2:3000 weight=1;
}
```

---

## 백업 및 복구

### 1. 볼륨 백업

```bash
# 백업 스크립트
#!/bin/bash

VOLUME_NAME="badebu-data"
BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)

docker run --rm \
  -v $VOLUME_NAME:/data \
  -v $BACKUP_DIR:/backup \
  alpine \
  tar czf /backup/${VOLUME_NAME}_${DATE}.tar.gz -C /data .

echo "백업 완료: ${BACKUP_DIR}/${VOLUME_NAME}_${DATE}.tar.gz"
```

### 2. 데이터베이스 백업

```bash
# PostgreSQL 백업
docker exec badebu-db \
  pg_dump -U badebu myapp \
  > backup_$(date +%Y%m%d).sql

# 복원
docker exec -i badebu-db \
  psql -U badebu myapp \
  < backup_20240115.sql
```

### 3. 자동 백업 (cron)

```bash
# crontab -e
# 매일 새벽 2시 백업
0 2 * * * /usr/local/bin/backup-docker-volumes.sh

# 매주 일요일 데이터베이스 백업
0 3 * * 0 /usr/local/bin/backup-database.sh
```

---

## 성능 최적화

### 1. 빌드 캐시 최적화

```dockerfile
# 나쁜 예
FROM node:18
COPY . /app
RUN npm install

# 좋은 예
FROM node:18
COPY package*.json /app/
RUN npm install
COPY . /app/
```

### 2. 레이어 수 줄이기

```dockerfile
# 나쁜 예 (레이어 많음)
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get clean

# 좋은 예 (레이어 적음)
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### 3. BuildKit 사용

```bash
# BuildKit 활성화
export DOCKER_BUILDKIT=1

# 빌드
docker build -t badebu/myapp .

# 장점:
# - 병렬 빌드
# - 효율적인 캐싱
# - Secret 마운트
```

### 4. 네트워크 최적화

```bash
# 호스트 네트워크 (성능 최우선)
docker run --network host myapp

# 커스텀 MTU
docker network create \
  --opt com.docker.network.driver.mtu=9000 \
  badebu-net
```

---

## 트러블슈팅

바데부의 문제 해결 가이드! 🔧

### 1. 컨테이너가 시작되지 않을 때

```bash
# 로그 확인
docker logs badebu-app

# 종료 코드 확인
docker inspect badebu-app --format='{{.State.ExitCode}}'

# 인터랙티브 모드로 디버깅
docker run -it --rm badebu/myapp sh
```

### 2. 메모리 부족

```bash
# 메모리 사용량 확인
docker stats badebu-app

# 메모리 제한 증가
docker update --memory=2g badebu-app

# OOM 이벤트 확인
docker inspect badebu-app | grep -i oom
```

### 3. 네트워크 연결 문제

```bash
# DNS 해석 확인
docker exec badebu-app nslookup db

# 네트워크 확인
docker network inspect badebu-net

# 포트 리스닝 확인
docker exec badebu-app netstat -tulpn

# 방화벽 확인
sudo iptables -L -n
```

### 4. 디스크 공간 부족

```bash
# 사용량 확인
docker system df

# 정리
docker system prune -a --volumes

# 더 자세히
docker system df -v
```

---

## 프로덕션 docker-compose.yml 예시

바데부의 완성형 구성! 🎯

```yaml
version: '3.8'

services:
  # Nginx 리버스 프록시
  nginx:
    image: nginx:alpine
    container_name: badebu-nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/ssl:/etc/nginx/ssl:ro
      - nginx-logs:/var/log/nginx
    depends_on:
      - app
    networks:
      - frontend
    healthcheck:
      test: ["CMD", "nginx", "-t"]
      interval: 30s
      timeout: 3s
      retries: 3

  # 애플리케이션 (3개 복제)
  app:
    image: badebu/myapp:1.0.0
    restart: unless-stopped
    deploy:
      replicas: 3
      resources:
        limits:
          cpus: '1'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
    environment:
      NODE_ENV: production
      DB_HOST: postgres
      REDIS_HOST: redis
    volumes:
      - app-uploads:/app/uploads
      - app-logs:/app/logs
    networks:
      - frontend
      - backend
    depends_on:
      - postgres
      - redis
    healthcheck:
      test: ["CMD", "node", "healthcheck.js"]
      interval: 30s
      timeout: 3s
      retries: 3
      start_period: 40s
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    security_opt:
      - no-new-privileges:true
    read_only: true
    tmpfs:
      - /tmp

  # PostgreSQL
  postgres:
    image: postgres:15-alpine
    container_name: badebu-postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./postgres/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    networks:
      - backend
    secrets:
      - db_password
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
    deploy:
      resources:
        limits:
          memory: 2G

  # Redis
  redis:
    image: redis:7-alpine
    container_name: badebu-redis
    restart: unless-stopped
    command: redis-server --appendonly yes
    volumes:
      - redis-data:/data
    networks:
      - backend
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5

  # 백업 서비스
  backup:
    image: alpine:latest
    container_name: badebu-backup
    restart: unless-stopped
    volumes:
      - postgres-data:/postgres-data:ro
      - ./backups:/backups
      - ./scripts/backup.sh:/backup.sh:ro
    command: sh -c "while true; do sh /backup.sh; sleep 86400; done"
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true

volumes:
  postgres-data:
  redis-data:
  app-uploads:
  app-logs:
  nginx-logs:

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

---

## 바데부의 최종 팁! 💡

### 1. 12 Factor App 원칙 준수

```
1. 코드베이스: 버전 관리
2. 의존성: 명시적 선언
3. 설정: 환경 변수
4. 백엔드 서비스: 독립적 리소스
5. 빌드/릴리스/실행: 분리
6. 프로세스: 무상태
7. 포트 바인딩: 서비스 노출
8. 동시성: 프로세스 모델
9. 폐기 가능: 빠른 시작/종료
10. 개발/프로덕션 일치
11. 로그: 이벤트 스트림
12. 관리 프로세스: 일회성 작업
```

### 2. 정기 점검 체크리스트

```bash
# 주간 점검
- 로그 확인
- 디스크 사용량
- 메모리 사용량
- 백업 확인

# 월간 점검
- 이미지 업데이트
- 보안 스캔
- 성능 분석
- 용량 계획
```

### 3. 유용한 도구들

```bash
# Portainer (웹 UI)
docker run -d \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  portainer/portainer-ce

# Dive (이미지 분석)
dive badebu/myapp:latest

# ctop (실시간 모니터링)
ctop

# docker-compose-viz (시각화)
docker run --rm -it \
  -v $(pwd):/input \
  pmsipilot/docker-compose-viz \
  render -m image docker-compose.yml
```

---

## 핵심 요약

1. **보안**
   - 비루트 사용자
   - 읽기 전용 파일시스템
   - 취약점 스캔
   - Secret 관리

2. **안정성**
   - 헬스체크
   - 재시작 정책
   - 리소스 제한
   - 백업 전략

3. **모니터링**
   - 로그 수집 (ELK)
   - 메트릭 (Prometheus)
   - 시각화 (Grafana)
   - 알림

4. **성능**
   - 이미지 최적화
   - 레이어 캐싱
   - 리소스 튜닝
   - 네트워크 최적화

---

## 축하합니다! 🎉

바데부와 함께한 Docker 기초 학습을 완료하셨습니다!

### 배운 내용

```
Chapter 1: Docker 소개 및 설치
Chapter 2: 이미지와 컨테이너
Chapter 3: Dockerfile 작성하기
Chapter 4: Docker 명령어
Chapter 5: 볼륨과 데이터 관리
Chapter 6: 네트워킹
Chapter 7: Docker Compose
Chapter 8: 멀티 스테이지 빌드
Chapter 9: Docker Hub와 레지스트리
Chapter 10: 프로덕션 배포와 모범 사례
```

### 다음 단계

1. **실습 프로젝트**
   - 개인 프로젝트 Docker화
   - 마이크로서비스 구축
   - CI/CD 파이프라인 구성

2. **고급 주제**
   - Docker Swarm
   - Kubernetes
   - Service Mesh
   - GitOps

3. **계속 학습하기**
   - 공식 문서: docs.docker.com
   - Docker Hub: hub.docker.com
   - 커뮤니티: forums.docker.com

**바데부와 함께 계속 성장하세요!** 🚀

---

## 참고 자료

- 공식 문서: https://docs.docker.com
- Docker Hub: https://hub.docker.com
- 모범 사례: https://docs.docker.com/develop/dev-best-practices/
- 보안 가이드: https://docs.docker.com/engine/security/
- Awesome Docker: https://github.com/veggiemonk/awesome-docker

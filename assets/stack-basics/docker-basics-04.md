# Chapter 4: Docker 명령어 (Run, Stop, Remove, Exec)

## 학습 목표
- Docker 컨테이너 관리 명령어 마스터하기
- 실행 중인 컨테이너 제어하기
- 컨테이너 내부 접근 및 디버깅하기
- 리소스 관리 및 제한하기

---

## docker run 완벽 가이드

바데부와 함께 가장 중요한 명령어를 배워봅시다! 🚀

### 기본 문법

```bash
docker run [옵션] 이미지명 [명령어] [인자...]
```

### 주요 옵션 총정리

#### 1. 백그라운드 실행

```bash
# 포어그라운드 (기본값)
docker run nginx
# 터미널이 블록됨

# 백그라운드 (-d, --detach)
docker run -d nginx
# 컨테이너 ID 반환 후 터미널 복귀
```

#### 2. 컨테이너 이름 지정

```bash
# 이름 없이 (자동 생성)
docker run nginx
# 이름: clever_einstein (랜덤)

# 이름 지정 (--name)
docker run --name badebu-web nginx
# 이름: badebu-web
```

#### 3. 포트 매핑

```bash
# 기본 포트 매핑 (-p)
docker run -p 8080:80 nginx
# 호스트:8080 → 컨테이너:80

# 여러 포트 매핑
docker run -p 8080:80 -p 8443:443 nginx

# 호스트 IP 지정
docker run -p 127.0.0.1:8080:80 nginx
# localhost에서만 접근 가능

# 모든 포트 자동 매핑 (-P)
docker run -P nginx
# EXPOSE된 모든 포트를 랜덤 포트에 매핑
```

바데부의 포트 매핑 팁:
```bash
# 매핑된 포트 확인
docker port badebu-web
# 80/tcp -> 0.0.0.0:8080
```

#### 4. 볼륨 마운트

```bash
# 호스트 디렉토리 마운트 (-v)
docker run -v /host/path:/container/path nginx

# 익명 볼륨
docker run -v /container/path nginx

# 명명된 볼륨
docker run -v badebu-data:/data nginx

# 읽기 전용 마운트
docker run -v /host/path:/container/path:ro nginx
```

**실전 예제:**
```bash
# 바데부의 웹사이트 호스팅
docker run -d \
  --name badebu-site \
  -p 8080:80 \
  -v /home/badebu/html:/usr/share/nginx/html:ro \
  nginx
```

#### 5. 환경 변수

```bash
# 단일 환경 변수 (-e)
docker run -e NODE_ENV=production node

# 여러 환경 변수
docker run \
  -e NODE_ENV=production \
  -e PORT=3000 \
  -e DEBUG=false \
  node

# 파일에서 읽기 (--env-file)
docker run --env-file .env node
```

**.env 파일 예시:**
```
NODE_ENV=production
PORT=3000
DB_HOST=localhost
DB_USER=badebu
```

#### 6. 인터랙티브 모드

```bash
# 터미널 연결 (-it)
docker run -it ubuntu bash

# -i: 표준 입력 유지 (interactive)
# -t: TTY 할당 (pseudo-terminal)
```

**바데부의 활용 예:**
```bash
# Python 인터프리터
docker run -it python:3.11

# Node.js REPL
docker run -it node:18

# 임시 테스트 환경
docker run -it --rm alpine sh
```

#### 7. 자동 삭제

```bash
# 종료 시 자동 삭제 (--rm)
docker run --rm alpine echo "임시 컨테이너"

# 일회성 작업에 유용
docker run --rm -v $(pwd):/app node:18 npm install
```

#### 8. 네트워크 설정

```bash
# 기본 bridge 네트워크
docker run nginx

# 특정 네트워크 (--network)
docker run --network badebu-net nginx

# 호스트 네트워크 사용
docker run --network host nginx

# 네트워크 없음
docker run --network none alpine
```

#### 9. 리소스 제한

```bash
# 메모리 제한 (-m, --memory)
docker run -m 512m nginx
docker run -m 2g nginx

# CPU 제한 (--cpus)
docker run --cpus 1.5 nginx  # 1.5 CPU 코어

# CPU 우선순위 (--cpu-shares)
docker run --cpu-shares 512 nginx  # 기본값: 1024
```

**바데부의 실전 예:**
```bash
docker run -d \
  --name badebu-app \
  -m 1g \
  --cpus 2 \
  -p 3000:3000 \
  badebu/node-app
```

#### 10. 재시작 정책

```bash
# 재시작 안 함 (기본값)
docker run --restart no nginx

# 실패 시만 재시작
docker run --restart on-failure nginx
docker run --restart on-failure:5 nginx  # 최대 5회

# 항상 재시작
docker run --restart always nginx

# 수동 중지 전까지 재시작
docker run --restart unless-stopped nginx
```

**바데부의 추천:**
```bash
# 프로덕션 서버
docker run -d --restart unless-stopped nginx

# 개발 환경
docker run -d --restart no nginx
```

#### 11. 작업 디렉토리

```bash
# 작업 디렉토리 지정 (-w, --workdir)
docker run -w /app node npm install

# Dockerfile WORKDIR 덮어쓰기
docker run -w /custom/path alpine pwd
```

#### 12. 사용자 지정

```bash
# 특정 사용자로 실행 (-u, --user)
docker run -u 1000 alpine id
docker run -u badebu alpine whoami

# 사용자:그룹 형식
docker run -u 1000:1000 alpine id
```

---

## docker exec - 실행 중인 컨테이너 접근

바데부가 실행 중인 컨테이너 내부로 들어가볼게요! 🚪

### 기본 사용법

```bash
docker exec [옵션] 컨테이너명 명령어
```

### 인터랙티브 셸 실행

```bash
# Bash 셸 접속
docker exec -it badebu-web bash

# 셸이 없으면 sh 사용
docker exec -it badebu-web sh

# 특정 사용자로 접속
docker exec -it -u root badebu-web bash
```

### 명령어 실행

```bash
# 파일 목록 보기
docker exec badebu-web ls -la

# 프로세스 확인
docker exec badebu-web ps aux

# 로그 확인
docker exec badebu-web cat /var/log/nginx/access.log

# 네트워크 테스트
docker exec badebu-web curl http://localhost
```

### 디버깅 활용

**바데부의 실전 디버깅:**

```bash
# 1. 컨테이너 내부 확인
docker exec -it badebu-app bash

# 2. 프로세스 상태
docker exec badebu-app ps aux | grep node

# 3. 네트워크 연결
docker exec badebu-app netstat -tulpn

# 4. 디스크 사용량
docker exec badebu-app df -h

# 5. 환경 변수 확인
docker exec badebu-app env

# 6. 파일 내용 확인
docker exec badebu-app cat /app/config.json

# 7. 실시간 로그
docker exec badebu-app tail -f /var/log/app.log
```

### 백그라운드 실행

```bash
# 백그라운드에서 스크립트 실행 (-d)
docker exec -d badebu-app /app/cleanup.sh

# 작업 디렉토리 지정
docker exec -w /app/scripts badebu-app ./backup.sh
```

---

## docker logs - 로그 확인

바데부의 로그 마스터 가이드! 📜

### 기본 사용법

```bash
# 전체 로그 보기
docker logs badebu-web

# 실시간 로그 (-f, --follow)
docker logs -f badebu-web

# 마지막 n줄만 (--tail)
docker logs --tail 100 badebu-web

# 타임스탬프 포함 (-t, --timestamps)
docker logs -t badebu-web
```

### 시간 범위 필터

```bash
# 특정 시간 이후 (--since)
docker logs --since 10m badebu-web     # 최근 10분
docker logs --since 1h badebu-web      # 최근 1시간
docker logs --since 2024-01-01 badebu-web

# 특정 시간 이전 (--until)
docker logs --until 2024-01-01T12:00:00 badebu-web

# 조합
docker logs --since 1h --until 10m badebu-web
```

### 로그 드라이버

```bash
# 로그 드라이버 확인
docker inspect badebu-web | grep LogConfig -A 5

# 로그 드라이버 지정
docker run -d \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  nginx
```

**바데부의 로그 모범 사례:**
```bash
docker run -d \
  --name badebu-app \
  --log-driver json-file \
  --log-opt max-size=50m \
  --log-opt max-file=5 \
  --log-opt compress=true \
  badebu/app
```

---

## docker stop & docker kill - 컨테이너 중지

### docker stop (우아한 종료)

```bash
# 기본 중지 (10초 대기)
docker stop badebu-web

# 대기 시간 지정 (-t)
docker stop -t 30 badebu-web  # 30초 대기

# 여러 컨테이너 중지
docker stop badebu-web badebu-db badebu-cache

# 모든 실행 중인 컨테이너 중지
docker stop $(docker ps -q)
```

**동작 과정:**
```
1. SIGTERM 신호 전송 (우아한 종료 요청)
2. 애플리케이션이 정리 작업 수행
3. 10초 대기 (또는 -t로 지정한 시간)
4. 여전히 실행 중이면 SIGKILL (강제 종료)
```

### docker kill (즉시 종료)

```bash
# 즉시 종료 (SIGKILL)
docker kill badebu-web

# 특정 시그널 전송 (-s)
docker kill -s SIGINT badebu-web
docker kill -s HUP badebu-web  # 설정 재로드
```

**바데부의 추천:**
- 일반 상황: `docker stop` 사용 (데이터 손실 방지)
- 응답 없음: `docker kill` 사용

---

## docker rm - 컨테이너 삭제

### 기본 삭제

```bash
# 중지된 컨테이너 삭제
docker rm badebu-web

# 여러 컨테이너 삭제
docker rm badebu-web badebu-db badebu-cache

# 실행 중인 컨테이너 강제 삭제 (-f)
docker rm -f badebu-web
```

### 대량 삭제

```bash
# 모든 중지된 컨테이너 삭제
docker container prune

# 확인 없이 삭제
docker container prune -f

# 모든 컨테이너 삭제 (주의!)
docker rm -f $(docker ps -aq)
```

### 볼륨도 함께 삭제

```bash
# 연결된 볼륨도 삭제 (-v)
docker rm -v badebu-web
```

**바데부의 안전 팁:**
```bash
# 삭제 전 확인
docker ps -a | grep badebu
docker rm badebu-web
```

---

## docker start & docker restart

### docker start

```bash
# 중지된 컨테이너 시작
docker start badebu-web

# 여러 컨테이너 시작
docker start badebu-web badebu-db

# 로그 출력하며 시작 (-a, --attach)
docker start -a badebu-web

# 인터랙티브 모드로 시작 (-i)
docker start -ai badebu-ubuntu
```

### docker restart

```bash
# 컨테이너 재시작
docker restart badebu-web

# 대기 시간 지정 (-t)
docker restart -t 30 badebu-web

# 모든 컨테이너 재시작
docker restart $(docker ps -q)
```

---

## docker ps - 컨테이너 목록

바데부의 ps 마스터 가이드! 📋

### 기본 사용법

```bash
# 실행 중인 컨테이너
docker ps

# 모든 컨테이너 (중지된 것 포함)
docker ps -a

# 최근 n개
docker ps -n 5

# 마지막 컨테이너만
docker ps -l
```

### 필터링

```bash
# 이름으로 필터
docker ps --filter "name=badebu"

# 상태로 필터
docker ps -a --filter "status=exited"
docker ps --filter "status=running"

# 이미지로 필터
docker ps --filter "ancestor=nginx"

# 볼륨으로 필터
docker ps --filter "volume=/data"

# 여러 필터 조합
docker ps --filter "name=badebu" --filter "status=running"
```

### 출력 형식

```bash
# 컨테이너 ID만
docker ps -q

# 크기 포함
docker ps -s

# 커스텀 포맷
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

# JSON 형식
docker ps --format '{{json .}}'
```

**바데부의 유용한 포맷:**
```bash
# 이름과 포트만 보기
docker ps --format "table {{.Names}}\t{{.Ports}}"

# 상태 요약
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
```

---

## docker inspect - 상세 정보

```bash
# 전체 정보
docker inspect badebu-web

# 특정 필드만 추출
docker inspect --format '{{.State.Status}}' badebu-web
docker inspect --format '{{.NetworkSettings.IPAddress}}' badebu-web
docker inspect --format '{{.Config.Env}}' badebu-web

# 여러 컨테이너
docker inspect badebu-web badebu-db
```

**바데부의 유용한 쿼리:**
```bash
# IP 주소 확인
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' badebu-web

# 포트 매핑
docker inspect -f '{{.NetworkSettings.Ports}}' badebu-web

# 볼륨 마운트
docker inspect -f '{{.Mounts}}' badebu-web

# 환경 변수
docker inspect -f '{{.Config.Env}}' badebu-web
```

---

## docker stats - 리소스 모니터링

```bash
# 실시간 모니터링
docker stats

# 특정 컨테이너만
docker stats badebu-web

# 한 번만 출력
docker stats --no-stream

# 포맷 지정
docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

**출력 예시:**
```
CONTAINER ID   NAME         CPU %     MEM USAGE / LIMIT     MEM %     NET I/O
abc123         badebu-web   0.15%     45.2MiB / 1GiB       4.41%     1.2kB / 648B
```

---

## 실전 시나리오

바데부의 실무 활용 예제들! 💼

### 시나리오 1: 웹 애플리케이션 배포

```bash
# 1. 이전 버전 중지 및 삭제
docker stop badebu-web
docker rm badebu-web

# 2. 새 버전 실행
docker run -d \
  --name badebu-web \
  --restart unless-stopped \
  -p 80:3000 \
  -v /app/logs:/app/logs \
  -e NODE_ENV=production \
  --memory 1g \
  --cpus 2 \
  badebu/web-app:2.0

# 3. 헬스체크
docker exec badebu-web curl http://localhost:3000/health

# 4. 로그 확인
docker logs -f --tail 50 badebu-web
```

### 시나리오 2: 데이터베이스 백업

```bash
# 1. 실행 중인 PostgreSQL 컨테이너에서 백업
docker exec badebu-db pg_dump -U badebu myapp > backup.sql

# 2. 또는 컨테이너 내부에서 백업 후 복사
docker exec badebu-db pg_dump -U badebu myapp > /tmp/backup.sql
docker cp badebu-db:/tmp/backup.sql ./backup_$(date +%Y%m%d).sql

# 3. 복원
docker exec -i badebu-db psql -U badebu myapp < backup.sql
```

### 시나리오 3: 디버깅 세션

```bash
# 1. 문제가 있는 컨테이너 확인
docker ps -a

# 2. 로그 확인
docker logs --tail 100 badebu-app

# 3. 컨테이너 내부 접속
docker exec -it badebu-app bash

# 4. 내부에서 디버깅
ps aux
netstat -tulpn
ls -la /app
cat /app/config.json
curl http://localhost:3000

# 5. 외부에서 프로세스 확인
docker top badebu-app

# 6. 리소스 사용량 확인
docker stats badebu-app --no-stream
```

### 시나리오 4: 로그 분석

```bash
# 1. 에러 로그만 추출
docker logs badebu-app 2>&1 | grep ERROR

# 2. 특정 시간대 로그
docker logs --since 2024-01-15T10:00:00 --until 2024-01-15T12:00:00 badebu-app

# 3. 실시간 에러 모니터링
docker logs -f badebu-app | grep -i error

# 4. 로그를 파일로 저장
docker logs badebu-app > app_logs_$(date +%Y%m%d).log
```

---

## 바데부의 팁! 💡

### 1. 별칭(Alias) 설정

```bash
# ~/.bashrc 또는 ~/.zshrc에 추가
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dlog='docker logs -f'
alias dexec='docker exec -it'
alias dstop='docker stop'
alias drm='docker rm'
alias dstart='docker start'

# 사용 예
dps
dlog badebu-web
dexec badebu-web bash
```

### 2. 컨테이너 이름 규칙

```bash
# 프로젝트-역할-환경
badebu-web-prod
badebu-db-dev
badebu-cache-staging

# 또는 환경-프로젝트-역할
prod-badebu-web
dev-badebu-db
```

### 3. 건강 확인 스크립트

```bash
#!/bin/bash
# health-check.sh

CONTAINER=$1

if [ -z "$CONTAINER" ]; then
    echo "사용법: ./health-check.sh 컨테이너명"
    exit 1
fi

echo "=== 컨테이너 상태 ==="
docker ps --filter "name=$CONTAINER"

echo "\n=== 리소스 사용량 ==="
docker stats --no-stream $CONTAINER

echo "\n=== 최근 로그 ==="
docker logs --tail 20 $CONTAINER

echo "\n=== 프로세스 ==="
docker top $CONTAINER
```

---

## 핵심 요약

1. **docker run - 컨테이너 실행**
   - `-d`: 백그라운드
   - `-p`: 포트 매핑
   - `-v`: 볼륨 마운트
   - `-e`: 환경 변수
   - `--restart`: 재시작 정책

2. **docker exec - 실행 중인 컨테이너 접근**
   - `-it`: 인터랙티브 셸
   - 디버깅 필수 도구

3. **docker logs - 로그 확인**
   - `-f`: 실시간 로그
   - `--tail`: 마지막 n줄
   - `--since`: 시간 필터

4. **컨테이너 관리**
   - `stop`: 우아한 종료
   - `kill`: 강제 종료
   - `rm`: 삭제
   - `restart`: 재시작

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **볼륨과 데이터 관리**를 배워보겠습니다!
- 데이터 영구 저장
- 볼륨 vs 바인드 마운트
- 컨테이너 간 데이터 공유
- 백업 및 복원

계속 화이팅! 🚀

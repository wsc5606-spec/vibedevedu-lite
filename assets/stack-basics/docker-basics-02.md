# Chapter 2: 이미지와 컨테이너

## 학습 목표
- Docker 이미지의 레이어 구조 이해하기
- 이미지 검색, 다운로드, 관리하기
- 컨테이너 라이프사이클 이해하기
- 이미지와 컨테이너의 관계 파악하기

---

## Docker 이미지 깊이 알기

바데부와 함께 Docker 이미지의 비밀을 파헤쳐봅시다! 🔍

### 이미지란?

Docker 이미지는 **읽기 전용 템플릿**입니다.

```
이미지 = 애플리케이션 실행에 필요한 모든 것의 패키지
├── 운영체제 (경량화된 Linux)
├── 런타임 (Node.js, Python, Java 등)
├── 라이브러리 및 의존성
├── 애플리케이션 코드
└── 환경 설정
```

---

## 이미지 레이어 구조

Docker 이미지는 여러 **레이어(Layer)**로 구성됩니다!

### 레이어 개념 이해하기

바데부가 샌드위치로 설명할게요! 🥪

```
┌─────────────────────────┐
│   바데부의 앱 코드       │ ← Layer 4 (앱)
├─────────────────────────┤
│   Python 패키지 설치     │ ← Layer 3 (의존성)
├─────────────────────────┤
│   pip, setuptools       │ ← Layer 2 (패키지 관리자)
├─────────────────────────┤
│   Ubuntu 베이스         │ ← Layer 1 (OS)
└─────────────────────────┘
```

### 레이어의 장점

**1. 효율적인 저장 공간**
```bash
# 예시: 두 개의 Python 앱
앱 A: Ubuntu + Python + Flask + 앱코드
앱 B: Ubuntu + Python + Django + 앱코드

# Ubuntu와 Python 레이어는 공유!
실제 저장: Ubuntu(1번) + Python(1번) + Flask + Django + 앱A + 앱B
```

**2. 빠른 빌드**
- 변경된 레이어만 다시 빌드
- 캐시 활용으로 시간 절약

**3. 쉬운 배포**
- 변경된 레이어만 전송
- 네트워크 대역폭 절약

---

## 이미지 태그 (Tag)

바데부의 이미지 버전 관리법! 🏷️

### 태그 형식

```
이미지명:태그
예: python:3.11
    nginx:latest
    ubuntu:22.04
```

### 자주 사용하는 태그

```bash
# 최신 버전
nginx:latest

# 특정 버전
python:3.11
python:3.11.5

# OS 변형
python:3.11-slim       # 경량화 버전
python:3.11-alpine     # 초경량 Alpine Linux 기반
python:3.11-bullseye   # Debian Bullseye 기반
```

### 태그 생략 시

```bash
docker pull python
# 실제로는 python:latest를 다운로드
```

---

## 이미지 검색하기

### Docker Hub에서 검색

**웹 브라우저:**
```
https://hub.docker.com
```

**명령줄:**
```bash
# 이미지 검색
docker search python

# 결과 예시
NAME                   DESCRIPTION                     STARS     OFFICIAL
python                 Official Python image           8000      [OK]
circleci/python        Python for CircleCI            500
kaggle/python          Kaggle Python images           300
```

### 공식 이미지 vs 커뮤니티 이미지

**공식 이미지 (Official)**
- Docker 또는 제작사가 관리
- 보안 업데이트 정기적
- 신뢰할 수 있음
- 예: `python`, `nginx`, `redis`

**커뮤니티 이미지**
- 개인/조직이 제작
- `사용자명/이미지명` 형식
- 예: `badebu/my-app`

---

## 이미지 다운로드 (Pull)

바데부가 이미지를 가져와볼게요!

### 기본 사용법

```bash
# 최신 버전 다운로드
docker pull nginx

# 특정 버전 다운로드
docker pull nginx:1.25

# 특정 플랫폼 지정
docker pull --platform linux/amd64 nginx
```

### 다운로드 과정 보기

```bash
docker pull python:3.11-slim
```

**출력:**
```
3.11-slim: Pulling from library/python
01085d60b3a8: Pull complete
fcd92899c8db: Pull complete
3f3b8f3d7a8e: Pull complete
6d7a2d5e1a9c: Pull complete
Digest: sha256:abc123...
Status: Downloaded newer image for python:3.11-slim
```

각 줄 = 하나의 레이어 다운로드!

---

## 이미지 목록 확인

### 로컬 이미지 보기

```bash
docker images
# 또는
docker image ls
```

**출력 예시:**
```
REPOSITORY   TAG          IMAGE ID       CREATED        SIZE
python       3.11-slim    abc123def456   2 weeks ago    125MB
nginx        latest       789ghi012jkl   3 weeks ago    142MB
ubuntu       22.04        345mno678pqr   1 month ago    77.8MB
```

**컬럼 설명:**
- `REPOSITORY`: 이미지 이름
- `TAG`: 버전 태그
- `IMAGE ID`: 고유 식별자
- `CREATED`: 생성 시간
- `SIZE`: 이미지 크기

### 특정 이미지만 보기

```bash
# Python 이미지만 보기
docker images python

# 출력
REPOSITORY   TAG          IMAGE ID       CREATED        SIZE
python       3.11-slim    abc123def456   2 weeks ago    125MB
python       3.11         def456ghi789   2 weeks ago    920MB
```

---

## 이미지 상세 정보

바데부가 이미지를 자세히 살펴볼게요! 🔬

### inspect 명령어

```bash
docker image inspect python:3.11-slim
```

**주요 정보:**
```json
[
    {
        "Id": "sha256:abc123...",
        "RepoTags": [
            "python:3.11-slim"
        ],
        "Size": 125000000,
        "Architecture": "amd64",
        "Os": "linux",
        "Layers": [
            "sha256:layer1...",
            "sha256:layer2...",
            "sha256:layer3...",
            "sha256:layer4..."
        ],
        "Env": [
            "PATH=/usr/local/bin:/usr/local/sbin:...",
            "PYTHON_VERSION=3.11.5"
        ]
    }
]
```

### 레이어 히스토리 보기

```bash
docker image history python:3.11-slim
```

**출력:**
```
IMAGE          CREATED BY                                      SIZE
abc123def456   CMD ["python3"]                                 0B
<missing>      COPY /usr/local/bin/python3 ...                 15MB
<missing>      RUN pip install --upgrade pip                   8MB
<missing>      ADD debian-base.tar.gz /                        102MB
```

---

## 이미지 삭제

### 기본 삭제

```bash
# 태그로 삭제
docker rmi python:3.11-slim

# 이미지 ID로 삭제
docker rmi abc123def456

# 강제 삭제 (-f)
docker rmi -f python:3.11-slim
```

### 여러 이미지 한번에 삭제

```bash
# 여러 이미지 지정
docker rmi nginx:latest ubuntu:22.04

# 모든 <none> 이미지 삭제 (댕글링 이미지)
docker image prune

# 사용하지 않는 모든 이미지 삭제
docker image prune -a
```

### 주의사항! ⚠️

컨테이너가 사용 중인 이미지는 삭제 불가!

```bash
# 에러 발생
Error response from daemon: conflict: unable to remove repository reference
"python:3.11" (must force) - container abc123 is using its referenced image

# 해결: 컨테이너를 먼저 삭제
docker rm 컨테이너명
docker rmi 이미지명
```

---

## 컨테이너 생성과 실행

바데부와 함께 컨테이너를 만들어봅시다!

### create vs run

**docker create**
- 컨테이너만 생성 (실행 X)

```bash
docker create --name badebu-nginx nginx
# 컨테이너 ID 반환: abc123def456
```

**docker run**
- 생성 + 실행을 한번에

```bash
docker run --name badebu-nginx nginx
# create + start를 동시에 수행
```

### run 명령어 옵션

바데부의 자주 사용하는 옵션들! 📋

```bash
docker run [옵션] 이미지명 [명령어]

# 주요 옵션
-d, --detach              # 백그라운드 실행
-i, --interactive         # 표준 입력 유지
-t, --tty                 # 터미널 할당
--name 이름               # 컨테이너 이름 지정
-p 호스트:컨테이너        # 포트 매핑
-v 호스트:컨테이너        # 볼륨 마운트
-e KEY=VALUE             # 환경 변수 설정
--rm                     # 종료 시 자동 삭제
--network 네트워크명      # 네트워크 지정
```

### 실전 예제

**1. 백그라운드 웹 서버**
```bash
docker run -d \
  --name badebu-web \
  -p 8080:80 \
  nginx
```

**2. 인터랙티브 셸**
```bash
docker run -it \
  --name badebu-ubuntu \
  ubuntu bash
```

**3. 환경 변수 설정**
```bash
docker run -d \
  --name badebu-db \
  -e POSTGRES_PASSWORD=mysecret \
  -e POSTGRES_USER=badebu \
  postgres
```

**4. 자동 삭제 컨테이너**
```bash
docker run --rm \
  alpine echo "안녕하세요, 바데부입니다!"
# 실행 후 자동으로 컨테이너 삭제
```

---

## 컨테이너 라이프사이클

### 상태 다이어그램

```
    create
      ↓
  [Created] ─────→ [Removed]
      ↓ start          ↑
  [Running]           rm
      ↓ stop           ↑
  [Stopped] ──────────┘
      ↓ start
  [Running]
```

### 상태별 명령어

**1. 컨테이너 생성**
```bash
docker create --name badebu-app nginx
```

**2. 컨테이너 시작**
```bash
docker start badebu-app
```

**3. 컨테이너 중지**
```bash
docker stop badebu-app
# 10초 후 강제 종료 (SIGTERM → SIGKILL)

# 즉시 강제 종료
docker kill badebu-app
```

**4. 컨테이너 재시작**
```bash
docker restart badebu-app
```

**5. 컨테이너 일시 정지**
```bash
docker pause badebu-app
docker unpause badebu-app
```

**6. 컨테이너 삭제**
```bash
docker rm badebu-app

# 실행 중인 컨테이너 강제 삭제
docker rm -f badebu-app
```

---

## 컨테이너 목록 확인

### 실행 중인 컨테이너

```bash
docker ps
```

**출력:**
```
CONTAINER ID   IMAGE   COMMAND                  CREATED          STATUS          PORTS                  NAMES
abc123def456   nginx   "/docker-entrypoint.…"   10 minutes ago   Up 10 minutes   0.0.0.0:8080->80/tcp   badebu-web
```

### 모든 컨테이너 (중지된 것 포함)

```bash
docker ps -a
```

**출력:**
```
CONTAINER ID   IMAGE    STATUS                      NAMES
abc123def456   nginx    Up 10 minutes              badebu-web
789ghi012jkl   ubuntu   Exited (0) 5 minutes ago   badebu-ubuntu
```

### 유용한 ps 옵션

```bash
# 최근 n개만 보기
docker ps -n 5

# 마지막 컨테이너만 보기
docker ps -l

# 컨테이너 ID만 출력
docker ps -q

# 크기 정보 포함
docker ps -s

# 특정 필터
docker ps --filter "status=running"
docker ps --filter "name=badebu"
```

---

## 컨테이너와 이미지의 관계

바데부가 비유로 설명할게요! 🎯

### 클래스와 인스턴스

```python
# 이미지 = 클래스 (Class)
class Nginx:
    def __init__(self):
        self.port = 80
        self.config = "default"

# 컨테이너 = 인스턴스 (Instance)
badebu_web1 = Nginx()  # 컨테이너 1
badebu_web2 = Nginx()  # 컨테이너 2
badebu_web3 = Nginx()  # 컨테이너 3
```

### 실제 예시

```bash
# 하나의 이미지로 여러 컨테이너 생성
docker run -d --name web1 -p 8081:80 nginx
docker run -d --name web2 -p 8082:80 nginx
docker run -d --name web3 -p 8083:80 nginx

# 모두 동일한 nginx 이미지 사용
# 하지만 각각 독립적인 컨테이너!
```

---

## 컨테이너 로그 확인

바데부가 컨테이너의 출력을 확인해볼게요! 📜

### 로그 보기

```bash
# 전체 로그
docker logs badebu-web

# 실시간 로그 (-f, follow)
docker logs -f badebu-web

# 마지막 n줄만 보기
docker logs --tail 50 badebu-web

# 타임스탬프 포함
docker logs -t badebu-web

# 특정 시간 이후 로그
docker logs --since 10m badebu-web  # 최근 10분
docker logs --since 2024-01-01T10:00:00 badebu-web
```

### 실전 예제

```bash
# Python 앱 실행
docker run -d --name badebu-python python:3.11 \
  python -c "
import time
for i in range(10):
    print(f'바데부의 로그 {i}')
    time.sleep(1)
"

# 로그 실시간 확인
docker logs -f badebu-python
```

---

## 컨테이너 리소스 사용량

### stats 명령어

```bash
# 실시간 모니터링
docker stats

# 특정 컨테이너만
docker stats badebu-web

# 한번만 출력 (--no-stream)
docker stats --no-stream
```

**출력:**
```
CONTAINER ID   NAME         CPU %   MEM USAGE / LIMIT   MEM %   NET I/O       BLOCK I/O
abc123def456   badebu-web   0.02%   5.5MiB / 7.77GiB    0.07%   1.5kB / 0B    0B / 0B
```

---

## 실습 문제

### 문제 1: 이미지 레이어 탐구
Node.js 이미지의 레이어 구조를 확인하세요.

```bash
# 1. 이미지 다운로드
docker pull node:18-alpine

# 2. 히스토리 확인
docker image history node:18-alpine

# 3. 상세 정보 확인
docker image inspect node:18-alpine | grep -A 10 Layers
```

### 문제 2: 멀티 컨테이너 실행
같은 이미지로 여러 컨테이너를 실행하고 관리해보세요.

```bash
# Redis 컨테이너 3개 실행
docker run -d --name redis1 -p 6379:6379 redis
docker run -d --name redis2 -p 6380:6379 redis
docker run -d --name redis3 -p 6381:6379 redis

# 모든 컨테이너 확인
docker ps

# 모든 컨테이너 중지
docker stop redis1 redis2 redis3

# 모든 컨테이너 삭제
docker rm redis1 redis2 redis3
```

### 문제 3: 이미지 크기 비교
같은 애플리케이션의 다른 베이스 이미지 크기를 비교하세요.

```bash
# 다양한 Python 이미지 다운로드
docker pull python:3.11
docker pull python:3.11-slim
docker pull python:3.11-alpine

# 크기 비교
docker images python
```

---

## 바데부의 팁! 💡

### 1. 가벼운 이미지 선택
```bash
# Alpine Linux 기반 이미지 사용
node:18-alpine    # 180MB
node:18           # 1.1GB

# 약 6배 차이!
```

### 2. 댕글링 이미지 정리
```bash
# <none>:<none> 이미지들
docker image prune -f

# 매주 실행하여 디스크 공간 확보
```

### 3. 컨테이너 자동 재시작
```bash
docker run -d \
  --name badebu-web \
  --restart unless-stopped \
  nginx

# 옵션:
# no: 재시작 안 함 (기본값)
# on-failure: 실패 시만
# always: 항상
# unless-stopped: 수동 중지 전까지
```

---

## 핵심 요약

1. **이미지 레이어 구조**
   - 여러 읽기 전용 레이어로 구성
   - 레이어 공유로 효율성 향상

2. **이미지 관리**
   - `docker pull`: 다운로드
   - `docker images`: 목록 확인
   - `docker rmi`: 삭제

3. **컨테이너 라이프사이클**
   - Created → Running → Stopped → Removed

4. **주요 명령어**
   - `docker run`: 생성 + 실행
   - `docker start/stop`: 시작/중지
   - `docker logs`: 로그 확인
   - `docker stats`: 리소스 모니터링

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **Dockerfile 작성**을 배워보겠습니다!
- 나만의 이미지 만들기
- Dockerfile 문법
- 효율적인 이미지 빌드
- 베스트 프랙티스

계속 화이팅! 🚀

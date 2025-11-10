# Chapter 1: Docker 소개 및 설치

## 학습 목표
- Docker가 무엇인지 이해하기
- 컨테이너와 가상머신의 차이점 알기
- Docker 설치 및 기본 설정하기
- 첫 Docker 컨테이너 실행해보기

---

## Docker란 무엇인가?

안녕하세요! 바데부와 함께 Docker를 배워볼까요? 🐳

Docker는 애플리케이션을 **컨테이너**라는 가볍고 독립적인 환경에서 실행할 수 있게 해주는 플랫폼입니다.

### 왜 Docker를 사용할까요?

바데부가 개발한 웹 애플리케이션이 있다고 가정해봅시다:
- 바데부의 컴퓨터에서는 완벽하게 작동
- 하지만 동료의 컴퓨터에서는 에러 발생!
- "내 컴퓨터에서는 잘 되는데..." 😢

Docker는 이런 문제를 해결합니다!

```
내 컴퓨터 = 동료 컴퓨터 = 서버 환경
모든 곳에서 동일하게 작동! ✨
```

---

## 컨테이너 vs 가상머신

### 가상머신 (Virtual Machine)
```
┌─────────────────────────────────┐
│  App A  │  App B  │  App C      │
├─────────────────────────────────┤
│  OS     │  OS     │  OS         │
├─────────────────────────────────┤
│       하이퍼바이저               │
├─────────────────────────────────┤
│       호스트 OS                  │
├─────────────────────────────────┤
│       하드웨어                   │
└─────────────────────────────────┘
```

**특징:**
- 각 VM마다 완전한 OS 필요
- 무겁고 느림 (GB 단위)
- 부팅 시간 오래 걸림

### Docker 컨테이너
```
┌─────────────────────────────────┐
│  App A  │  App B  │  App C      │
├─────────────────────────────────┤
│  Libs   │  Libs   │  Libs       │
├─────────────────────────────────┤
│       Docker Engine             │
├─────────────────────────────────┤
│       호스트 OS                  │
├─────────────────────────────────┤
│       하드웨어                   │
└─────────────────────────────────┘
```

**특징:**
- OS 공유 (커널만 사용)
- 가볍고 빠름 (MB 단위)
- 초 단위로 시작

---

## Docker의 핵심 개념

### 1. 이미지 (Image)
- 애플리케이션 실행에 필요한 모든 것을 포함한 템플릿
- 읽기 전용 (Read-only)
- 마치 "요리 레시피"와 같음

```bash
# 바데부의 비유
이미지 = 붕어빵 틀
```

### 2. 컨테이너 (Container)
- 이미지를 실행한 인스턴스
- 쓰기 가능 (Writable)
- 격리된 환경에서 실행

```bash
# 바데부의 비유
컨테이너 = 틀에서 구운 붕어빵
```

### 3. Docker Hub
- Docker 이미지를 저장하고 공유하는 저장소
- GitHub의 Docker 버전!

---

## Docker 설치하기

### Windows / Mac 사용자

**1. Docker Desktop 다운로드**
```
https://www.docker.com/products/docker-desktop
```

**2. 설치 파일 실행**
- 다운로드한 파일을 더블클릭
- 안내에 따라 설치 진행

**3. 설치 확인**
```bash
# 터미널 또는 명령 프롬프트 열기
docker --version
```

**출력 예시:**
```
Docker version 24.0.6, build ed223bc
```

### Linux 사용자 (Ubuntu 기준)

**1. 기존 Docker 제거**
```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

**2. 필요한 패키지 설치**
```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

**3. Docker의 공식 GPG 키 추가**
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

**4. 저장소 설정**
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

**5. Docker 설치**
```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

**6. 설치 확인**
```bash
sudo docker --version
```

---

## 첫 Docker 컨테이너 실행하기!

바데부와 함께 첫 컨테이너를 실행해봅시다!

### Hello World 실행

```bash
docker run hello-world
```

**무슨 일이 일어날까요?**

```
1. Docker가 로컬에서 'hello-world' 이미지 검색
2. 없으면 Docker Hub에서 다운로드
3. 이미지로부터 컨테이너 생성
4. 컨테이너 실행
5. 메시지 출력 후 종료
```

**출력 결과:**
```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:...
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
```

---

## 실전 예제: Nginx 웹 서버 실행

바데부가 간단한 웹 서버를 실행해볼게요!

### 1. Nginx 컨테이너 실행

```bash
docker run -d -p 8080:80 --name badebu-web nginx
```

**명령어 분석:**
- `docker run`: 컨테이너 실행
- `-d`: 백그라운드에서 실행 (detached mode)
- `-p 8080:80`: 포트 매핑 (호스트:컨테이너)
- `--name badebu-web`: 컨테이너 이름 지정
- `nginx`: 사용할 이미지 이름

### 2. 웹 브라우저에서 확인

```
http://localhost:8080
```

"Welcome to nginx!" 페이지가 보이면 성공! 🎉

### 3. 실행 중인 컨테이너 확인

```bash
docker ps
```

**출력 예시:**
```
CONTAINER ID   IMAGE   COMMAND                  CREATED          STATUS          PORTS                  NAMES
abc123def456   nginx   "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds    0.0.0.0:8080->80/tcp   badebu-web
```

### 4. 컨테이너 중지

```bash
docker stop badebu-web
```

### 5. 컨테이너 삭제

```bash
docker rm badebu-web
```

---

## Docker 기본 명령어 요약

바데부의 Docker 치트시트! 📝

```bash
# 버전 확인
docker --version

# 이미지 목록 보기
docker images

# 컨테이너 목록 보기 (실행 중)
docker ps

# 컨테이너 목록 보기 (전체)
docker ps -a

# 컨테이너 실행
docker run [옵션] 이미지명

# 컨테이너 중지
docker stop 컨테이너명

# 컨테이너 시작
docker start 컨테이너명

# 컨테이너 재시작
docker restart 컨테이너명

# 컨테이너 삭제
docker rm 컨테이너명

# 이미지 삭제
docker rmi 이미지명

# Docker 시스템 정보
docker info
```

---

## 실습 문제

### 문제 1: Ubuntu 컨테이너 실행
Ubuntu 컨테이너를 실행하고 bash 셸에 접속해보세요.

```bash
docker run -it --name badebu-ubuntu ubuntu bash
```

**힌트:**
- `-it`: 인터랙티브 터미널 모드
- `bash`: 실행할 명령어

### 문제 2: 컨테이너 내부 탐색
Ubuntu 컨테이너 내부에서 다음 명령어를 실행해보세요:

```bash
# 현재 디렉토리 확인
pwd

# 파일 목록 보기
ls -la

# OS 정보 확인
cat /etc/os-release

# 종료
exit
```

### 문제 3: 정리하기
사용한 컨테이너와 이미지를 정리해보세요.

```bash
# 중지된 컨테이너 삭제
docker rm badebu-ubuntu

# 이미지 확인
docker images

# 사용하지 않는 이미지 삭제
docker image prune
```

---

## 바데부의 팁! 💡

### 1. Docker Desktop 활용
- GUI로 컨테이너와 이미지 관리 가능
- 리소스 사용량 모니터링
- 설정 변경 쉬움

### 2. WSL 2 사용 (Windows)
- Windows에서 Docker 성능 향상
- Linux 환경과 거의 동일한 성능

### 3. 자주 사용하는 명령어 별칭
```bash
# ~/.bashrc 또는 ~/.zshrc에 추가
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias dstop='docker stop'
alias drm='docker rm'
```

---

## 트러블슈팅

### 문제 1: "permission denied" 에러 (Linux)
```bash
# 해결: 현재 사용자를 docker 그룹에 추가
sudo usermod -aG docker $USER

# 로그아웃 후 다시 로그인
```

### 문제 2: Docker Desktop이 시작되지 않음
- 가상화 기능 활성화 확인 (BIOS 설정)
- WSL 2 업데이트 (Windows)
- 재설치 시도

### 문제 3: 포트가 이미 사용 중
```bash
# 다른 포트 사용
docker run -p 8081:80 nginx  # 8080 대신 8081 사용
```

---

## 핵심 요약

1. **Docker는 컨테이너 기반 플랫폼**
   - 애플리케이션을 격리된 환경에서 실행
   - "내 컴퓨터에서는 되는데" 문제 해결

2. **컨테이너 vs 가상머신**
   - 컨테이너: 가볍고 빠름
   - VM: 무겁고 느림

3. **핵심 개념**
   - 이미지: 읽기 전용 템플릿
   - 컨테이너: 실행 중인 이미지

4. **기본 명령어**
   - `docker run`: 컨테이너 실행
   - `docker ps`: 컨테이너 목록
   - `docker stop`: 컨테이너 중지
   - `docker rm`: 컨테이너 삭제

---

## 다음 챕터 예고

다음 시간에는 바데부와 함께 **이미지와 컨테이너**를 더 깊이 알아보겠습니다!
- 이미지 레이어 구조
- 컨테이너 라이프사이클
- 이미지 검색 및 다운로드
- 컨테이너 상태 관리

계속 열심히 공부해요! 화이팅! 💪

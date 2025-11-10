# VIBEDEV Lite - 오프라인 코딩 학습 플랫폼

라이트 버전의 독립 실행형 코딩 학습 플랫폼입니다.

## 프로젝트 구조

이 프로젝트는 본버전(vibeDevedu)과는 별도로 운영되는 라이트 버전입니다.

## Supabase 설정

라이트 버전은 본버전과 별도의 Supabase 프로젝트를 사용합니다.

### 설정 방법

1. `.env.example` 파일을 `.env`로 복사
2. Supabase에서 새 프로젝트 생성
3. `.env` 파일에 새 프로젝트의 URL과 anon key 입력

```bash
cp .env.example .env
```

### 환경 변수

- `SUPABASE_URL`: Supabase 프로젝트 URL
- `SUPABASE_ANON_KEY`: Supabase anon/public key

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 디버그 모드 실행
flutter run

# 릴리즈 빌드 (Windows)
flutter build windows --release
```

## 주요 기능

- 오프라인 학습 지원
- 기본 문법 학습
- 퀴즈 및 챌린지
- 진도 추적

## 본버전과의 차이점

- 라이트 버전: 오프라인 중심, 기본 기능
- 본버전: 온라인 기능, SNS, AI 기능 포함

## 라이센스

Private

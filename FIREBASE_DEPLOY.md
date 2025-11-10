# Firebase Hosting 배포 가이드 - VibeDevEdu

## 현재 상태
- ✅ Firebase CLI 설치 완료
- ✅ Firebase 로그인 완료 (wsc5606@gmail.com)
- ✅ Flutter Web 빌드 완료 (build/web)
- ⏳ Firebase 프로젝트 설정 대기 중

## 배포 단계

### 1단계: Firebase Console에서 프로젝트 생성 ✅
1. https://console.firebase.google.com 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 이름: `VibeDevEdu` 입력
4. 프로젝트 ID 확인 (예: vibedev-edu-xxxxx)

### 2단계: .firebaserc 파일 업데이트
프로젝트 ID를 받은 후 아래 명령어 실행:

```bash
cd vibedev
# .firebaserc 파일의 "your-firebase-project-id"를 실제 프로젝트 ID로 변경
```

또는 수동으로 편집:
```json
{
  "projects": {
    "default": "실제-프로젝트-ID"
  }
}
```

### 3단계: Firebase Hosting 활성화
Firebase Console에서:
1. 프로젝트 선택
2. 좌측 메뉴에서 "Hosting" 클릭
3. "시작하기" 버튼 클릭

### 4단계: 배포 실행
```bash
cd vibedev
firebase deploy --only hosting
```

## 배포 후 확인사항

배포 완료 후 다음 URL에서 앱이 작동하는지 확인:
- Hosting URL: https://프로젝트-ID.web.app
- Custom Domain: https://프로젝트-ID.firebaseapp.com

## API 연결 설정

배포 후 Flutter 앱이 백엔드 API와 통신하도록 설정 필요:

### API 서비스 파일 수정
`lib/services/api_service.dart` (또는 해당 파일)에서:

```dart
class ApiService {
  // 로컬 개발
  // static const String baseUrl = 'http://localhost:8080';
  
  // 프로덕션 (Vercel 백엔드)
  static const String baseUrl = 'https://your-backend.vercel.app';
}
```

## 백엔드 배포

프론트엔드 배포 후 백엔드도 배포해야 합니다:

### Vercel로 백엔드 배포
1. https://vercel.com 접속 및 로그인
2. "Add New Project" 클릭
3. GitHub 저장소 연결
4. Root Directory: `backend/vibedev-backend`
5. 환경 변수 설정:
   - PORT=8080
   - OPENAI_API_KEY=...
   - SUPABASE_URL=...
   - SUPABASE_ANON_KEY=...
   - REVIEW_MODE=mock

6. Deploy 클릭

## 트러블슈팅

### Firebase 배포 오류
```bash
# Firebase 재로그인
firebase logout
firebase login

# 프로젝트 확인
firebase projects:list

# 프로젝트 재설정
firebase use --add
```

### Flutter 빌드 오류
```bash
# 캐시 정리 후 재빌드
flutter clean
flutter pub get
flutter build web --release
```

### CORS 오류
백엔드 `main.ts`에서 CORS 설정 확인:
```typescript
const app = await NestFactory.create(AppModule, {
  cors: {
    origin: ['https://프로젝트-ID.web.app', 'https://프로젝트-ID.firebaseapp.com'],
    credentials: true
  }
});
```

## 추가 최적화

### 커스텀 도메인 설정
Firebase Console > Hosting > 도메인 추가

### 성능 모니터링
Firebase Console > Performance 활성화

### 분석 설정
Firebase Console > Analytics 활성화

---

**다음 단계**: 프로젝트 ID를 받으면 배포를 진행하세요!

/// API 설정
/// 환경별 API BASE URL 관리
class ApiConfig {
  // Production: Vercel Serverless Functions
  static const String base = 'https://vibedevedu-lite.vercel.app/api';

  // Development: 로컬 서버 (개발시 아래 라인을 활성화)
  // static const String base = 'http://127.0.0.1:8081';
}

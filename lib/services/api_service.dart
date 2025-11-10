// import 'package:http/http.dart' as http;

/// API 서비스 클래스 (추후 백엔드 연결 시 사용)
///
/// 백엔드 API 엔드포인트:
/// - POST /execute : 코드 실행
/// - POST /review : AI 코드 리뷰
/// - GET /challenges : 챌린지 목록
/// - GET /challenge/:slug : 챌린지 상세
/// - POST /submit : 챌린지 제출

class ApiService {
  // 백엔드 서버 주소
  static const String baseUrl = 'http://localhost:8080';

  /// 코드 실행 API 호출
  ///
  /// 사용 예시:
  /// ```dart
  /// final result = await ApiService.executeCode(
  ///   code: 'print("Hello")',
  ///   language: 'python',
  /// );
  /// ```
  static Future<Map<String, dynamic>> executeCode({
    required String code,
    required String language,
  }) async {
    // TODO: 실제 HTTP 요청 구현
    // final response = await http.post(
    //   Uri.parse('$baseUrl/execute'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'code': code,
    //     'language': language,
    //   }),
    // );
    //
    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('Failed to execute code');
    // }

    // 임시 응답
    return {
      'success': true,
      'output': 'Hello, World!',
      'executionTime': 0.05,
      'memoryUsage': 12.4,
    };
  }

  /// AI 코드 리뷰 API 호출
  ///
  /// 사용 예시:
  /// ```dart
  /// final review = await ApiService.requestAIReview(
  ///   code: 'def hello(): print("Hi")',
  ///   language: 'python',
  ///   challengeSlug: 'python-list-sum',
  /// );
  /// ```
  static Future<Map<String, dynamic>> requestAIReview({
    required String code,
    required String language,
    required String challengeSlug,
  }) async {
    // TODO: 실제 HTTP 요청 구현
    // final response = await http.post(
    //   Uri.parse('$baseUrl/review'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'code': code,
    //     'language': language,
    //     'challenge': challengeSlug,
    //   }),
    // );
    //
    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('Failed to get AI review');
    // }

    // 임시 응답
    return {
      'success': true,
      'score': 85,
      'feedback': 'Your code is good but could be improved...',
      'suggestions': [
        'Add error handling',
        'Use built-in functions',
        'Add documentation',
      ],
    };
  }

  /// 챌린지 목록 가져오기
  static Future<List<Map<String, dynamic>>> getChallenges() async {
    // TODO: 실제 HTTP 요청 구현
    return [];
  }

  /// 챌린지 상세 정보 가져오기
  static Future<Map<String, dynamic>> getChallengeDetail(String slug) async {
    // TODO: 실제 HTTP 요청 구현
    return {};
  }

  /// 챌린지 제출
  static Future<Map<String, dynamic>> submitChallenge({
    required String challengeSlug,
    required String code,
  }) async {
    // TODO: 실제 HTTP 요청 구현
    return {};
  }
}

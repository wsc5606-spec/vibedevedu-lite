import 'package:shared_preferences/shared_preferences.dart';

/// 사용자 세션 관리
/// 로그인한 이메일 및 토큰 정보를 전역으로 보관
class UserSession {
  static String? email;
  static String? _token;
  static String? _userId;
  static bool _isGuest = false;

  /// Get current auth token
  static String? get token => _token;

  /// Get current user ID
  static String? get userId => _userId;

  /// Check if user is guest
  static bool get isGuest => _isGuest;

  /// Check if user is authenticated (includes guest)
  static bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  /// Set auth token and user ID
  static Future<void> setToken(String token, String userId, {bool isGuest = false}) async {
    _token = token;
    _userId = userId;
    _isGuest = isGuest;

    // Persist to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);
    await prefs.setBool('is_guest', isGuest);
  }

  /// Load token from SharedPreferences
  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    _userId = prefs.getString('user_id');
    _isGuest = prefs.getBool('is_guest') ?? false;
    email = prefs.getString('user_email');
  }

  /// Clear session (logout)
  static Future<void> clear() async {
    _token = null;
    _userId = null;
    _isGuest = false;
    email = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    await prefs.remove('is_guest');
    await prefs.remove('user_email');
  }

  /// Set mock token for development/testing (until v1.2 auth is implemented)
  /// This simulates a logged-in user for API testing
  static Future<void> setMockToken() async {
    // TODO: Replace with real Supabase auth in v1.2
    // For now, use a test token that the backend will need to handle
    const mockToken = 'dev-test-token-123';
    // Use actual user ID from Supabase
    const mockUserId = '1437c04f-26c5-4dc4-884b-0756db63b295';
    await setToken(mockToken, mockUserId);
    email = 'test@vibedev.com';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email!);
  }
}

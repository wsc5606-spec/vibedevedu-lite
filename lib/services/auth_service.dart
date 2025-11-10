import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'user_session.dart';

/// VibeDev v2.6 Authentication Service
/// Google, Apple, GitHub, Kakao, Guest 로그인/계정(Supabase Auth)
class AuthService {
  final _supabase = Supabase.instance.client;

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Supabase OAuth
        await _supabase.auth.signInWithOAuth(OAuthProvider.google);
      } else {
        // Mobile: Google Sign In → Supabase
        final googleSignIn = GoogleSignIn(scopes: ['email']);
        final googleUser = await googleSignIn.signIn();
        if (googleUser == null) throw Exception('Google sign in cancelled');

        final googleAuth = await googleUser.authentication;
        await _supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: googleAuth.idToken!,
          accessToken: googleAuth.accessToken,
        );
      }

      // Save session
      final session = _supabase.auth.currentSession;
      if (session != null) {
        await UserSession.setToken(session.accessToken, session.user.id);

        // Create user profile if not exists
        await _createUserProfileIfNeeded(session.user);
      }
    } catch (e) {
      print('[AuthService] Google sign in error: $e');
      rethrow;
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: kIsWeb
            ? WebAuthenticationOptions(
                clientId: 'com.vibedev.app',
                redirectUri: Uri.parse('https://soweluoqppldiybgonkc.supabase.co/auth/v1/callback'),
              )
            : null,
      );

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
      );

      // Save session
      final session = _supabase.auth.currentSession;
      if (session != null) {
        await UserSession.setToken(session.accessToken, session.user.id);
        await _createUserProfileIfNeeded(session.user);
      }
    } catch (e) {
      print('[AuthService] Apple sign in error: $e');
      rethrow;
    }
  }

  /// Sign up with Email/Password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String displayName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'display_name': displayName,
        },
      );

      if (response.session != null) {
        await UserSession.setToken(
          response.session!.accessToken,
          response.user!.id,
        );

        // Create user profile
        await _createUserProfileIfNeeded(
          response.user!,
          username: username,
          displayName: displayName,
        );
      }
    } catch (e) {
      print('[AuthService] Email signup error: $e');
      rethrow;
    }
  }

  /// Sign in with Email/Password
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        await UserSession.setToken(
          response.session!.accessToken,
          response.user!.id,
        );
      }
    } catch (e) {
      print('[AuthService] Email sign in error: $e');
      rethrow;
    }
  }

  /// Sign in as Guest
  /// 게스트 모드: 로컬 세션 생성 (Supabase 인증 미사용)
  /// 게스트는 학습만 가능, 소셜 기능은 제한
  Future<void> signInAsGuest() async {
    try {
      // Generate guest ID and credentials
      final guestId = const Uuid().v4();
      final guestUsername = 'guest_${guestId.substring(0, 8)}';

      // Create local guest session (no Supabase auth)
      await UserSession.setToken(
        'guest_token_$guestId', // Local token (not a real JWT)
        guestId,                // Guest user ID
        isGuest: true,          // Mark as guest
      );

      print('[AuthService] Guest login successful: $guestUsername (study-only mode)');
    } catch (e) {
      print('[AuthService] Guest sign in error: $e');
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      await UserSession.clear();
    } catch (e) {
      print('[AuthService] Sign out error: $e');
      rethrow;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => UserSession.isAuthenticated;

  /// Get current user ID
  String? get userId => UserSession.userId;

  /// Get current auth token
  String? get token => UserSession.token;

  /// Create user profile via backend API (uses service role key)
  Future<void> _createUserProfileViaApi(
    User user, {
    String? username,
    String? displayName,
    bool isGuest = false,
  }) async {
    try {
      final profileUsername = username ??
          user.userMetadata?['username'] ??
          (isGuest ? 'Guest_${user.id.substring(0, 8)}' : user.email?.split('@')[0] ?? 'user_${user.id.substring(0, 8)}');

      final profileDisplayName = displayName ??
          user.userMetadata?['display_name'] ??
          user.userMetadata?['full_name'] ??
          profileUsername;

      final response = await http.post(
        Uri.parse('${_getApiBaseUrl()}/profiles/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': user.id,
          'username': profileUsername,
          'displayName': profileDisplayName,
          'bio': isGuest ? '게스트 사용자입니다.' : 'VibeDevEdu에서 코딩을 배우고 있어요! 🚀',
          'avatarUrl': user.userMetadata?['avatar_url'],
          'isGuest': isGuest,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('[AuthService] User profile created: $profileUsername');
      } else {
        print('[AuthService] Profile creation response: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('[AuthService] Error creating user profile via API: $e');
      // Don't throw - profile creation is not critical for login
    }
  }

  /// Get API base URL
  String _getApiBaseUrl() {
    // Use localhost for development, production URL for prod
    if (kIsWeb) {
      return 'http://localhost:8080';
    }
    return 'http://localhost:8080'; // Mobile can use 10.0.2.2 for Android emulator
  }

  /// Create user profile if it doesn't exist (legacy method - kept for compatibility)
  Future<void> _createUserProfileIfNeeded(
    User user, {
    String? username,
    String? displayName,
    bool isGuest = false,
  }) async {
    // Use API method instead
    await _createUserProfileViaApi(
      user,
      username: username,
      displayName: displayName,
      isGuest: isGuest,
    );
  }
}

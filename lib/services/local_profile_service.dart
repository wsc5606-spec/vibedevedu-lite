import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

/// 로컬 사용자 프로필 관리 서비스 (SharedPreferences 기반)
class LocalProfileService {
  static const String _profileKey = 'vibedev_user_profile';

  /// 프로필 저장
  static Future<bool> saveProfile(UserProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(profile.toJson());
      return await prefs.setString(_profileKey, jsonString);
    } catch (e) {
      print('Error saving profile: $e');
      return false;
    }
  }

  /// 프로필 로드
  static Future<UserProfile?> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_profileKey);

      if (jsonString == null) {
        return null;
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfile.fromJson(json);
    } catch (e) {
      print('Error loading profile: $e');
      return null;
    }
  }

  /// 프로필 업데이트
  static Future<bool> updateProfile(UserProfile profile) async {
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());
    return await saveProfile(updatedProfile);
  }

  /// 프로필 삭제
  static Future<bool> deleteProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_profileKey);
    } catch (e) {
      print('Error deleting profile: $e');
      return false;
    }
  }

  /// 프로필 존재 여부 확인
  static Future<bool> hasProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_profileKey);
    } catch (e) {
      print('Error checking profile: $e');
      return false;
    }
  }

  /// 게스트 여부 확인
  static Future<bool> isGuest() async {
    final profile = await loadProfile();
    return profile?.isGuest ?? true;
  }

  /// 외부 이메일 연동
  static Future<bool> linkEmail(String email) async {
    final profile = await loadProfile();
    if (profile == null) return false;

    final updatedProfile = profile.copyWith(
      email: email,
      isGuest: false,
    );

    return await updateProfile(updatedProfile);
  }

  /// 닉네임 업데이트
  static Future<bool> updateNickname(String nickname) async {
    final profile = await loadProfile();
    if (profile == null) return false;

    final updatedProfile = profile.copyWith(nickname: nickname);
    return await updateProfile(updatedProfile);
  }

  /// 프로필 이미지 업데이트
  static Future<bool> updateProfileImage(String imageUrl) async {
    final profile = await loadProfile();
    if (profile == null) return false;

    final updatedProfile = profile.copyWith(profileImageUrl: imageUrl);
    return await updateProfile(updatedProfile);
  }

  /// 자주 쓰는 언어 업데이트
  static Future<bool> updateFavoriteLanguage(String language) async {
    final profile = await loadProfile();
    if (profile == null) return false;

    final updatedProfile = profile.copyWith(favoriteLanguage: language);
    return await updateProfile(updatedProfile);
  }
}

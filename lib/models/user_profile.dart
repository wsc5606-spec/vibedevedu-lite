/// 사용자 프로필 모델
class UserProfile {
  final String? userId;
  final String nickname;
  final String? email;
  final String? profileImageUrl;
  final String? favoriteLanguage;
  final bool isGuest;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    this.userId,
    required this.nickname,
    this.email,
    this.profileImageUrl,
    this.favoriteLanguage,
    this.isGuest = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'favoriteLanguage': favoriteLanguage,
      'isGuest': isGuest,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// JSON에서 생성
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as String?,
      nickname: json['nickname'] as String,
      email: json['email'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      favoriteLanguage: json['favoriteLanguage'] as String?,
      isGuest: json['isGuest'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  /// 복사본 생성 (일부 필드 업데이트)
  UserProfile copyWith({
    String? userId,
    String? nickname,
    String? email,
    String? profileImageUrl,
    String? favoriteLanguage,
    bool? isGuest,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      favoriteLanguage: favoriteLanguage ?? this.favoriteLanguage,
      isGuest: isGuest ?? this.isGuest,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// 게스트 사용자 기본 프로필 생성
  static UserProfile createGuestProfile() {
    return UserProfile(
      nickname: 'Guest_${DateTime.now().millisecondsSinceEpoch % 10000}',
      isGuest: true,
    );
  }
}

/// 사용자 통계 모델
class UserStats {
  final int totalSolved;
  final double accuracy;
  final int totalTimeSeconds;
  final int daysActive;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastSolvedAt;
  final Map<String, int> languageProgress; // {language: solved_count}
  final Map<String, int> difficultyBreakdown; // {difficulty: solved_count}

  UserStats({
    required this.totalSolved,
    required this.accuracy,
    required this.totalTimeSeconds,
    required this.daysActive,
    required this.currentStreak,
    required this.longestStreak,
    this.lastSolvedAt,
    required this.languageProgress,
    required this.difficultyBreakdown,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalSolved: json['total_solved'] ?? 0,
      accuracy: (json['accuracy'] ?? 0.0).toDouble(),
      totalTimeSeconds: json['total_time_seconds'] ?? 0,
      daysActive: json['days_active'] ?? 0,
      currentStreak: json['current_streak'] ?? 0,
      longestStreak: json['longest_streak'] ?? 0,
      lastSolvedAt: json['last_solved_at'] != null
          ? DateTime.parse(json['last_solved_at'])
          : null,
      languageProgress: Map<String, int>.from(json['language_progress'] ?? {}),
      difficultyBreakdown:
          Map<String, int>.from(json['difficulty_breakdown'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_solved': totalSolved,
      'accuracy': accuracy,
      'total_time_seconds': totalTimeSeconds,
      'days_active': daysActive,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_solved_at': lastSolvedAt?.toIso8601String(),
      'language_progress': languageProgress,
      'difficulty_breakdown': difficultyBreakdown,
    };
  }

  /// 총 학습 시간 (시간 단위)
  double get totalHours => totalTimeSeconds / 3600;

  /// 언어별 진행도 퍼센트 (전체 대비)
  Map<String, double> get languageProgressPercent {
    if (totalSolved == 0) return {};
    return languageProgress.map(
      (key, value) => MapEntry(key, (value / totalSolved) * 100),
    );
  }

  /// Empty stats
  static UserStats empty() {
    return UserStats(
      totalSolved: 0,
      accuracy: 0.0,
      totalTimeSeconds: 0,
      daysActive: 0,
      currentStreak: 0,
      longestStreak: 0,
      languageProgress: {},
      difficultyBreakdown: {},
    );
  }
}

/// 전역 통계 모델
class GlobalStats {
  final int totalUsers;
  final int totalSolved;
  final double averageAccuracy;
  final List<TopUser> topUsers;

  GlobalStats({
    required this.totalUsers,
    required this.totalSolved,
    required this.averageAccuracy,
    required this.topUsers,
  });

  factory GlobalStats.fromJson(Map<String, dynamic> json) {
    return GlobalStats(
      totalUsers: json['totalUsers'] ?? 0,
      totalSolved: json['totalSolved'] ?? 0,
      averageAccuracy: (json['averageAccuracy'] ?? 0.0).toDouble(),
      topUsers: (json['topUsers'] as List?)
              ?.map((e) => TopUser.fromJson(e))
              .toList() ??
          [],
    );
  }
}

/// Top User 모델
class TopUser {
  final String userId;
  final String username;
  final int solvedCount;

  TopUser({
    required this.userId,
    required this.username,
    required this.solvedCount,
  });

  factory TopUser.fromJson(Map<String, dynamic> json) {
    return TopUser(
      userId: json['userId'] ?? '',
      username: json['username'] ?? 'Unknown',
      solvedCount: json['solvedCount'] ?? 0,
    );
  }
}

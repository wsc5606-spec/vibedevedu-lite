class UserStats {
  final String userId;
  final int daysActive;
  final int solvedTotal;
  final int correctTotal;
  final int timeTotalSec;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastSolvedAt;
  final double accuracy;
  final Map<String, int> topLanguages;
  final Map<String, int> difficultyStats;

  UserStats({
    required this.userId,
    required this.daysActive,
    required this.solvedTotal,
    required this.correctTotal,
    required this.timeTotalSec,
    required this.currentStreak,
    required this.longestStreak,
    this.lastSolvedAt,
    required this.accuracy,
    required this.topLanguages,
    required this.difficultyStats,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      userId: json['userId'] as String,
      daysActive: json['daysActive'] as int? ?? 0,
      solvedTotal: json['solvedTotal'] as int? ?? 0,
      correctTotal: json['correctTotal'] as int? ?? 0,
      timeTotalSec: json['timeTotalSec'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastSolvedAt: json['lastSolvedAt'] != null
          ? DateTime.parse(json['lastSolvedAt'] as String)
          : null,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      topLanguages: (json['topLanguages'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          {},
      difficultyStats: (json['difficultyStats'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'daysActive': daysActive,
      'solvedTotal': solvedTotal,
      'correctTotal': correctTotal,
      'timeTotalSec': timeTotalSec,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastSolvedAt': lastSolvedAt?.toIso8601String(),
      'accuracy': accuracy,
      'topLanguages': topLanguages,
      'difficultyStats': difficultyStats,
    };
  }

  // Helper getters
  String get formattedTime {
    final hours = timeTotalSec ~/ 3600;
    final minutes = (timeTotalSec % 3600) ~/ 60;
    if (hours > 0) {
      return '$hours h $minutes min';
    }
    return '$minutes min';
  }

  List<MapEntry<String, int>> get topLanguagesList {
    final list = topLanguages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return list;
  }
}

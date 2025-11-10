class UserBestScore {
  final String challengeSlug;
  final String language;
  final int bestScore;
  final double bestAccuracy;
  final int bestTimeSec;
  final DateTime achievedAt;

  UserBestScore({
    required this.challengeSlug,
    required this.language,
    required this.bestScore,
    required this.bestAccuracy,
    required this.bestTimeSec,
    required this.achievedAt,
  });

  factory UserBestScore.fromJson(Map<String, dynamic> json) {
    return UserBestScore(
      challengeSlug: json['challengeSlug'] as String,
      language: json['language'] as String,
      bestScore: json['bestScore'] as int? ?? 0,
      bestAccuracy: (json['bestAccuracy'] as num?)?.toDouble() ?? 0.0,
      bestTimeSec: json['bestTimeSec'] as int? ?? 0,
      achievedAt: DateTime.parse(json['achievedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challengeSlug': challengeSlug,
      'language': language,
      'bestScore': bestScore,
      'bestAccuracy': bestAccuracy,
      'bestTimeSec': bestTimeSec,
      'achievedAt': achievedAt.toIso8601String(),
    };
  }

  String get formattedTime {
    final minutes = bestTimeSec ~/ 60;
    final seconds = bestTimeSec % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class UserRank {
  final int? globalRank;
  final int? weeklyRank;
  final int totalScore;
  final int scoreThisWeek;

  UserRank({
    this.globalRank,
    this.weeklyRank,
    required this.totalScore,
    required this.scoreThisWeek,
  });

  factory UserRank.fromJson(Map<String, dynamic> json) {
    return UserRank(
      globalRank: json['globalRank'] as int?,
      weeklyRank: json['weeklyRank'] as int?,
      totalScore: json['totalScore'] as int? ?? 0,
      scoreThisWeek: json['scoreThisWeek'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'globalRank': globalRank,
      'weeklyRank': weeklyRank,
      'totalScore': totalScore,
      'scoreThisWeek': scoreThisWeek,
    };
  }

  bool get hasGlobalRank => globalRank != null && globalRank! > 0;
  bool get hasWeeklyRank => weeklyRank != null && weeklyRank! > 0;
}

class DifficultyWeight {
  final String difficulty;
  final double weight;
  final String description;

  DifficultyWeight({
    required this.difficulty,
    required this.weight,
    required this.description,
  });

  factory DifficultyWeight.fromJson(Map<String, dynamic> json) {
    return DifficultyWeight(
      difficulty: json['difficulty'] as String,
      weight: (json['weight'] as num).toDouble(),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'difficulty': difficulty,
      'weight': weight,
      'description': description,
    };
  }
}

class SubmissionScore {
  final int finalScore;
  final double accuracy;
  final int speedBonus;
  final double difficultyWeight;
  final bool isCorrect;
  final int testPassed;
  final int testTotal;
  final int timeTakenSec;

  SubmissionScore({
    required this.finalScore,
    required this.accuracy,
    required this.speedBonus,
    required this.difficultyWeight,
    required this.isCorrect,
    required this.testPassed,
    required this.testTotal,
    required this.timeTakenSec,
  });

  factory SubmissionScore.fromJson(Map<String, dynamic> json) {
    return SubmissionScore(
      finalScore: json['finalScore'] as int? ?? 0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      speedBonus: json['speedBonus'] as int? ?? 0,
      difficultyWeight: (json['difficultyWeight'] as num?)?.toDouble() ?? 1.0,
      isCorrect: json['isCorrect'] as bool? ?? false,
      testPassed: json['testPassed'] as int? ?? 0,
      testTotal: json['testTotal'] as int? ?? 0,
      timeTakenSec: json['timeTakenSec'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finalScore': finalScore,
      'accuracy': accuracy,
      'speedBonus': speedBonus,
      'difficultyWeight': difficultyWeight,
      'isCorrect': isCorrect,
      'testPassed': testPassed,
      'testTotal': testTotal,
      'timeTakenSec': timeTakenSec,
    };
  }

  String get formattedAccuracy => '${accuracy.toStringAsFixed(1)}%';

  String get formattedTime {
    final minutes = timeTakenSec ~/ 60;
    final seconds = timeTakenSec % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

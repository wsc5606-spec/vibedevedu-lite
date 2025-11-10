import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// 추천 서비스 - 사용자 맞춤 챌린지 추천
class RecommendService {
  /// 사용자 맞춤 추천 조회
  static Future<RecommendData?> fetchRecommendations(String email) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.base}/recommend/me?email=$email'),
      );

      if (res.statusCode != 200) return null;

      final json = jsonDecode(res.body);
      if (json['ok'] != true) return null;

      return RecommendData.fromJson(json);
    } catch (e) {
      print('Error fetching recommendations: $e');
      return null;
    }
  }

  /// 의미 기반 추천 조회 (특정 문제와 유사한 문제)
  static Future<SemanticRecommendData?> fetchSemantic(String slug) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiConfig.base}/recommend/semantic?slug=$slug'),
      );

      if (res.statusCode != 200) return null;

      final json = jsonDecode(res.body);
      if (json['ok'] != true) return null;

      return SemanticRecommendData.fromJson(json);
    } catch (e) {
      print('Error fetching semantic recommendations: $e');
      return null;
    }
  }
}

/// 추천 데이터 모델
class RecommendData {
  final List<RecommendedChallenge> recommendations;
  final String reason;
  final UserStats userStats;

  RecommendData({
    required this.recommendations,
    required this.reason,
    required this.userStats,
  });

  factory RecommendData.fromJson(Map<String, dynamic> json) {
    return RecommendData(
      recommendations: (json['recommendations'] as List?)
              ?.map((r) => RecommendedChallenge.fromJson(r))
              .toList() ??
          [],
      reason: json['reason'] as String? ?? 'unknown',
      userStats: UserStats.fromJson(json['user_stats'] ?? {}),
    );
  }
}

/// 추천 챌린지 모델
class RecommendedChallenge {
  final String slug;
  final String title;
  final String language;
  final String difficulty;
  final String? description;

  RecommendedChallenge({
    required this.slug,
    required this.title,
    required this.language,
    required this.difficulty,
    this.description,
  });

  factory RecommendedChallenge.fromJson(Map<String, dynamic> json) {
    return RecommendedChallenge(
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? 'Unknown',
      language: json['language'] as String? ?? 'unknown',
      difficulty: json['difficulty'] as String? ?? 'beginner',
      description: json['description'] as String?,
    );
  }
}

/// 사용자 통계 모델
class UserStats {
  final int totalSubmissions;
  final String topLanguage;
  final int averageScore;
  final int solvedCount;
  final String? recommendedDifficulty;

  UserStats({
    required this.totalSubmissions,
    required this.topLanguage,
    required this.averageScore,
    required this.solvedCount,
    this.recommendedDifficulty,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalSubmissions: json['total_submissions'] as int? ?? 0,
      topLanguage: json['top_language'] as String? ?? 'unknown',
      averageScore: json['average_score'] as int? ?? 0,
      solvedCount: json['solved_count'] as int? ?? 0,
      recommendedDifficulty: json['recommended_difficulty'] as String?,
    );
  }
}

/// 의미 기반 추천 데이터 모델
class SemanticRecommendData {
  final List<SemanticChallenge> recommendations;
  final String reason;
  final BaseChallenge? baseChallenge;

  SemanticRecommendData({
    required this.recommendations,
    required this.reason,
    this.baseChallenge,
  });

  factory SemanticRecommendData.fromJson(Map<String, dynamic> json) {
    return SemanticRecommendData(
      recommendations: (json['recommendations'] as List?)
              ?.map((r) => SemanticChallenge.fromJson(r))
              .toList() ??
          [],
      reason: json['reason'] as String? ?? 'unknown',
      baseChallenge: json['base_challenge'] != null
          ? BaseChallenge.fromJson(json['base_challenge'])
          : null,
    );
  }
}

/// 의미 기반 추천 챌린지 모델 (유사도 포함)
class SemanticChallenge {
  final String slug;
  final String title;
  final String language;
  final String difficulty;
  final String? description;
  final double? similarity;

  SemanticChallenge({
    required this.slug,
    required this.title,
    required this.language,
    required this.difficulty,
    this.description,
    this.similarity,
  });

  factory SemanticChallenge.fromJson(Map<String, dynamic> json) {
    return SemanticChallenge(
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? 'Unknown',
      language: json['language'] as String? ?? 'unknown',
      difficulty: json['difficulty'] as String? ?? 'beginner',
      description: json['description'] as String?,
      similarity: (json['similarity'] as num?)?.toDouble(),
    );
  }
}

/// 기준 챌린지 모델
class BaseChallenge {
  final String slug;
  final String title;
  final String language;

  BaseChallenge({
    required this.slug,
    required this.title,
    required this.language,
  });

  factory BaseChallenge.fromJson(Map<String, dynamic> json) {
    return BaseChallenge(
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? 'Unknown',
      language: json['language'] as String? ?? 'unknown',
    );
  }
}

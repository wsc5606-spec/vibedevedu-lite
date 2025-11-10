import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/quiz_model.dart';

/// 퀴즈 서비스
class QuizService {
  // 스택 목록 (프레임워크/플랫폼)
  static const List<String> stacks = [
    'flutter',
    'react',
    'supabase',
    'firebase',
    'springboot',
    'nestjs',
    'angular',
  ];

  // 개발도구 목록
  static const List<String> devtools = [
    'git',
    'docker',
    'vscode',
    'androidstudio',
    'cicd',
  ];

  bool isStack(String languageId) {
    return stacks.contains(languageId);
  }

  bool isDevtool(String languageId) {
    return devtools.contains(languageId);
  }

  /// 언어별/스택별/개발도구별 퀴즈 파일 경로
  static String getQuizFilePath(String languageId) {
    // 스택 또는 개발도구면 stack-quiz 폴더에서 로드
    if (stacks.contains(languageId) || devtools.contains(languageId)) {
      return 'assets/stack-quiz/$languageId-quiz.json';
    }
    // 언어면 quiz 폴더에서 로드
    return 'assets/quiz/$languageId-quiz.json';
  }

  /// 퀴즈 콘텐츠 로드
  Future<QuizContent> loadQuizContent(String languageId) async {
    try {
      final String jsonString = await rootBundle.loadString(
        getQuizFilePath(languageId),
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return QuizContent.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load quiz content for $languageId: $e');
    }
  }
}

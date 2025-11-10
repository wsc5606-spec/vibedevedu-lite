import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/grammar_model.dart';

class GrammarService {
  static const List<LanguageInfo> supportedLanguages = [
    LanguageInfo(id: 'python', name: 'Python', icon: '🐍', color: '#3776AB'),
    LanguageInfo(id: 'javascript', name: 'JavaScript', icon: '📜', color: '#F7DF1E'),
    LanguageInfo(id: 'typescript', name: 'TypeScript', icon: '💙', color: '#3178C6'),
    LanguageInfo(id: 'java', name: 'Java', icon: '☕', color: '#007396'),
    LanguageInfo(id: 'c', name: 'C', icon: '🔧', color: '#A8B9CC'),
    LanguageInfo(id: 'cpp', name: 'C++', icon: '⚡', color: '#00599C'),
    LanguageInfo(id: 'csharp', name: 'C#', icon: '🎯', color: '#239120'),
    LanguageInfo(id: 'go', name: 'Go', icon: '🐹', color: '#00ADD8'),
    LanguageInfo(id: 'dart', name: 'Dart', icon: '🎯', color: '#0175C2'),
    LanguageInfo(id: 'kotlin', name: 'Kotlin', icon: '🅺', color: '#7F52FF'),
    LanguageInfo(id: 'sql', name: 'SQL', icon: '🗄️', color: '#4479A1'),
    LanguageInfo(id: 'html', name: 'HTML', icon: '🌐', color: '#E34F26'),
    LanguageInfo(id: 'css', name: 'CSS', icon: '🎨', color: '#1572B6'),
    LanguageInfo(id: 'rust', name: 'Rust', icon: '🦀', color: '#CE422B'),
  ];

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

  Future<GrammarContent> loadGrammarContent(String languageId) async {
    try {
      // Angular와 Android Studio는 JSON 파일로 로드
      if (languageId == 'angular' || languageId == 'androidstudio') {
        final String jsonString = await rootBundle.loadString(
          'assets/grammar/${languageId}-grammar.json',
        );
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        return GrammarContent.fromJson(jsonData);
      }

      // 다른 스택 또는 개발도구면 마크다운 파일에서 로드
      if (isStack(languageId) || isDevtool(languageId)) {
        return await _loadStackBasics(languageId);
      }

      // 언어면 JSON 파일에서 로드
      final String jsonString = await rootBundle.loadString(
        'assets/grammar/${languageId}-grammar.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return GrammarContent.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load grammar content for $languageId: $e');
    }
  }

  // 스택 기초 학습 콘텐츠 로드 (마크다운 파일)
  Future<GrammarContent> _loadStackBasics(String stackId) async {
    List<GrammarChapter> chapters = [];

    for (int i = 1; i <= 10; i++) {
      try {
        final String markdown = await rootBundle.loadString(
          'assets/stack-basics/${stackId}-basics-${i.toString().padLeft(2, '0')}.md',
        );

        // 마크다운에서 제목 추출 (첫 번째 # 라인)
        String title = 'Chapter $i';
        final lines = markdown.split('\n');
        for (var line in lines) {
          if (line.startsWith('#') && !line.startsWith('##')) {
            title = line.replaceFirst('#', '').trim();
            break;
          }
        }

        chapters.add(GrammarChapter(
          chapterId: i,
          title: title,
          content: markdown,
        ));
      } catch (e) {
        throw Exception('Failed to load chapter $i for $stackId: $e');
      }
    }

    return GrammarContent(
      language: stackId,
      chapters: chapters,
    );
  }

  LanguageInfo? getLanguageInfo(String languageId) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.id == languageId);
    } catch (e) {
      return null;
    }
  }
}

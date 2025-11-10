class GrammarChapter {
  final int chapterId;
  final String title;
  final String content;

  GrammarChapter({
    required this.chapterId,
    required this.title,
    required this.content,
  });

  factory GrammarChapter.fromJson(Map<String, dynamic> json) {
    return GrammarChapter(
      chapterId: json['chapterId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

class GrammarContent {
  final String language;
  final List<GrammarChapter> chapters;

  GrammarContent({
    required this.language,
    required this.chapters,
  });

  factory GrammarContent.fromJson(Map<String, dynamic> json) {
    return GrammarContent(
      language: json['language'] as String,
      chapters: (json['chapters'] as List)
          .map((chapter) => GrammarChapter.fromJson(chapter))
          .toList(),
    );
  }
}

class LanguageInfo {
  final String id;
  final String name;
  final String icon;
  final String color;

  const LanguageInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

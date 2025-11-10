/// 퀴즈 문제 모델
class QuizQuestion {
  final int id;
  final int chapter;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.chapter,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as int,
      chapter: json['chapter'] as int,
      question: json['question'] as String,
      options: (json['options'] as List).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as int,
      explanation: json['explanation'] as String,
    );
  }
}

/// 퀴즈 콘텐츠 (언어별 전체 문제)
class QuizContent {
  final String language;
  final List<QuizQuestion> questions;

  QuizContent({
    required this.language,
    required this.questions,
  });

  factory QuizContent.fromJson(Map<String, dynamic> json) {
    return QuizContent(
      language: json['language'] as String,
      questions: (json['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q))
          .toList(),
    );
  }

  /// 50개 중 랜덤으로 10개 선택
  List<QuizQuestion> getRandomQuestions({int count = 10}) {
    final shuffled = List<QuizQuestion>.from(questions)..shuffle();
    return shuffled.take(count).toList();
  }
}

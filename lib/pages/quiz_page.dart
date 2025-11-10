import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/platform_utils.dart';
import '../services/quiz_service.dart';
import '../models/quiz_model.dart';

/// 객관식 문제 풀어보기 페이지 (v2.5: 랜덤 10문제, 틀린 문제 분석, AI 조언)
class QuizPage extends StatefulWidget {
  final String language;

  const QuizPage({
    super.key,
    required this.language,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizService _quizService = QuizService();

  int _currentQuestionIndex = 0;
  Map<int, int> _selectedAnswers = {}; // 문제 번호 -> 선택된 답 인덱스
  bool _showResults = false;
  int _score = 0;
  List<int> _wrongQuestionIndices = []; // 틀린 문제 인덱스들

  // 실제 출제될 10문제 (QuizQuestion 객체들)
  List<QuizQuestion> _selectedQuestions = [];
  bool _isLoading = true;
  String? _errorMessage;

  bool _isStack() {
    return _quizService.isStack(widget.language);
  }

  bool _isDevtool() {
    return _quizService.isDevtool(widget.language);
  }

  String _getLearningTitle() {
    if (_isStack() || _isDevtool()) {
      return '기초 끝장내기';
    }
    return '문법 끝장내기';
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final content = await _quizService.loadQuizContent(widget.language);
      final randomQuestions = content.getRandomQuestions(count: 10);

      setState(() {
        _selectedQuestions = randomQuestions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '퀴즈를 불러오는데 실패했습니다: $e';
        _isLoading = false;
      });
    }
  }

  String _getLanguageDisplayName() {
    final languageNames = {
      'python': 'Python',
      'javascript': 'JavaScript',
      'typescript': 'TypeScript',
      'java': 'Java',
      'c': 'C',
      'cpp': 'C++',
      'csharp': 'C#',
      'go': 'Go',
      'dart': 'Dart',
      'kotlin': 'Kotlin',
      'sql': 'SQL',
      'html': 'HTML',
      'css': 'CSS',
    };
    return languageNames[widget.language] ?? widget.language.toUpperCase();
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _selectedQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _submitQuiz() {
    int score = 0;
    List<int> wrongIndices = [];

    for (int i = 0; i < _selectedQuestions.length; i++) {
      if (_selectedAnswers[i] == _selectedQuestions[i].correctAnswer) {
        score++;
      } else {
        wrongIndices.add(i);
      }
    }

    setState(() {
      _score = score;
      _wrongQuestionIndices = wrongIndices;
      _showResults = true;
    });
  }

  void _retryQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswers = {};
      _showResults = false;
      _score = 0;
      _wrongQuestionIndices = [];
    });
    // 새로운 10문제 랜덤 선택
    _loadQuestions();
  }

  // 취약한 챕터 분석
  String _getWeakChapters() {
    if (_wrongQuestionIndices.isEmpty) return '';

    Map<int, int> chapterErrors = {};
    for (int idx in _wrongQuestionIndices) {
      int chapter = _selectedQuestions[idx].chapter;
      chapterErrors[chapter] = (chapterErrors[chapter] ?? 0) + 1;
    }

    // 가장 많이 틀린 챕터 찾기
    var sorted = chapterErrors.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sorted.isEmpty) return '';
    return sorted.map((e) => '${e.key}장').take(2).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final langName = _getLanguageDisplayName();

    if (_showResults) {
      return _buildResultsScreen();
    }

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$langName 객관식 문제',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                )
              : _errorMessage != null
                  ? _buildErrorScreen()
                  : _buildQuizScreen(),
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadQuestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    if (_selectedQuestions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.tealAccent),
      );
    }

    final question = _selectedQuestions[_currentQuestionIndex];
    final selectedAnswer = _selectedAnswers[_currentQuestionIndex];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: PlatformUtils.getMaxContentWidth(context),
        ),
        child: SingleChildScrollView(
          padding: PlatformUtils.responsivePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 진행 표시
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _selectedQuestions.length,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
              ),
              const SizedBox(height: 16),
              Text(
                '문제 ${_currentQuestionIndex + 1} / ${_selectedQuestions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // 문제
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.tealAccent.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 선택지
              ...List.generate(
                question.options.length,
                (index) {
                  final option = question.options[index];
                  final isSelected = selectedAnswer == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildOptionCard(
                      option: option,
                      index: index,
                      isSelected: isSelected,
                      onTap: () => _selectAnswer(index),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // 네비게이션 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentQuestionIndex > 0)
                    ElevatedButton.icon(
                      onPressed: _previousQuestion,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('이전'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  if (_currentQuestionIndex > 0)
                    const SizedBox(width: 16),
                  if (_currentQuestionIndex < _selectedQuestions.length - 1)
                    ElevatedButton.icon(
                      onPressed: _nextQuestion,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('다음'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: _selectedAnswers.length == _selectedQuestions.length
                          ? _submitQuiz
                          : null,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('제출하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String option,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Card(
      color: isSelected ? Colors.tealAccent.withOpacity(0.2) : Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.tealAccent : Colors.grey[700]!,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // 선택 원
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.tealAccent : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.tealAccent : Colors.grey[600]!,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.black,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              // 옵션 텍스트
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.tealAccent : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final percentage = (_score / _selectedQuestions.length * 100).round();
    final passed = percentage >= 70;
    final weakChapters = _getWeakChapters();

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '결과',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: PlatformUtils.getMaxContentWidth(context),
              ),
              child: SingleChildScrollView(
                padding: PlatformUtils.responsivePadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 결과 아이콘
                    Icon(
                      passed ? Icons.celebration : Icons.sentiment_dissatisfied,
                      size: 100,
                      color: passed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 24),

                    // 결과 텍스트
                    Text(
                      passed ? '합격!' : '다시 도전하세요!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: passed ? Colors.green : Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 점수
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: passed
                              ? Colors.green.withOpacity(0.5)
                              : Colors.orange.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$_score / ${_selectedQuestions.length}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$percentage점',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 틀린 문제가 있으면 표시
                    if (_wrongQuestionIndices.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.error_outline, color: Colors.redAccent, size: 28),
                                SizedBox(width: 12),
                                Text(
                                  '틀린 문제 분석',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ..._wrongQuestionIndices.map((idx) {
                              final q = _selectedQuestions[idx];
                              final userAnswer = _selectedAnswers[idx];
                              final correctAnswer = q.correctAnswer;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Q${idx + 1}. ${q.question}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (userAnswer != null)
                                      Row(
                                        children: [
                                          const Icon(Icons.close, color: Colors.red, size: 20),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              '내 답: ${q.options[userAnswer]}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.green, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '정답: ${q.options[correctAnswer]}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '💡 ${q.explanation}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // AI 학습 조언
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.purple.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.lightbulb_outline, color: Colors.purpleAccent, size: 28),
                                SizedBox(width: 12),
                                Text(
                                  'AI 학습 조언',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              weakChapters.isNotEmpty
                                  ? '🎯 $weakChapters 단원을 다시 복습해보세요!\n\n'
                                      '이 부분에서 ${_wrongQuestionIndices.length}개의 문제를 틀렸어요. '
                                      '${_getLearningTitle()}로 돌아가서 해당 챕터를 다시 학습하면 실력이 향상될 거예요!'
                                  : '완벽합니다! 모든 문제를 맞히셨네요! 다음 단계로 넘어가세요.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[300],
                                height: 1.6,
                              ),
                            ),
                            if (weakChapters.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // 기초/문법 끝장내기 페이지로 이동
                                  Navigator.pushNamed(
                                    context,
                                    '/basic/${widget.language}/grammar',
                                  );
                                },
                                icon: const Icon(Icons.menu_book),
                                label: Text('${_getLearningTitle()}로 이동'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purpleAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 48),

                    // 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _retryQuiz,
                          icon: const Icon(Icons.refresh),
                          label: const Text('다시 풀기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.home),
                          label: const Text('돌아가기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}

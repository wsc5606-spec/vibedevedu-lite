import 'package:flutter/material.dart';
import 'topics_page.dart';
import 'basic_learning_page.dart';
import 'chapter_select_page.dart';
import '../core/theme/app_colors.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/floating_chatbot_button.dart';

/// 학습 모드 선택 페이지: 도전/응용/실전 중 선택 (v1.8: 상단바/하단바 추가)
class ModeSelectPage extends StatefulWidget {
  final String language;

  const ModeSelectPage({super.key, required this.language});

  @override
  State<ModeSelectPage> createState() => _ModeSelectPageState();
}

class _ModeSelectPageState extends State<ModeSelectPage> {
  int _currentIndex = 0;

  String _getLanguageDisplayName() {
    switch (widget.language) {
      case 'python':
        return 'Python';
      case 'dart':
        return 'Dart';
      case 'go':
        return 'Go';
      case 'java':
        return 'Java';
      case 'supabase':
        return 'Supabase';
      case 'firebase':
        return 'Firebase';
      default:
        return widget.language.toUpperCase();
    }
  }

  Color _getLanguageColor() {
    switch (widget.language) {
      case 'python':
        return AppColors.python;
      case 'dart':
        return AppColors.dart;
      case 'go':
        return AppColors.go;
      case 'java':
        return AppColors.java;
      case 'supabase':
        return AppColors.supabase;
      case 'firebase':
        return AppColors.firebase;
      default:
        return AppColors.primary;
    }
  }

  bool _isStackOrDevTools(String language) {
    // 스택 카테고리
    const stackItems = ['flutter', 'react', 'supabase', 'springboot', 'nestjs', 'firebase', 'angular'];
    // 개발도구 카테고리
    const devToolsItems = ['git', 'docker', 'vscode', 'cicd', 'androidstudio', 'jupyter'];

    return stackItems.contains(language) || devToolsItems.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    final langColor = _getLanguageColor();
    final langName = _getLanguageDisplayName();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$langName 모드 선택',
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        const Color(0xFF000000),
                        const Color(0xFF121212),
                      ]
                    : [
                        Colors.grey[50]!,
                        Colors.grey[100]!,
                      ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 상단 안내 텍스트
                        Text(
                      '학습 단계를 선택하세요',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                      '기초부터 실전까지 단계별로 학습하세요',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),

                        // 기초 학습 (신규)
                        _buildModeCard(
                      context,
                      category: 'basic',
                      title: '기초 학습',
                      description: '문법 끝장내기 & 객관식 문제로 기초를 다집니다',
                      icon: Icons.school_outlined,
                      color: const Color(0xFF00E5FF), // 밝은 시안
                          isDark: isDark,
                        ),
                        const SizedBox(height: 20),

                        // 챌린지 (통합)
                        _buildModeCard(
                      context,
                      category: 'challenge',
                      title: '챌린지',
                      description: '기본 문법부터 심화까지 모든 문제를 풀어보세요',
                      icon: Icons.lightbulb_outline,
                      color: langColor,
                          isDark: isDark,
                        ),
                        const SizedBox(height: 20),

                        // 실전 챌린지 (기존 실전문제)
                        _buildModeCard(
                      context,
                      category: 'practice',
                      title: '실전 챌린지',
                      description: '장문의 코딩을 진행해야 하는 실전 문제입니다',
                      icon: Icons.rocket_launch_outlined,
                          color: const Color(0xFFFF6B35), // 오렌지
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 플로팅 챗봇 버튼
          const FloatingChatbotButton(),
        ],
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String category,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            // 스택/개발도구에서 챌린지와 실전 챌린지는 OBT 예고 메시지 표시
            final isStackOrDevTools = _isStackOrDevTools(widget.language);
            if (isStackOrDevTools && (category == 'challenge' || category == 'practice')) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('OBT 준비 중'),
                  content: const Text('챌린지 모드는 OBT(공개 베타 테스트) 기간에 만나보실 수 있습니다!\n곧 출시될 예정이니 기대해주세요 😊'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
              return;
            }

            // 기초 학습은 BasicLearningPage로 이동
            if (category == 'basic') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BasicLearningPage(
                    language: widget.language,
                  ),
                ),
              );
            } else if (category == 'challenge') {
              // 챌린지는 ChapterSelectPage로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterSelectPage(
                    language: widget.language,
                  ),
                ),
              );
            } else {
              // 나머지는 기존처럼 TopicsPage로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicsPage(
                    language: widget.language,
                    category: category,
                  ),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        color.withOpacity(0.15),
                        color.withOpacity(0.05),
                      ]
                    : [
                        color.withOpacity(0.1),
                        color.withOpacity(0.02),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                // 아이콘
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color.withOpacity(isDark ? 0.3 : 0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(width: 20),
                // 텍스트
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                // 화살표 아이콘
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

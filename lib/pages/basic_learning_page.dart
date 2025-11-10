import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/platform_utils.dart';

/// 기초 학습 페이지 - 문법 끝장내기 & 객관식 문제
class BasicLearningPage extends StatefulWidget {
  final String language;

  const BasicLearningPage({
    super.key,
    required this.language,
  });

  @override
  State<BasicLearningPage> createState() => _BasicLearningPageState();
}

class _BasicLearningPageState extends State<BasicLearningPage> {
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
      case 'javascript':
        return 'JavaScript';
      case 'typescript':
        return 'TypeScript';
      case 'supabase':
        return 'Supabase';
      case 'firebase':
        return 'Firebase';
      case 'flutter':
        return 'Flutter';
      case 'react':
        return 'React';
      case 'nestjs':
        return 'NestJS';
      case 'springboot':
        return 'Spring Boot';
      case 'angular':
        return 'Angular';
      case 'git':
        return 'Git';
      case 'docker':
        return 'Docker';
      case 'vscode':
        return 'VS Code';
      case 'cicd':
        return 'CI/CD';
      default:
        return widget.language.toUpperCase();
    }
  }

  Color _getLanguageColor() {
    switch (widget.language) {
      case 'python':
        return const Color(0xFF3776AB);
      case 'dart':
        return const Color(0xFF0175C2);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'java':
        return const Color(0xFFFF6B35);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'flutter':
        return const Color(0xFF00E5FF);
      case 'react':
        return const Color(0xFF61DAFB);
      case 'supabase':
        return const Color(0xFF3ECF8E);
      case 'springboot':
        return const Color(0xFF6DB33F);
      case 'nestjs':
        return const Color(0xFFE0234E);
      default:
        return const Color(0xFF00E5FF);
    }
  }

  bool _isStack() {
    return ['flutter', 'react', 'supabase', 'firebase', 'springboot', 'nestjs', 'angular'].contains(widget.language);
  }

  bool _isDevtool() {
    return ['git', 'docker', 'vscode', 'cicd'].contains(widget.language);
  }

  String _getLearningTitle() {
    if (_isStack() || _isDevtool()) {
      return '기초 끝장내기';
    }
    return '문법 끝장내기';
  }

  @override
  Widget build(BuildContext context) {
    final langColor = _getLanguageColor();
    final langName = _getLanguageDisplayName();
    final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$langName 기초 학습',
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
                    // 상단 안내 텍스트
                    Icon(
                      Icons.school_outlined,
                      size: isTabletOrLarger ? 100 : 80,
                      color: langColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '$langName 기초 학습',
                      style: TextStyle(
                        fontSize: isTabletOrLarger ? 32 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '기초를 탄탄히 다져보세요',
                      style: TextStyle(
                        fontSize: isTabletOrLarger ? 18 : 16,
                        color: Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // 학습 모드 카드들
                    if (isTabletOrLarger)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildLearningModeCard(
                              context,
                              mode: 'grammar',
                              title: _getLearningTitle(),
                              description: _isStack() ? '핵심 개념을 체계적으로 학습합니다' : '핵심 문법을 체계적으로 학습합니다',
                              icon: Icons.menu_book_rounded,
                              color: const Color(0xFF00E5FF),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildLearningModeCard(
                              context,
                              mode: 'quiz',
                              title: '객관식 문제 풀어보기',
                              description: '배운 내용을 퀴즈로 확인합니다',
                              icon: Icons.quiz_outlined,
                              color: const Color(0xFF1DE9B6),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildLearningModeCard(
                            context,
                            mode: 'grammar',
                            title: _getLearningTitle(),
                            description: _isStack() ? '핵심 개념을 체계적으로 학습합니다' : '핵심 문법을 체계적으로 학습합니다',
                            icon: Icons.menu_book_rounded,
                            color: const Color(0xFF00E5FF),
                          ),
                          const SizedBox(height: 20),
                          _buildLearningModeCard(
                            context,
                            mode: 'quiz',
                            title: '객관식 문제 풀어보기',
                            description: '배운 내용을 퀴즈로 확인합니다',
                            icon: Icons.quiz_outlined,
                            color: const Color(0xFF1DE9B6),
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

  Widget _buildLearningModeCard(
    BuildContext context, {
    required String mode,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.2),
              color.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: () {
            // 라우팅
            if (mode == 'grammar') {
              Navigator.pushNamed(
                context,
                '/basic/${widget.language}/grammar',
              );
            } else if (mode == 'quiz') {
              Navigator.pushNamed(
                context,
                '/basic/${widget.language}/quiz',
              );
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아이콘
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 50,
                    color: color,
                  ),
                ),
                const SizedBox(height: 24),
                // 타이틀
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // 설명
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    if (mode == 'grammar') {
                      Navigator.pushNamed(
                        context,
                        '/basic/${widget.language}/grammar',
                      );
                    } else if (mode == 'quiz') {
                      Navigator.pushNamed(
                        context,
                        '/basic/${widget.language}/quiz',
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('시작하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

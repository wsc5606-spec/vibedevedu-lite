import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'level_grid_page.dart';

/// 챕터 선택 페이지 - 10개 단원으로 구분
class ChapterSelectPage extends StatelessWidget {
  final String language;

  const ChapterSelectPage({
    super.key,
    required this.language,
  });

  String _getLanguageDisplayName() {
    switch (language.toLowerCase()) {
      case 'python':
        return 'Python';
      case 'javascript':
        return 'JavaScript';
      case 'dart':
        return 'Dart';
      case 'c':
        return 'C';
      case 'cpp':
        return 'C++';
      case 'csharp':
        return 'C#';
      case 'java':
        return 'Java';
      case 'kotlin':
        return 'Kotlin';
      case 'go':
        return 'Go';
      case 'typescript':
        return 'TypeScript';
      case 'sql':
        return 'SQL';
      case 'html':
        return 'HTML';
      case 'css':
        return 'CSS';
      default:
        return language.toUpperCase();
    }
  }

  Color _getLanguageColor() {
    switch (language.toLowerCase()) {
      case 'python':
        return const Color(0xFF00E5FF);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'dart':
        return const Color(0xFF1DE9B6);
      case 'c':
        return const Color(0xFF555555);
      case 'cpp':
        return const Color(0xFF00599C);
      case 'csharp':
        return const Color(0xFF239120);
      case 'java':
        return const Color(0xFFFF6B35);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      case 'go':
        return const Color(0xFF00ADD8);
      case 'sql':
        return const Color(0xFF00758F);
      case 'html':
        return const Color(0xFFE34F26);
      case 'css':
        return const Color(0xFF1572B6);
      default:
        return Colors.grey;
    }
  }

  List<Map<String, String>> _getChapters() {
    // 언어별로 10개 단원 정의
    // 일단 Python 기준으로 하고, 다른 언어도 비슷한 구조
    return [
      {'id': '1', 'title': '출력과 주석', 'icon': '📝'},
      {'id': '2', 'title': '변수와 자료형', 'icon': '📦'},
      {'id': '3', 'title': '연산자', 'icon': '➕'},
      {'id': '4', 'title': '조건문', 'icon': '🔀'},
      {'id': '5', 'title': '반복문', 'icon': '🔄'},
      {'id': '6', 'title': '함수', 'icon': '⚡'},
      {'id': '7', 'title': '리스트·배열·컬렉션', 'icon': '📚'},
      {'id': '8', 'title': '딕셔너리·맵·세트', 'icon': '🗂️'},
      {'id': '9', 'title': '입출력', 'icon': '💾'},
      {'id': '10', 'title': '예외처리·오류 관리', 'icon': '🛡️'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final langName = _getLanguageDisplayName();
    final langColor = _getLanguageColor();
    final chapters = _getChapters();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$langName 챌린지',
      ),
      body: Container(
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
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  // 헤더
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 48,
                          color: langColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '단원을 선택하세요',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '총 ${chapters.length}개 단원',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // 챕터 그리드
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = chapters[index];
                        return _buildChapterCard(
                          context,
                          chapterId: chapter['id']!,
                          title: chapter['title']!,
                          icon: chapter['icon']!,
                          color: langColor,
                          isDark: isDark,
                        );
                      },
                    ),
                  ),
                ],
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

  Widget _buildChapterCard(
    BuildContext context, {
    required String chapterId,
    required String title,
    required String icon,
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
            // 해당 챕터의 문제들로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LevelGridPage(
                  language: language,
                  kind: 'challenge',
                  chapterId: int.parse(chapterId),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 아이콘/이모지
                Text(
                  icon,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 6),
                // 챕터 번호
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(isDark ? 0.3 : 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$chapterId단원',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // 제목
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

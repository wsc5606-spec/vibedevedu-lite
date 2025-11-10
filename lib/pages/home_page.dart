import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/floating_chatbot_button.dart';
import '../utils/platform_utils.dart';

/// 홈 페이지 - 언어 선택 (v1.8: 상단바/하단바 통합)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VibDevTopAppBar(
        title: '언어 선택',
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF121212),
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                // 로고/타이틀 (v1.9: 로봇 아이콘으로 변경)
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E5FF).withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.smart_toy_rounded,
                    size: 80,
                    color: Color(0xFF00E5FF),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'AI 코딩 챌린지 플랫폼',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '카테고리를 선택하세요',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 48),

                    // 카테고리 선택 카드들 (반응형)
                    _buildResponsiveCategoryGrid(context),
                  ],
                ),
              ),
            ),
          ),
          // 플로팅 챗봇 버튼
          const FloatingChatbotButton(),
        ],
      ),
      bottomNavigationBar: const VibDevBottomNavBar(
        currentIndex: 2, // 홈 (커리큘럼 추가로 index 2로 변경)
      ),
    );
  }

  // 반응형 카테고리 그리드
  Widget _buildResponsiveCategoryGrid(BuildContext context) {
    final screenType = PlatformUtils.getScreenType(context);
    final categories = [
      {
        'category': 'language',
        'displayName': '언어',
        'icon': Icons.smart_toy_rounded,
        'color': const Color(0xFF00E5FF),
        'description': '프로그래밍 언어 학습',
      },
      {
        'category': 'stack',
        'displayName': '스택',
        'icon': Icons.layers,
        'color': const Color(0xFF1DE9B6),
        'description': '개발 스택 & 프레임워크',
      },
      {
        'category': 'devtools',
        'displayName': '개발도구',
        'icon': Icons.build_circle,
        'color': const Color(0xFFFF6B35),
        'description': '개발 도구 & 환경',
      },
    ];

    // 화면 크기에 따라 카드 크기 조정
    double cardWidth;
    double cardHeight;
    switch (screenType) {
      case ScreenType.desktop:
        cardWidth = 280;
        cardHeight = 300;
        break;
      case ScreenType.tablet:
        cardWidth = 240;
        cardHeight = 260;
        break;
      default:
        cardWidth = 200;
        cardHeight = 220;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (cardWidth * 3) + 32, // 3 cards + spacing
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: categories.map((cat) {
            return _buildCategoryCard(
              context,
              category: cat['category'] as String,
              displayName: cat['displayName'] as String,
              icon: cat['icon'] as IconData,
              color: cat['color'] as Color,
              description: cat['description'] as String,
              width: cardWidth,
              height: cardHeight,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String category,
    required String displayName,
    required IconData icon,
    required Color color,
    required String description,
    required double width,
    required double height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: Colors.white10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // 모든 카테고리를 카테고리 선택 페이지로 이동
            Navigator.pushNamed(context, '/category/$category');
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: width * 0.23, // 반응형 아이콘 크기
                  color: color,
                ),
                const SizedBox(height: 16),
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: width * 0.08, // 반응형 폰트 크기
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: width * 0.055,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

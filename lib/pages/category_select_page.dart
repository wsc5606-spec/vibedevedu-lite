import 'package:flutter/material.dart';
import '../widgets/top_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/floating_chatbot_button.dart';

/// 카테고리 선택 후 세부 항목 선택 페이지
class CategorySelectPage extends StatelessWidget {
  final String category;

  const CategorySelectPage({
    super.key,
    required this.category,
  });

  String get categoryDisplayName {
    switch (category) {
      case 'language':
        return '언어';
      case 'stack':
        return '스택';
      case 'devtools':
        return '개발도구';
      default:
        return category;
    }
  }

  List<Map<String, dynamic>> get items {
    switch (category) {
      case 'language':
        return [
          // 기존 언어들 (문제 있음)
          {
            'id': 'python',
            'name': 'Python',
            'icon': Icons.code,
            'color': const Color(0xFF00E5FF),
            'description': '초보자에게 친화적인 언어',
          },
          {
            'id': 'dart',
            'name': 'Dart',
            'icon': Icons.flutter_dash,
            'color': const Color(0xFF1DE9B6),
            'description': 'Flutter 개발 언어',
          },
          {
            'id': 'go',
            'name': 'Go',
            'icon': Icons.speed,
            'color': const Color(0xFF00ADD8),
            'description': '빠르고 간결한 언어',
          },
          {
            'id': 'java',
            'name': 'Java',
            'icon': Icons.coffee,
            'color': const Color(0xFFFF6B35),
            'description': '엔터프라이즈 표준 언어',
          },
          // 새로운 언어들
          {
            'id': 'typescript',
            'name': 'TypeScript',
            'icon': Icons.code_rounded,
            'color': const Color(0xFF3178C6),
            'description': '타입 안정성이 있는 JavaScript',
          },
          {
            'id': 'javascript',
            'name': 'JavaScript',
            'icon': Icons.javascript,
            'color': const Color(0xFFF7DF1E),
            'description': '웹 개발의 필수 언어',
          },
          {
            'id': 'sql',
            'name': 'SQL',
            'icon': Icons.storage,
            'color': const Color(0xFF00758F),
            'description': '데이터베이스 쿼리 언어',
          },
          {
            'id': 'c',
            'name': 'C',
            'icon': Icons.memory,
            'color': const Color(0xFF555555),
            'description': '시스템 프로그래밍 언어',
          },
          {
            'id': 'cpp',
            'name': 'C++',
            'icon': Icons.developer_board,
            'color': const Color(0xFF00599C),
            'description': '객체지향 시스템 언어',
          },
          {
            'id': 'csharp',
            'name': 'C#',
            'icon': Icons.terminal,
            'color': const Color(0xFF239120),
            'description': '.NET 개발 언어',
          },
          {
            'id': 'kotlin',
            'name': 'Kotlin',
            'icon': Icons.android,
            'color': const Color(0xFF7F52FF),
            'description': 'Android 공식 언어',
          },
          {
            'id': 'html',
            'name': 'HTML',
            'icon': Icons.web,
            'color': const Color(0xFFE34F26),
            'description': '웹 구조 마크업 언어',
          },
          {
            'id': 'css',
            'name': 'CSS',
            'icon': Icons.palette,
            'color': const Color(0xFF1572B6),
            'description': '웹 스타일링 언어',
          },
        ];
      case 'stack':
        return [
          {
            'id': 'flutter',
            'name': 'Flutter',
            'icon': Icons.widgets,
            'color': const Color(0xFF00E5FF),
            'description': '크로스 플랫폼 UI 프레임워크',
            'hasContent': true,
          },
          {
            'id': 'react',
            'name': 'React',
            'icon': Icons.circle_outlined,
            'color': const Color(0xFF61DAFB),
            'description': 'UI 라이브러리',
            'hasContent': true,
          },
          {
            'id': 'supabase',
            'name': 'Supabase',
            'icon': Icons.cloud_circle,
            'color': const Color(0xFF3ECF8E),
            'description': '오픈소스 백엔드 플랫폼',
            'hasContent': true,
          },
          {
            'id': 'springboot',
            'name': 'Spring Boot',
            'icon': Icons.spa,
            'color': const Color(0xFF6DB33F),
            'description': 'Java 백엔드 프레임워크',
            'hasContent': true,
          },
          {
            'id': 'nestjs',
            'name': 'NestJS',
            'icon': Icons.api,
            'color': const Color(0xFFE0234E),
            'description': 'Node.js 백엔드 프레임워크',
            'hasContent': true,
          },
          {
            'id': 'firebase',
            'name': 'Firebase',
            'icon': Icons.local_fire_department,
            'color': const Color(0xFFFFCA28),
            'description': 'Google 백엔드 서비스',
            'hasContent': true,
          },
          {
            'id': 'angular',
            'name': 'Angular',
            'icon': Icons.web_asset,
            'color': const Color(0xFFDD0031),
            'description': 'TypeScript 기반 프레임워크',
            'hasContent': true,
          },
        ];
      case 'devtools':
        return [
          {
            'id': 'git',
            'name': 'Git',
            'icon': Icons.source,
            'color': const Color(0xFFF05032),
            'description': '버전 관리 시스템',
            'hasContent': true,
          },
          {
            'id': 'docker',
            'name': 'Docker',
            'icon': Icons.view_in_ar,
            'color': const Color(0xFF2496ED),
            'description': '컨테이너 플랫폼',
            'hasContent': true,
          },
          {
            'id': 'vscode',
            'name': 'VS Code',
            'icon': Icons.code_off,
            'color': const Color(0xFF007ACC),
            'description': '코드 에디터',
            'hasContent': true,
          },
          {
            'id': 'cicd',
            'name': 'CI/CD',
            'icon': Icons.sync_alt,
            'color': const Color(0xFF2088FF),
            'description': 'GitHub Actions',
            'hasContent': true,
          },
          {
            'id': 'androidstudio',
            'name': 'Android Studio',
            'icon': Icons.phone_android,
            'color': const Color(0xFF3DDC84),
            'description': 'Android 개발 환경',
            'hasContent': true,
          },
          {
            'id': 'jupyter',
            'name': 'Colab / Jupyter',
            'icon': Icons.science,
            'color': const Color(0xFFF37726),
            'description': '데이터 분석 노트북',
            'hasContent': false,
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemList = items;

    return Scaffold(
      appBar: VibDevTopAppBar(
        title: '$categoryDisplayName 선택',
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
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '학습할 $categoryDisplayName을 선택하세요',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (itemList.isEmpty)
                    Column(
                      children: [
                        Icon(
                          Icons.construction,
                          size: 80,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '준비 중입니다',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '곧 다양한 콘텐츠가 추가될 예정입니다',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        ],
                      )
                    else
                      // 홈 페이지와 동일한 Wrap 방식 사용
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1000, // 최대 너비 제한
                          ),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: itemList.map((item) {
                              return _buildItemCard(
                                context,
                                id: item['id'] as String,
                                name: item['name'] as String,
                                icon: item['icon'] as IconData,
                                color: item['color'] as Color,
                                description: item['description'] as String,
                                isFlutterUI: item['isFlutterUI'] as bool? ?? false,
                                hasContent: item['hasContent'] as bool? ?? true,
                                cardWidth: 180.0,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
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
        currentIndex: 1, // 홈
      ),
    );
  }

  Widget _buildItemCard(
    BuildContext context, {
    required String id,
    required String name,
    required IconData icon,
    required Color color,
    required String description,
    bool isFlutterUI = false,
    bool hasContent = true,
    double cardWidth = 180,
  }) {
    // 홈 페이지와 동일한 간단한 카드 구조
    return SizedBox(
      width: cardWidth,
      height: cardWidth * 1.1, // 약간 더 높게
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
            if (!hasContent) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('준비 중'),
                  content: Text('$name 콘텐츠는 현재 준비 중입니다.\n곧 만나보실 수 있습니다!'),
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

            // Flutter UI 챌린지는 현재 비활성화됨
            if (!isFlutterUI) {
              Navigator.pushNamed(context, '/mode/$id');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: cardWidth * 0.23, // 홈 페이지와 동일한 비율
                  color: hasContent ? color : Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: cardWidth * 0.08, // 홈 페이지와 동일한 비율
                    fontWeight: FontWeight.bold,
                    color: hasContent ? color : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: cardWidth * 0.055,
                    color: hasContent ? Colors.grey[400] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

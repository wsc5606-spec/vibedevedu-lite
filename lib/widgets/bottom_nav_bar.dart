import 'package:flutter/material.dart';
import '../services/user_session.dart';

/// VibeDev v2.6 하단바
/// 5개 탭: 커리큘럼 / Feed / 홈 / 히스토리 / 마이페이지
/// v2.6 변경사항: Feed 탭 추가, 히스토리 플레이스홀더 추가 (v2.7 예정)
/// 게스트는 Feed/마이페이지 탭 사용 불가
/// 각 탭 클릭 시 해당 페이지로 직접 네비게이션
class VibDevBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const VibDevBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    final routes = [
      '/curriculum', // 0: 커리큘럼
      '/feed',       // 1: Feed (VIBE톡톡)
      '/',           // 2: 홈
      '/history',    // 3: 히스토리 (v2.7 플레이스홀더)
      '/profile',    // 4: 마이페이지
    ];

    // VibeTalk (Feed) 버튼 - OBT 예고 다이얼로그
    if (index == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OBT 준비 중'),
          content: const Text('VibeTalk 기능은 OBT(공개 베타 테스트) 기간에 만나보실 수 있습니다!\n곧 출시될 예정이니 기대해주세요 😊'),
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

    // 마이페이지 버튼 - OBT 예고 다이얼로그
    if (index == 4) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OBT 준비 중'),
          content: const Text('마이페이지 기능은 OBT(공개 베타 테스트) 기간에 만나보실 수 있습니다!\n곧 출시될 예정이니 기대해주세요 😊'),
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

    // 같은 페이지를 클릭한 경우
    if (index == currentIndex) {
      // 홈 버튼(index 2)을 클릭한 경우, 루트로 돌아감
      if (index == 2) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
      // 다른 버튼은 아무 동작 안 함
      return;
    }

    // 커리큘럼 버튼 - OBT 예고 다이얼로그
    if (index == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OBT 준비 중'),
          content: const Text('커리큘럼 기능은 OBT(공개 베타 테스트) 기간에 만나보실 수 있습니다!\n곧 출시될 예정이니 기대해주세요 😊'),
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

    // 히스토리 버튼 - OBT 예고 다이얼로그
    if (index == 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('OBT 준비 중'),
          content: const Text('히스토리 기능은 OBT(공개 베타 테스트) 기간에 만나보실 수 있습니다!\n곧 출시될 예정이니 기대해주세요 😊'),
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

    // 다른 페이지로 이동
    Navigator.pushReplacementNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onTap(context, index),
      backgroundColor: colorScheme.surface.withOpacity(0.95),
      elevation: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school),
          label: '커리큘럼',
        ),
        NavigationDestination(
          icon: Icon(Icons.dynamic_feed_outlined),
          selectedIcon: Icon(Icons.dynamic_feed),
          label: 'VibeTalk',
        ),
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: '홈',
        ),
        NavigationDestination(
          icon: Icon(Icons.history),
          selectedIcon: Icon(Icons.history),
          label: '히스토리',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: '마이페이지',
        ),
      ],
    );
  }
}

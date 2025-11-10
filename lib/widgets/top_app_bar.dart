import 'package:flutter/material.dart';
import '../services/user_session.dart';

/// VibeDev v2.6 상단바
/// 모든 화면에서 동일하게 표시 (시작화면 제외)
/// 좌측: 크레딧 표시 | 중앙: VIBE 로고 | 우측: 설정 버튼
/// v2.6 변경사항: Feed 버튼 제거 (NavBar로 이동), 로고 중앙 배치
/// 알림/즐겨찾기/친구 버튼 제거됨
class VibDevTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const VibDevTopAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: colorScheme.surface.withOpacity(0.95),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 뒤로가기 버튼 (네비게이션 스택이 있을 때만 표시)
            if (canPop)
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                tooltip: '뒤로가기',
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            if (canPop) const SizedBox(width: 4),
            // 크레딧 표시
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '1,250',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leadingWidth: canPop ? 140 : 100,
      // v2.6: 중앙에 VIBE 로고 표시
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.flash_on,
            color: Color(0xFF00E5FF),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'VIBE',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF00E5FF),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: actions ?? _buildDefaultActions(context),
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    return [
      // 설정 - 모두 표시
      IconButton(
        onPressed: () => Navigator.pushNamed(context, '/settings'),
        icon: const Icon(Icons.settings_outlined),
        tooltip: '설정',
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      const SizedBox(width: 8),
    ];
  }
}

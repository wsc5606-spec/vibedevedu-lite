import 'package:flutter/material.dart';
import '../utils/platform_utils.dart';

/// 반응형 스캐폴드 - 화면 크기에 따라 레이아웃 자동 조정
class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentIndex;
  final Function(int)? onNavigationChanged;
  final List<NavigationItem>? navigationItems;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool showNavigation;

  const AdaptiveScaffold({
    super.key,
    required this.body,
    this.title = 'VibeDev',
    this.currentIndex = 0,
    this.onNavigationChanged,
    this.navigationItems,
    this.floatingActionButton,
    this.appBar,
    this.showNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);

    // 네비게이션이 없는 경우 기본 Scaffold 반환
    if (!showNavigation || navigationItems == null) {
      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
      );
    }

    // 태블릿 이상: 사이드 네비게이션
    if (isTabletOrLarger) {
      return Scaffold(
        body: Row(
          children: [
            // 왼쪽 사이드바 네비게이션
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: onNavigationChanged,
              labelType: NavigationRailLabelType.all,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              selectedLabelTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              destinations: navigationItems!
                  .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon ?? item.icon),
                        label: Text(item.label),
                      ))
                  .toList(),
            ),

            const VerticalDivider(thickness: 1, width: 1),

            // 오른쪽 메인 콘텐츠
            Expanded(
              child: Scaffold(
                appBar: appBar ??
                    AppBar(
                      title: Text(title),
                      elevation: 0,
                    ),
                body: body,
                floatingActionButton: floatingActionButton,
              ),
            ),
          ],
        ),
      );
    }

    // 모바일: 하단 네비게이션 바
    return Scaffold(
      appBar: appBar ??
          AppBar(
            title: Text(title),
            elevation: 0,
          ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onNavigationChanged,
        destinations: navigationItems!
            .map((item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon ?? item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

/// 네비게이션 아이템 모델
class NavigationItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const NavigationItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

/// 반응형 콘텐츠 컨테이너 - 최대 너비 제한
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = PlatformUtils.getMaxContentWidth(context);
    final defaultPadding = PlatformUtils.responsivePadding(context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? defaultPadding,
          child: child,
        ),
      ),
    );
  }
}

/// 반응형 그리드 뷰
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final double? childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final columns = PlatformUtils.getGridColumns(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: childAspectRatio ?? 1.0,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// 반응형 2열 레이아웃 (데스크톱에서 split view)
class ResponsiveSplitView extends StatelessWidget {
  final Widget left;
  final Widget right;
  final double leftFlex;
  final double rightFlex;

  const ResponsiveSplitView({
    super.key,
    required this.left,
    required this.right,
    this.leftFlex = 1.0,
    this.rightFlex = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final isTabletOrLarger = PlatformUtils.isTabletOrLarger(context);

    if (isTabletOrLarger) {
      // 태블릿/데스크톱: 좌우 분할
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: leftFlex.toInt(),
            child: left,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            flex: rightFlex.toInt(),
            child: right,
          ),
        ],
      );
    }

    // 모바일: 탭으로 전환
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: '코드'),
              Tab(text: '결과'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [left, right],
            ),
          ),
        ],
      ),
    );
  }
}

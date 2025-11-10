import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

/// 플랫폼 및 화면 크기 감지 유틸리티
class PlatformUtils {
  /// 웹 플랫폼 여부
  static bool get isWeb => kIsWeb;

  /// 모바일 앱 여부
  static bool get isMobile => !kIsWeb;

  /// 화면 너비 기준 브레이크포인트
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  /// 현재 화면 크기 타입 감지
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopBreakpoint) {
      return ScreenType.desktop;
    } else if (width >= tabletBreakpoint) {
      return ScreenType.tablet;
    } else if (width >= mobileBreakpoint) {
      return ScreenType.largeMobile;
    } else {
      return ScreenType.mobile;
    }
  }

  /// 데스크톱 웹 여부 (넓은 화면의 웹)
  static bool isDesktopWeb(BuildContext context) {
    return isWeb && getScreenType(context) == ScreenType.desktop;
  }

  /// 태블릿 이상 크기 여부
  static bool isTabletOrLarger(BuildContext context) {
    final type = getScreenType(context);
    return type == ScreenType.tablet || type == ScreenType.desktop;
  }

  /// 모바일 크기 여부
  static bool isMobileSize(BuildContext context) {
    final type = getScreenType(context);
    return type == ScreenType.mobile || type == ScreenType.largeMobile;
  }

  /// 반응형 패딩 계산
  static EdgeInsets responsivePadding(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.desktop:
        return const EdgeInsets.symmetric(horizontal: 48, vertical: 24);
      case ScreenType.tablet:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
      case ScreenType.largeMobile:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
      case ScreenType.mobile:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  /// 반응형 그리드 컬럼 수
  static int getGridColumns(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.desktop:
        return 4; // 4열
      case ScreenType.tablet:
        return 3; // 3열
      case ScreenType.largeMobile:
        return 2; // 2열
      case ScreenType.mobile:
        return 1; // 1열
    }
  }

  /// 반응형 최대 콘텐츠 너비
  static double getMaxContentWidth(BuildContext context) {
    final screenType = getScreenType(context);

    switch (screenType) {
      case ScreenType.desktop:
        return 1400;
      case ScreenType.tablet:
        return 900;
      case ScreenType.largeMobile:
      case ScreenType.mobile:
        return double.infinity; // 전체 너비 사용
    }
  }
}

/// 화면 크기 타입
enum ScreenType {
  mobile,       // < 600px
  largeMobile,  // 600px - 900px
  tablet,       // 900px - 1200px
  desktop,      // >= 1200px
}

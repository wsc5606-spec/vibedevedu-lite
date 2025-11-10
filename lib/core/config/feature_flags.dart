/// Feature Flags for v1.6+ Prototype Mode
/// Centralized configuration for prototype vs production features
class FeatureFlags {
  // dart-define에서 읽어오기, 없으면 기본값 사용
  static const bool prototypeMode = bool.fromEnvironment(
    'PROTOTYPE_MODE',
    defaultValue: true, // 프로토타입 모드가 기본값
  );

  static const bool rewardsEnabled = bool.fromEnvironment(
    'REWARDS_ENABLED',
    defaultValue: false, // 프로토타입에서는 리워드 비활성
  );

  static const bool loginGateEnabled = bool.fromEnvironment(
    'LOGIN_GATE_ENABLED',
    defaultValue: true, // 시작 게이트는 유지
  );

  // v1.7: Settings Center
  static const bool featureSettingsV17 = bool.fromEnvironment(
    'FEATURE_SETTINGS_V17',
    defaultValue: true,
  );

  /// 힌트 기능 무료 제공 여부 (프로토타입 모드에서는 무료)
  static bool get freeHintsEnabled => prototypeMode;

  /// AI 코드 분석 무료 제공 여부 (프로토타입 모드에서는 무료)
  static bool get freeAnalysisEnabled => prototypeMode;

  /// 리워드 탭 표시 여부
  static bool get showRewardsTab => rewardsEnabled && !prototypeMode;

  /// 크레딧/코인 표시 여부
  static bool get showCredits => rewardsEnabled && !prototypeMode;

  /// 배지 표시 여부
  static bool get showBadges => rewardsEnabled && !prototypeMode;

  /// 게스트 모드에서 보호된 기능 접근 허용 여부
  static bool get allowGuestAccess => prototypeMode;

  /// 설정 탭 표시 여부 (v1.7)
  static bool get showSettingsTab => featureSettingsV17;

  /// 디버그 정보 출력
  static void printFlags() {
    print('=== Feature Flags v1.7 ===');
    print('PROTOTYPE_MODE: $prototypeMode');
    print('REWARDS_ENABLED: $rewardsEnabled');
    print('LOGIN_GATE_ENABLED: $loginGateEnabled');
    print('FEATURE_SETTINGS_V17: $featureSettingsV17');
    print('Free Hints: $freeHintsEnabled');
    print('Free Analysis: $freeAnalysisEnabled');
    print('Show Rewards Tab: $showRewardsTab');
    print('Show Settings Tab: $showSettingsTab');
    print('Show Credits: $showCredits');
    print('Show Badges: $showBadges');
    print('Allow Guest Access: $allowGuestAccess');
    print('========================');
  }
}

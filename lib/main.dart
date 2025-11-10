import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// v1.8 Pages
import 'pages/start_page.dart';
import 'pages/login_page.dart';
import 'pages/email_login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart'; // 언어 선택 홈
import 'pages/category_select_page.dart'; // 카테고리 선택 페이지
import 'pages/friends_page.dart';
import 'pages/settings_page.dart';
import 'pages/history_page.dart';
import 'pages/mode_select_page.dart';
import 'pages/level_grid_page.dart';
import 'pages/challenge_list_page.dart';
import 'pages/challenge_detail_page.dart';
import 'pages/recommend_page.dart';
import 'pages/result_page.dart';
import 'pages/favorites_page.dart';

// v2.2 Community Pages
import 'pages/feed_page.dart';
import 'pages/notification_page.dart';

// v2.5 Basic Learning Pages
import 'pages/grammar_learning_page.dart';
import 'pages/quiz_page.dart';

// AI Pages
import 'pages/ai_chatbot_page.dart';
import 'pages/coing_page.dart';
import 'pages/curriculum_page.dart';
import 'pages/dashboard_page.dart';

// v1.8 Widgets
import 'widgets/top_app_bar.dart';
import 'widgets/bottom_nav_bar.dart';

// Services
import 'services/user_session.dart';
import 'core/config/feature_flags.dart';
import 'core/config/supabase_config.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Feature Flags 출력
  FeatureFlags.printFlags();

  // Supabase 초기화
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  // 사용자 토큰 로드
  await UserSession.loadToken();

  // Supabase 세션 확인
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    // Supabase 세션이 있으면 UserSession에 저장
    await UserSession.setToken(session.accessToken, session.user.id);
  }

  // 전역 테마 컨트롤러 준비
  final themeController = ThemeController();
  await themeController.load();

  runApp(
    ChangeNotifierProvider.value(
      value: themeController,
      child: const VIBEDEVApp(),
    ),
  );
}

/// VIBEDEV v1.8 - AI 코딩 챌린지 플랫폼
class VIBEDEVApp extends StatelessWidget {
  const VIBEDEVApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = context.watch<ThemeController>();

    return MaterialApp(
      title: 'VIBEDEV - AI Coding Challenge',
      debugShowCheckedModeBanner: false,

      // 전역 테마 적용
      theme: AppTheme.buildLight(highContrast: tc.highContrast),
      darkTheme: AppTheme.buildDark(highContrast: tc.highContrast),
      themeMode: tc.mode,

      // 텍스트 크기 & 애니메이션 감소 적용
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final scaled = media.copyWith(
          textScaler: TextScaler.linear(tc.textScale.factor),
          disableAnimations: tc.reduceMotion,
        );
        return MediaQuery(data: scaled, child: child ?? const SizedBox.shrink());
      },

      // 초기 라우트: 시작화면
      initialRoute: '/start',

      // 라우팅 설정
      routes: {
        '/start': (context) => const StartPage(),
        '/login': (context) => const LoginPage(),
        '/email-login': (context) => const EmailLoginPage(),
        '/signup': (context) => const SignupPage(),
        '/': (context) => const HomePage(), // 언어 선택 홈
        '/favorites': (context) => const FavoritesPage(),
        '/friends': (context) => const FriendsPage(),
        '/settings': (context) => const SettingsPage(),
        '/history': (context) => const HistoryPage(),
        '/challenges': (context) => const ChallengeListPage(),
        '/recommend': (context) => const RecommendPage(),
        '/result': (context) => const ResultPage(),
        // v2.2 Community routes
        '/feed': (context) => const FeedPage(),
        '/notifications': (context) => const NotificationPage(),
        // AI routes
        '/ai-chatbot': (context) => const AiChatbotPage(),
        '/coing': (context) => const CoingPage(),
        '/curriculum': (context) => const CurriculumPage(),
        '/dashboard': (context) => const DashboardPage(),
      },

      // 동적 라우팅
      onGenerateRoute: (settings) {
        // /category/:category
        if (settings.name?.startsWith('/category/') ?? false) {
          final category = settings.name!.substring(10);
          return MaterialPageRoute(
            builder: (context) => CategorySelectPage(category: category),
          );
        }

        // /mode/:language
        if (settings.name?.startsWith('/mode/') ?? false) {
          final language = settings.name!.substring(6);
          return MaterialPageRoute(
            builder: (context) => ModeSelectPage(language: language),
          );
        }

        // /levels/:language/:kind
        if (settings.name?.startsWith('/levels/') ?? false) {
          final parts = settings.name!.substring(8).split('/');
          if (parts.length == 2) {
            return MaterialPageRoute(
              builder: (context) => LevelGridPage(
                language: parts[0],
                kind: parts[1],
              ),
            );
          }
        }

        // /challenge/:slug
        if (settings.name?.startsWith('/challenge/') ?? false) {
          final slug = settings.name!.substring(11);
          return MaterialPageRoute(
            builder: (context) => ChallengeDetailPage(slug: slug),
          );
        }

        // /basic/:language/grammar
        if (settings.name?.startsWith('/basic/') ?? false) {
          final parts = settings.name!.substring(7).split('/');
          if (parts.length == 2) {
            final language = parts[0];
            final mode = parts[1];

            if (mode == 'grammar') {
              return MaterialPageRoute(
                builder: (context) => GrammarLearningPage(language: language),
              );
            } else if (mode == 'quiz') {
              return MaterialPageRoute(
                builder: (context) => QuizPage(language: language),
              );
            }
          }
        }

        return null;
      },
    );
  }
}

/// v1.8 메인 스캐폴드
/// 상단바 + 하단바 통합 레이아웃
///
/// 참고: 이 위젯은 현재 사용되지 않습니다.
/// 각 페이지가 독립적으로 TopAppBar와 BottomNavBar를 사용합니다.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    FeedPage(),
    SettingsPage(),
  ];

  final List<String> _titles = const [
    '홈',
    '커뮤니티',
    '설정',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VibDevTopAppBar(
        title: _titles[_currentIndex],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: VibDevBottomNavBar(
        currentIndex: _currentIndex,
      ),
    );
  }
}

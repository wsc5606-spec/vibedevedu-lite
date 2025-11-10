import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// VibeDev v1.8 시작화면
/// 로봇 캐릭터 + 텍스트 애니메이션 → 자동으로 로그인 화면 진입
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentTextIndex = 0;

  final List<String> _texts = [
    '바이브데브 CBT에\n참여해주셔서 감사합니다 ㅎㅎ',
    '많은 관심 부탁드리며\n설문도 부탁드리겠습니다.',
    '지금 시작합니다 😊🎉✨',
  ];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    // 2초 간격으로 텍스트 변경
    for (int i = 0; i < _texts.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _currentTextIndex = i;
        });
      }
    }

    // 마지막 텍스트 표시 후 1초 대기 후 홈 화면으로 이동
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: GestureDetector(
        onTap: _goToHome,
        child: Container(
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              // 로봇 캐릭터 (이미지가 없으면 아이콘 표시)
              Container(
                width: 200,
                height: 200,
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
                  size: 120,
                  color: Color(0xFF00E5FF),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms)
                  .then()
                  .shake(hz: 1, curve: Curves.easeInOutCubic),

              const SizedBox(height: 60),

              // 애니메이션 텍스트
              SizedBox(
                height: 100,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _texts[_currentTextIndex],
                    key: ValueKey<int>(_currentTextIndex),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 로딩 인디케이터
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Color(0xFF00E5FF),
                ),
              ).animate(onPlay: (controller) => controller.repeat()).fadeIn(
                    duration: 800.ms,
                  ),
                  ],
                ),
              ),
              // 스킵 문구
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '화면을 클릭하면 스킵됩니다',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).fadeIn(
                        duration: 1500.ms,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

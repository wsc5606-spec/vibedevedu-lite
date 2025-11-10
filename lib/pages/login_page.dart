import 'package:flutter/material.dart';
import 'package:vibedev_lite/services/auth_service.dart';

/// VibeDev v2.6 로그인 화면
/// Google, Apple, 이메일/비밀번호 로그인 지원
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
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
              padding: const EdgeInsets.all(24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 로봇 캐릭터
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.smart_toy_rounded,
                        size: 60,
                        color: Color(0xFF00E5FF),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 타이틀
                    const Text(
                      'VIBEDEV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00E5FF),
                        letterSpacing: 2,
                        fontSize: 36,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AI 코딩 챌린지 플랫폼',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Google 로그인
                    _LoginButton(
                      onPressed: () => _handleGoogleLogin(context),
                      icon: Icons.g_mobiledata,
                      label: 'Google로 계속하기',
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                    ),
                    const SizedBox(height: 12),

                    // Apple 로그인
                    _LoginButton(
                      onPressed: () => _handleAppleLogin(context),
                      icon: Icons.apple,
                      label: 'Apple로 계속하기',
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 12),

                    // 바이브데브 로그인
                    _LoginButton(
                      onPressed: () => Navigator.pushNamed(context, '/email-login'),
                      icon: Icons.login,
                      label: '바이브데브로 로그인',
                      backgroundColor: const Color(0xFF00E5FF),
                      foregroundColor: Colors.black87,
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '또는',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 게스트 로그인 (임시 계정)
                    OutlinedButton.icon(
                      onPressed: () => _handleGuestLogin(context),
                      icon: const Icon(Icons.explore_outlined),
                      label: const Text('게스트로 체험하기'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(
                          color: colorScheme.outline.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 회원가입 링크
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        '계정이 없으신가요? 회원가입',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 안내 텍스트
                    Text(
                      '로그인하면 학습 진행도를 저장하고\n리워드를 받을 수 있습니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleGoogleLogin(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signInWithGoogle();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, '로그인 실패: ${e.toString()}');
      }
    }
  }

  void _handleAppleLogin(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signInWithApple();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, '로그인 실패: ${e.toString()}');
      }
    }
  }

  void _handleGuestLogin(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signInAsGuest();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, '게스트 로그인 실패: ${e.toString()}');
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

/// 로그인 버튼 위젯
class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  const _LoginButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

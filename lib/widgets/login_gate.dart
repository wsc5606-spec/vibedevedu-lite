import 'package:flutter/material.dart';
import 'package:vibedev_lite/services/user_session.dart';
import 'package:vibedev_lite/services/auth_service.dart';

/// LoginGate widget that wraps protected pages
/// Shows login prompt if user is not authenticated
class LoginGate extends StatelessWidget {
  final Widget child;
  final String featureName;
  final IconData icon;

  const LoginGate({
    super.key,
    required this.child,
    this.featureName = '이 기능',
    this.icon = Icons.lock_outline,
  });

  @override
  Widget build(BuildContext context) {
    // If user is authenticated, show the child widget
    if (UserSession.isAuthenticated) {
      return child;
    }

    // Otherwise, show login prompt
    return _LoginPrompt(
      featureName: featureName,
      icon: icon,
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  final String featureName;
  final IconData icon;

  const _LoginPrompt({
    required this.featureName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(featureName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                '로그인이 필요합니다',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                '$featureName을 사용하려면\n로그인해주세요',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Google Login Button
              SizedBox(
                width: 280,
                child: FilledButton.icon(
                  onPressed: () => _handleGoogleLogin(context),
                  icon: const Icon(Icons.g_mobiledata, size: 32),
                  label: const Text('Google로 로그인'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Apple Login Button
              SizedBox(
                width: 280,
                child: FilledButton.icon(
                  onPressed: () => _handleAppleLogin(context),
                  icon: const Icon(Icons.apple),
                  label: const Text('Apple로 로그인'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dev Mock Login (Debug Mode Only)
              if (_isDevMode())
                TextButton.icon(
                  onPressed: () async {
                    await UserSession.setMockToken();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginGate(
                            featureName: featureName,
                            icon: icon,
                            child: child,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.developer_mode, size: 18),
                  label: const Text('[DEV] Mock 로그인'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get child => const SizedBox.shrink();

  void _handleGoogleLogin(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signInWithGoogle();

      if (context.mounted) {
        // Refresh to show the protected content
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginGate(
              featureName: featureName,
              icon: icon,
              child: child,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleAppleLogin(BuildContext context) async {
    try {
      final authService = AuthService();
      await authService.signInWithApple();

      if (context.mounted) {
        // Refresh to show the protected content
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginGate(
              featureName: featureName,
              icon: icon,
              child: child,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  bool _isDevMode() {
    // Check if running in debug mode
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}

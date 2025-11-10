import 'package:flutter/material.dart';

/// v2.3: VibeBot 감정 상태
enum VibeMood {
  idle,
  happy,
  thinking,
  sad,
  celebrate,
}

/// v2.3: VibeBot 캐릭터 위젯
class VibeBotWidget extends StatelessWidget {
  final VibeMood mood;
  final String? message;
  final double size;

  const VibeBotWidget({
    super.key,
    this.mood = VibeMood.idle,
    this.message,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // VibeBot 아이콘 (Lottie 대신 간단한 아이콘으로 대체)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(mood),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getMoodColors(),
              ),
              boxShadow: [
                BoxShadow(
                  color: _getMoodColors()[0].withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _getMoodIcon(),
                size: size * 0.5,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          // 말풍선
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 감정에 따른 아이콘 반환
  IconData _getMoodIcon() {
    switch (mood) {
      case VibeMood.idle:
        return Icons.psychology;
      case VibeMood.happy:
        return Icons.sentiment_very_satisfied;
      case VibeMood.thinking:
        return Icons.lightbulb_outline;
      case VibeMood.sad:
        return Icons.sentiment_dissatisfied;
      case VibeMood.celebrate:
        return Icons.celebration;
    }
  }

  /// 감정에 따른 그라디언트 컬러 반환
  List<Color> _getMoodColors() {
    switch (mood) {
      case VibeMood.idle:
        return [const Color(0xFF00FFC8), const Color(0xFF00CCa0)];
      case VibeMood.happy:
        return [const Color(0xFFFFEB3B), const Color(0xFFFFC107)];
      case VibeMood.thinking:
        return [const Color(0xFF2196F3), const Color(0xFF1976D2)];
      case VibeMood.sad:
        return [const Color(0xFF9E9E9E), const Color(0xFF757575)];
      case VibeMood.celebrate:
        return [const Color(0xFFFF5252), const Color(0xFFF44336)];
    }
  }
}

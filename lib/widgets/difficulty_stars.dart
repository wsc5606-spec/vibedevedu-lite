import 'package:flutter/material.dart';

/// VibeDev v1.9 난이도 별 위젯
/// 1~3 사이의 정수로 난이도를 시각적으로 표시
class DifficultyStars extends StatelessWidget {
  final int level; // 1~3
  final double size;
  final Color? color;

  const DifficultyStars({
    super.key,
    required this.level,
    this.size = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? const Color(0xFFFFD700); // 금색
    final clampedLevel = level.clamp(1, 3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < clampedLevel ? Icons.star : Icons.star_border,
          size: size,
          color: starColor,
        );
      }),
    );
  }
}

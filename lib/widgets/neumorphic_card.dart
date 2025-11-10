import 'package:flutter/material.dart';
import '../core/color_palette.dart';

/// v2.3: Neumorphic 스타일 카드
class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? VibePalette.bgDarkCard : VibePalette.bgLightCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? VibePalette.neumorphicDark
              : VibePalette.neumorphicLight,
        ),
        child: child,
      ),
    );
  }
}

/// v2.3: 간단한 카드
class VibeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Color? color;

  const VibeCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: VibePalette.shadowSoft,
        ),
        child: child,
      ),
    );
  }
}

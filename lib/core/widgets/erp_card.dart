import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_shadows.dart';
class ERPCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? color;

  const ERPCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xl);
    Widget content = Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ??
            AppColors.cardBackground.withValues(alpha: 0.94),
        borderRadius: radius,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: .40),
          width: 1,
        ),
        boxShadow: AppShadows.md,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );

    if (width != null || height != null) {
      content = SizedBox(
        width: width,
        height: height,
        child: content,
      );
    }

    if (onTap != null) {
      content = InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
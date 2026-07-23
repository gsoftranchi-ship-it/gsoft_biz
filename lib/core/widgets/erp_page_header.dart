import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class ERPPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final EdgeInsetsGeometry? padding;

  const ERPPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final leadingWidget = leading;
    final trailingWidget = trailing;
    final pageSubtitle = subtitle;

    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.lg,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?leadingWidget,
          if (leadingWidget != null)
            const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.pageTitle,
                ),

                if (pageSubtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    pageSubtitle,
                    style: AppTypography.pageSubtitle,
                  ),
                ],
              ],
            ),
          ),

          ?trailingWidget,
        ],
      ),
    );
  }
}
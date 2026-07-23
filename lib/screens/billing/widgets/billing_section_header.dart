import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';

class BillingSectionHeader extends StatelessWidget {
  final String step;
  final String title;
  final String? subtitle;

  const BillingSectionHeader({
    super.key,
    required this.step,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: AppTypography.label.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            title,
            style: AppTypography.pageTitle,
          ),

          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle!,
              style: AppTypography.cardSubtitle,
            ),
          ],
        ],
      ),
    );
  }
}
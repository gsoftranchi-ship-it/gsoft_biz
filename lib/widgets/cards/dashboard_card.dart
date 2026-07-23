import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/widgets/erp_card.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mobile = width < 500;

    final iconSize = mobile ? 18.0 : 22.0;
    final circleSize = mobile ? 36.0 : 42.0;
    final valueSize = mobile ? 18.0 : 28.0;
    final titleSize = mobile ? 13.0 : 15.0;
    final subTitleSize = mobile ? 11.0 : 12.0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ERPCard(
        onTap: onTap,
        padding: EdgeInsets.all(
          mobile ? AppSpacing.md : AppSpacing.lg,
        ),
        child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: circleSize,
            width: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: .15),
            ),
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),

          SizedBox(
            height: mobile
                ? AppSpacing.sm
                : AppSpacing.md,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.pageTitle.copyWith(
                    fontSize: valueSize,
                  ),
                ),

              const SizedBox(
                height: AppSpacing.xs,
              ),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.cardTitle.copyWith(
                    fontSize: titleSize,
                  ),
                ),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: subTitleSize,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

        ],
      ),

            ),
          );

  }
}
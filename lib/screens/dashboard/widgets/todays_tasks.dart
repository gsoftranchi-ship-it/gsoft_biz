import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/erp_card.dart';

class TodaysTasks extends StatelessWidget {
  const TodaysTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final crossAxisCount = width >= 1200
        ? 4
        : width >= 800
        ? 2
        : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const _TaskCard(
              title: "Renewals Today",
              value: "--",
              icon: Icons.event_repeat_rounded,
              color: AppColors.success,
            );

          case 1:
            return const _TaskCard(
              title: "Pending Fees",
              value: "--",
              icon: Icons.payments_outlined,
              color: AppColors.primary,
            );

          case 2:
            return const _TaskCard(
              title: "Birthdays",
              value: "--",
              icon: Icons.cake_outlined,
              color: AppColors.info,
            );

          default:
            return const _TaskCard(
              title: "Low Stock",
              value: "--",
              icon: Icons.inventory_2_outlined,
              color: AppColors.danger,
            );
        }
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _TaskCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ERPCard(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),

      child: Row(
        children: [

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: AppTypography.cardTitle.copyWith(
                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.xs,
                ),

                Text(
                  value,
                  style: AppTypography.sectionTitle.copyWith(
                    color: color,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
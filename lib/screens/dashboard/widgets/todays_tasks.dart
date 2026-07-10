import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

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
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const _TaskCard(
              title: "Renewals Today",
              value: "--",
              icon: Icons.event_repeat_rounded,
              color: AppColors.warning,
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
              color: AppColors.success,
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1B1F24),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: .05),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
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

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
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
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../cards/glass_card.dart';

class MembershipPieChart extends StatelessWidget {
  const MembershipPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Membership Distribution",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 50,
                sectionsSpace: 3,
                sections: [
                  PieChartSectionData(
                    value: 45,
                    color: AppColors.warning,
                    radius: 70,
                    title: "",
                  ),
                  PieChartSectionData(
                    value: 30,
                    color: AppColors.success,
                    radius: 70,
                    title: "",
                  ),
                  PieChartSectionData(
                    value: 25,
                    color: AppColors.info,
                    radius: 70,
                    title: "",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Legend(AppColors.warning, "Gold"),
              _Legend(AppColors.success, "Silver"),
              _Legend(AppColors.info, "Premium"),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend(this.color, this.title);
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(title),
      ],
    );
  }
}
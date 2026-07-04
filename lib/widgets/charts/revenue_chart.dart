import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../cards/glass_card.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: SizedBox(
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Revenue Overview",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),

                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                  ),

                  titlesData: FlTitlesData(
                    rightTitles:
                    const AxisTitles(
                      sideTitles:
                      SideTitles(showTitles: false),
                    ),

                    topTitles:
                    const AxisTitles(
                      sideTitles:
                      SideTitles(showTitles: false),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget:
                            (value, meta) {
                          const months = [
                            "Jan",
                            "Feb",
                            "Mar",
                            "Apr",
                            "May",
                            "Jun"
                          ];

                          if (value.toInt() <
                              months.length &&
                              value.toInt() >= 0) {
                            return Text(
                              months[value.toInt()],
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,

                      color: AppColors.primary,

                      barWidth: 4,

                      dotData:
                      const FlDotData(
                        show: true,
                      ),

                      spots: const [
                        FlSpot(0, 8),
                        FlSpot(1, 10),
                        FlSpot(2, 13),
                        FlSpot(3, 12),
                        FlSpot(4, 16),
                        FlSpot(5, 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
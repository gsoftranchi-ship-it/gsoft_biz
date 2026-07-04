import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../widgets/cards/dashboard_card.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;

    if (width >= 1200) {
      crossAxisCount = 4;
      childAspectRatio = 1.35;
    } else if (width >= 900) {
      crossAxisCount = 4;
      childAspectRatio = 1.20;
    } else if (width >= 700) {
      crossAxisCount = 3;
      childAspectRatio = 1.05;
    } else if (width >= 500) {
      crossAxisCount = 2;
      childAspectRatio = 1.00;
    } else if (width >= 380) {
      crossAxisCount = 2;
      childAspectRatio = 0.82;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 2.1;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const DashboardCard(
              icon: AppIcons.members,
              title: "Members",
              value: "286",
              subtitle: "+12 This Month",
              color: AppColors.info,
            );

          case 1:
            return const DashboardCard(
              icon: AppIcons.attendance,
              title: "Attendance",
              value: "148",
              subtitle: "Today",
              color: AppColors.success,
            );

          case 2:
            return const DashboardCard(
              icon: AppIcons.billing,
              title: "Revenue",
              value: "₹18,450",
              subtitle: "Today",
              color: AppColors.primary,
            );

          default:
            return const DashboardCard(
              icon: AppIcons.inventory,
              title: "Store",
              value: "54",
              subtitle: "Products",
              color: AppColors.warning,
            );
        }
      },
    );
  }
}
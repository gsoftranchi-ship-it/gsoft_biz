import 'package:flutter/material.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/charts/membership_pie_chart.dart';
import '../../widgets/charts/revenue_chart.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/recent_activity.dart';
import 'widgets/summary_cards.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/todays_tasks.dart';

class DashboardPage extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const DashboardPage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldDark,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background/dashboard_surface.png',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DashboardHeader(),

              SizedBox(height: 20),

              SummaryCards(
                onNavigate: onNavigate,
              ),
              SizedBox(height: 28),

              SectionTitle(
                title: "Today's Tasks",
              ),

              SizedBox(height: 14),

              TodaysTasks(),

              SizedBox(height: 28),



              SectionTitle(
                title: "Revenue",
              ),

              SizedBox(height: 14),

              RevenueChart(),

              SizedBox(height: 28),

              SectionTitle(
                title: "Membership",
              ),

              SizedBox(height: 14),

              MembershipPieChart(),

              SizedBox(height: 28),

              SectionTitle(
                title: "Recent Activity",
              ),

              SizedBox(height: 14),

              RecentActivity(),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
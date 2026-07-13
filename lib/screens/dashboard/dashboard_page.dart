import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/member_provider.dart';

import '../../widgets/common/section_title.dart';
import '../../widgets/charts/membership_pie_chart.dart';
import '../../widgets/charts/revenue_chart.dart';

import 'widgets/dashboard_header.dart';
import 'widgets/recent_activity.dart';
import 'widgets/summary_cards.dart';
import 'widgets/todays_tasks.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.onNavigate,
  });

  final ValueChanged<int> onNavigate;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final authProvider = context.read<AuthProvider>();

        final gymId = authProvider.currentUser?.tenantInfo.gymId;

        if (gymId == null || gymId.isEmpty) return;

        await Future.wait([
          context.read<MemberProvider>().loadMembers(
            gymId: gymId,
          ),
          context.read<AttendanceProvider>().loadAttendance(
            gymId: gymId,
          ),
          context.read<InvoiceProvider>().loadInvoices(
            gymId: gymId,
          ),
          context.read<DashboardProvider>().loadGym(
            gymId: gymId,
          ),
        ]);
      });
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardHeader(),

            const SizedBox(height: 20),

            SummaryCards(
              onNavigate: widget.onNavigate,
            ),

            const SizedBox(height: 28),

            const SectionTitle(
              title: "Today's Tasks",
            ),

            const SizedBox(height: 14),

            const TodaysTasks(),

            const SizedBox(height: 28),

            const SectionTitle(
              title: "Revenue",
            ),

            const SizedBox(height: 14),

            const RevenueChart(),

            const SizedBox(height: 28),

            const SectionTitle(
              title: "Membership",
            ),

            const SizedBox(height: 14),

            const MembershipPieChart(),

            const SizedBox(height: 28),

            const SectionTitle(
              title: "Recent Activity",
            ),

            const SizedBox(height: 14),

            const RecentActivity(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/member_provider.dart';

import '../../widgets/charts/membership_pie_chart.dart';
import '../../widgets/charts/revenue_chart.dart';

import 'widgets/dashboard_header.dart';
import 'widgets/recent_activity.dart';
import 'widgets/summary_cards.dart';
import 'widgets/todays_tasks.dart';
import '../../core/widgets/erp_section.dart';

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

  Future<void> _loadDashboard() async {
    final authProvider = context.read<AuthProvider>();

    final gymId = authProvider.currentUser?.tenantInfo.gymId;

    if (gymId == null || gymId.isEmpty) {
      return;
    }

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
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
            onRefresh: _loadDashboard,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1600,
                ),
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

            ERPSection(
              title: "Today's Tasks",
              child: const TodaysTasks(),
            ),


            const SizedBox(height: 28),

            ERPSection(
              title: "Revenue",
              child: const RevenueChart(),
            ),

            const SizedBox(height: 28),

            ERPSection(
              title: "Membership",
              child: const MembershipPieChart(),
            ),

            const SizedBox(height: 28),

            ERPSection(
              title: "Recent Activity",
              child: const RecentActivity(),
            ),

            const SizedBox(height: 40),
          ],
                  ),
                ),
              ),
            ),
        ),
    );
  }
}
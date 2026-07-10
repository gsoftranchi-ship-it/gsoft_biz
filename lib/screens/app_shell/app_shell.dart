import 'package:flutter/material.dart';
import '../dashboard/dashboard_page.dart';
import '../members/members_page.dart';
import '../attendance/attendance_page.dart';
import '../fees/fees_page.dart';
import '../inventory/inventory_page.dart';
import '../reports/reports_page.dart';
import '../settings/settings_page.dart';
import '../../widgets/navigation/bottom_navbar.dart';
import '../../widgets/navigation/app_drawer.dart';
import '../more/more_page.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/member_provider.dart';
import '../../providers/membership_provider.dart';
import '../../providers/tenant_provider.dart';


class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = context.read<AuthProvider>();
      final tenantProvider = context.read<TenantProvider>();
      final memberProvider = context.read<MemberProvider>();
      final membershipProvider = context.read<MembershipProvider>();

      final gymId = authProvider.currentUser?.tenantInfo.gymId;

      if (gymId == null || gymId.isEmpty) {
        return;
      }

      await tenantProvider.loadGym(
        gymId: gymId,
      );

      await Future.wait([
        memberProvider.loadMembers(
          gymId: gymId,
        ),
        membershipProvider.loadInvoices(
          gymId: gymId,
        ),
      ]);
    });
  }
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    DashboardPage(
      onNavigate: changePage,
    ),
    const MembersPage(),      // 1
    const AttendancePage(),   // 2
    const FeesPage(),         // 3
    const InventoryPage(),    // 4
    const ReportsPage(),      // 5
    const SettingsPage(),     // 6
  ];

  void changePage(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });
  }

  Widget get currentPage => _pages[_currentIndex];

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }
  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: desktop
          ? Row(
        children: [
          AppDrawer(
            selectedIndex: _currentIndex,
            onChanged: changePage,
          ),
          Expanded(child: currentPage),
        ],
      )
          : currentPage,

      bottomNavigationBar: desktop
          ? null
          : AppBottomNavbar(
        currentIndex: _currentIndex,
        onChanged: (index) {

          switch (index) {

            case 0:
              changePage(0); // Dashboard
              break;

            case 1:
              changePage(1); // Members
              break;

            case 2:
              changePage(3); // Billing
              break;

            case 3:
              showModalBottomSheet(
                context: context,
                builder: (_) => MorePage(
                  onPageSelected: (page) {
                    Navigator.pop(context);
                    changePage(page);
                  },
                ),
              );
              break;
          }

        },
      ),
    );
  }
}
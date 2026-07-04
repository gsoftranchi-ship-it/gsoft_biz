import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  final ValueChanged<int> onPageSelected;

  const MorePage({
    super.key,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: ListView(
        children: [

          _tile(
            context,
            Icons.fact_check,
            "Attendance",
            2,
          ),

          _tile(
            context,
            Icons.inventory,
            "Inventory",
            4,
          ),

          _tile(
            context,
            Icons.bar_chart,
            "Reports",
            5,
          ),

         /* _tile(
            context,
            Icons.fitness_center,
            "Trainers",
            const TrainersPage(),
          ),*/

         /* _tile(
            context,
            Icons.card_membership,
            "Membership Plans",
            const MembershipPlansPage(),
          ),*/

          _tile(
            context,
            Icons.settings,
            "Settings",
            6,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text("Logout"),
            onTap: () {
              Navigator.popUntil(
                context,
                    (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _tile(
      BuildContext context,
      IconData icon,
      String title,
  int pageIndex,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        onPageSelected(pageIndex);
      },
    );
  }
}
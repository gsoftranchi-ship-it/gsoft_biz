import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppColors.cardDark,
      child: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 34,
              child: Icon(Icons.business, size: 34),
            ),

            const SizedBox(height: 12),

            const Text(
              "GSoft Biz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(height: 40),

            _item(0, AppIcons.dashboard, "Dashboard"),

            _item(1, AppIcons.members, "Members"),

            _item(2, AppIcons.attendance, "Attendance"),

            _item(3, AppIcons.billing, "Billing"),

            _item(4, AppIcons.inventory, "Inventory"),

            _item(5, AppIcons.reports, "Reports"),

            _item(6, AppIcons.settings, "Settings"),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(
                AppIcons.logout,
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _item(
      int index,
      IconData icon,
      String title,
      ) {
    final selected = selectedIndex == index;

    return ListTile(
      selected: selected,
      leading: Icon(
        icon,
        color: selected
            ? AppColors.primary
            : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected
              ? AppColors.primary
              : Colors.white,
        ),
      ),
      onTap: () => onChanged(index),
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';
import 'package:provider/provider.dart';

import '../../core/routes/route_names.dart';
import '../../providers/auth_provider.dart';
import '../../providers/tenant_provider.dart';

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
    final tenantProvider = context.watch<TenantProvider>();
    final gym = tenantProvider.currentGym;
    return Container(
      width: 265,
      color: AppColors.cardDark,
      child: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: .25),
                blurRadius: 16,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.cardDark,
            child: ClipOval(
              child: (gym?.logoUrl != null && gym!.logoUrl!.isNotEmpty)
                  ? Image.network(
                gym.logoUrl!,
                width: 84,
                height: 84,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/logo.png',
                width: 84,
                height: 84,
                fit: BoxFit.cover,
              ),
            ),
          )
        ),

            const SizedBox(height: 16),

            Text(
              gym?.gymName ?? "Power House Gym",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              "Partner ID : ${gym?.gymCode ?? "--"}",
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),

            const Divider(
              height: 36,
              color: AppColors.border,
            ),

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
              onTap: () async {
                final navigator = Navigator.of(context);
                final authProvider = context.read<AuthProvider>();

                final logout = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF081A33),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: AppColors.border,
                        ),
                      ),

                      icon: const CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0xff3A2323),
                        child: Icon(
                          AppIcons.logout,
                          color: AppColors.danger,
                        ),
                      ),

                      title: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      content: const Text(
                        "Are you sure you want to logout from GSoft Biz ERP?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),

                      actionsAlignment: MainAxisAlignment.center,

                      actions: [

                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext, false);
                          },
                          child: const Text("Cancel"),
                        ),

                        FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(dialogContext, true);
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                        ),
                      ],
                    );
                  },
                );

                if (logout != true) return;

                await authProvider.signOut();

                navigator.pushNamedAndRemoveUntil(
                  RouteNames.login,
                      (route) => false,
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

    return AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: .12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: selected
              ? Border.all(
            color: AppColors.primary,
          )
              : null,
        ),
        child: ListTile(
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
        ),
    );
  }
}
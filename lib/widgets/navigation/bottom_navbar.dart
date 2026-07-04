import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_icons.dart';

class AppBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: AppColors.cardDark,
      selectedIndex: currentIndex > 3 ? 3 : currentIndex,
      onDestinationSelected: onChanged,
      destinations: const [
        NavigationDestination(
          icon: Icon(AppIcons.dashboard),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(AppIcons.members),
          label: 'Members',
        ),
        NavigationDestination(
          icon: Icon(AppIcons.billing),
          label: 'Fees',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_rounded),
          label: 'More',
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

class ERPToolbar extends StatelessWidget {
  final Widget? searchBar;
  final Widget? filterBar;
  final List<Widget> actions;

  const ERPToolbar({
    super.key,
    this.searchBar,
    this.filterBar,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        children: [
          if (searchBar != null)
            SizedBox(
              width: 320,
              child: searchBar!,
            ),

          if (filterBar != null)
            Expanded(
              child: filterBar!,
            ),

          ...actions,
        ],
      ),
    );
  }
}
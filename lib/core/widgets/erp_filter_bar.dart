import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

class ERPFilterBar extends StatelessWidget {
  final Widget? search;

  final List<Widget> filters;

  final List<Widget> actions;

  const ERPFilterBar({
    super.key,
    this.search,
    this.filters = const [],
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
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (search != null)
            SizedBox(
              width: 320,
              child: search!,
            ),

          ...filters,

          if (actions.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.lg),
            ...actions,
          ],
        ],
      ),
    );
  }
}
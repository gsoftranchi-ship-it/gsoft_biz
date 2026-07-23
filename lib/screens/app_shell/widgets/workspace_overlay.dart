import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class WorkspaceOverlay extends StatelessWidget {
  final Widget child;

  const WorkspaceOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.overlayDark,
      child: child,
    );
  }
}
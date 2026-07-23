import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

class ERPWorkspace extends StatelessWidget {
  final Widget? header;
  final Widget? toolbar;
  final Widget body;
  final Widget? footer;

  final EdgeInsetsGeometry? padding;

  const ERPWorkspace({
    super.key,
    this.header,
    this.toolbar,
    required this.body,
    this.footer,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) ...[
            header!,
            const SizedBox(height: AppSpacing.lg),
          ],

          if (toolbar != null) ...[
            toolbar!,
            const SizedBox(height: AppSpacing.lg),
          ],

          Expanded(
            child: body,
          ),

          if (footer != null) ...[
            const SizedBox(height: AppSpacing.lg),
            footer!,
          ],
        ],
      ),
    );
  }
}
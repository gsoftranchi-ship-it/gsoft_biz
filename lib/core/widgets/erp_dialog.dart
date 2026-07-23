import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import 'erp_button.dart';

class ERPDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;

  final String confirmText;
  final String cancelText;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final ERPButtonType confirmType;

  const ERPDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.confirmType = ERPButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      title: Text(
        title,
        style: AppTypography.sectionTitle,
      ),
      content: content ??
          (message == null
              ? null
              : Text(
            message!,
            style: AppTypography.body,
          )),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      actions: [
        ERPButton(
          text: cancelText,
          type: ERPButtonType.outline,
          onPressed: () {
            Navigator.pop(context);
            onCancel?.call();
          },
        ),
        ERPButton(
          text: confirmText,
          type: confirmType,
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
        ),
      ],
    );
  }
}
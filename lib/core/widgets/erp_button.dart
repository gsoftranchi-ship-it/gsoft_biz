import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_durations.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

enum ERPButtonType {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  outline,
  text,
}

enum ERPButtonSize {
  small,
  medium,
  large,
}

class ERPButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final ERPButtonType type;
  final ERPButtonSize size;

  final IconData? icon;
  final bool loading;
  final bool enabled;
  final bool fullWidth;

  const ERPButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ERPButtonType.primary,
    this.size = ERPButtonSize.medium,
    this.icon,
    this.loading = false,
    this.enabled = true,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = !enabled || loading;

    final Color background = switch (type) {
      ERPButtonType.primary => AppColors.primary,
      ERPButtonType.secondary => AppColors.secondary,
      ERPButtonType.success => AppColors.success,
      ERPButtonType.danger => AppColors.danger,
      ERPButtonType.warning => AppColors.warning,
      ERPButtonType.info => AppColors.info,
      ERPButtonType.outline => Colors.transparent,
      ERPButtonType.text => Colors.transparent,
    };

    final Color foreground = switch (type) {
      ERPButtonType.warning => Colors.black,
      ERPButtonType.outline => AppColors.primary,
      ERPButtonType.text => AppColors.primary,
      _ => Colors.white,
    };

    final BorderSide border = switch (type) {
      ERPButtonType.outline =>
      const BorderSide(color: AppColors.primary),
      _ => BorderSide.none,
    };

    final double height = switch (size) {
      ERPButtonSize.small => 38,
      ERPButtonSize.medium => 46,
      ERPButtonSize.large => 54,
    };

    final EdgeInsets padding = switch (size) {
      ERPButtonSize.small =>
      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      ERPButtonSize.medium =>
      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ERPButtonSize.large =>
      const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
    };

    Widget child = AnimatedContainer(
      duration: AppDurations.fast,
      height: height,
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.onLightSecondary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: border,
          ),
        ),
        child: loading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.button,
              ),
            ),
          ],
        ),
      ),
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: child,
      );
    }

    return child;
  }
}
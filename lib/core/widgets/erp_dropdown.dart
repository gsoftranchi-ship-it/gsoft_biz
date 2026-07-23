import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class ERPDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  final String? label;
  final String? hint;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool enabled;

  final String? Function(T?)? validator;

  const ERPDropdown({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.lg);

    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      style: AppTypography.body,
      dropdownColor: AppColors.cardBackground,
      iconEnabledColor: AppColors.iconPrimary,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle: AppTypography.inputLabel,
        hintStyle: AppTypography.inputHint,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: AppColors.inputFill,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),

        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.inputFocusBorder,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.danger,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 2,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.disabled,
          ),
        ),
      ),
    );
  }
}
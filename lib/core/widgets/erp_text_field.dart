import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class ERPTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;

  final int maxLines;
  final int? minLines;

  final String? helperText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  const ERPTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.helperText,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onTap,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.lg);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      autovalidateMode: autovalidateMode,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      style: AppTypography.body,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,

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
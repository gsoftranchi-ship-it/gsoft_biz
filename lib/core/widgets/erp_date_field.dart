import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

class ERPDateField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;

  final DateTime? value;


  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool enabled;

  final VoidCallback? onTap;

  final String? Function(String?)? validator;

  const ERPDateField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.value,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.onTap,
    this.validator,
  });


  @override
  State<ERPDateField> createState() => _ERPDateFieldState();
}

class _ERPDateFieldState extends State<ERPDateField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _syncText();
  }

  @override
  void didUpdateWidget(covariant ERPDateField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _syncText();
    }
  }

  void _syncText() {
    if (widget.value == null) {
      _controller.clear();
    } else {
      final d = widget.value!;
      _controller.text =
      '${d.day}/${d.month}/${d.year}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.lg);

    return InkWell(
      onTap: widget.enabled ? widget.onTap : null,
      borderRadius: radius,
      child: IgnorePointer(
        child: TextFormField(
          controller: _controller,
          enabled: widget.enabled,
          validator: widget.validator,
          style: AppTypography.body,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            helperText: widget.helperText,
            labelStyle: AppTypography.inputLabel,
            hintStyle: AppTypography.inputHint,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ??
                const Icon(Icons.calendar_today_outlined),
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
        ),
      ),
    );
  }
}

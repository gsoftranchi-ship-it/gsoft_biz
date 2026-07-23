import 'package:flutter/material.dart';

import 'erp_text_field.dart';


class ERPSearchBar extends StatelessWidget {
  final TextEditingController? controller;

  final String hint;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onClear;

  final bool autofocus;

  const ERPSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return ERPTextField(
      controller: controller,
      hint: hint,
      autofocus: autofocus,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller != null &&
          controller!.text.isNotEmpty
          ? IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          controller!.clear();
          onClear?.call();
          onChanged?.call('');
        },
      )
          : null,
      onChanged: onChanged,
    );
  }
}
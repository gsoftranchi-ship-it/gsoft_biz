import 'package:flutter/material.dart';

class InvoiceActions extends StatelessWidget {
  const InvoiceActions({
    super.key,
    required this.onCancel,
    required this.onSave,
    this.onSaveDraft,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;
  final VoidCallback? onSaveDraft;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.close),
          label: const Text('Cancel'),
        ),

        const Spacer(),

        OutlinedButton.icon(
          onPressed: onSaveDraft,
          icon: const Icon(Icons.drafts_outlined),
          label: const Text('Save Draft'),
        ),

        const SizedBox(width: 12),

        FilledButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.save),
          label: const Text('Save Invoice'),
        ),
      ],
    );
  }
}
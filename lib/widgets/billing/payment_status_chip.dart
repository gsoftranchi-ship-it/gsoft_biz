import 'package:flutter/material.dart';

import '../../models/invoice_model.dart';

class PaymentStatusChip extends StatelessWidget {
  const PaymentStatusChip({
    super.key,
    required this.status,
  });

  final PaymentStatus status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    String text;

    switch (status) {
      case PaymentStatus.paid:
        backgroundColor = Colors.green.withValues(alpha: 0.15);
        foregroundColor = Colors.green;
        text = 'PAID';
        break;

      case PaymentStatus.partial:
        backgroundColor = Colors.orange.withValues(alpha: 0.15);
        foregroundColor = Colors.orange;
        text = 'PARTIAL';
        break;

      case PaymentStatus.unpaid:
        backgroundColor = Colors.red.withValues(alpha: 0.15);
        foregroundColor = Colors.red;
        text = 'UNPAID';
        break;

      case PaymentStatus.cancelled:
        backgroundColor = Colors.grey.withValues(alpha: 0.20);
        foregroundColor = Colors.grey;
        text = 'CANCELLED';
        break;

      case PaymentStatus.refunded:
        backgroundColor = Colors.blue.withValues(alpha: 0.15);
        foregroundColor = Colors.blue;
        text = 'REFUNDED';
        break;
    }

    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: backgroundColor,
      side: BorderSide.none,
      label: Text(
        text,
        style: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
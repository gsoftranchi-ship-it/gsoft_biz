import 'package:flutter/material.dart';

class MemberPaymentSummaryCard extends StatelessWidget {
  const MemberPaymentSummaryCard({
    super.key,
    required this.totalFee,
    required this.paidAmount,
    required this.dueAmount,
    required this.lastPayment,
    required this.nextDueDate,
  });

  final double totalFee;
  final double paidAmount;
  final double dueAmount;
  final String lastPayment;
  final String nextDueDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row("Total Fee", "₹ ${totalFee.toStringAsFixed(0)}"),
            _row("Paid", "₹ ${paidAmount.toStringAsFixed(0)}"),
            _row(
              "Due",
              "₹ ${dueAmount.toStringAsFixed(0)}",
              valueColor: dueAmount > 0
                  ? Colors.red
                  : Colors.green,
            ),
            _row("Last Payment", lastPayment),
            _row("Next Due", nextDueDate),
          ],
        ),
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        Color? valueColor,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment History",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _paymentTile(
              receiptNo: "REC000001",
              date: "05 Jul 2026",
              amount: "₹ 1,500",
              mode: "UPI",
              success: true,
            ),

            _paymentTile(
              receiptNo: "REC000002",
              date: "05 Jun 2026",
              amount: "₹ 1,500",
              mode: "Cash",
              success: true,
            ),

            _paymentTile(
              receiptNo: "REC000003",
              date: "05 May 2026",
              amount: "₹ 1,500",
              mode: "Card",
              success: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile({
    required String receiptNo,
    required String date,
    required String amount,
    required String mode,
    required bool success,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(
          success ? Icons.check : Icons.close,
        ),
      ),
      title: Text(receiptNo),
      subtitle: Text("$date • $mode"),
      trailing: Text(
        amount,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
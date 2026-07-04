import 'package:flutter/material.dart';

class RenewalSummaryCard extends StatelessWidget {
  const RenewalSummaryCard({
    super.key,
    required this.currentPlan,
    required this.expiryDate,
    required this.remainingDays,
    required this.status,
  });

  final String currentPlan;
  final String expiryDate;
  final int remainingDays;
  final String status;

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
              "Membership Renewal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row("Current Plan", currentPlan),
            _row("Expiry Date", expiryDate),
            _row("Remaining Days", "$remainingDays"),
            _row("Status", status),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    super.key,
    required this.plan,
    required this.joinDate,
    required this.expiryDate,
    required this.remainingDays,
  });

  final String plan;
  final String joinDate;
  final String expiryDate;
  final int remainingDays;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Membership",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(height: 24),

            _row("Plan", plan),
            _row("Joining", joinDate),
            _row("Expiry", expiryDate),
            _row(
              "Remaining",
              "$remainingDays Days",
              valueColor:
              remainingDays <= 7 ? Colors.red : Colors.green,
            ),
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
          Expanded(
            child: Text(title),
          ),
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
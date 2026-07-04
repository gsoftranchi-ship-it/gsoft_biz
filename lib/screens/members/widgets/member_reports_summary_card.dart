import 'package:flutter/material.dart';

class MemberReportsSummaryCard extends StatelessWidget {
  const MemberReportsSummaryCard({
    super.key,
    required this.attendance,
    required this.payments,
    required this.workouts,
    required this.progress,
  });

  final int attendance;
  final int payments;
  final int workouts;
  final int progress;

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
              "Reports Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),
            _row("Attendance Records", "$attendance"),
            _row("Payment Records", "$payments"),
            _row("Workout Sessions", "$workouts"),
            _row("Progress Entries", "$progress"),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
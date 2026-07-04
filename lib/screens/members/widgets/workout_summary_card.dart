import 'package:flutter/material.dart';

class WorkoutSummaryCard extends StatelessWidget {
  const WorkoutSummaryCard({
    super.key,
    required this.trainer,
    required this.program,
    required this.week,
    required this.completed,
  });

  final String trainer;
  final String program;
  final int week;
  final int completed;

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
              "Workout Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row("Trainer", trainer),
            _row("Program", program),
            _row("Current Week", "$week"),
            _row("Completed", "$completed%"),
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
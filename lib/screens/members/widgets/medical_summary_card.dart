import 'package:flutter/material.dart';

class MedicalSummaryCard extends StatelessWidget {
  const MedicalSummaryCard({
    super.key,
    required this.bloodGroup,
    required this.allergies,
    required this.conditions,
    required this.fitForWorkout,
  });

  final String bloodGroup;
  final int allergies;
  final int conditions;
  final bool fitForWorkout;

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
              "Medical Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row("Blood Group", bloodGroup),
            _row("Allergies", "$allergies"),
            _row("Medical Conditions", "$conditions"),
            _row(
              "Workout Status",
              fitForWorkout
                  ? "Fit"
                  : "Medical Clearance Required",
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
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
import 'package:flutter/material.dart';

class DietSummaryCard extends StatelessWidget {
  const DietSummaryCard({
    super.key,
    required this.goal,
    required this.calories,
    required this.meals,
    required this.trainer,
  });

  final String goal;
  final int calories;
  final int meals;
  final String trainer;

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
              "Diet Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row("Goal", goal),
            _row("Daily Calories", "$calories kcal"),
            _row("Meals / Day", "$meals"),
            _row("Diet Coach", trainer),
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
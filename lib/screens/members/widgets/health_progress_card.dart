import 'package:flutter/material.dart';

class HealthProgressCard extends StatelessWidget {
  const HealthProgressCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
    required this.currentBMI,
    required this.targetBMI,
    required this.bodyFat,
  });

  final double currentWeight;
  final double targetWeight;
  final double currentBMI;
  final double targetBMI;
  final double bodyFat;

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
              "Health Progress",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row(
              "Current Weight",
              "${currentWeight.toStringAsFixed(1)} kg",
            ),

            _row(
              "Target Weight",
              "${targetWeight.toStringAsFixed(1)} kg",
            ),

            _row(
              "Current BMI",
              currentBMI.toStringAsFixed(1),
            ),

            _row(
              "Target BMI",
              targetBMI.toStringAsFixed(1),
            ),

            _row(
              "Body Fat",
              "${bodyFat.toStringAsFixed(1)} %",
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
import 'package:flutter/material.dart';

class ProgressChartCard extends StatelessWidget {
  const ProgressChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Weight Trend",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 220,
              child: Center(
                child: Icon(
                  Icons.show_chart,
                  size: 80,
                  color: Colors.blue.shade300,
                ),
              ),
            ),

            const Text(
              "Interactive chart will be connected after Firestore integration.",
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MedicalAlertsCard extends StatelessWidget {
  const MedicalAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              "Medical Alerts",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            const Divider(height: 24),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.warning,
                color: Colors.orange,
              ),
              title: const Text(
                "No Active Medical Alerts",
              ),
              subtitle: const Text(
                "Trainer can assign workouts normally.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  import 'package:flutter/material.dart';

  class MemberQuickActions extends StatelessWidget {
    const MemberQuickActions({
      super.key,
      this.onCollectFee,
      this.onAttendance,
      this.onWorkout,
      this.onDiet,
      this.onRenew,
    });

    final VoidCallback? onCollectFee;
    final VoidCallback? onAttendance;
    final VoidCallback? onWorkout;
    final VoidCallback? onDiet;
    final VoidCallback? onRenew;

    @override
    Widget build(BuildContext context) {
      return Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: onCollectFee,
                    icon: const Icon(Icons.currency_rupee),
                    label: const Text("Collect Fee"),
                  ),
                  FilledButton.icon(
                    onPressed: onAttendance,
                    icon: const Icon(Icons.fact_check),
                    label: const Text("Attendance"),
                  ),
                  FilledButton.icon(
                    onPressed: onWorkout,
                    icon: const Icon(Icons.fitness_center),
                    label: const Text("Workout"),
                  ),
                  FilledButton.icon(
                    onPressed: onDiet,
                    icon: const Icon(Icons.restaurant),
                    label: const Text("Diet"),
                  ),
                  FilledButton.icon(
                    onPressed: onRenew,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Renew"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
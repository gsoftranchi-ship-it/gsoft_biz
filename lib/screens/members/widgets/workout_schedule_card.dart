import 'package:flutter/material.dart';

class WorkoutScheduleCard extends StatelessWidget {
  const WorkoutScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Workout",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _exercise(
              "Bench Press",
              "4 Sets × 12 Reps",
              Icons.fitness_center,
            ),

            _exercise(
              "Incline Dumbbell Press",
              "3 Sets × 10 Reps",
              Icons.fitness_center,
            ),

            _exercise(
              "Cable Fly",
              "3 Sets × 15 Reps",
              Icons.sports_gymnastics,
            ),

            _exercise(
              "Push Ups",
              "3 Sets × Failure",
              Icons.accessibility_new,
            ),
          ],
        ),
      ),
    );
  }

  Widget _exercise(
      String title,
      String subtitle,
      IconData icon,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
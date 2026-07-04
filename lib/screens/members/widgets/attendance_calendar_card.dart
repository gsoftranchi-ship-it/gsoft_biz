import 'package:flutter/material.dart';

class AttendanceCalendarCard extends StatelessWidget {
  const AttendanceCalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    final days = List.generate(30, (index) {
      if (index % 7 == 0) return 0; // Holiday
      if (index % 5 == 0) return -1; // Absent
      return 1; // Present
    });

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Attendance",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: days.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                Color color;

                switch (days[index]) {
                  case 1:
                    color = Colors.green;
                    break;
                  case -1:
                    color = Colors.red;
                    break;
                  default:
                    color = Colors.grey;
                }

                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
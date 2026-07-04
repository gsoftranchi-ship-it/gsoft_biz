import 'package:flutter/material.dart';

class MemberReportsListCard extends StatelessWidget {
  const MemberReportsListCard({super.key});

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
              "Available Reports",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            const ListTile(
              leading: Icon(Icons.fact_check),
              title: Text("Attendance Report"),
            ),

            const ListTile(
              leading: Icon(Icons.currency_rupee),
              title: Text("Payment Report"),
            ),

            const ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text("Workout Report"),
            ),

            const ListTile(
              leading: Icon(Icons.restaurant),
              title: Text("Diet Report"),
            ),

            const ListTile(
              leading: Icon(Icons.monitor_weight),
              title: Text("Progress Report"),
            ),
          ],
        ),
      ),
    );
  }
}
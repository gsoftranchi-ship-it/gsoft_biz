import 'package:flutter/material.dart';

class RenewalHistoryCard extends StatelessWidget {
  const RenewalHistoryCard({super.key});

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
              "Renewal History",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),

            ListTile(
              title: const Text("Gold Membership"),
              subtitle: const Text("01 Jan 2026 - 30 Jun 2026"),
              trailing: const Text("₹6000"),
            ),

            ListTile(
              title: const Text("Gold Membership"),
              subtitle: const Text("01 Jul 2026 - 31 Dec 2026"),
              trailing: const Text("₹6000"),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RenewalActionsCard extends StatelessWidget {
  const RenewalActionsCard({
    super.key,
    this.onRenew,
    this.onInvoice,
    this.onReminder,
  });

  final VoidCallback? onRenew;
  final VoidCallback? onInvoice;
  final VoidCallback? onReminder;

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
              "Renewal Actions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: onRenew,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Renew Membership"),
                ),
                FilledButton.icon(
                  onPressed: onInvoice,
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("Invoice"),
                ),
                FilledButton.icon(
                  onPressed: onReminder,
                  icon: const Icon(Icons.notifications),
                  label: const Text("Reminder"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
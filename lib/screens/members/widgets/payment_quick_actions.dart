import 'package:flutter/material.dart';

class PaymentQuickActions extends StatelessWidget {
  const PaymentQuickActions({
    super.key,
    this.onCollectFee,
    this.onPrintReceipt,
    this.onWhatsAppReceipt,
    this.onRenewMembership,
  });

  final VoidCallback? onCollectFee;
  final VoidCallback? onPrintReceipt;
  final VoidCallback? onWhatsAppReceipt;
  final VoidCallback? onRenewMembership;

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
              "Payment Actions",
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
                  onPressed: onPrintReceipt,
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("Print Receipt"),
                ),

                FilledButton.icon(
                  onPressed: onWhatsAppReceipt,
                  icon: const Icon(Icons.message),
                  label: const Text("WhatsApp"),
                ),

                FilledButton.icon(
                  onPressed: onRenewMembership,
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
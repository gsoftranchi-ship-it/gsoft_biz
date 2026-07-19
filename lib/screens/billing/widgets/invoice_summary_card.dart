import 'package:flutter/material.dart';

class InvoiceSummaryCard extends StatelessWidget {
  const InvoiceSummaryCard({
    super.key,
    required this.subTotal,
    required this.discount,
    required this.tax,
    required this.grandTotal,
  });

  final double subTotal;
  final double discount;
  final double tax;
  final double grandTotal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'STEP 5',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Invoice Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(height: 28),

            Row(
              children: [
                const Expanded(
                  child: Text('Subtotal'),
                ),
                Text(
                  '₹ ${subTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Expanded(
                  child: Text('Discount'),
                ),
                Text(
                  '₹ ${discount.toStringAsFixed(2)}',
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Expanded(
                  child: Text('Tax'),
                ),
                Text(
                  '₹ ${tax.toStringAsFixed(2)}',
                ),
              ],
            ),

            const Divider(height: 30),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Grand Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '₹ ${grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class InvoiceInformationCard extends StatelessWidget {
  const InvoiceInformationCard({
    super.key,
    required this.invoiceNumberController,
    required this.invoiceDateController,
    required this.dueDateController,
  });

  final TextEditingController invoiceNumberController;
  final TextEditingController invoiceDateController;
  final TextEditingController dueDateController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'STEP 1',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Customer & Invoice Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Create and manage invoice details for members or walk-in customers.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),

            const Divider(height: 28),

            Row(
              children: [

                Expanded(
                  child: TextFormField(
                    controller: invoiceNumberController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Invoice Number',
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller: invoiceDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Invoice Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller: dueDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Due Date',
                      suffixIcon: Icon(Icons.event),
                    ),
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
import 'package:flutter/material.dart';

import '../../models/membership_invoice_model.dart';

class MembershipInvoiceDetailsPage extends StatelessWidget {
  const MembershipInvoiceDetailsPage({
    super.key,
    required this.invoice,
  });

  final MembershipInvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Invoice'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow(
                      'Invoice No.',
                      invoice.invoiceNumber,
                    ),
                    _infoRow(
                      'Invoice Date',
                      invoice.invoiceDate
                          .toLocal()
                          .toString()
                          .split(' ')
                          .first,
                    ),
                    _infoRow(
                      'Due Date',
                      invoice.dueDate == null
                          ? '-'
                          : invoice.dueDate!
                          .toLocal()
                          .toString()
                          .split(' ')
                          .first,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Status'),
                        ),
                        Chip(
                          label: Text(
                            invoice.dueAmount <= 0 ? 'Paid' : 'Due',
                          ),
                          backgroundColor: invoice.dueAmount <= 0
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    _infoRow(
                      'Member ID',
                      invoice.memberId,
                    ),

                    _infoRow(
                      'Admission Fee',
                      '₹${invoice.admissionFee.toStringAsFixed(2)}',
                    ),

                    _infoRow(
                      'Membership Fee',
                      '₹${invoice.membershipFee.toStringAsFixed(2)}',
                    ),

                    _infoRow(
                      'Discount',
                      '₹${invoice.discount.toStringAsFixed(2)}',
                    ),

                    _infoRow(
                      'Tax',
                      '₹${invoice.taxAmount.toStringAsFixed(2)}',
                    ),

                    const Divider(),

                    _infoRow(
                      'Total',
                      '₹${invoice.totalAmount.toStringAsFixed(2)}',
                      bold: true,
                    ),

                    _infoRow(
                      'Paid',
                      '₹${invoice.paidAmount.toStringAsFixed(2)}',
                    ),

                    Text(
                      '₹${invoice.dueAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: invoice.dueAmount > 0
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (invoice.remarks.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Remarks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(invoice.remarks),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [

                FilledButton.icon(
                  onPressed: invoice.dueAmount <= 0
                      ? null
                      : () {
                    // TODO(Sprint 16E):
                    // Navigate to Collect Membership Payment.
                  },
                  icon: const Icon(Icons.payments),
                  label: const Text('Collect Payment'),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    // TODO(Sprint 16F):
                    // Print Receipt.
                  },
                  icon: const Icon(Icons.print),
                  label: const Text('Print'),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    // TODO(Future):
                    // Share Invoice.
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      String title,
      String value, {
        bool bold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight:
              bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
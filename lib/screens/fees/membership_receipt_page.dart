  import 'package:flutter/material.dart';

  import '../../models/membership_invoice_model.dart';
  import '../../models/membership_payment_model.dart';
  import '../../../core/constants/app_colors.dart';

  class MembershipReceiptPage extends StatelessWidget {
    const MembershipReceiptPage({
      super.key,
      required this.invoice,
      required this.payment,
    });

    final MembershipInvoiceModel invoice;
    final MembershipPaymentModel payment;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Receipt'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'PAYMENT RECEIPT',
                      style: Theme.of(context).textTheme.headlineSmall
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Thank you for your payment.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Receipt Information',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 16),

                      _infoRow(
                        'Receipt Number',
                        payment.receiptNumber,
                      ),

                      _infoRow(
                        'Payment Date',
                        payment.paymentDate
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
                              (invoice.dueAmount - payment.amount) <= 0
                                  ? 'Paid'
                                  : 'Partial Payment',
                              style: TextStyle(
                                color: (invoice.dueAmount - payment.amount) <= 0
                                    ? AppColors.success
                                    : AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: (invoice.dueAmount - payment.amount) <= 0
                                ? AppColors.success.withValues(alpha: .15)
                                : AppColors.warning.withValues(alpha: .15)
                          )
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Invoice Information',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 16),

                      _infoRow(
                        'Invoice Number',
                        invoice.invoiceNumber,
                      ),

                      _infoRow(
                        'Member ID',
                        invoice.memberId,
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Payment Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 16),

                      _infoRow(
                        'Payment Method',
                        payment.paymentMethod,
                      ),

                      _infoRow(
                        'Transaction ID',
                        payment.transactionId.isEmpty
                            ? '-'
                            : payment.transactionId,
                      ),

                      _infoRow(
                        'Reference Number',
                        payment.referenceNumber.isEmpty
                            ? '-'
                            : payment.referenceNumber,
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Financial Summary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 16),

                      _infoRow(
                        'Amount Paid',
                        '₹${payment.amount.toStringAsFixed(2)}',
                        bold: true,
                      ),

                      // TODO(Sprint 17):
                      // Display refreshed outstanding amount from the updated invoice
                      // after payment is persisted instead of calculating it locally.

                      _infoRow(
                        'Outstanding',
                        '₹${(invoice.dueAmount - payment.amount).clamp(0, double.infinity).toStringAsFixed(2)}',
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),
              if (payment.remarks.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remarks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(payment.remarks),
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
                    onPressed: () {
                      // TODO(Sprint 17):
                      // Implement PDF / Thermal receipt printing.
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print'),
                  ),

                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO(Sprint 17):
                      // Share receipt.
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),

                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
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
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight:
                bold ? FontWeight.bold : FontWeight.normal,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }
  }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/invoice_model.dart';
import 'payment_status_chip.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
    this.onTap,
  });

  final InvoiceModel invoice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 2,
    );

    final date = DateFormat(
      'dd MMM yyyy',
    ).format(invoice.invoiceDate);

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              /// Invoice No + Status
              Row(
                children: [

                  Expanded(
                    child: Text(
                      invoice.invoiceNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  PaymentStatusChip(
                    status:
                    invoice.paymentStatus,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Customer
              Text(
                invoice.customerName.isEmpty
                    ? 'Walk-in Customer'
                    : invoice.customerName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// Invoice Type
              Text(
                invoice.invoiceType.name
                    .toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Grand Total',
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          currency.format(
                            invoice.grandTotal,
                          ),
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [

                        const Text(
                          'Balance',
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          currency.format(
                            invoice.balanceAmount,
                          ),
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 24,
              ),

              Row(
                children: [

                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                  ),

                  const SizedBox(width: 8),

                  Text(date),

                  const Spacer(),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
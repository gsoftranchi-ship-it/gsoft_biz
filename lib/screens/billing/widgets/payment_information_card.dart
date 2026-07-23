import 'package:flutter/material.dart';
import '../../../core/widgets/erp_card.dart';
import '../../../core/widgets/erp_dropdown.dart';
import '../../../core/widgets/erp_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/erp_date_field.dart';

class PaymentInformationCard extends StatelessWidget {
  const PaymentInformationCard({
    super.key,
    required this.taxType,
    required this.paymentMethod,
    required this.notesController,
    required this.onTaxTypeChanged,
    required this.onPaymentMethodChanged,
    required this.paymentStatus,
    required this.onPaymentStatusChanged,
    required this.receivedAmountController,
    required this.balanceAmountController,
    required this.dueDate,

    required this.onSelectDueDate,
    required this.onReceivedAmountChanged,
  });

  final String taxType;
  final String paymentMethod;
  final TextEditingController notesController;
  final String paymentStatus;
  final TextEditingController receivedAmountController;
  final TextEditingController balanceAmountController;
  final DateTime? dueDate;

  final VoidCallback onSelectDueDate;
  final VoidCallback onReceivedAmountChanged;

  final ValueChanged<String> onPaymentStatusChanged;
  final ValueChanged<String?> onTaxTypeChanged;
  final ValueChanged<String?> onPaymentMethodChanged;

  @override
  Widget build(BuildContext context) {
    return ERPCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STEP 4',
              style: AppTypography.label.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Payment Details',
              style: AppTypography.pageTitle,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ERPDropdown<String>(
                    value: taxType,
                    label: 'Tax Type',
                    prefixIcon: const Icon(Icons.receipt_long),
                    items: const [
                      DropdownMenuItem(
                        value: 'GST',
                        child: Text('GST Invoice'),
                      ),
                      DropdownMenuItem(
                        value: 'NON_GST',
                        child: Text('Non GST Invoice'),
                      ),
                    ],
                    onChanged: onTaxTypeChanged,
                  ),
                ),

                if (paymentStatus != 'Credit') ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: ERPDropdown<String>(
                      value: paymentMethod,
                      label: 'Payment Method',
                      prefixIcon: const Icon(Icons.payments),
                      items: const [
                        DropdownMenuItem(
                          value: 'Cash',
                          child: Text('Cash'),
                        ),
                        DropdownMenuItem(
                          value: 'UPI',
                          child: Text('UPI'),
                        ),
                        DropdownMenuItem(
                          value: 'Card',
                          child: Text('Card'),
                        ),
                        DropdownMenuItem(
                          value: 'Bank',
                          child: Text('Bank Transfer'),
                        ),
                      ],
                      onChanged: onPaymentMethodChanged,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            ERPDropdown<String>(
              value: paymentStatus,
              label: 'Payment Status',
              items: const [
                DropdownMenuItem(
                  value: 'Paid',
                  child: Text('Paid'),
                ),
                DropdownMenuItem(
                  value: 'Partial',
                  child: Text('Partial'),
                ),
                DropdownMenuItem(
                  value: 'Credit',
                  child: Text('Credit'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onPaymentStatusChanged(value);
                }
              },
            ),

            const SizedBox(height: 20),

            // Received Amount
            if (paymentStatus != 'Credit') ...[
              ERPTextField(
                controller: receivedAmountController,
                label: 'Received Amount',
                prefixIcon: const Icon(Icons.currency_rupee),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => onReceivedAmountChanged(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Received amount is required.';
                  }

                  final amount = double.tryParse(value);

                  if (amount == null) {
                    return 'Enter a valid amount.';
                  }

                  if (amount < 0) {
                    return 'Amount cannot be negative.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],

              // Balance Amount
            if (paymentStatus == 'Partial' || paymentStatus == 'Credit') ...[
              ERPTextField(
                controller: balanceAmountController,
                label: 'Balance Amount',
                readOnly: true,
                prefixIcon: const Icon(Icons.account_balance_wallet),
              ),
              const SizedBox(height: 20),
            ],

              // Due Date
            if (paymentStatus != 'Paid') ...[
              ERPDateField(
                label: 'Due Date',
                hint: 'Select Due Date',
                value: dueDate,
                prefixIcon: const Icon(Icons.calendar_today),
                onTap: onSelectDueDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Due Date.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 20),

            ERPTextField(
              controller: notesController,
              label: 'Notes / Remarks',
              maxLines: 3,
              prefixIcon: const Icon(Icons.notes),
            ),
          ],
        ),
      ),
    );
  }
}
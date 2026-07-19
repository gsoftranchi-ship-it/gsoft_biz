import 'package:flutter/material.dart';

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
              'STEP 4',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: taxType,
                    decoration: const InputDecoration(
                      labelText: 'Tax Type',
                      prefixIcon: Icon(Icons.receipt_long),
                    ),
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
                    child: DropdownButtonFormField<String>(
                      initialValue: paymentMethod,
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                        prefixIcon: Icon(Icons.payments),
                      ),
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

            DropdownButtonFormField<String>(
              initialValue: paymentStatus,
              decoration: const InputDecoration(
                labelText: 'Payment Status',
                border: OutlineInputBorder(),
              ),
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
              TextFormField(
                controller: receivedAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => onReceivedAmountChanged(),
                decoration: const InputDecoration(
                  labelText: 'Received Amount',
                  prefixIcon: Icon(Icons.currency_rupee),
                ),
              ),
              const SizedBox(height: 20),
            ],

              // Balance Amount
            if (paymentStatus == 'Partial' || paymentStatus == 'Credit') ...[
              TextFormField(
                controller: balanceAmountController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Balance Amount',
                  prefixIcon: Icon(Icons.account_balance_wallet),
                ),
              ),
              const SizedBox(height: 20),
            ],

              // Due Date
            if (paymentStatus != 'Paid') ...[
              InkWell(
                onTap: onSelectDueDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    dueDate == null
                        ? 'Select Due Date'
                        : '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 20),

            TextFormField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes / Remarks',
                prefixIcon: Icon(Icons.notes),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
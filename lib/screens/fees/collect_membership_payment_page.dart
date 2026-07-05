import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/base/audit_info.dart';
import '../../models/base/entity_status.dart';
import '../../models/membership_invoice_model.dart';
import '../../models/membership_payment_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/membership_provider.dart';

class CollectMembershipPaymentPage extends StatefulWidget {
  const CollectMembershipPaymentPage({
    super.key,
    required this.invoice,
  });

  final MembershipInvoiceModel invoice;

  @override
  State<CollectMembershipPaymentPage> createState() =>
      _CollectMembershipPaymentPageState();
}

class _CollectMembershipPaymentPageState
    extends State<CollectMembershipPaymentPage> {
  final _formKey = GlobalKey<FormState>();

  final _paymentAmountController = TextEditingController();

  final _transactionIdController = TextEditingController();

  final _referenceNumberController = TextEditingController();

  final _remarksController = TextEditingController();

  DateTime _paymentDate = DateTime.now();

  String _paymentMethod = 'Cash';

  @override
  void initState() {
    super.initState();

    _paymentAmountController.text =
        widget.invoice.dueAmount.toStringAsFixed(2);
  }
  @override
  void dispose() {
    _paymentAmountController.dispose();
    _transactionIdController.dispose();
    _referenceNumberController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collect Membership Payment'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            if (widget.invoice.dueAmount <= 0)
              Card(
                color: Colors.green.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'This invoice has already been fully paid.',
                  ),
                ),
              ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Invoice Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _infoRow(
                      'Invoice Number',
                      widget.invoice.invoiceNumber,
                    ),

                    _infoRow(
                      'Member ID',
                      widget.invoice.memberId,
                    ),

                    _infoRow(
                      'Invoice Total',
                      '₹${widget.invoice.totalAmount.toStringAsFixed(2)}',
                    ),

                    _infoRow(
                      'Paid Amount',
                      '₹${widget.invoice.paidAmount.toStringAsFixed(2)}',
                    ),

                    _infoRow(
                      'Outstanding',
                      '₹${widget.invoice.dueAmount.toStringAsFixed(2)}',
                      bold: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            TextFormField(
              controller: _paymentAmountController,
              enabled: widget.invoice.dueAmount > 0,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter payment amount';
                }

                final amount = double.tryParse(value);

                if (amount == null) {
                  return 'Invalid amount';
                }

                if (amount <= 0) {
                  return 'Payment must be greater than zero';
                }

                if (amount > widget.invoice.dueAmount) {
                  return 'Payment cannot exceed outstanding amount';
                }

                return null;
              },

              decoration: const InputDecoration(
                labelText: 'Payment Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                border: OutlineInputBorder(),
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
                  value: 'Bank Transfer',
                  child: Text('Bank Transfer'),
                ),
              ],
              onChanged: widget.invoice.dueAmount <= 0
                  ? null
                  : (value) {
                if (value == null) return;

                setState(() {
                  _paymentMethod = value;
                });
              },
            ),

            const SizedBox(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text('Payment Date'),
              subtitle: Text(
                _paymentDate
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),
              trailing: const Icon(Icons.edit_calendar),
              enabled: widget.invoice.dueAmount > 0,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _paymentDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() {
                    _paymentDate = picked;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _transactionIdController,
              enabled: widget.invoice.dueAmount > 0,
              decoration: const InputDecoration(
                labelText: 'Transaction ID (Optional)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _referenceNumberController,
              enabled: widget.invoice.dueAmount > 0,
              decoration: const InputDecoration(
                labelText: 'Reference Number (Optional)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _remarksController,
              enabled: widget.invoice.dueAmount > 0,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: widget.invoice.dueAmount <= 0
                  ? null
                  : () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                final authProvider =
                context.read<AuthProvider>();

                final currentUser =
                authProvider.currentUser!;

                final paymentAmount =
                double.parse(
                  _paymentAmountController.text,
                );

                final payment = MembershipPaymentModel(
                  paymentId: '',
                  invoiceId: widget.invoice.invoiceId,
                  memberId: widget.invoice.memberId,
                  receiptNumber: '',
                  paymentDate: _paymentDate,
                  amount: paymentAmount,
                  paymentMethod: _paymentMethod,
                  transactionId:
                  _transactionIdController.text.trim(),
                  referenceNumber:
                  _referenceNumberController.text.trim(),
                  remarks:
                  _remarksController.text.trim(),
                  tenantInfo: currentUser.tenantInfo,
                  auditInfo: AuditInfo(
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    createdBy: currentUser.id,
                    updatedBy: currentUser.id,
                  ),
                  status: EntityStatus.active,
                );

                final messenger =
                ScaffoldMessenger.of(context);

                final navigator =
                Navigator.of(context);

                final success = await context
                    .read<MembershipProvider>()
                    .collectPayment(payment);

                if (!mounted) return;

                if (success) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Payment collected successfully.',
                      ),
                    ),
                  );

                  // TODO(Sprint 16F):
                  // Navigate back to
                  // MembershipInvoiceDetailsPage
                  // after refreshing invoice data.

                  navigator.pop();
                } else {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Unable to collect payment.',
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.payments),
              label: const Text(
                'Collect Payment',
              ),
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
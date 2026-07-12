import 'package:flutter/material.dart';

import '../../models/invoice_model.dart';
import '../../models/payment_model.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/payment_provider.dart';

import '../../models/base/audit_info.dart';
import '../../models/base/entity_status.dart';
import '../../models/base/tenant_info.dart';

class CollectPaymentPage extends StatefulWidget {
  const CollectPaymentPage({
    super.key,
    required this.invoice,
  });

  final InvoiceModel invoice;

  @override
  State<CollectPaymentPage> createState() =>
      _CollectPaymentPageState();
}

class _CollectPaymentPageState
    extends State<CollectPaymentPage> {
  final _formKey = GlobalKey<FormState>();

  final _paymentAmountController =
  TextEditingController();

  final _referenceController =
  TextEditingController();

  final _paymentSourceController =
  TextEditingController();

  final _remarksController =
  TextEditingController();

  PaymentMethod _paymentMethod =
      PaymentMethod.cash;

  double get _outstanding =>
      widget.invoice.balanceAmount;

  @override
  void initState() {
    super.initState();

    _paymentAmountController.text =
        _outstanding.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _paymentAmountController.dispose();
    _referenceController.dispose();
    _paymentSourceController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _validateAndContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider =
    context.read<AuthProvider>();

    final paymentProvider =
    context.read<PaymentProvider>();

    final user = authProvider.currentUser;

    final gymId = user?.tenantInfo.gymId;

    if (gymId == null || gymId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gym not found.'),
        ),
      );
      return;
    }

    final amount = double.parse(
      _paymentAmountController.text,
    );

    final receivedAmount =
        widget.invoice.receivedAmount + amount;

    final balanceAmount =
    (widget.invoice.grandTotal - receivedAmount)
        .clamp(
      0.0,
      double.infinity,
    );

    final PaymentStatus paymentStatus;

    if (balanceAmount <= 0) {
      paymentStatus = PaymentStatus.paid;
    } else if (receivedAmount > 0) {
      paymentStatus = PaymentStatus.partial;
    } else {
      paymentStatus = PaymentStatus.unpaid;
    }

    final payment = PaymentModel(
      paymentId:
      DateTime.now().millisecondsSinceEpoch.toString(),

      invoiceId: widget.invoice.invoiceId,

      paymentType: PaymentType.payment,

      paymentMethod: _paymentMethod,

      paymentDate: DateTime.now(),

      amount: amount,

      referenceNumber:
      _referenceController.text.trim(),

      paymentSource:
      _paymentSourceController.text.trim(),

      remarks:
      _remarksController.text.trim(),

      version: 1,

      tenantInfo: TenantInfo(
        gymId: gymId,
      ),

      auditInfo: AuditInfo(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: user?.id ?? '',
        updatedBy: user?.id ?? '',
      ),

      status: EntityStatus.active,
    );

    final updatedInvoice = InvoiceModel(
      invoiceId: widget.invoice.invoiceId,
      invoiceNumber: widget.invoice.invoiceNumber,
      invoiceType: widget.invoice.invoiceType,

      memberId: widget.invoice.memberId,
      customerId: widget.invoice.customerId,
      supplierId: widget.invoice.supplierId,

      customerName: widget.invoice.customerName,
      customerPhone: widget.invoice.customerPhone,
      customerEmail: widget.invoice.customerEmail,
      customerAddress: widget.invoice.customerAddress,
      customerGstin: widget.invoice.customerGstin,

      invoiceDate: widget.invoice.invoiceDate,
      dueDate: widget.invoice.dueDate,

      subtotal: widget.invoice.subtotal,
      discountAmount: widget.invoice.discountAmount,
      discountPercentage:
      widget.invoice.discountPercentage,
      taxableAmount:
      widget.invoice.taxableAmount,

      cgstAmount: widget.invoice.cgstAmount,
      sgstAmount: widget.invoice.sgstAmount,
      igstAmount: widget.invoice.igstAmount,
      taxAmount: widget.invoice.taxAmount,

      grandTotal: widget.invoice.grandTotal,

      receivedAmount: receivedAmount,

      balanceAmount: balanceAmount,

      paymentStatus: paymentStatus,

      paymentMethod: _paymentMethod.name,

      amountInWords:
      widget.invoice.amountInWords,

      notes: widget.invoice.notes,

      version: widget.invoice.version,

      tenantInfo: widget.invoice.tenantInfo,

      auditInfo: AuditInfo(
        createdAt:
        widget.invoice.auditInfo.createdAt,
        updatedAt: DateTime.now(),
        createdBy:
        widget.invoice.auditInfo.createdBy,
        updatedBy: user?.id ?? '',
      ),

      status: widget.invoice.status,
    );

    try {
      await paymentProvider.savePaymentTransaction(
        gymId: gymId,
        payment: payment,
        invoice: updatedInvoice,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collect Payment',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            Card(
              child: Padding(
                padding:
                const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.invoice.invoiceNumber,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Customer : ${widget.invoice.customerName}',
                    ),

                    Text(
                      'Grand Total : ₹ ${widget.invoice.grandTotal.toStringAsFixed(2)}',
                    ),

                    Text(
                      'Received : ₹ ${widget.invoice.receivedAmount.toStringAsFixed(2)}',
                    ),

                    Text(
                      'Outstanding : ₹ ${widget.invoice.balanceAmount.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextFormField(
              controller:
              _paymentAmountController,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
              const InputDecoration(
                labelText:
                'Payment Amount',
                prefixIcon:
                Icon(Icons.currency_rupee),
              ),
              validator: (value) {
                final amount =
                    double.tryParse(
                      value ?? '',
                    ) ??
                        0;

                if (amount <= 0) {
                  return 'Enter payment amount';
                }

                if (amount > _outstanding) {
                  return 'Payment exceeds outstanding balance';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<
                PaymentMethod>(
              initialValue: _paymentMethod,
              decoration:
              const InputDecoration(
                labelText:
                'Payment Method',
                prefixIcon:
                Icon(Icons.payments),
              ),
              items: PaymentMethod.values
                  .map(
                    (method) =>
                    DropdownMenuItem(
                      value: method,
                      child: Text(
                        method.name,
                      ),
                    ),
              )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _paymentMethod = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _referenceController,
              decoration:
              const InputDecoration(
                labelText:
                'Reference Number',
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _paymentSourceController,
              decoration:
              const InputDecoration(
                labelText:
                'Payment Source',
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _remarksController,
              maxLines: 3,
              decoration:
              const InputDecoration(
                labelText:
                'Remarks',
              ),
            ),

            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed:
              _validateAndContinue,
              icon: const Icon(
                Icons.payments,
              ),
              label: const Text(
                'Collect Payment',
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
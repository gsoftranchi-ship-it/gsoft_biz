import 'package:flutter/material.dart';

import '../../../../core/constants/app_lists.dart';
import '../controllers/member_form_controller.dart';

class PaymentInformationCard extends StatelessWidget {
  const PaymentInformationCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Payment Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.admissionFeeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Admission Fee",
                prefixIcon: Icon(Icons.payments),
              ),
              onChanged: (_) =>
                  controller.calculateFinalAmount(),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.membershipFeeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Membership Fee",
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              onChanged: (_) =>
                  controller.calculateFinalAmount(),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.discountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Discount",
                prefixIcon: Icon(Icons.discount),
              ),
              onChanged: (_) =>
                  controller.calculateFinalAmount(),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.finalAmountController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Final Amount",
                prefixIcon: Icon(Icons.calculate),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.paidAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Paid Amount",
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              onChanged: (_) =>
                  controller.calculateDue(),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.dueAmountController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Due Amount",
                prefixIcon: Icon(Icons.warning_amber),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: controller.paymentMode,
              decoration: const InputDecoration(
                labelText: "Payment Mode",
                prefixIcon: Icon(Icons.credit_card),
              ),
              items: AppLists.paymentModes
                  .map(
                    (mode) => DropdownMenuItem(
                  value: mode,
                  child: Text(mode),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.setPaymentMode(value);
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              controller.transactionIdController,
              decoration: const InputDecoration(
                labelText: "Transaction ID",
                prefixIcon: Icon(Icons.receipt_long),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              controller.receiptNumberController,
              decoration: const InputDecoration(
                labelText: "Receipt Number",
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              controller.paymentRemarksController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Payment Remarks",
                prefixIcon: Icon(Icons.notes),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
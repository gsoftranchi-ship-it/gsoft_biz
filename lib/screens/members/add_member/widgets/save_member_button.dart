import 'package:flutter/material.dart';

import '../controllers/member_form_controller.dart';

class SaveMemberButton extends StatelessWidget {
  const SaveMemberButton({
    super.key,
    required this.controller,
    required this.onSave,
  });

  final MemberFormController controller;

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 30),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Admission Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            _row(
              "Member ID",
              controller.memberIdController.text,
            ),

            _row(
              "Member Name",
              controller.fullNameController.text,
            ),

            _row(
              "Membership",
              controller.membershipPlan,
            ),

            _row(
              "Final Amount",
              "₹ ${controller.finalAmountController.text}",
            ),

            _row(
              "Paid",
              "₹ ${controller.paidAmountController.text}",
            ),

            _row(
              "Due",
              "₹ ${controller.dueAmountController.text}",
            ),

            _row(
              "BMI",
              controller.bmi.toStringAsFixed(1),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text(
                  "SAVE ADMISSION",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(title),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../controllers/member_form_controller.dart';
import 'package:provider/provider.dart';
import '../../../../providers/member_provider.dart';

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
    final isSaving = context.watch<MemberProvider>().loading;
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

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: isSaving ? null : onSave,
                icon: isSaving
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : const Icon(Icons.save),
                label: Text(
                  isSaving ? "Saving Admission..." : "Save Admission",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
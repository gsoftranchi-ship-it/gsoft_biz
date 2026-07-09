import 'package:flutter/material.dart';

import '../controllers/purchase_form_controller.dart';

class SavePurchaseButton extends StatelessWidget {
  const SavePurchaseButton({
    super.key,
    required this.controller,
    required this.onSave,
  });

  final PurchaseFormController controller;
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
              "Purchase Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            _row(
              "Supplier",
              controller.supplierController.text,
            ),

            _row(
              "Product",
              controller.selectedProduct,
            ),

            _row(
              "Quantity",
              controller.quantityController.text,
            ),

            _row(
              "Purchase Price",
              "₹ ${controller.purchasePriceController.text}",
            ),

            _row(
              "GST",
              "${controller.taxController.text} %",
            ),

            _row(
              "Grand Total",
              "₹ ${controller.grandTotalController.text.isEmpty ? "0.00" : controller.grandTotalController.text}",
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Purchase",
                  style: TextStyle(
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
      padding: const EdgeInsets.symmetric(vertical: 5),
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
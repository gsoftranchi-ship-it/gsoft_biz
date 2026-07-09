import 'package:flutter/material.dart';

import '../controllers/purchase_form_controller.dart';

class PurchaseSupplierCard extends StatelessWidget {
  const PurchaseSupplierCard({
    super.key,
    required this.controller,
  });

  final PurchaseFormController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Supplier Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.supplierController,
              decoration: const InputDecoration(
                labelText: "Supplier Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.invoiceNumberController,
              decoration: const InputDecoration(
                labelText: "Invoice Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt_long),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
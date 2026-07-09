import 'package:flutter/material.dart';

import '../controllers/purchase_form_controller.dart';

class PurchaseProductCard extends StatelessWidget {
  const PurchaseProductCard({
    super.key,
    required this.controller,
  });

  final PurchaseFormController controller;

  static const List<String> _products = [
    'Whey Protein 1kg',
    'Mass Gainer',
    'Creatine',
    'Gym Gloves',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: controller.selectedProduct,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select Product',
              ),
              items: _products
                  .map(
                    (product) => DropdownMenuItem<String>(
                  value: product,
                  child: Text(product),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.setProduct(value);
                }
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: controller.quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.production_quantity_limits),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: controller.purchasePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: controller.taxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'GST %',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.percent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
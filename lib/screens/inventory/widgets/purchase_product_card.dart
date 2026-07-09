import 'package:flutter/material.dart';

import '../controllers/purchase_form_controller.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_provider.dart';
import '../../../models/product_model.dart';

class PurchaseProductCard extends StatelessWidget {
  const PurchaseProductCard({
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
              'Product',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<String>(
                  initialValue: controller.selectedProduct.isEmpty
                      ? null
                      : controller.selectedProduct,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Product',
                  ),
                  items: provider.products
                      .map(
                        (ProductModel product) => DropdownMenuItem<String>(
                      value: product.productName,
                      child: Text(product.productName),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    controller.setProduct(value);

                    final product = provider.products.firstWhere(
                          (e) => e.productName == value,
                    );

                    controller.purchasePriceController.text =
                        product.purchasePrice.toStringAsFixed(2);

                    controller.calculateTotals();
                  },
                );
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
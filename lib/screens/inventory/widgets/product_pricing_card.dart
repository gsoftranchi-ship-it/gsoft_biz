import 'package:flutter/material.dart';

import '../controllers/product_form_controller.dart';

class ProductPricingCard extends StatelessWidget {
  const ProductPricingCard({
    super.key,
    required this.controller,
  });

  final ProductFormController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.purchasePriceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
                hintText: '0.00',
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.sellingPriceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Selling Price',
                hintText: '0.00',
                prefixIcon: Icon(Icons.sell_outlined),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
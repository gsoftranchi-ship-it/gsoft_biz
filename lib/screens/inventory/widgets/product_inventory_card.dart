import 'package:flutter/material.dart';

import '../controllers/product_form_controller.dart';

class ProductInventoryCard extends StatelessWidget {
  const ProductInventoryCard({
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
              'Inventory Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.reorderLevelController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Reorder Level',
                hintText: '0',
                helperText:
                'Minimum stock level before replenishment is recommended.',
                prefixIcon: Icon(Icons.inventory_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Current stock is managed by Purchase and Sales transactions. '
                          'Only the reorder level is maintained in Product Master.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
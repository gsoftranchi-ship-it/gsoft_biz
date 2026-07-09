import 'package:flutter/material.dart';

import '../controllers/product_form_controller.dart';

class ProductBasicInformationCard extends StatelessWidget {
  const ProductBasicInformationCard({
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
              'Basic Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.productNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.inventory_2_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.categoryController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.unitController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Unit',
                hintText: 'Nos, Kg, Box, Packet',
                prefixIcon: Icon(Icons.straighten_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Active Product'),
              subtitle: const Text(
                'Inactive products will not be available for purchase or sales.',
              ),
              value: controller.isActive,
              onChanged: controller.setActive,
            ),
          ],
        ),
      ),
    );
  }
}
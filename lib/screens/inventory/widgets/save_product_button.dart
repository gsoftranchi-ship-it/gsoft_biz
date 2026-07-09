import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/product_provider.dart';
import '../controllers/product_form_controller.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({
    super.key,
    required this.controller,
  });

  final ProductFormController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return FilledButton.icon(
            onPressed: provider.loading
                ? null
                : () async {
              final messenger = ScaffoldMessenger.of(context);

              if (!controller.validate()) {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please fill all required fields.',
                    ),
                  ),
                );
                return;
              }

              final authProvider =
              context.read<AuthProvider>();

              final gymId = authProvider
                  .currentUser?.tenantInfo.gymId ??
                  '';

              if (gymId.isEmpty) {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Gym information not found.',
                    ),
                  ),
                );
                return;
              }

              final productId =
              await provider.generateNextProductId();

              if (productId == null) {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Unable to generate Product ID.',
                    ),
                  ),
                );
                return;
              }

              final product = ProductModel(
                productId: productId,
                gymId: gymId,
                productName: controller
                    .productNameController.text
                    .trim(),
                categoryId: controller
                    .categoryController.text
                    .trim(),
                unit: controller.unitController.text.trim(),
                purchasePrice: double.tryParse(
                  controller.purchasePriceController.text,
                ) ??
                    0,
                sellingPrice: double.tryParse(
                  controller.sellingPriceController.text,
                ) ??
                    0,
                reorderLevel: int.tryParse(
                  controller.reorderLevelController.text,
                ) ??
                    0,
                isActive: controller.isActive,
                searchName: controller
                    .productNameController.text
                    .trim()
                    .toLowerCase(),
                version: 1,
              );

              final success =
              await provider.add(product);

              if (!context.mounted) return;

              if (success) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Product saved successfully.',
                    ),
                  ),
                );
              } else {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      provider.failure?.message ??
                          'Failed to save product.',
                    ),
                  ),
                );
              }
            },
            icon: provider.loading
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
                : const Icon(Icons.save),
            label: Text(
              provider.loading
                  ? 'Saving...'
                  : 'Save Product',
            ),
          );
        },
      ),
    );
  }
}
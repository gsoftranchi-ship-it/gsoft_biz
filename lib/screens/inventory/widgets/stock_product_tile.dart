import 'package:flutter/material.dart';

import '../../../models/product_model.dart';

class StockProductTile extends StatelessWidget {
  const StockProductTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: product.isActive
              ? Colors.green.shade100
              : Colors.red.shade100,
          child: Icon(
            Icons.inventory_2_rounded,
            color: product.isActive
                ? Colors.green
                : Colors.red,
          ),
        ),

        title: Text(
          product.productName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category : ${product.categoryId}"),
            Text("Unit : ${product.unit}"),
            Text(
              "Reorder Level : ${product.reorderLevel}",
            ),
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹${product.sellingPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 4),

            Chip(
              label: Text(
                product.isActive
                    ? "ACTIVE"
                    : "INACTIVE",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: product.isActive
                  ? Colors.green
                  : Colors.red,
              materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),

        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(product.productName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.inventory_2_rounded,
                      size: 64,
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text("Product ID : ${product.productId}"),
                  Text("Category : ${product.categoryId}"),
                  Text("Unit : ${product.unit}"),

                  const Divider(),

                  Text(
                    "Purchase Price : ₹${product.purchasePrice.toStringAsFixed(2)}",
                  ),

                  Text(
                    "Selling Price : ₹${product.sellingPrice.toStringAsFixed(2)}",
                  ),

                  Text(
                    "Reorder Level : ${product.reorderLevel}",
                  ),

                  const SizedBox(height: 12),

                  Text(
                    product.isActive
                        ? "Status : Active"
                        : "Status : Inactive",
                    style: TextStyle(
                      color: product.isActive
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Current stock will be calculated automatically after Purchase and Sales modules are integrated.",
                  ),
                ],
              ),
              actions: [
                FilledButton(
                  onPressed: () =>
                      Navigator.of(context).pop(),
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
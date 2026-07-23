import 'package:flutter/material.dart';
import '../../models/invoice_item_model.dart';

class InvoiceItemsTable extends StatelessWidget {
  const InvoiceItemsTable({
    super.key,
    required this.items,
    required this.onAddProduct,
    required this.onDeleteItem,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  final List<InvoiceItemModel> items;

  final VoidCallback onAddProduct;

  final ValueChanged<int> onDeleteItem;

  final ValueChanged<int> onIncreaseQuantity;

  final ValueChanged<int> onDecreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Expanded(
                  child: Text(
                    'Invoice Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                FilledButton.icon(
                  onPressed: onAddProduct,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Table(
              border: TableBorder.all(
                color: Theme.of(context).dividerColor,
              ),
              columnWidths: const {
                0: FlexColumnWidth(4),
                1: FlexColumnWidth(1.4),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Product',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          'Qty',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Rate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Icon(Icons.delete_outline),
                      ),
                    ),
                  ],
                ),

                ...List.generate(items.length, (index) {
                  final item = items[index];

                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(item.itemName),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => onDecreaseQuantity(index),
                            ),
                            Text(
                              item.quantity.toStringAsFixed(0),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => onIncreaseQuantity(index),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '₹${item.unitPrice.toStringAsFixed(2)}',
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          '₹${item.lineTotal.toStringAsFixed(2)}',
                        ),
                      ),

                      Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => onDeleteItem(index),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),

            const SizedBox(height: 20),

            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 56,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Products Added',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add products or services to begin creating this invoice.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: onAddProduct,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Product'),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../models/invoice_item_model.dart';

class InvoiceItemsTable extends StatelessWidget {
  const InvoiceItemsTable({
    super.key,
    required this.items,
    required this.onAddProduct,
    required this.onDeleteItem,
  });

  final List<InvoiceItemModel> items;

  final VoidCallback onAddProduct;

  final ValueChanged<int> onDeleteItem;

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
                color: Colors.grey.shade300,
              ),
              columnWidths: const {

                0: FlexColumnWidth(4),

                1: FlexColumnWidth(1.2),

                2: FlexColumnWidth(2),

                3: FlexColumnWidth(2),

                4: FlexColumnWidth(1),
              },

              children: const [

                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F5F5),
                  ),
                  children: [

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Item',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Qty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Rate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No items added.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  items.length,
                      (index) {
                    final item = items[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [

                          Expanded(
                            flex: 4,
                            child: Text(item.itemName),
                          ),

                          Expanded(
                            child: Text(
                              item.quantity.toStringAsFixed(0),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              "₹${item.unitPrice.toStringAsFixed(2)}",
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              "₹${item.lineTotal.toStringAsFixed(2)}",
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                onDeleteItem(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
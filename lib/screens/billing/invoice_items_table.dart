import 'package:flutter/material.dart';

class InvoiceItemsTable extends StatelessWidget {
  const InvoiceItemsTable({
    super.key,
  });

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
                  onPressed: () {
                    // TODO(RC1):
                    // Open Product Selector
                  },
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

            const Center(
              child: Text(
                'No items added.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Management"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.refresh),
        label: const Text("Refresh"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  "Products",
                  "245",
                  Colors.blue,
                  Icons.inventory_2,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  "Low Stock",
                  "06",
                  Colors.red,
                  Icons.warning_amber_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  "In Stock",
                  "239",
                  Colors.green,
                  Icons.check_circle,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  "Stock Value",
                  "₹4.82L",
                  Colors.orange,
                  Icons.currency_rupee,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            "Current Stock",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _stockTile(
            context,
            "Whey Protein 1kg",
            "Nutrition",
            24,
            5,
          ),

          _stockTile(
            context,
            "Mass Gainer",
            "Nutrition",
            12,
            5,
          ),

          _stockTile(
            context,
            "Creatine",
            "Supplement",
            48,
            10,
          ),

          _stockTile(
            context,
            "Gym Gloves",
            "Accessories",
            8,
            10,
          ),

          _stockTile(
            context,
            "Shaker Bottle",
            "Accessories",
            36,
            10,
          ),

          _stockTile(
            context,
            "Resistance Band",
            "Fitness",
            3,
            10,
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _summaryCard(
      String title,
      String value,
      Color color,
      IconData icon,
      ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 6),

            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _stockTile(
      BuildContext context,
      String product,
      String category,
      int stock,
      int minimum,
      ) {
    final low = stock <= minimum;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          low ? Colors.red.shade100 : Colors.green.shade100,
          child: Icon(
            Icons.inventory_2,
            color: low ? Colors.red : Colors.green,
          ),
        ),

        title: Text(
          product,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(category),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "$stock",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: low ? Colors.red : Colors.green,
                fontSize: 18,
              ),
            ),

            Text(
              low ? "LOW" : "OK",
              style: TextStyle(
                color: low ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(product),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.inventory_2,
                    size: 70,
                    color: Colors.orange,
                  ),

                  const SizedBox(height: 16),

                  Text("Category : $category"),

                  Text("Available : $stock"),

                  Text("Minimum : $minimum"),

                  const SizedBox(height: 10),

                  Text(
                    low
                        ? "Stock Reorder Required"
                        : "Stock Available",
                    style: TextStyle(
                      color: low
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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


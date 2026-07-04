import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _productCard(
            "Whey Protein 1kg",
            "Health Supplement",
            "₹2200",
            "Stock : 24",
            Colors.green,
          ),

          _productCard(
            "Mass Gainer",
            "Nutrition",
            "₹1850",
            "Stock : 12",
            Colors.orange,
          ),

          _productCard(
            "Creatine",
            "Supplement",
            "₹950",
            "Stock : 48",
            Colors.green,
          ),

          _productCard(
            "Gym Gloves",
            "Accessories",
            "₹450",
            "Stock : 8",
            Colors.red,
          ),

          _productCard(
            "Shaker Bottle",
            "Accessories",
            "₹250",
            "Stock : 36",
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _productCard(
      String name,
      String category,
      String price,
      String stock,
      Color stockColor,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.inventory_2_rounded,
                size: 38,
                color: Colors.orange,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(category),

                  const SizedBox(height: 8),

                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    stock,
                    style: TextStyle(
                      color: stockColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            PopupMenuButton(
              itemBuilder: (_) => const [

                PopupMenuItem(
                  value: 1,
                  child: Text("View"),
                ),

                PopupMenuItem(
                  value: 2,
                  child: Text("Edit"),
                ),

                PopupMenuItem(
                  value: 3,
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import 'add_product/add_product_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final authProvider = context.read<AuthProvider>();

      final gymId = authProvider.currentUser?.tenantInfo.gymId;

      if (gymId != null) {
        context.read<ProductProvider>().loadProducts(
          gymId: gymId,
        );
      }
    });
  }

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
        onPressed: () async {
          final authProvider = context.read<AuthProvider>();
          final productProvider = context.read<ProductProvider>();

          final gymId = authProvider.currentUser?.tenantInfo.gymId;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductPage(),
            ),
          );

          if (!mounted || gymId == null) return;

          await productProvider.loadProducts(
            gymId: gymId,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.products.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];

              return _productCard(
                product.productName,
                product.categoryId,
                "₹${product.sellingPrice.toStringAsFixed(2)}",
                "Product Master",
                product.isActive
                    ? Colors.green
                    : Colors.red,
              );
            },
          );
        },
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
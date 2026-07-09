import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import 'widgets/stock_product_tile.dart';


class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
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
        onPressed: () async {
          await context.read<ProductProvider>().refresh();
        },
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
            "Product Master",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              if (provider.loading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (provider.products.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "No products available.",
                    ),
                  ),
                );
              }

              return Column(
                children: provider.products
                    .map(
                      (product) => StockProductTile(
                    product: product,
                  ),
                )
                    .toList(),
              );
            },
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


}


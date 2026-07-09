import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import 'widgets/stock_product_tile.dart';
import 'widgets/stock_summary_card.dart';


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

          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  Expanded(
                    child: StockSummaryCard(
                      title: "Products",
                      value: provider.totalProducts.toString(),
                      color: Colors.blue,
                      icon: Icons.inventory_2,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: StockSummaryCard(
                      title: "Inactive",
                      value: provider.inactiveProducts.toString(),
                      color: Colors.red,
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 12),

          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  Expanded(
                    child: StockSummaryCard(
                      title: "Active",
                      value: provider.activeProducts.toString(),
                      color: Colors.green,
                      icon: Icons.check_circle,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: StockSummaryCard(
                      title: "Inventory",
                      value: "Pending",
                      color: Colors.orange,
                      icon: Icons.inventory,
                    ),
                  ),
                ],
              );
            },
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
}


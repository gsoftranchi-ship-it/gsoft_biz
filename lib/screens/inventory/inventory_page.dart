import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'products_page.dart';
import 'purchase_page.dart';
import 'sales_page.dart';
import 'stock_page.dart';


class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            "Inventory Management",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Manage Products, Purchase, Sales & Stock",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 24),

          GridView.count(
            crossAxisCount:
            MediaQuery.of(context).size.width > 700 ? 4 : 2,
            childAspectRatio:
            MediaQuery.of(context).size.width > 700 ? 1.1 : 0.82,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [

              _dashboardCard(
                context,
                "Products",
                Icons.inventory_2_rounded,
                "245 Items",
                AppColors.info,
                const ProductsPage(),
              ),

              _dashboardCard(
                context,
                "Purchase",
                Icons.shopping_cart_checkout_rounded,
                "Today's Purchase",
                AppColors.success,
                const PurchasePage(),
              ),

              _dashboardCard(
                context,
                "Sales",
                Icons.point_of_sale_rounded,
                "Today's Sales",
                AppColors.primary,
                const SalesPage(),
              ),

              _dashboardCard(
                context,
                "Stock",
                Icons.warehouse_rounded,
                "Current Stock",
                AppColors.warning,
                const StockPage(),
              ),

            ],
          ),

          const SizedBox(height: 28),

          const Text(
            "Inventory Summary",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),



          Row(
            children: [

              Expanded(
                child: _summary(
                  "Products",
                  "245",
                  Colors.blue,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Stock Value",
                  "₹4.82L",
                  Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summary(
                  "Today's Sale",
                  "₹18,450",
                  Colors.orange,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Low Stock",
                  "06",
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
     ),
    );
  }

  Widget _summary(
      String title,
      String value,
      Color color,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(
                  color: color,
                  fontSize: value.length > 6 ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(
      BuildContext context,
      String title,
      IconData icon,
      String subtitle,
      Color color,
      Widget page,
      ) {
    return Material(
        borderRadius: BorderRadius.circular(18),
        color: Colors.transparent,
        child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 24,
                backgroundColor:
                color.withValues(alpha: .15),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
     ),
    );
  }
}
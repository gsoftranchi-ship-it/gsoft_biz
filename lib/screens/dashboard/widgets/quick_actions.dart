import 'package:flutter/material.dart';
import '../../../widgets/buttons/quick_action_button.dart';
import '../../inventory/purchase_page.dart';
import '../../inventory/sales_page.dart';
import '../../inventory/stock_page.dart';
import '../../members/add_member/add_member_page.dart';
import '../../attendance/attendance_page.dart';
import '../../fees/fees_page.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [

          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.person_add,
              title: "Admission",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddMemberPage(),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.shopping_cart_checkout,
              title: "Purchase",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PurchasePage(),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.point_of_sale,
              title: "Sales",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SalesPage(),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.inventory_2,
              title: "Stock",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StockPage(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.receipt_long_rounded,
              title: "Billing",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FeesPage(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 90,
            child: QuickActionButton(
              icon: Icons.fact_check_rounded,
              title: "Attendance",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AttendancePage(),
                  ),
                );
              },
            ),
          ),

        ],
      );
  }
}
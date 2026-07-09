import 'package:flutter/material.dart';
import 'controllers/purchase_form_controller.dart';
import 'widgets/purchase_supplier_card.dart';
import 'widgets/purchase_product_card.dart';
import 'widgets/purchase_summary_card.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  late final PurchaseFormController controller;

  @override
  void initState() {
    super.initState();

    controller = PurchaseFormController();
    controller.selectedProduct = "Whey Protein 1kg";
    controller.taxController.text = "18";

  }

  @override
  void dispose() {
    controller.dispose();
   super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Entry"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          PurchaseSupplierCard(
            controller: controller,
          ),

          const SizedBox(height: 24),

          PurchaseProductCard(
            controller: controller,
          ),

          const SizedBox(height: 30),

          PurchaseSummaryCard(
            controller: controller,
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Purchase Saved Successfully (Demo)",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text("Save Purchase"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
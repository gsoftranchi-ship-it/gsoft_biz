import 'package:flutter/material.dart';
import 'controllers/purchase_form_controller.dart';

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

          const Text(
            "Supplier Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller.supplierController,
            decoration: const InputDecoration(
              labelText: "Supplier Name",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.business),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller.invoiceNumberController,
            decoration: const InputDecoration(
              labelText: "Invoice Number",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.receipt_long),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Product",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: controller.selectedProduct,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Select Product",
            ),
            items: const [

              DropdownMenuItem(
                value: "Whey Protein 1kg",
                child: Text("Whey Protein 1kg"),
              ),

              DropdownMenuItem(
                value: "Mass Gainer",
                child: Text("Mass Gainer"),
              ),

              DropdownMenuItem(
                value: "Creatine",
                child: Text("Creatine"),
              ),

              DropdownMenuItem(
                value: "Gym Gloves",
                child: Text("Gym Gloves"),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.setProduct(value);
              }
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller.quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.production_quantity_limits),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller.purchasePriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Purchase Price",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.currency_rupee),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller.taxController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "GST %",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.percent),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            color: Colors.orange.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Purchase Total"),
                      Text(
                        "₹0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GST"),
                      Text("18%"),
                    ],
                  ),
                ],
              ),
            ),
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
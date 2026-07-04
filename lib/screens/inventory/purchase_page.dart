import 'package:flutter/material.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final _supplierController = TextEditingController();
  final _invoiceController = TextEditingController();
  final _qtyController = TextEditingController(text: "1");
  final _priceController = TextEditingController();
  final _gstController = TextEditingController(text: "18");

  String _selectedProduct = "Whey Protein 1kg";

  @override
  void dispose() {
    _supplierController.dispose();
    _invoiceController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    _gstController.dispose();
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
            controller: _supplierController,
            decoration: const InputDecoration(
              labelText: "Supplier Name",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.business),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _invoiceController,
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
            initialValue: _selectedProduct,
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
                setState(() {
                  _selectedProduct = value;
                });
              }
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.production_quantity_limits),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Purchase Price",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.currency_rupee),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _gstController,
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
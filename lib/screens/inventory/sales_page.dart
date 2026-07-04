import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  String product = "Whey Protein 1kg";
  String paymentMode = "Cash";

  final qtyController = TextEditingController(text: "1");
  final discountController = TextEditingController(text: "0");

  @override
  void dispose() {
    qtyController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double price = 2200;

    final qty = int.tryParse(qtyController.text) ?? 1;
    final discount = double.tryParse(discountController.text) ?? 0;

    final subtotal = qty * price;
    final gst = subtotal * .18;
    final grandTotal = subtotal + gst - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales / POS"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "New Sale",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            initialValue: product,
            decoration: const InputDecoration(
              labelText: "Product",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.inventory_2),
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
            onChanged: (v) {
              if (v != null) {
                setState(() {
                  product = v;
                });
              }
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.production_quantity_limits),
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: discountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Discount",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.discount),
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            initialValue: paymentMode,
            decoration: const InputDecoration(
              labelText: "Payment Mode",
              border: OutlineInputBorder(),
            ),
            items: const [

              DropdownMenuItem(
                value: "Cash",
                child: Text("Cash"),
              ),

              DropdownMenuItem(
                value: "UPI",
                child: Text("UPI"),
              ),

              DropdownMenuItem(
                value: "Card",
                child: Text("Card"),
              ),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(() {
                  paymentMode = v;
                });
              }
            },
          ),

          const SizedBox(height: 24),

          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  const Text(
                    "Invoice Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const Divider(),

                  _row("Price", "₹${price.toStringAsFixed(0)}"),
                  _row("Quantity", "$qty"),
                  _row("Subtotal", "₹${subtotal.toStringAsFixed(0)}"),
                  _row("GST (18%)", "₹${gst.toStringAsFixed(0)}"),
                  _row("Discount", "₹${discount.toStringAsFixed(0)}"),

                  const Divider(),

                  _row(
                    "Grand Total",
                    "₹${grandTotal.toStringAsFixed(0)}",
                    bold: true,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            icon: const Icon(Icons.print),
            label: const Text("Generate Invoice"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Invoice Generated"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      ),

                      SizedBox(height: 12),

                      Text(
                        "Sale completed successfully.",
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Invoice No : INV-2026-001",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Done"),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool bold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          Expanded(
            child: Text(title),
          ),

          Text(
            value,
            style: TextStyle(
              fontWeight:
              bold ? FontWeight.bold : FontWeight.normal,
              fontSize: bold ? 18 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
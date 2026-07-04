import 'package:flutter/material.dart';

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {

  String paymentMode = "Cash";

  final memberController =
  TextEditingController(text: "Rahul Kumar");

  final mobileController =
  TextEditingController(text: "9876543210");

  final amountController =
  TextEditingController(text: "3400");

  final discountController =
  TextEditingController(text: "200");

  @override
  Widget build(BuildContext context) {

    final amount =
        double.tryParse(amountController.text) ?? 0;

    final discount =
        double.tryParse(discountController.text) ?? 0;

    final gst = (amount - discount) * .18;

    final total = amount - discount + gst;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Billing / POS"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Member Billing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: memberController,
            decoration: const InputDecoration(
              labelText: "Member Name",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: mobileController,
            decoration: const InputDecoration(
              labelText: "Mobile",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Monthly Membership"),
                      Text("₹1200"),
                    ],
                  ),

                  SizedBox(height: 8),

                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Protein Powder"),
                      Text("₹2200"),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Subtotal",
              border: OutlineInputBorder(),
              prefixIcon:
              Icon(Icons.currency_rupee),
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
              prefixIcon:
              Icon(Icons.discount),
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            initialValue: paymentMode,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Payment Mode",
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
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  const Text(
                    "Invoice Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Divider(),

                  _row(
                    "Subtotal",
                    "₹${amount.toStringAsFixed(0)}",
                  ),

                  _row(
                    "Discount",
                    "₹${discount.toStringAsFixed(0)}",
                  ),

                  _row(
                    "GST (18%)",
                    "₹${gst.toStringAsFixed(0)}",
                  ),

                  const Divider(),

                  _row(
                    "Grand Total",
                    "₹${total.toStringAsFixed(0)}",
                    true,
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            icon: const Icon(Icons.receipt_long),
            label: const Text("Generate Invoice"),
            onPressed: () {

              showDialog(
                context: context,
                builder: (_) {

                  return AlertDialog(

                    title: const Text("Payment Successful"),

                    content: const Column(
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [

                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 70,
                        ),

                        SizedBox(height: 16),

                        Text(
                          "Invoice Generated",
                        ),

                        SizedBox(height: 10),

                        Text(
                          "INV-2026-00125",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
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
                  );
                },
              );

            },
          ),

          const SizedBox(height: 40),

        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value,
      [bool bold = false]) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          Expanded(
            child: Text(title),
          ),

          Text(
            value,
            style: TextStyle(
              fontWeight:
              bold ? FontWeight.bold : null,
              fontSize: bold ? 18 : 15,
            ),
          ),

        ],
      ),
    );
  }
}
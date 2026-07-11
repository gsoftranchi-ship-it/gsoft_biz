import 'package:flutter/material.dart';
import 'invoice_items_table.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() =>
      _CreateInvoicePageState();
}

class _CreateInvoicePageState
    extends State<CreateInvoicePage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _invoiceNumberController =
  TextEditingController();

  final TextEditingController _memberController =
  TextEditingController();

  final TextEditingController _customerController =
  TextEditingController();

  final TextEditingController _invoiceDateController =
  TextEditingController();

  final TextEditingController _dueDateController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    _invoiceDateController.text =
        DateTime.now().toString().split(' ').first;
  }

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _memberController.dispose();
    _customerController.dispose();
    _invoiceDateController.dispose();
    _dueDateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Create Invoice',
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 90,
              ),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                'Billing',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Center(
              child: Text(
                'Create Invoice',
              ),
            ),

            const SizedBox(height: 24),

            TextFormField(
              controller:
              _invoiceNumberController,

              readOnly: true,

              decoration:
              const InputDecoration(
                labelText:
                'Invoice Number',
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _invoiceDateController,

              readOnly: true,

              decoration:
              const InputDecoration(
                labelText:
                'Invoice Date',
                suffixIcon:
                Icon(Icons.calendar_today),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _dueDateController,

              readOnly: true,

              decoration:
              const InputDecoration(
                labelText:
                'Due Date',
                suffixIcon:
                Icon(Icons.event),
              ),
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _memberController,

              readOnly: true,

              decoration:
              const InputDecoration(
                labelText:
                'Member',
                hintText:
                'Select Member',
                suffixIcon:
                Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
              _customerController,

              decoration:
              const InputDecoration(
                labelText:
                'Walk-in Customer',
              ),
            ),

            const SizedBox(height: 32),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 16),

            const Text(
              'Invoice Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const InvoiceItemsTable(),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    Row(
                      children: const [

                        Expanded(
                          child: Text('Subtotal'),
                        ),

                        Text(
                          '₹ 0.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: const [

                        Expanded(
                          child: Text('Discount'),
                        ),

                        Text(
                          '₹ 0.00',
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: const [

                        Expanded(
                          child: Text('Tax'),
                        ),

                        Text(
                          '₹ 0.00',
                        ),
                      ],
                    ),

                    Divider(height: 30),

                    Row(
                      children: const [

                        Expanded(
                          child: Text(
                            'Grand Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        Text(
                          '₹ 0.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: () {
                // TODO(RC1):
                // Save Invoice
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Invoice'),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                // TODO(RC1):
                // Save & Collect Payment
              },
              icon: const Icon(Icons.payments),
              label: const Text('Save & Collect Payment'),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
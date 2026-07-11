import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/invoice_provider.dart';
import '../../widgets/billing/invoice_card.dart';

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  State<InvoiceListPage> createState() =>
      _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  final TextEditingController _searchController =
  TextEditingController();

  bool _loaded = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    context.watch<InvoiceProvider>();
    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // TODO(RC1):
        // Load invoices once AuthProvider exposes gymId.
        //
        // final authProvider =
        //     context.read<AuthProvider>();
        //
        // provider.loadInvoices(
        //     authProvider.currentGymId);
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 42,
            ),

            const SizedBox(width: 12),

            const Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  'Billing',
                  style: TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                Text(
                  'Invoice Management',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          // TODO(RC1):
          // Navigate to CreateInvoicePage
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'New Invoice',
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller:
              _searchController,

              decoration:
              const InputDecoration(
                prefixIcon:
                Icon(Icons.search),

                hintText:
                'Search invoice...',
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                FilterChip(
                  label:
                  const Text('All'),

                  selected: true,

                  onSelected: (_) {},
                ),

                const SizedBox(width: 8),

                FilterChip(
                  label:
                  const Text('Paid'),

                  selected: false,

                  onSelected: (_) {},
                ),

                const SizedBox(width: 8),

                FilterChip(
                  label:
                  const Text('Due'),

                  selected: false,

                  onSelected: (_) {},
                ),
              ],
            ),


            const SizedBox(height: 20),

            Row(
              children: [


                Expanded(

                  child: Card(
                    child: Padding(
                      padding:const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          const Icon(
                            Icons.receipt_long,
                            color: Colors.orange,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Invoices',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '${provider.invoices.length}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Collected',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            '₹0',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          const Icon(
                            Icons.pending_actions,
                            color: Colors.redAccent,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Outstanding',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            '₹0',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: provider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : provider.errorMessage != null
                  ? Center(
                child: Text(provider.errorMessage!),
              )
                  : provider.invoices.isEmpty
                  ? const Center(
                child: Text('No invoices found'),
              )
                  : ListView.builder(
                itemCount: provider.invoices.length,
                itemBuilder: (context, index) {
                  final invoice = provider.invoices[index];

                  return InvoiceCard(
                    invoice: invoice,
                    onTap: () {
                      // TODO: Invoice Details
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


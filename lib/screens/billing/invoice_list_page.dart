import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/invoice_provider.dart';
import '../../widgets/billing/invoice_card.dart';
import 'create_invoice_page.dart';
import '../../providers/auth_provider.dart';
import 'invoice_details_page.dart';

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

  int _selectedFilter = 0;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    context.watch<InvoiceProvider>();
    final filteredInvoices = provider.invoices.where((invoice) {

      switch (_selectedFilter) {
        case 1:
          return invoice.paymentStatus.name == 'paid';

        case 2:
          return invoice.paymentStatus.name == 'unpaid' ||
              invoice.paymentStatus.name == 'partial';

        default:
          return true;
      }
    }).toList();
    final totalCollected = provider.invoices.fold<double>(
      0,
          (sum, invoice) => sum + invoice.receivedAmount,
    );

    final totalOutstanding = provider.invoices.fold<double>(
      0,
          (sum, invoice) => sum + invoice.balanceAmount,
    );
    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final authProvider =
        context.read<AuthProvider>();

        final invoiceProvider =
        context.read<InvoiceProvider>();

        final gymId =
            authProvider.currentUser?.tenantInfo.gymId;

        if (gymId == null || gymId.isEmpty) {
          return;
        }

        await invoiceProvider.loadInvoices(
          gymId: gymId,
        );
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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateInvoicePage(),
            ),
          );

          if (!context.mounted) return;

          final authProvider = context.read<AuthProvider>();
          final gymId = authProvider.currentUser?.tenantInfo.gymId;

          if (gymId != null && gymId.isNotEmpty) {
            await context.read<InvoiceProvider>().loadInvoices(
              gymId: gymId,
            );
          }
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
                  label: const Text('All'),
                  selected: _selectedFilter == 0,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = 0;
                    });
                  },
                ),

                const SizedBox(width: 8),

                FilterChip(
                  label: const Text('Paid'),
                  selected: _selectedFilter == 1,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = 1;
                    });
                  },
                ),
                const SizedBox(width: 8),

                FilterChip(
                  label: const Text('Due'),
                  selected: _selectedFilter == 2,
                  onSelected: (_) {
                    setState(() {
                      _selectedFilter = 2;
                    });
                  },
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

                          Text(
                            '₹${totalCollected.toStringAsFixed(0)}',
                            style: const TextStyle(
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

                          Text(
                            '₹${totalOutstanding.toStringAsFixed(0)}',
                            style: const TextStyle(
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
                itemCount: filteredInvoices.length,
                itemBuilder: (context, index) {
                  final invoice = filteredInvoices[index];

                  return InvoiceCard(
                    invoice: invoice,
                    onTap: () async {
                      final authProvider =
                      context.read<AuthProvider>();

                      final invoiceProvider =
                      context.read<InvoiceProvider>();

                      final gymId =
                          authProvider.currentUser?.tenantInfo.gymId;

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InvoiceDetailsPage(
                            invoice: invoice,
                          ),
                        ),
                      );

                      if (!mounted) return;

                      if (gymId == null || gymId.isEmpty) {
                        return;
                      }

                      await invoiceProvider.loadInvoices(
                        gymId: gymId,
                      );
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


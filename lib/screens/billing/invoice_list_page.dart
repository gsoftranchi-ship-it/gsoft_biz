import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/invoice_provider.dart';
import 'create_invoice_page.dart';
import '../../providers/auth_provider.dart';
import 'invoice_details_page.dart';
import 'widgets/billing_statistics_section.dart';
import '../../core/widgets/erp_workspace.dart';
import '../../core/widgets/erp_page_header.dart';
import 'widgets/recent_invoice_list.dart';
import 'widgets/invoice_toolbar.dart';


class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  State<InvoiceListPage> createState() =>
      _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  final TextEditingController _searchController =
  TextEditingController();
  String _searchQuery = '';

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

      final matchesSearch =
          _searchQuery.isEmpty ||
              invoice.invoiceNumber
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              invoice.customerName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              invoice.customerPhone
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase());

      final matchesFilter = switch (_selectedFilter) {
        1 => invoice.paymentStatus.name == 'paid',
        2 =>
        invoice.paymentStatus.name == 'unpaid' ||
            invoice.paymentStatus.name == 'partial',
        _ => true,
      };

      return matchesSearch && matchesFilter;

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

        body: ERPWorkspace(
          header: const ERPPageHeader(
            title: 'Billing & Invoices',
            subtitle: 'Manage invoices, collections and outstanding payments',
            padding: EdgeInsets.zero,
          ),
        toolbar: InvoiceToolbar(
          searchController: _searchController,
          searchHint: 'Search Invoice No / Customer / Phone',
          onSearchChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
          selectedFilter: _selectedFilter,
          onFilterChanged: (value) {
            setState(() {
              _selectedFilter = value;
            });
          },
        ),
          body: Column(
              children: [

            const SizedBox(height: 20),

            BillingStatisticsSection(
              totalInvoices: provider.invoices.length,
              totalCollected: totalCollected,
              totalOutstanding: totalOutstanding,
            ),

            const SizedBox(height: 20),

                Expanded(
                  child: RecentInvoiceList(
                    isLoading: provider.isLoading,
                    errorMessage: provider.errorMessage,
                    invoices: filteredInvoices,
                    onInvoiceTap: (invoice) async {
                      final authProvider = context.read<AuthProvider>();
                      final invoiceProvider = context.read<InvoiceProvider>();

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
                  ),
                )
          ]
          ),
        ),
      );
    }
  }


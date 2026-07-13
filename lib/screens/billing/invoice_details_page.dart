import 'package:flutter/material.dart';
import '../../models/invoice_model.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/invoice_item_provider.dart';
import '../../providers/invoice_provider.dart';
import 'collect_payment_page.dart';
import '../../models/invoice_item_model.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({
    super.key,
    required this.invoice,
  });

  final InvoiceModel invoice;

  @override
  State<InvoiceDetailsPage> createState() =>
      _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState
    extends State<InvoiceDetailsPage> {
  InvoiceModel get _invoice {
    final provider =
    context.read<InvoiceProvider>();

    return provider.selectedInvoice ??
        widget.invoice;
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user =
          context.read<AuthProvider>().currentUser;

      final gymId = user?.tenantInfo.gymId;

      if (gymId == null || gymId.isEmpty) {
        return;
      }

      await context
          .read<InvoiceItemProvider>()
          .loadInvoiceItems(
        gymId: gymId,
        invoiceId: widget.invoice.invoiceId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _buildInvoiceSummary(),

          const SizedBox(height: 16),

          _buildCustomerCard(),

          const SizedBox(height: 16),

          _buildFinancialSummary(),

          const SizedBox(height: 16),

          _buildInvoiceItems(),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: _collectPayment,
            icon: const Icon(Icons.payments),
            label: const Text(
              'Collect Payment',
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print),
            label: const Text(
              'Print Invoice',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Text(
              'Invoice Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _info(
              'Invoice Number',
              _invoice.invoiceNumber,
            ),

            _info(
              'Invoice Date',
              _invoice.invoiceDate
                  .toString()
                  .split(' ')
                  .first,
            ),

            _info(
              'Invoice Type',
              _invoice.invoiceType.name,
            ),

            const SizedBox(height: 8),

            Chip(
              label: Text(
                _invoice.paymentStatus.name
                    .toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Text(
              'Customer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _info(
              'Name',
              _invoice.customerName,
            ),

            _info(
              'Phone',
              _invoice.customerPhone,
            ),

            _info(
              'Email',
              _invoice.customerEmail,
            ),

            _info(
              'Address',
              _invoice.customerAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Text(
              'Financial Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _money(
              'Subtotal',
              _invoice.subtotal,
            ),

            _money(
              'Discount',
              _invoice.discountAmount,
            ),

            _money(
              'Tax',
              _invoice.taxAmount,
            ),

            const Divider(),

            _money(
              'Grand Total',
              _invoice.grandTotal,
              bold: true,
            ),

            _money(
              'Received',
              _invoice.receivedAmount,
            ),

            _money(
              'Outstanding',
              _invoice.balanceAmount,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _collectPayment() async {
    final authProvider =
    context.read<AuthProvider>();

    final invoiceProvider =
    context.read<InvoiceProvider>();

    final invoiceItemProvider =
    context.read<InvoiceItemProvider>();
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CollectPaymentPage(
          invoice: widget.invoice,
        ),
      ),
    );

    if (result != true || !mounted) {
      return;
    }

    final user = authProvider.currentUser;

    final gymId = user?.tenantInfo.gymId;

    if (gymId == null || gymId.isEmpty) {
      return;
    }

    await invoiceProvider.loadInvoice(
      gymId: gymId,
      invoiceId: _invoice.invoiceId,
    );
    if (!mounted) return;

    setState(() {});

    await invoiceItemProvider.loadInvoiceItems(
      gymId: gymId,
      invoiceId: _invoice.invoiceId,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Payment collected successfully.',
        ),
      ),
    );
  }
  Widget _buildInvoiceItems() {
    return Consumer<InvoiceItemProvider>(
      builder: (
          context,
          provider,
          _,
          ) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                const Text(
                  'Invoice Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                if (provider.loading)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (provider.items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'No invoice items found.',
                      ),
                    ),
                  )
                else
                  ...provider.items.map(
                        (item) => _buildItemTile(item),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildItemTile(
      InvoiceItemModel item,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      title: Text(
        item.itemName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Text(
        '${item.quantity} × ₹ ${item.unitPrice.toStringAsFixed(2)}',
      ),

      trailing: Text(
        '₹ ${item.lineTotal.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _info(
      String title,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Text(title),
          ),

          Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? '-' : value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _money(
      String title,
      double value, {
        bool bold = false,
      }) {
    final style = TextStyle(
      fontWeight: bold
          ? FontWeight.bold
          : FontWeight.normal,
      fontSize: bold ? 16 : 14,
    );

    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: style,
            ),
          ),

          Text(
            '₹ ${value.toStringAsFixed(2)}',
            style: style,
          ),
        ],
      ),
    );
  }
}
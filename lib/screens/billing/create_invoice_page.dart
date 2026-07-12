import 'package:flutter/material.dart';
import 'invoice_items_table.dart';
import 'package:provider/provider.dart';
import '../../models/member_model.dart';
import '../../providers/member_provider.dart';
import 'member_selector_dialog.dart';
import '../../models/invoice_item_model.dart';
import 'product_selector_dialog.dart';
import '../../models/product_model.dart';
import '../../models/base/tenant_info.dart';
import '../../models/base/audit_info.dart';
import '../../models/base/entity_status.dart';
import '../../providers/auth_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../models/invoice_model.dart';



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

  final TextEditingController _phoneController =
  TextEditingController();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _addressController =
  TextEditingController();

  final TextEditingController _gstinController =
  TextEditingController();

  final TextEditingController _notesController =
  TextEditingController();


  final String _paymentMethod = 'Cash';

  final TextEditingController _invoiceDateController =
  TextEditingController();

  final TextEditingController _dueDateController =
  TextEditingController();



  MemberModel? _selectedMember;
  final List<InvoiceItemModel> _items = [];


  double _subTotal = 0;
  final double _discount = 0;
  double _tax = 0;
  double _grandTotal = 0;

  @override
  void initState() {
    super.initState();

    _invoiceDateController.text =
        DateTime.now().toString().split(' ').first;
    _invoiceNumberController.text =
    "INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
  }

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _memberController.dispose();
    _customerController.dispose();
    _invoiceDateController.dispose();
    _dueDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _gstinController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _calculateTotals() {
    double subtotal = 0;
    double tax = 0;

    for (final item in _items) {
      subtotal += item.lineTotal;
      tax += item.taxAmount;
    }

    setState(() {
      _subTotal = subtotal;
      _tax = tax;
      _grandTotal = subtotal + tax - _discount;
    });
  }
  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please add at least one invoice item.',
          ),
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final invoiceProvider = context.read<InvoiceProvider>();

    final user = authProvider.currentUser;

    final gymId = user?.tenantInfo.gymId;

    if (gymId == null || gymId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gym not found.'),
        ),
      );
      return;
    }

    try {
      final invoiceNumber =
      await invoiceProvider.generateInvoiceNumber(
        gymId: gymId,
      );

      final invoice = InvoiceModel(
        invoiceId: '',
        invoiceNumber: invoiceNumber,
        invoiceType: InvoiceType.sale,

        memberId: _selectedMember?.memberId,
        customerId: null,
        supplierId: null,

        customerName: _customerController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        customerEmail: _emailController.text.trim(),
        customerAddress: _addressController.text.trim(),
        customerGstin: _gstinController.text.trim(),

        invoiceDate: DateTime.now(),

        dueDate: _dueDateController.text.isEmpty
            ? null
            : DateTime.tryParse(
          _dueDateController.text,
        ),

        subtotal: _subTotal,

        discountAmount: _discount,

        discountPercentage: 0,

        taxableAmount: _subTotal,

        cgstAmount: _tax / 2,

        sgstAmount: _tax / 2,

        igstAmount: 0,

        taxAmount: _tax,

        grandTotal: _grandTotal,

        receivedAmount: 0,

        balanceAmount: _grandTotal,

        paymentStatus: PaymentStatus.unpaid,

        paymentMethod: _paymentMethod,

        amountInWords: '',

        notes: _notesController.text.trim(),

        version: 1,

        tenantInfo: TenantInfo(
          gymId: gymId,
        ),

        auditInfo: AuditInfo(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdBy: user?.id ?? '',
          updatedBy: user?.id ?? '',
        ),

        status: EntityStatus.active,
      );

      await invoiceProvider.createInvoice(
        gymId: gymId,
        invoice: invoice,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: Text(
            'Invoice $invoiceNumber created successfully.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
  Future<void> _saveAndCollectPayment() async {
    await _saveInvoice();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Payment module will open next.",
        ),
      ),
    );
  }
  Future<void> _addProduct() async {
    final product = await showDialog<ProductModel>(
      context: context,
      builder: (_) => ProductSelectorDialog(
        onSelected: (selected) {
          Navigator.pop(context, selected);
        },
      ),
    );

    if (product == null) return;

    setState(() {
      _items.add(
        InvoiceItemModel(
          invoiceItemId:
          DateTime.now().millisecondsSinceEpoch.toString(),

          invoiceId: '',

          itemType: InvoiceItemType.product,

          referenceId: product.productId,

          itemCode: product.productId,

          barcode: '',

          itemName: product.productName,

          description: '',

          hsnSacCode: '',

          unit: product.unit,

          quantity: 1,

          purchasePrice: product.purchasePrice,

          sellingPrice: product.sellingPrice,

          unitPrice: product.sellingPrice,

          discountAmount: 0,

          discountPercentage: 0,

          taxPercentage: 18,

          taxAmount: product.sellingPrice * 0.18,

          lineTotal: product.sellingPrice,

          remarks: '',

          version: 1,

          tenantInfo: const TenantInfo(
            gymId: '',
          ),

          auditInfo: AuditInfo(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            createdBy: '',
            updatedBy: '',
          ),

          status: EntityStatus.active,
        ),
      );

      _calculateTotals();
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
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
              controller: _memberController,
              readOnly: true,
              onTap: () async {
                final memberProvider =
                context.read<MemberProvider>();

                await showDialog(
                  context: context,
                  builder: (_) => MemberSelectorDialog(
                    members: memberProvider.members,
                    onSelected: (member) {
                      setState(() {
                        _selectedMember = member;
                        _memberController.text = member.fullName;
                        _customerController.text = member.fullName;
                        _phoneController.text = member.phone;
                        _emailController.text = member.email;
                        _addressController.text = member.address;
                      });
                    },
                  ),
                );
              },
              decoration: const InputDecoration(
                labelText: 'Member',
                hintText: 'Tap to select member',
                suffixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _customerController,
              enabled: _selectedMember == null,
              decoration: const InputDecoration(
                labelText: 'Walk-in Customer',
              ),
            ),
            if (_selectedMember != null) ...[
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        _selectedMember!.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Phone : ${_selectedMember!.phone}',
                      ),

                      Text(
                        'Email : ${_selectedMember!.email}',
                      ),

                      Text(
                        'Address : ${_selectedMember!.address}',
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            const Text(
              'Customer Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _gstinController,
              decoration: const InputDecoration(
                labelText: 'GSTIN (Optional)',
                prefixIcon: Icon(Icons.badge),
              ),
            ),

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

            SizedBox(height: 12),

            InvoiceItemsTable(
              items: _items,
              onAddProduct: _addProduct,
              onDeleteItem: _deleteItem,
            ),

            const SizedBox(height: 24),

            const Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                prefixIcon: Icon(Icons.payments),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Cash',
                  child: Text('Cash'),
                ),
                DropdownMenuItem(
                  value: 'UPI',
                  child: Text('UPI'),
                ),
                DropdownMenuItem(
                  value: 'Card',
                  child: Text('Card'),
                ),
                DropdownMenuItem(
                  value: 'Bank',
                  child: Text('Bank Transfer'),
                ),
              ],
              onChanged: (_) {},
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes / Remarks',
                prefixIcon: Icon(Icons.notes),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text('Subtotal'),
                        ),

                        Text(
                          '₹ ${_subTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [

                        Expanded(
                          child: Text('Discount'),
                        ),

                        Text(
                          '₹ ${_discount.toStringAsFixed(2)}',
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [

                        Expanded(
                          child: Text('Tax'),
                        ),

                        Text(
                          '₹ ${_tax.toStringAsFixed(2)}',
                        ),
                      ],
                    ),

                    Divider(height: 30),

                    Row(
                      children: [

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
                          '₹ ${_grandTotal.toStringAsFixed(2)}',
                          style:TextStyle(
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

            SizedBox(height: 24),

            FilledButton.icon(
              onPressed: _saveInvoice,
              icon: const Icon(Icons.save),
              label: const Text('Save Invoice'),
            ),

            SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: _saveAndCollectPayment,
              icon: const Icon(Icons.payments),
              label: const Text('Save & Collect Payment'),
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
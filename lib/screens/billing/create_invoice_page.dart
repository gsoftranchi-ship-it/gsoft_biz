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
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/invoice_item_provider.dart';
import 'widgets/billing_header.dart';
import 'widgets/invoice_summary_card.dart';
import 'widgets/invoice_actions.dart';
import 'widgets/payment_information_card.dart';
import 'widgets/invoice_information_card.dart';
import 'widgets/customer_type_section.dart';
import 'widgets/member_selection_section.dart';
import 'widgets/customer_details_section.dart';
import '../../providers/tenant_provider.dart';
import '../../models/invoice_render_data.dart';
import 'builders/invoice_render_builder.dart';
import 'preview/invoice_preview_page.dart';
import '../../core/widgets/erp_card.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/erp_dropdown.dart';
import '../../core/widgets/erp_text_field.dart';
import '../../screens/app_shell/widgets/workspace_container.dart';
import 'widgets/billing_section_header.dart';



class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() =>
      _CreateInvoicePageState();
}

class _CreateInvoicePageState
    extends State<CreateInvoicePage> {
  Future<void> _previewInvoice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one invoice item.'),
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final tenantProvider = context.read<TenantProvider>();

    final user = authProvider.currentUser;
    final gym = tenantProvider.currentGym;

    if (gym == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gym information not found.'),
        ),
      );
      return;
    }

    final invoice = InvoiceModel(
      invoiceId: 'PREVIEW',
      invoiceNumber: _invoiceNumberController.text.trim(),
      invoiceType: InvoiceType.sale,

      memberId:
      _customerType == 'MEMBER'
          ? _selectedMember?.memberId
          : null,

      customerId: null,
      supplierId: null,

      customerName: _customerController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      customerEmail: _emailController.text.trim(),
      customerAddress: _addressController.text.trim(),
      customerGstin: _gstinController.text.trim(),

      invoiceDate: DateTime.now(),

      dueDate: _dueDate,

      subtotal: _subTotal,

      discountAmount: _discountAmount,

      discountPercentage:
      _discountType == 'Percentage'
          ? (double.tryParse(
        _discountController.text.trim(),
      ) ??
          0)
          : 0,

      taxableAmount: _subTotal,

      cgstAmount: _taxType == 'GST' ? _tax / 2 : 0,
      sgstAmount: _taxType == 'GST' ? _tax / 2 : 0,
      igstAmount: 0,
      taxAmount: _taxType == 'GST' ? _tax : 0,

      grandTotal: _grandTotal,

      receivedAmount:
      double.tryParse(
        _receivedAmountController.text,
      ) ??
          0,

      balanceAmount:
      double.tryParse(
        _balanceAmountController.text,
      ) ??
          0,

      paymentStatus:
      _paymentStatus == 'Paid'
          ? PaymentStatus.paid
          : _paymentStatus == 'Partial'
          ? PaymentStatus.partial
          : PaymentStatus.unpaid,

      paymentMethod: _paymentMethod,

      amountInWords: '',

      notes: _notesController.text.trim(),

      version: 1,

      tenantInfo: TenantInfo(
        gymId: user?.tenantInfo.gymId ?? '',
      ),

      auditInfo: AuditInfo(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: user?.id ?? '',
        updatedBy: user?.id ?? '',
      ),

      status: EntityStatus.active,
    );

    final InvoiceRenderData renderData =
    InvoiceRenderBuilder.build(
      gym: gym,
      invoice: invoice,
      items: _items,
    );

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InvoicePreviewPage(
          data: renderData,
        ),
      ),
    );
  }

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

  final TextEditingController _receivedAmountController =
  TextEditingController();

  final TextEditingController _balanceAmountController =
  TextEditingController();

  DateTime? _dueDate;


  String _paymentMethod = 'Cash';
  String _paymentStatus = 'Paid';
  String _customerType = 'MEMBER';

  String _taxType = 'GST';

  String _discountType = 'None';

  final TextEditingController _discountController =
  TextEditingController();

  double _discountAmount = 0.0;

  final TextEditingController _invoiceDateController =
  TextEditingController();


  MemberModel? _selectedMember;
  final List<InvoiceItemModel> _items = [];


  double _subTotal = 0;
  // Discount is calculated dynamically using _discountAmount.
  double _tax = 0;
  double _grandTotal = 0;


  @override
  void initState() {
    super.initState();

    _invoiceDateController.text =
        DateTime.now().toString().split(' ').first;
    _invoiceNumberController.text =
    "INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    _receivedAmountController.clear();
    _balanceAmountController.text = '0.00';

    _updatePaymentCalculation();
  }

  @override
  void dispose() {
    _discountController.dispose();
    _invoiceNumberController.dispose();
    _memberController.dispose();
    _customerController.dispose();
    _invoiceDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _gstinController.dispose();
    _notesController.dispose();
    _receivedAmountController.dispose();
    _balanceAmountController.dispose();
    super.dispose();
  }

  void _calculateTotals() {
    double subtotal = 0;
    double tax = 0;

    for (final item in _items) {
      subtotal += item.lineTotal;

      if (_taxType == 'GST') {
        tax += item.taxAmount;
      }
    }

    if (_taxType == 'NON_GST') {
      tax = 0;
    }

    final baseTotal = subtotal + tax;
    final calculatedDiscount = _calculateDiscount(baseTotal);

    setState(() {
      _subTotal = subtotal;
      _tax = tax;
      _discountAmount = calculatedDiscount;
      _grandTotal = baseTotal - calculatedDiscount;
    });

    _updatePaymentCalculation();
  }

  double _calculateDiscount(double total) {
    double value =
        double.tryParse(_discountController.text.trim()) ?? 0.0;

    // Prevent negative values.
    if (value < 0) {
      value = 0;
    }

    switch (_discountType) {
      case 'Fixed':
      // Fixed discount cannot exceed invoice total.
        if (value > total) {
          value = total;
        }
        return value;

      case 'Percentage':
      // Percentage must remain between 0 and 100.
        if (value > 100) {
          value = 100;
        }

        return total * value / 100;

      default:
        return 0.0;
    }
  }

  Future<void> _saveInvoice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if ((_paymentStatus == 'Credit' || _paymentStatus == 'Partial') &&
        _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a Due Date for Partial or Credit invoices.',
          ),
        ),
      );
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
    final received =
        double.tryParse(_receivedAmountController.text.trim()) ?? 0.0;

    if (_paymentStatus == 'Paid') {
      if ((received - _grandTotal).abs() > 0.01) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'For Paid invoices, received amount must equal the grand total.',
            ),
          ),
        );
        return;
      }
    }

    if (_paymentStatus == 'Partial') {
      if (received <= 0 || received >= _grandTotal) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Received amount must be greater than zero and less than the grand total.',
            ),
          ),
        );
        return;
      }
    }

    if (_paymentStatus == 'Credit') {
      if (received > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Credit invoices cannot have a received amount.',
            ),
          ),
        );
        return;
      }
    }

    if (received > _grandTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Received amount cannot exceed the grand total.',
          ),
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final invoiceProvider = context.read<InvoiceProvider>();
    final invoiceItemProvider =
    context.read<InvoiceItemProvider>();

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

    final invoiceId = FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymId)
        .collection('invoices')
        .doc()
        .id;

    try {
      final invoiceNumber =
      await invoiceProvider.generateInvoiceNumber(
        gymId: gymId,
      );

      final invoice = InvoiceModel(
        invoiceId: invoiceId,
        invoiceNumber: invoiceNumber,
        invoiceType: InvoiceType.sale,

        memberId: _customerType == 'MEMBER'
            ? _selectedMember?.memberId
            : null,
        customerId: null,
        supplierId: null,

        customerName: _customerController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        customerEmail: _emailController.text.trim(),
        customerAddress: _addressController.text.trim(),
        customerGstin: _gstinController.text.trim(),

        invoiceDate: DateTime.now(),

        dueDate: _dueDate,

        subtotal: _subTotal,

        discountAmount: _discountAmount,

        discountPercentage:
        _discountType == 'Percentage'
            ? (double.tryParse(_discountController.text.trim()) ?? 0)
            : 0,

        taxableAmount: _subTotal,

        cgstAmount: _taxType == 'GST'
            ? _tax / 2
            : 0,

        sgstAmount: _taxType == 'GST'
            ? _tax / 2
            : 0,

        igstAmount: 0,

        taxAmount: _taxType == 'GST'
            ? _tax
            : 0,

        grandTotal: _grandTotal,

        receivedAmount:
        double.tryParse(
          _receivedAmountController.text,
        ) ??
            0,

        balanceAmount:
        double.tryParse(
          _balanceAmountController.text,
        ) ??
            0,

        paymentStatus:
        _paymentStatus == 'Paid'
            ? PaymentStatus.paid
            : _paymentStatus == 'Partial'
            ? PaymentStatus.partial
            : PaymentStatus.unpaid,

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

      final invoiceItems = _items
          .map(
            (item) => item.copyWith(
          invoiceId: invoiceId,
          tenantInfo: TenantInfo(
            gymId: gymId,
          ),
          auditInfo: AuditInfo(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            createdBy: user?.id ?? '',
            updatedBy: user?.id ?? '',
          ),
        ),
      )
          .toList();

      await invoiceProvider.createInvoice(

        gymId: gymId,
        invoice: invoice,
      );
      await invoiceItemProvider.saveItems(
        gymId: gymId,
        items: invoiceItems,
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

  Future<void> _addProduct() async {
    final product = await showDialog<ProductModel>(
      context: context,
      builder: (_) => const ProductSelectorDialog(),
    );

    if (product == null) return;

    setState(() {
      final existingIndex = _items.indexWhere(
            (item) =>
        item.referenceId == product.productId &&
            item.itemType == InvoiceItemType.product,
      );

      if (existingIndex != -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product already exists in the invoice.'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      _items.add(
        InvoiceItemModel(
          invoiceItemId:
          DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
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
          tenantInfo: const TenantInfo(gymId: ''),
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
  Future<void> _selectDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

      void _deleteItem(int index) {
        setState(() {
          _items.removeAt(index);
        });
      }
  void _increaseQuantity(int index) {
    setState(() {
      final item = _items[index];

      final double quantity = item.quantity + 1.0;
      final double amount = quantity * item.unitPrice;
      final double tax = _taxType == 'GST'
          ? amount * (item.taxPercentage / 100)
          : 0.0;

      _items[index] = item.copyWith(
        quantity: quantity,
        taxAmount: tax,
        lineTotal: amount,
      );
    });

    _calculateTotals();
  }

  void _decreaseQuantity(int index) {
    if (_items[index].quantity <= 1) return;

    setState(() {
      final item = _items[index];

      final double quantity = item.quantity - 1.0;
      final double amount = quantity * item.unitPrice;
      final double tax = _taxType == 'GST'
          ? amount * (item.taxPercentage / 100)
          : 0.0;

      _items[index] = item.copyWith(
        quantity: quantity,
        taxAmount: tax,
        lineTotal: amount,
      );
    });

    _calculateTotals();
  }

  void _updatePaymentCalculation() {
    final double grandTotal = _grandTotal;

    final double received =
        double.tryParse(_receivedAmountController.text) ?? 0.0;

    switch (_paymentStatus) {
      case 'Paid':
        _balanceAmountController.text = '0.00';
        break;

      case 'Partial':
        final balance = grandTotal - received;

        _balanceAmountController.text =
        balance <= 0
            ? '0.00'
            : balance.toStringAsFixed(2);
        break;

      case 'Credit':
        _receivedAmountController.clear();

        _balanceAmountController.text =
            grandTotal.toStringAsFixed(2);
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WorkspaceContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1300,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  BillingHeader(
                    title: 'Create Invoice',
                    subtitle: 'Create and manage customer invoices',
                    onPreview: _previewInvoice,
                  ),
                  ERPCard(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BillingSectionHeader(
                            step: 'STEP 1',
                            title: 'Invoice Information',
                            subtitle: 'Invoice number and billing date.',
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          InvoiceInformationCard(
                            invoiceNumberController: _invoiceNumberController,
                            invoiceDateController: _invoiceDateController,
                          ),
                        ],
                      ),
                    ),
                  ),

                    const SizedBox(height: 5),
                    ERPCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const BillingSectionHeader(
                              step: '',
                              title: 'Customer Information',
                              subtitle: 'Select a member or enter customer details.',
                            ),

                        CustomerTypeSection(
                          customerType: _customerType,
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              _customerType = value;
                              if (value == 'GUEST') {
                                _selectedMember = null;

                                _memberController.clear();
                                _customerController.clear();
                                _phoneController.clear();
                                _emailController.clear();
                                _addressController.clear();
                                _gstinController.clear();
                              }
                            });
                          },
                        ),

                            const SizedBox(height: 16),

                            if (_customerType == 'MEMBER') ...[
                              MemberSelectionSection(
                                memberController: _memberController,
                                selectedMember: _selectedMember,
                                onTap: () async {
                                  final memberProvider = context.read<MemberProvider>();

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
                              ),

                              const SizedBox(height: 16),
                            ],

                            const SizedBox(height: 16),

                            CustomerDetailsSection(
                              customerType: _customerType,
                              customerController: _customerController,
                              phoneController: _phoneController,
                              emailController: _emailController,
                              addressController: _addressController,
                              gstinController: _gstinController,
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ERPCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const BillingSectionHeader(
                              step: 'STEP 2',
                              title: 'Products & Services',
                              subtitle: 'Add products or services to this invoice.',
                            ),

                            const SizedBox(
                              height: AppSpacing.lg,
                            ),SizedBox(height: 12),

                            InvoiceItemsTable(
                              items: _items,
                              onAddProduct: _addProduct,
                              onDeleteItem: _deleteItem,
                              onIncreaseQuantity: _increaseQuantity,
                              onDecreaseQuantity: _decreaseQuantity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ERPCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BillingSectionHeader(
                              step: 'STEP 3',
                              title: 'Discount',
                              subtitle: 'Apply invoice-level discounts if required.',
                            ),

                          ERPDropdown<String>(
                            value: _discountType,
                            label: 'Discount Type',
                            prefixIcon: const Icon(Icons.discount),
                            items: const [
                              DropdownMenuItem(
                                value: 'None',
                                child: Text('No Discount'),
                              ),
                              DropdownMenuItem(
                                value: 'Fixed',
                                child: Text('Fixed Amount'),
                              ),
                              DropdownMenuItem(
                                value: 'Percentage',
                                child: Text('Percentage (%)'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value == null) return;

                              setState(() {
                                _discountType = value;

                                if (_discountType == 'None') {
                                  _discountController.clear();
                                }
                              });

                              _calculateTotals();
                            },
                          ),

                            if (_discountType != 'None') ...[
                              const SizedBox(height: 20),

                    ERPTextField(
                      controller: _discountController,
                      label: _discountType == 'Fixed'
                          ? 'Discount Amount'
                          : 'Discount Percentage',
                      prefixIcon: Icon(
                        _discountType == 'Fixed'
                            ? Icons.currency_rupee
                            : Icons.percent,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (_) {
                        _calculateTotals();
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return null;
                        }

                        final number = double.tryParse(value);

                        if (number == null) {
                          return 'Enter a valid number.';
                        }

                        if (number < 0) {
                          return 'Discount cannot be negative.';
                        }

                        if (_discountType == 'Percentage' && number > 100) {
                          return 'Percentage cannot exceed 100%.';
                        }

                        if (_discountType == 'Fixed' && number > _subTotal + _tax) {
                          return 'Discount cannot exceed invoice total.';
                        }

                        return null;
                      },
                    ),
                            ],

                            const SizedBox(height: 20),

                            ERPTextField(
                              controller: TextEditingController(
                                text: _discountAmount.toStringAsFixed(2),
                              ),
                              label: 'Discount Applied',
                              prefixIcon: const Icon(Icons.savings),
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              ERPCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BillingSectionHeader(
                        step: 'STEP 4',
                        title: 'Payment Information',
                        subtitle: 'Select tax type, payment method and payment status.',
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      PaymentInformationCard(
                      receivedAmountController: _receivedAmountController,
                      balanceAmountController: _balanceAmountController,
                      dueDate: _dueDate,
                      onSelectDueDate: _selectDueDate,
                      onReceivedAmountChanged: () {
                        _updatePaymentCalculation();
                      },
                      taxType: _taxType,
                      paymentMethod: _paymentMethod,
                      notesController: _notesController,
                      onTaxTypeChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _taxType = value;
                        });


                        _calculateTotals();
                      },
                      onPaymentMethodChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                      paymentStatus: _paymentStatus,

                      onPaymentStatusChanged: (value) {
                        setState(() {
                          _paymentStatus = value;

                          if (value == 'Paid') {
                            _receivedAmountController.text =
                                _grandTotal.toStringAsFixed(2);

                            _balanceAmountController.text = '0.00';
                          }

                          if (value == 'Credit') {
                            _receivedAmountController.clear();
                          }

                          _updatePaymentCalculation();
                        });
                      },
                      ),
                    ],
                  ),
                ),
              ),

                  const SizedBox(height: 20),
              ERPCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BillingSectionHeader(
                        step: 'STEP 5',
                        title: 'Invoice Summary',
                        subtitle: 'Review invoice totals before saving.',
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      InvoiceSummaryCard(
                      subTotal: _subTotal,
                      discount: _discountAmount,
                      tax: _tax,
                      grandTotal: _grandTotal,
                      ),
                    ],
                  ),
                ),
              ),

                  const SizedBox(height: 20),

              ERPCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BillingSectionHeader(
                        step: 'STEP 6',
                        title: 'Invoice Actions',
                        subtitle: 'Save, cancel or complete the invoice.',
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      InvoiceActions(
                      onCancel: () => Navigator.pop(context),

                      onPreview: _previewInvoice,

                      onSaveDraft: () {
                        // TODO: Save Draft
                      },

                      onSave: _saveInvoice,
                      ),
                    ],
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


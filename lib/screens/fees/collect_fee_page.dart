import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/member_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/member_provider.dart';
import '../../providers/membership_provider.dart';
import '../../models/membership_invoice_model.dart';
import '../../models/base/audit_info.dart';
import '../../models/base/entity_status.dart';

class CollectFeePage extends StatefulWidget {
  const CollectFeePage({super.key});

  @override
  State<CollectFeePage> createState() => _CollectFeePageState();
}

class _CollectFeePageState extends State<CollectFeePage> {
  final _formKey = GlobalKey<FormState>();

  final _admissionFeeController =
  TextEditingController(text: '0');

  final _membershipFeeController =
  TextEditingController(text: '0');

  final _discountController =
  TextEditingController(text: '0');

  final _remarksController =
  TextEditingController();

  DateTime _invoiceDate = DateTime.now();
  DateTime? _dueDate;

  MemberModel? _selectedMember;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth =
      context.read<AuthProvider>();

      final user = auth.currentUser;

      if (user == null) return;

      await context
          .read<MemberProvider>()
          .loadMembers(
        gymId: user.tenantInfo.gymId,
      );
    });
  }

  @override
  void dispose() {
    _admissionFeeController.dispose();
    _membershipFeeController.dispose();
    _discountController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider =
    context.watch<MemberProvider>();

    final membershipProvider =
    context.watch<MembershipProvider>();

    final admission =
        double.tryParse(
          _admissionFeeController.text,
        ) ??
            0;

    final membership =
        double.tryParse(
          _membershipFeeController.text,
        ) ??
            0;

    final discount =
        double.tryParse(
          _discountController.text,
        ) ??
            0;

    final total =
        admission +
            membership -
            discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Membership Invoice',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            if (memberProvider.loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!memberProvider.loading &&
                memberProvider.members.where((e) => e.isActive).isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No active members available. Please add a member first.',
                  ),
                ),
              ),

            DropdownButtonFormField<MemberModel>(
              initialValue: _selectedMember,
              decoration: const InputDecoration(
                labelText: 'Member',
                border: OutlineInputBorder(),
              ),
              items: memberProvider.members
                  .where((e) => e.isActive)
                  .map(
                    (member) =>
                    DropdownMenuItem(
                      value: member,
                      child: Text(
                        member.fullName,
                      ),
                    ),
              )
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select a member';
                }
                return null;
              },

              onChanged: (member) {
                setState(() {
                  _selectedMember = member;
                });
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _admissionFeeController,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter admission fee';
                }

                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }

                return null;
              },

              onChanged: (_) {
                setState(() {});
              },

              decoration: const InputDecoration(
                labelText: 'Admission Fee',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _membershipFeeController,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter membership fee';
                }

                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }

                return null;
              },

              onChanged: (_) {
                setState(() {});
              },

              decoration: const InputDecoration(
                labelText: 'Membership Fee',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _discountController,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null;
                }

                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }

                return null;
              },

              onChanged: (_) {
                setState(() {});
              },

              decoration: const InputDecoration(
                labelText: 'Discount',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text('Invoice Date'),
              subtitle: Text(
                _invoiceDate
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _invoiceDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() {
                    _invoiceDate = picked;
                  });
                }
              },
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: const Text('Due Date'),
              subtitle: Text(
                _dueDate == null
                    ? 'Not selected'
                    : _dueDate!
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),
              trailing: const Icon(Icons.edit_calendar),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? _invoiceDate,
                  firstDate: _invoiceDate,
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() {
                    _dueDate = picked;
                  });
                }
              },
            ),

            const SizedBox(height: 16),
            TextFormField(
              controller:
              _remarksController,
              maxLines: 3,
              decoration:
              const InputDecoration(
                labelText: 'Remarks',
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding:
                const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    const Text(
                      'Total',
                    ),
                    Text(
                      '₹${total.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed:
              membershipProvider.loading
                  ? null
                  : () async {

                if (!_formKey.currentState!.validate()) {
                  return;
                }

                if (_selectedMember == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a member.'),
                    ),
                  );
                  return;
                }

                final authProvider = context.read<AuthProvider>();
                final currentUser = authProvider.currentUser!;

                final invoice = MembershipInvoiceModel(
                  invoiceId: '',
                  memberId: _selectedMember!.memberId,
                  invoiceNumber: '',
                  invoiceDate: _invoiceDate,
                  dueDate: _dueDate,
                  admissionFee: admission,
                  membershipFee: membership,
                  discount: discount,
                  taxAmount: 0,
                  totalAmount: total,
                  paidAmount: 0,
                  dueAmount: total,
                  remarks: _remarksController.text.trim(),
                  isPaid: false,
                  tenantInfo: currentUser.tenantInfo,
                  auditInfo: AuditInfo(
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    createdBy: currentUser.id,
                    updatedBy: currentUser.id,
                  ),
                  status: EntityStatus.active,
                );

                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                final success =
                await membershipProvider.createInvoice(invoice);

                if (!mounted) return;

                  // TODO(Infrastructure):
                  // Replace ScaffoldMessenger with SnackbarService
                  // after the centralized notification service is implemented.

                if (success) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Membership invoice created successfully.',
                      ),
                    ),
                  );

                  // TODO(Sprint 16D):
                  // Replace Navigator.pop() with navigation
                  // to InvoiceDetailsPage.

                  navigator.pop();
                } else {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        membershipProvider.failure?.toString() ??
                            'Unable to create invoice.',
                      ),
                    ),
                  );
                }

              },
              child: const Text(
                'Generate Invoice',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
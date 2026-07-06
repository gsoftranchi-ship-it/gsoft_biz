import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/member_model.dart';
import '../../models/membership_invoice_model.dart';

import '../../providers/member_provider.dart';
import '../../providers/membership_provider.dart';

import 'collect_fee_page.dart';
import 'collect_membership_payment_page.dart';
import 'membership_invoice_details_page.dart';

enum InvoiceFilter {
  all,
  due,
  paid,
  overdue,
}

class MembershipInvoiceListPage extends StatefulWidget {
  const MembershipInvoiceListPage({
    super.key,
  });

  @override
  State<MembershipInvoiceListPage> createState() =>
      _MembershipInvoiceListPageState();
}

class _MembershipInvoiceListPageState
    extends State<MembershipInvoiceListPage> {

  final _searchController =
  TextEditingController();

  InvoiceFilter _filter =
      InvoiceFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final membershipProvider =
    context.watch<MembershipProvider>();

    final memberProvider =
    context.watch<MemberProvider>();

    if (membershipProvider.loading ||
        memberProvider.loading) {
      return const Scaffold(
        body: Center(
          child:
          CircularProgressIndicator(),
        ),
      );
    }

    final invoices =
    List<MembershipInvoiceModel>.from(
      membershipProvider.invoices,
    );

    final members =
        memberProvider.members;

    invoices.sort(
          (a, b) =>
          b.invoiceDate.compareTo(
            a.invoiceDate,
          ),
    );

    final query =
    _searchController.text
        .trim()
        .toLowerCase();

    final filteredInvoices =
    invoices.where((invoice) {
      final MemberModel? member =
      members.cast<MemberModel?>().firstWhere(
            (m) =>
        m?.memberId ==
            invoice.memberId,
        orElse: () => null,
      );

      final memberName =
          member?.fullName
              .toLowerCase() ??
              '';

      final matchesSearch =
          invoice.invoiceNumber
              .toLowerCase()
              .contains(query) ||
              invoice.memberId
                  .toLowerCase()
                  .contains(query) ||
              memberName.contains(query);

      if (!matchesSearch) {
        return false;
      }

      switch (_filter) {
        case InvoiceFilter.all:
          return true;

        case InvoiceFilter.paid:
          return invoice.dueAmount <= 0;

        case InvoiceFilter.due:
          return invoice.dueAmount > 0;

        case InvoiceFilter.overdue:
          if (invoice.dueDate == null) {
            return false;
          }

          return invoice.dueAmount > 0 &&
              invoice.dueDate!
                  .isBefore(
                DateTime.now(),
              );
      }
    }).toList();

    final totalInvoices =
        invoices.length;

    final dueInvoices =
        invoices
            .where(
              (e) =>
          e.dueAmount > 0,
        )
            .length;

    final paidInvoices =
        invoices
            .where(
              (e) =>
          e.dueAmount <= 0,
        )
            .length;

    final outstanding =
    invoices.fold<double>(
      0,
          (sum, invoice) =>
      sum + invoice.dueAmount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Membership Invoices',
        ),
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const CollectFeePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      body: ListView(
        padding:
        const EdgeInsets.all(16),
        children: [

          // ===== Summary Cards =====
          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  title: 'Invoices',
                  value: totalInvoices.toString(),
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  title: 'Due',
                  value: dueInvoices.toString(),
                  color: Colors.orange,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  title: 'Paid',
                  value: paidInvoices.toString(),
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  title: 'Outstanding',
                  value:
                  '₹${outstanding.toStringAsFixed(2)}',
                  color: Colors.red,
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText:
              'Search Invoice / Member',
              prefixIcon:
              const Icon(Icons.search),
              suffixIcon:
              _searchController.text.isEmpty
                  ? null
                  : IconButton(
                icon: const Icon(
                  Icons.clear,
                ),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
              border:
              const OutlineInputBorder(),
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [

              ChoiceChip(
                label: const Text('All'),
                selected:
                _filter ==
                    InvoiceFilter.all,
                onSelected: (_) {
                  setState(() {
                    _filter =
                        InvoiceFilter.all;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Due'),
                selected:
                _filter ==
                    InvoiceFilter.due,
                onSelected: (_) {
                  setState(() {
                    _filter =
                        InvoiceFilter.due;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Paid'),
                selected:
                _filter ==
                    InvoiceFilter.paid,
                onSelected: (_) {
                  setState(() {
                    _filter =
                        InvoiceFilter.paid;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Overdue'),
                selected:
                _filter ==
                    InvoiceFilter.overdue,
                onSelected: (_) {
                  setState(() {
                    _filter =
                        InvoiceFilter.overdue;
                  });
                },
              ),

            ],
          ),

          const SizedBox(height: 24),

          if (filteredInvoices.isEmpty)

            const Card(
              child: Padding(
                padding:
                EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'No membership invoices found.',
                  ),
                ),
              ),
            )

          else
            ...filteredInvoices.map(
                  (invoice) {
                final MemberModel? member =
                members.cast<MemberModel?>().firstWhere(
                      (m) =>
                  m?.memberId ==
                      invoice.memberId,
                  orElse: () => null,
                );

                return _buildInvoiceCard(
                  context,
                  invoice,
                  member,
                );
              },
            ),

          const SizedBox(height: 80),
        ],
      ),

    );
  }
    Widget _buildInvoiceCard(
        BuildContext context,
        MembershipInvoiceModel invoice,
        MemberModel? member,
        ) {
      final isOverdue =
          invoice.dueDate != null &&
              invoice.dueAmount > 0 &&
              invoice.dueDate!.isBefore(
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ),
              );

      return Card(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Expanded(
                    child: Text(
                      member?.fullName ??
                          invoice.memberId,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Chip(
                    label: Text(
                      invoice.dueAmount <= 0
                          ? 'Paid'
                          : isOverdue
                          ? 'Overdue'
                          : 'Due',
                    ),
                    labelStyle: TextStyle(
                      color: invoice.dueAmount <= 0
                          ? Colors.green.shade800
                          : isOverdue
                          ? Colors.red.shade800
                          : Colors.orange.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor:
                    invoice.dueAmount <= 0
                        ? Colors.green.shade100
                        : isOverdue
                        ? Colors.red.shade100
                        : Colors.orange.shade100,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _infoRow(
                'Invoice No.',
                invoice.invoiceNumber,
              ),

              _infoRow(
                'Member ID',
                invoice.memberId,
              ),
              _infoRow(
                'Due Date',
                invoice.dueDate == null
                    ? '-'
                    : invoice.dueDate!
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),

              _infoRow(
                'Invoice Date',
                invoice.invoiceDate
                    .toLocal()
                    .toString()
                    .split(' ')
                    .first,
              ),

              _infoRow(
                'Total',
                '₹${invoice.totalAmount.toStringAsFixed(2)}',
              ),

              _infoRow(
                'Paid',
                '₹${invoice.paidAmount.toStringAsFixed(2)}',
              ),

              _infoRow(
                'Outstanding',
                '₹${invoice.dueAmount.toStringAsFixed(2)}',
                bold: true,
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [

                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MembershipInvoiceDetailsPage(
                                invoice: invoice,
                              ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.receipt_long,
                    ),
                    label: const Text(
                      'View Invoice',
                    ),
                  ),

                  OutlinedButton.icon(
                    onPressed: invoice.dueAmount <= 0
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CollectMembershipPaymentPage(
                                invoice: invoice,
                              ),
                        ),
                      );

                      // TODO(Sprint 18):
                      // Refresh invoice list after
                      // returning from payment collection.
                    },
                    icon: const Icon(
                      Icons.payments,
                    ),
                    label: const Text(
                      'Collect Payment',
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      );
    }
    Widget _summaryCard({
      required String title,
      required String value,
      required Color color,
    }) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      );
    }

    Widget _infoRow(
        String title,
        String value, {
          bool bold = false,
        }) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Row(
          children: [

            Expanded(
              child: Text(title),
            ),

            Text(
              value,
              style: TextStyle(
                fontWeight: bold
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),

          ],
        ),
      );
    }
  }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/member_model.dart';
import '../../models/membership_invoice_model.dart';
import '../../providers/member_provider.dart';
import '../../providers/membership_provider.dart';

import 'collect_membership_payment_page.dart';
import 'membership_invoice_details_page.dart';

enum DueMemberFilter {
  all,
  dueToday,
  overdue,
  next7Days,
}

class DueMembersPage extends StatefulWidget {
  const DueMembersPage({super.key});

  @override
  State<DueMembersPage> createState() =>
      _DueMembersPageState();
}

class _DueMembersPageState
    extends State<DueMembersPage> {

  DueMemberFilter _selectedFilter =
      DueMemberFilter.all;

  @override
  Widget build(BuildContext context) {
    final membershipProvider =
    context.watch<MembershipProvider>();

    final memberProvider =
    context.watch<MemberProvider>();

    final invoices =
        membershipProvider.invoices;

    final members =
        memberProvider.members;

    final today = DateTime.now();

    final todayDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final next7Days = todayDate.add(
      const Duration(days: 7),
    );

    final dueInvoices = invoices.where((invoice) {
      if (invoice.dueAmount <= 0) {
        return false;
      }

      if (invoice.dueDate == null) {
        return false;
      }

      final dueDate = DateTime(
        invoice.dueDate!.year,
        invoice.dueDate!.month,
        invoice.dueDate!.day,
      );

      switch (_selectedFilter) {
        case DueMemberFilter.all:
          return true;

        case DueMemberFilter.dueToday:
          return dueDate == todayDate;

        case DueMemberFilter.overdue:
          return dueDate.isBefore(todayDate);

        case DueMemberFilter.next7Days:
          return dueDate.isAfter(todayDate) &&
              !dueDate.isAfter(next7Days);
      }
    }).toList();
    dueInvoices.sort(
          (a, b) => a.dueDate!.compareTo(b.dueDate!),
    );

    final totalDueMembers =
        invoices.where((invoice) {
          return invoice.dueAmount > 0 &&
              invoice.dueDate != null;
        }).length;

    final dueTodayCount =
        invoices.where((invoice) {
          if (invoice.dueAmount <= 0 ||
              invoice.dueDate == null) {
            return false;
          }

          final dueDate = DateTime(
            invoice.dueDate!.year,
            invoice.dueDate!.month,
            invoice.dueDate!.day,
          );

          return dueDate == todayDate;
        }).length;

    final overdueCount =
        invoices.where((invoice) {
          if (invoice.dueAmount <= 0 ||
              invoice.dueDate == null) {
            return false;
          }

          final dueDate = DateTime(
            invoice.dueDate!.year,
            invoice.dueDate!.month,
            invoice.dueDate!.day,
          );

          return dueDate.isBefore(todayDate);
        }).length;

    final totalOutstanding =
    invoices.fold<double>(
      0,
          (sum, invoice) {
        if (invoice.dueAmount <= 0) {
          return sum;
        }

        return sum + invoice.dueAmount;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Due Members',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ===== Summary Cards =====
          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  title: 'Total Due',
                  value: totalDueMembers.toString(),
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  title: 'Due Today',
                  value: dueTodayCount.toString(),
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
                  title: 'Overdue',
                  value: overdueCount.toString(),
                  color: Colors.red,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  title: 'Outstanding',
                  value:
                  '₹${totalOutstanding.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Filters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [

              ChoiceChip(
                label: const Text('All'),
                selected:
                _selectedFilter ==
                    DueMemberFilter.all,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter =
                        DueMemberFilter.all;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Due Today'),
                selected:
                _selectedFilter ==
                    DueMemberFilter.dueToday,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter =
                        DueMemberFilter.dueToday;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Overdue'),
                selected:
                _selectedFilter ==
                    DueMemberFilter.overdue,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter =
                        DueMemberFilter.overdue;
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Next 7 Days'),
                selected:
                _selectedFilter ==
                    DueMemberFilter.next7Days,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter =
                        DueMemberFilter.next7Days;
                  });
                },
              ),

            ],
          ),

          const SizedBox(height: 24),

          if (dueInvoices.isEmpty)

            const Card(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'No due members found.',
                  ),
                ),
              ),
            )

          else
            ...dueInvoices.map(
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

          const SizedBox(height: 40),
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
                    isOverdue
                        ? 'Overdue'
                        : 'Due',
                  ),
                  labelStyle: TextStyle(
                    color: isOverdue
                        ? Colors.red.shade800
                        : Colors.orange.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor:
                  isOverdue
                      ? Colors.red.shade100
                      : Colors.orange.shade100,
                ),
              ],
            ),

            const SizedBox(height: 12),

            _infoRow(
              'Member ID',
              invoice.memberId,
            ),

            _infoRow(
              'Invoice No.',
              invoice.invoiceNumber,
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
                    // TODO(Sprint 18):
                    // Refresh invoice list after returning
                    // from payment collection.
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CollectMembershipPaymentPage(
                              invoice: invoice,
                            ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.payments,
                  ),
                  label: const Text(
                    'Collect Payment',
                  ),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    // TODO(Sprint 18):
                    // Call Member.
                  },
                  icon: const Icon(
                    Icons.call,
                  ),
                  label: const Text(
                    'Call',
                  ),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    // TODO(Sprint 18):
                    // WhatsApp Reminder.
                  },
                  icon: const Icon(
                    Icons.chat,
                  ),
                  label: const Text(
                    'WhatsApp',
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

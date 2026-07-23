import 'package:flutter/material.dart';

import '../../../models/invoice_render_data.dart';


class InvoiceTemplate extends StatelessWidget {
  final InvoiceRenderData data;

  const InvoiceTemplate({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
     return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),

          const SizedBox(height: 24),

          _buildCustomerInformation(),

          const SizedBox(height: 24),

          _buildItemsTable(),

          const SizedBox(height: 24),

          _buildPaymentStatus(),

          const SizedBox(height: 24),

          _buildSummary(),

          const SizedBox(height: 24),

          _buildAmountInWords(),

          const SizedBox(height: 24),

          _buildNotes(),

          const SizedBox(height: 24),

          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final gym = data.gym;
    final invoice = data.invoice;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: gym.logoUrl != null && gym.logoUrl!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                gym.logoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.fitness_center, size: 40),
              ),
            )
                : const Icon(
              Icons.fitness_center,
              size: 40,
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.amber,
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    gym.gymName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                if ((gym.tagline ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 10),
                    child: Text(
                      gym.tagline!,
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                if ((gym.address ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(gym.address!),
                  ),

                _infoRow(
                  'Location',
                  [
                    gym.city,
                    gym.state,
                    gym.pincode,
                    gym.country,
                  ]
                      .where((e) => e != null && e.trim().isNotEmpty)
                      .join(', '),
                ),

                _infoRow('Phone', gym.phone),
                _infoRow('Email', gym.email),
                _infoRow('Website', gym.website),
                _infoRow('GSTIN', gym.gstNumber),
              ],
            ),
          ),

          const SizedBox(width: 24),

          Container(
            width: 220,
            color: Colors.lightBlue.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TAX INVOICE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "Invoice No : ${invoice.invoiceNumber}",
                ),

                Text(
                  "Invoice Date : "
                      "${invoice.invoiceDate.day.toString().padLeft(2, '0')}/"
                      "${invoice.invoiceDate.month.toString().padLeft(2, '0')}/"
                      "${invoice.invoiceDate.year}",
                ),

                if (invoice.dueDate != null)
                  Text(
                    "Due Date : "
                        "${invoice.dueDate!.day.toString().padLeft(2, '0')}/"
                        "${invoice.dueDate!.month.toString().padLeft(2, '0')}/"
                        "${invoice.dueDate!.year}",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInformation() {
    final invoice = data.invoice;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BILL TO',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            invoice.customerName,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (invoice.customerPhone.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Phone : ${invoice.customerPhone}',
              ),
            ),

          if (invoice.customerEmail.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Email : ${invoice.customerEmail}',
              ),
            ),

          if (invoice.customerAddress.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                invoice.customerAddress,
              ),
            ),

          if (invoice.customerGstin.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'GSTIN : ${invoice.customerGstin}',
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    if (value == null || value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        '$label : $value',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }
  Widget _buildItemsTable() {
    return const Placeholder(
      fallbackHeight: 250,
    );
  }

  Widget _buildPaymentStatus() {
    return const Placeholder(
      fallbackHeight: 70,
    );
  }

  Widget _buildSummary() {
    return const Placeholder(
      fallbackHeight: 170,
    );
  }

  Widget _buildAmountInWords() {
    return const Placeholder(
      fallbackHeight: 60,
    );
  }

  Widget _buildNotes() {
    return const Placeholder(
      fallbackHeight: 70,
    );
  }

  Widget _buildFooter() {
    return const Placeholder(
      fallbackHeight: 100,
    );
  }
}
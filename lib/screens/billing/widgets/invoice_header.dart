import 'package:flutter/material.dart';

import '../../../models/invoice_render_data.dart';

class InvoiceHeader extends StatelessWidget {
  final InvoiceRenderData data;

  const InvoiceHeader({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final gym = data.gym;
    final invoice = data.invoice;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          SizedBox(
            width: 80,
            height: 80,
            child: gym.logoUrl != null && gym.logoUrl!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                gym.logoUrl!,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.fitness_center,
                size: 40,
              ),
            ),
          ),

          const SizedBox(width: 18),

          // Gym Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gym.gymName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                if ((gym.address ?? '').isNotEmpty)
                  Text(gym.address!),

                if ((gym.phone ?? '').isNotEmpty)
                  Text(gym.phone!),

                if ((gym.email ?? '').isNotEmpty)
                  Text(gym.email!),

                if ((gym.gstNumber ?? '').isNotEmpty)
                  Text(
                    "GSTIN : ${gym.gstNumber}",
                  ),

                if ((gym.website ?? '').isNotEmpty)
                  Text(
                    gym.website!,
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Invoice Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "TAX INVOICE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "Invoice : ${invoice.invoiceNumber}",
              ),

              Text(
                "Date : ${invoice.invoiceDate}",
              ),

              if (invoice.dueDate != null)
                Text(
                  "Due : ${invoice.dueDate}",
                ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: data.isPaid
                      ? Colors.green
                      : data.isPartial
                      ? Colors.orange
                      : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.paymentStatusLabel.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
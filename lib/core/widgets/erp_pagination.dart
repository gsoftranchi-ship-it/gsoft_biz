import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import 'erp_button.dart';
import 'erp_dropdown.dart';

class ERPPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final int rowsPerPage;

  final List<int> rowsPerPageOptions;

  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onRowsPerPageChanged;

  const ERPPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.rowsPerPage,
    this.rowsPerPageOptions = const [10, 20, 50, 100],
    this.onPageChanged,
    this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Text(
            'Total: $totalRecords',
            style: AppTypography.body,
          ),

          const SizedBox(width: AppSpacing.xl),

          SizedBox(
            width: 140,
            child: ERPDropdown<int>(
              value: rowsPerPage,
              label: 'Rows',
              items: rowsPerPageOptions
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text('$e'),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onRowsPerPageChanged?.call(value);
                }
              },
            ),
          ),

          const Spacer(),

          ERPButton(
            text: 'Previous',
            type: ERPButtonType.outline,
            enabled: currentPage > 1,
            onPressed: () {
              onPageChanged?.call(currentPage - 1);
            },
          ),

          const SizedBox(width: AppSpacing.sm),

          Text(
            '$currentPage / $totalPages',
            style: AppTypography.body,
          ),

          const SizedBox(width: AppSpacing.sm),

          ERPButton(
            text: 'Next',
            type: ERPButtonType.outline,
            enabled: currentPage < totalPages,
            onPressed: () {
              onPageChanged?.call(currentPage + 1);
            },
          ),
        ],
      ),
    );
  }
}
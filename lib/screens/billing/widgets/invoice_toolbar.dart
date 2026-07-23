import 'package:flutter/material.dart';

import '../../../core/widgets/erp_filter_bar.dart';
import '../../../core/widgets/erp_search_bar.dart';

class InvoiceToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final String searchHint;
  final ValueChanged<String> onSearchChanged;

  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  const InvoiceToolbar({
    super.key,
    required this.searchController,
    required this.searchHint,
    required this.onSearchChanged,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ERPFilterBar(
      search: ERPSearchBar(
        controller: searchController,
        hint: searchHint,
        onChanged: onSearchChanged,
      ),
      filters: [
        FilterChip(
          label: const Text('All'),
          selected: selectedFilter == 0,
          onSelected: (_) => onFilterChanged(0),
        ),
        FilterChip(
          label: const Text('Paid'),
          selected: selectedFilter == 1,
          onSelected: (_) => onFilterChanged(1),
        ),
        FilterChip(
          label: const Text('Due'),
          selected: selectedFilter == 2,
          onSelected: (_) => onFilterChanged(2),
        ),
      ],
    );
  }
}
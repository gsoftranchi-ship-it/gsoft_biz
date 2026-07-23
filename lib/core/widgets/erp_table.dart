import 'package:flutter/material.dart';

import 'erp_empty_state.dart';
import 'erp_loading.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';


class ERPTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  final bool loading;
  final String? errorMessage;

  final String emptyTitle;
  final String emptyMessage;

  final double columnSpacing;
  final double horizontalMargin;
  final double headingRowHeight;
  final double dataRowMinHeight;
  final double dataRowMaxHeight;



  const ERPTable({
    super.key,
    required this.columns,
    required this.rows,
    this.loading = false,
    this.errorMessage,
    this.emptyTitle = 'No Records Found',
    this.emptyMessage = 'There is no data available.',
    this.columnSpacing = 24,
    this.horizontalMargin = 24,
    this.headingRowHeight = 56,
    this.dataRowMinHeight = 52,
    this.dataRowMaxHeight = 52,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const ERPLoading(
        message: 'Loading...',
      );
    }

    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ),
      );
    }

    if (rows.isEmpty) {
      return ERPEmptyState(
        title: emptyTitle,
        message: emptyMessage,
      );
    }

    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columns,
          rows: rows,
          columnSpacing: columnSpacing,
          horizontalMargin: horizontalMargin,
          headingRowHeight: headingRowHeight,
          dataRowMinHeight: dataRowMinHeight,
          dataRowMaxHeight: dataRowMaxHeight,
        ),
      ),
    );
  }
}
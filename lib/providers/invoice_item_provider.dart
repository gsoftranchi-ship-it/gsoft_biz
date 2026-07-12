import 'package:flutter/foundation.dart';

import '../domain/repositories/invoice_item_repository.dart';
import '../models/invoice_item_model.dart';

class InvoiceItemProvider
    extends ChangeNotifier {
  InvoiceItemProvider({
    required InvoiceItemRepository repository,
  }) : _repository = repository;

  final InvoiceItemRepository _repository;

  final List<InvoiceItemModel> _items = [];
  bool _loading = false;

  List<InvoiceItemModel> get items =>
      List.unmodifiable(_items);
  bool get loading => _loading;

  Future<void> loadInvoiceItems({
    required String gymId,
    required String invoiceId,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      final data =
      await _repository.getInvoiceItems(
        gymId,
        invoiceId,
      );

      _items
        ..clear()
        ..addAll(data);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> saveItems({
    required String gymId,
    required List<InvoiceItemModel> items,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      await _repository.createMany(
        gymId,
        items,
      );

      _items
        ..clear()
        ..addAll(items);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteInvoiceItems({
    required String gymId,
    required String invoiceId,
  }) async {
    _loading = true;
    notifyListeners();

    try {
      await _repository.softDeleteInvoiceItems(
        gymId,
        invoiceId,
      );

      _items.clear();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
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

  List<InvoiceItemModel> get items =>
      List.unmodifiable(_items);

  Future<void> loadInvoiceItems({
    required String gymId,
    required String invoiceId,
  }) async {
    final data =
    await _repository.getInvoiceItems(
      gymId,
      invoiceId,
    );

    _items
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  Future<void> saveItems({
    required String gymId,
    required List<InvoiceItemModel> items,
  }) async {
    await _repository.createMany(
      gymId,
      items,
    );

    _items
      ..clear()
      ..addAll(items);

    notifyListeners();
  }

  Future<void> deleteInvoiceItems({
    required String gymId,
    required String invoiceId,
  }) async {
    await _repository.softDeleteInvoiceItems(
      gymId,
      invoiceId,
    );

    _items.clear();

    notifyListeners();
  }
}
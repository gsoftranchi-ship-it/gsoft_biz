import 'package:flutter/foundation.dart';

import '../domain/repositories/invoice_repository.dart';
import '../models/invoice_model.dart';

class InvoiceProvider extends ChangeNotifier {
  InvoiceProvider({
    required InvoiceRepository repository,
  }) : _repository = repository;

  final InvoiceRepository _repository;

  InvoiceRepository get repository => _repository;

  final List<InvoiceModel> _invoices = [];

  InvoiceModel? _selectedInvoice;

  bool _loading = false;

  String? _error;

  String? _currentGymId;

  List<InvoiceModel> get invoices =>
      List.unmodifiable(_invoices);

  InvoiceModel? get selectedInvoice =>
      _selectedInvoice;

  bool get loading => _loading;

  /// Backward compatibility
  bool get isLoading => _loading;

  String? get error => _error;

  /// Backward compatibility
  String? get errorMessage => _error;

  int get totalInvoices => _invoices.length;

  double get totalSales => _invoices.fold(
    0,
        (sum, invoice) => sum + invoice.grandTotal,
  );

  double get totalOutstanding => _invoices.fold(
    0,
        (sum, invoice) => sum + invoice.balanceAmount,
  );

  Future<void> loadInvoices({
    required String gymId,
  }) async {
    _currentGymId = gymId;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _repository.getAll(gymId);

      _invoices
        ..clear()
        ..addAll(data);
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_currentGymId == null) return;

    await loadInvoices(
      gymId: _currentGymId!,
    );
  }

  Future<void> loadInvoice({
    required String gymId,
    required String invoiceId,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedInvoice = await _repository.get(
        gymId,
        invoiceId,
      );
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
  Future<String> generateInvoiceNumber({
    required String gymId,
  }) {
    return _repository.generateInvoiceNumber(
      gymId,
    );
  }

  Future<void> createInvoice({
    required String gymId,
    required InvoiceModel invoice,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.create(
        gymId,
        invoice,
      );

      await refresh();
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> updateInvoice({
    required String gymId,
    required InvoiceModel invoice,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.update(
        gymId,
        invoice,
      );

      await refresh();
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> deleteInvoice({
    required String gymId,
    required String invoiceId,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.softDelete(
        gymId,
        invoiceId,
      );

      await refresh();
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;
    notifyListeners();
  }
}
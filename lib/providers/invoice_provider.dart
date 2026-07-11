

import '../domain/repositories/invoice_repository.dart';
import '../models/invoice_model.dart';
import 'base/base_provider.dart';

class InvoiceProvider extends BaseProvider {
  InvoiceProvider({
    required InvoiceRepository repository,
  }) : _repository = repository;

  final InvoiceRepository _repository;

  List<InvoiceModel> _invoices = [];

  InvoiceModel? _selectedInvoice;

  List<InvoiceModel> get invoices =>
      List.unmodifiable(_invoices);

  InvoiceModel? get selectedInvoice =>
      _selectedInvoice;
  ///===========================================================
  /// Load All Invoices
  ///===========================================================
  Future<void> loadInvoices(
      String gymId,
      ) async {
    try {
      clearError();
      setLoading(true);

      _invoices = await _repository.getAll(gymId);

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Load Invoice
  ///===========================================================
  Future<void> loadInvoice(
      String gymId,
      String invoiceId,
      ) async {
    try {
      clearError();
      setLoading(true);

      _selectedInvoice = await _repository.get(
        gymId,
        invoiceId,
      );

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
  ///===========================================================
  /// Create Invoice
  ///===========================================================
  Future<void> createInvoice(
      String gymId,
      InvoiceModel invoice,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.create(
        gymId,
        invoice,
      );

      await loadInvoices(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Update Invoice
  ///===========================================================
  Future<void> updateInvoice(
      String gymId,
      InvoiceModel invoice,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.update(
        gymId,
        invoice,
      );

      await loadInvoices(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
  ///===========================================================
  /// Delete Invoice
  ///===========================================================
  Future<void> deleteInvoice(
      String gymId,
      String invoiceId,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.softDelete(
        gymId,
        invoiceId,
      );

      await loadInvoices(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}

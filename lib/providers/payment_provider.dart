import '../domain/repositories/payment_repository.dart';
import '../models/payment_model.dart';
import 'base/base_provider.dart';
import '../models/invoice_model.dart';

class PaymentProvider extends BaseProvider {
  PaymentProvider({
    required PaymentRepository repository,
  }) : _repository = repository;

  final PaymentRepository _repository;

  List<PaymentModel> _payments = [];

  PaymentModel? _selectedPayment;

  List<PaymentModel> get payments =>
      List.unmodifiable(_payments);

  PaymentModel? get selectedPayment =>
      _selectedPayment;

  ///===========================================================
  /// Load All Payments
  ///===========================================================
  Future<void> loadPayments(
      String gymId,
      ) async {
    try {
      clearError();
      setLoading(true);

      _payments = await _repository.getAll(gymId);

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Load Payment
  ///===========================================================
  Future<void> loadPayment(
      String gymId,
      String paymentId,
      ) async {
    try {
      clearError();
      setLoading(true);

      _selectedPayment = await _repository.get(
        gymId,
        paymentId,
      );

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Create Payment
  ///===========================================================
  Future<void> createPayment(
      String gymId,
      PaymentModel payment,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.create(
        gymId,
        payment,
      );

      await loadPayments(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
  ///===========================================================
  /// Save Payment Transaction
  ///===========================================================
  Future<void> savePaymentTransaction({
    required String gymId,
    required PaymentModel payment,
    required InvoiceModel invoice,
  }) async {
    try {
      clearError();
      setLoading(true);

      await _repository.savePaymentTransaction(
        gymId: gymId,
        payment: payment,
        invoice: invoice,
      );

      await loadPayments(gymId);

      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Update Payment
  ///===========================================================
  Future<void> updatePayment(
      String gymId,
      PaymentModel payment,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.update(
        gymId,
        payment,
      );

      await loadPayments(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  ///===========================================================
  /// Delete Payment
  ///===========================================================
  Future<void> deletePayment(
      String gymId,
      String paymentId,
      ) async {
    try {
      clearError();
      setLoading(true);

      await _repository.softDelete(
        gymId,
        paymentId,
      );

      await loadPayments(gymId);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
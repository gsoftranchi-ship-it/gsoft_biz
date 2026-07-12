import '../../models/payment_model.dart';
import 'base/base_repository.dart';
import '../../models/invoice_model.dart';

abstract class PaymentRepository
    implements BaseRepository<PaymentModel> {

  ///===========================================================
  /// Payment Exists
  ///===========================================================
  Future<bool> exists(
      String gymId,
      String paymentId,
      );

  ///===========================================================
  /// Invoice Payments
  ///===========================================================
  Future<List<PaymentModel>> getInvoicePayments(
      String gymId,
      String invoiceId,
      );

  ///===========================================================
  /// Today's Payments
  ///===========================================================
  Future<List<PaymentModel>> getTodayPayments(
      String gymId,
      );

  ///===========================================================
  /// Payment History
  ///===========================================================
  Future<List<PaymentModel>> getPaymentHistory(
      String gymId,
      String memberId,
      );

  ///===========================================================
  /// Outstanding Payments
  ///===========================================================
  Future<double> getTotalCollection(
      String gymId,
      );
  ///===========================================================
  /// Save Payment Transaction
  ///===========================================================
  Future<void> savePaymentTransaction({
    required String gymId,
    required PaymentModel payment,
    required InvoiceModel invoice,
  });
}
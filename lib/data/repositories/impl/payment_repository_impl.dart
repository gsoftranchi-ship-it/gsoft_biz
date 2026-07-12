import '../../../data/datasources/remote/firebase/payment_datasource.dart';
import '../../../domain/repositories/payment_repository.dart';
import '../../../models/payment_model.dart';
import '../../../models/invoice_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({
    required PaymentDataSource paymentDataSource,
  }) : _paymentDataSource = paymentDataSource;

  final PaymentDataSource _paymentDataSource;

  @override
  Future<void> create(
      String gymId,
      PaymentModel model,
      ) {
    return _paymentDataSource.create(
      gymId,
      model,
    );
  }

  @override
  Future<void> update(
      String gymId,
      PaymentModel model,
      ) {
    return _paymentDataSource.update(
      gymId,
      model,
    );
  }

  @override
  Future<PaymentModel?> get(
      String gymId,
      String id,
      ) {
    return _paymentDataSource.get(
      gymId,
      id,
    );
  }

  @override
  Future<List<PaymentModel>> getAll(
      String gymId,
      ) {
    return _paymentDataSource.getAll(
      gymId,
    );
  }

  @override
  Future<void> softDelete(
      String gymId,
      String id,
      ) {
    return _paymentDataSource.softDelete(
      gymId,
      id,
    );
  }

  @override
  Future<bool> exists(
      String gymId,
      String paymentId,
      ) async {
    final payment = await get(
      gymId,
      paymentId,
    );

    return payment != null;
  }

  @override
  Future<List<PaymentModel>> getInvoicePayments(
      String gymId,
      String invoiceId,
      ) {
    throw UnimplementedError(
      'Will be implemented in Payment Query Sprint.',
    );
  }

  @override
  Future<List<PaymentModel>> getTodayPayments(
      String gymId,
      ) {
    throw UnimplementedError(
      'Will be implemented in Dashboard Sprint.',
    );
  }

  @override
  Future<List<PaymentModel>> getPaymentHistory(
      String gymId,
      String memberId,
      ) {
    throw UnimplementedError(
      'Will be implemented in Member Billing Sprint.',
    );
  }

  @override
  Future<double> getTotalCollection(
      String gymId,
      ) {
    throw UnimplementedError(
      'Will be implemented in Dashboard Sprint.',
    );
  }
  @override
  Future<void> savePaymentTransaction({
    required String gymId,
    required PaymentModel payment,
    required InvoiceModel invoice,
  }) {
    return _paymentDataSource.savePaymentTransaction(
      gymId: gymId,
      payment: payment,
      invoice: invoice,
    );
  }
}
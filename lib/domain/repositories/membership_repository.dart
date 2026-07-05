import '../../core/result/result.dart';
import '../../models/membership_invoice_model.dart';
import '../../models/membership_payment_model.dart';

abstract class MembershipRepository {
  // ---------- Invoice ----------

  Future<Result<List<MembershipInvoiceModel>>> getInvoices({
    required String gymId,
  });

  Future<Result<MembershipInvoiceModel?>> getInvoiceById({
    required String gymId,
    required String invoiceId,
  });

  Future<Result<void>> createInvoice(
      MembershipInvoiceModel invoice,
      );

  Future<Result<void>> updateInvoice(
      MembershipInvoiceModel invoice,
      );

  Future<Result<void>> deleteInvoice(
      String invoiceId,
      );

  Future<Result<List<MembershipInvoiceModel>>> getMemberInvoices({
    required String gymId,
    required String memberId,
  });

  Future<Result<List<MembershipInvoiceModel>>> getDueInvoices({
    required String gymId,
  });

  // ---------- Payments ----------

  Future<Result<List<MembershipPaymentModel>>> getPayments({
    required String gymId,
    required String invoiceId,
  });

  Future<Result<void>> collectPayment(
      MembershipPaymentModel payment,
      );

  Future<Result<double>> getOutstandingAmount({
    required String gymId,
    required String memberId,
  });
}
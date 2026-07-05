import '../../../../models/membership_invoice_model.dart';
import '../../../../models/membership_payment_model.dart';

abstract class MembershipDataSource {
  // ---------- Invoice ----------

  Future<List<MembershipInvoiceModel>> getInvoices({
    required String gymId,
  });

  Future<MembershipInvoiceModel?> getInvoiceById({
    required String gymId,
    required String invoiceId,
  });

  Future<void> createInvoice(
      MembershipInvoiceModel invoice,
      );

  Future<void> updateInvoice(
      MembershipInvoiceModel invoice,
      );

  Future<void> deleteInvoice(
      String invoiceId,
      );

  Future<List<MembershipInvoiceModel>> getMemberInvoices({
    required String gymId,
    required String memberId,
  });

  Future<List<MembershipInvoiceModel>> getDueInvoices({
    required String gymId,
  });

  // ---------- Payments ----------

  Future<List<MembershipPaymentModel>> getPayments({
    required String gymId,
    required String invoiceId,
  });

  Future<void> collectPayment(
      MembershipPaymentModel payment,
      );

  Future<double> getOutstandingAmount({
    required String gymId,
    required String memberId,
  });
}
import '../../../core/result/failures.dart';
import '../../../core/result/result.dart';
import '../../../domain/repositories/membership_repository.dart';
import '../../../models/membership_invoice_model.dart';
import '../../../models/membership_payment_model.dart';
import '../../datasources/remote/firebase/firestore_datasource.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  MembershipRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<List<MembershipInvoiceModel>>> getInvoices({
    required String gymId,
  }) async {
    try {
      final invoices = await _firestoreDataSource.getMembershipInvoices(
        gymId: gymId,
      );
      return Success(invoices);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<MembershipInvoiceModel?>> getInvoiceById({
    required String gymId,
    required String invoiceId,
  }) async {
    try {
      final invoice = await _firestoreDataSource.getMembershipInvoiceById(
        invoiceId: invoiceId,
      );
      return Success(invoice);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> createInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    try {
      await _firestoreDataSource.createMembershipInvoice(invoice);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> updateInvoice(
      MembershipInvoiceModel invoice,
      ) async {
    try {
      await _firestoreDataSource.updateMembershipInvoice(invoice);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> deleteInvoice(
      String invoiceId,
      ) async {
    try {
      await _firestoreDataSource.deleteMembershipInvoice(invoiceId);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<MembershipInvoiceModel>>> getMemberInvoices({
    required String gymId,
    required String memberId,
  }) async {
    try {
      final invoices = await _firestoreDataSource.getMemberInvoices(
        gymId: gymId,
        memberId: memberId,
      );
      return Success(invoices);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<MembershipInvoiceModel>>> getDueInvoices({
    required String gymId,
  }) async {
    try {
      final invoices =
      await _firestoreDataSource.getDueMembershipInvoices(
        gymId: gymId,
      );
      return Success(invoices);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<MembershipPaymentModel>>> getPayments({
    required String gymId,
    required String invoiceId,
  }) async {
    try {
      final payments = await _firestoreDataSource.getMembershipPayments(
        gymId: gymId,
        invoiceId: invoiceId,
      );
      return Success(payments);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> collectPayment(
      MembershipPaymentModel payment,
      ) async {
    try {
      await _firestoreDataSource.collectMembershipPayment(payment);
      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<double>> getOutstandingAmount({
    required String gymId,
    required String memberId,
  }) async {
    try {
      final amount = await _firestoreDataSource.getOutstandingAmount(
        gymId: gymId,
        memberId: memberId,
      );
      return Success(amount);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }
}
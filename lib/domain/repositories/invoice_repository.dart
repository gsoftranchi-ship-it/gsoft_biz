import '../../models/invoice_model.dart';
import 'base/base_repository.dart';

abstract class InvoiceRepository
    implements BaseRepository<InvoiceModel> {

  ///===========================================================
  /// Invoice Number
  ///===========================================================
  Future<String> generateInvoiceNumber(
      String gymId,
      );

  ///===========================================================
  /// Invoice Exists
  ///===========================================================
  Future<bool> exists(
      String gymId,
      String invoiceId,
      );

  ///===========================================================
  /// Search Invoice
  ///===========================================================
  Future<List<InvoiceModel>> search(
      String gymId,
      String keyword,
      );

  ///===========================================================
  /// Today's Invoices
  ///===========================================================
  Future<List<InvoiceModel>> getTodayInvoices(
      String gymId,
      );

  ///===========================================================
  /// Outstanding Invoices
  ///===========================================================
  Future<List<InvoiceModel>> getOutstandingInvoices(
      String gymId,
      );
}
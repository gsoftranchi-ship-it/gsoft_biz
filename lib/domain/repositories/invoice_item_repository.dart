import '../../models/invoice_item_model.dart';

abstract class InvoiceItemRepository {
  Future<void> create(
      String gymId,
      InvoiceItemModel item,
      );

  Future<void> createMany(
      String gymId,
      List<InvoiceItemModel> items,
      );

  Future<List<InvoiceItemModel>> getInvoiceItems(
      String gymId,
      String invoiceId,
      );

  Future<void> softDeleteInvoiceItems(
      String gymId,
      String invoiceId,
      );
}
import '../../../domain/repositories/invoice_item_repository.dart';
import '../../../models/invoice_item_model.dart';
import '../../datasources/remote/firebase/invoice_item_datasource.dart';

class InvoiceItemRepositoryImpl
    implements InvoiceItemRepository {
  InvoiceItemRepositoryImpl({
    required InvoiceItemDataSource invoiceItemDataSource,
  }) : _invoiceItemDataSource =
      invoiceItemDataSource;

  final InvoiceItemDataSource
  _invoiceItemDataSource;

  @override
  Future<void> create(
      String gymId,
      InvoiceItemModel item,
      ) {
    return _invoiceItemDataSource.create(
      gymId,
      item,
    );
  }

  @override
  Future<void> createMany(
      String gymId,
      List<InvoiceItemModel> items,
      ) {
    return _invoiceItemDataSource.createMany(
      gymId,
      items,
    );
  }

  @override
  Future<List<InvoiceItemModel>>
  getInvoiceItems(
      String gymId,
      String invoiceId,
      ) {
    return _invoiceItemDataSource
        .getInvoiceItems(
      gymId,
      invoiceId,
    );
  }

  @override
  Future<void> softDeleteInvoiceItems(
      String gymId,
      String invoiceId,
      ) {
    return _invoiceItemDataSource
        .softDeleteInvoiceItems(
      gymId,
      invoiceId,
    );
  }
}
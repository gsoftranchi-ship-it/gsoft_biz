import '../../../data/datasources/remote/firebase/invoice_datasource.dart';
import '../../../domain/repositories/invoice_repository.dart';
import '../../../models/invoice_model.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  InvoiceRepositoryImpl({
    required InvoiceDataSource invoiceDataSource,
  }) : _invoiceDataSource = invoiceDataSource;

  final InvoiceDataSource _invoiceDataSource;

  @override
  Future<void> create(
      String gymId,
      InvoiceModel model,
      ) {
    return _invoiceDataSource.create(
      gymId,
      model,
    );
  }

  @override
  Future<void> update(
      String gymId,
      InvoiceModel model,
      ) {
    return _invoiceDataSource.update(
      gymId,
      model,
    );
  }

  @override
  Future<InvoiceModel?> get(
      String gymId,
      String id,
      ) {
    return _invoiceDataSource.get(
      gymId,
      id,
    );
  }

  @override
  Future<List<InvoiceModel>> getAll(
      String gymId,
      ) {
    return _invoiceDataSource.getAll(
      gymId,
    );
  }

  @override
  Future<void> softDelete(
      String gymId,
      String id,
      ) {
    return _invoiceDataSource.softDelete(
      gymId,
      id,
    );
  }

  @override
  Future<bool> exists(
      String gymId,
      String invoiceId,
      ) async {
    final invoice = await get(
      gymId,
      invoiceId,
    );

    return invoice != null;
  }

  @override
  Future<String> generateInvoiceNumber(
      String gymId,
      ) {
    throw UnimplementedError(
      'Will be implemented with DocumentNumberService.',
    );
  }

  @override
  Future<List<InvoiceModel>> search(
      String gymId,
      String keyword,
      ) {
    throw UnimplementedError(
      'Will be implemented in next sprint.',
    );
  }

  @override
  Future<List<InvoiceModel>> getTodayInvoices(
      String gymId,
      ) {
    throw UnimplementedError(
      'Will be implemented in next sprint.',
    );
  }

  @override
  Future<List<InvoiceModel>> getOutstandingInvoices(
      String gymId,
      ) {
    throw UnimplementedError(
      'Will be implemented in next sprint.',
    );
  }
}
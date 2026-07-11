import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../models/invoice_model.dart';
import '../../../../models/base/entity_status.dart';
import '../../base/base_firestore_datasource.dart';

class InvoiceDataSource
    implements BaseFirestoreDataSource<InvoiceModel> {
  InvoiceDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _invoiceCollection(
      String gymId,
      ) {
    return _firestore
        .collection(FirestorePaths.gyms)
        .doc(gymId)
        .collection(FirestorePaths.invoices);
  }

  @override
  Future<void> create(
      String gymId,
      InvoiceModel invoice,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoice.invoiceId)
        .set(invoice.toMap());
  }

  @override
  Future<void> update(
      String gymId,
      InvoiceModel invoice,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoice.invoiceId)
        .update(invoice.toMap());
  }

  @override
  Future<InvoiceModel?> get(
      String gymId,
      String invoiceId,
      ) async {
    final document = await _invoiceCollection(gymId)
        .doc(invoiceId)
        .get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return InvoiceModel.fromMap(
      document.data()!,
      document.id,
    );
  }
  ///===========================================================
  /// Get All Invoices
  ///===========================================================
  @override
  Future<List<InvoiceModel>> getAll(
      String gymId,
      ) async {
    final snapshot = await _invoiceCollection(gymId)
        .orderBy('invoiceDate', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => InvoiceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }
  ///===========================================================
  /// Soft Delete Invoice
  ///===========================================================
  @override
  Future<void> softDelete(
      String gymId,
      String invoiceId,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoiceId)
        .update({
      'status': EntityStatus.inactive.name,
      'updatedAt': Timestamp.now(),
    });
  }
}
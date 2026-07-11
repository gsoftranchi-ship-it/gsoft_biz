import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../models/invoice_model.dart';
import '../../../../models/base/entity_status.dart';

class InvoiceDataSource {
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

  Future<void> createInvoice(
      String gymId,
      InvoiceModel invoice,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoice.invoiceId)
        .set(invoice.toMap());
  }

  Future<void> updateInvoice(
      String gymId,
      InvoiceModel invoice,
      ) async {
    await _invoiceCollection(gymId)
        .doc(invoice.invoiceId)
        .update(invoice.toMap());
  }

  Future<InvoiceModel?> getInvoice(
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
  Future<List<InvoiceModel>> getInvoices(
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
  Future<void> deleteInvoice(
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
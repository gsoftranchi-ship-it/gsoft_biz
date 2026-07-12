import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../models/invoice_item_model.dart';
import '../../../../models/base/entity_status.dart';

class InvoiceItemDataSource {
  InvoiceItemDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collection(
      String gymId,
      ) {
    return _firestore
        .collection(FirestorePaths.gyms)
        .doc(gymId)
        .collection(FirestorePaths.invoiceItems);
  }

  Future<void> create(
      String gymId,
      InvoiceItemModel item,
      ) async {
    await _collection(gymId)
        .doc(item.invoiceItemId)
        .set(item.toMap());
  }

  Future<void> createMany(
      String gymId,
      List<InvoiceItemModel> items,
      ) async {
    final batch = _firestore.batch();

    for (final item in items) {
      batch.set(
        _collection(gymId).doc(item.invoiceItemId),
        item.toMap(),
      );
    }

    await batch.commit();
  }

  Future<List<InvoiceItemModel>> getInvoiceItems(
      String gymId,
      String invoiceId,
      ) async {
    final snapshot = await _collection(gymId)
        .where(
      'invoiceId',
      isEqualTo: invoiceId,
    )
        .where(
      'status',
      isEqualTo: EntityStatus.active.name,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => InvoiceItemModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  Future<void> softDeleteInvoiceItems(
      String gymId,
      String invoiceId,
      ) async {
    final snapshot = await _collection(gymId)
        .where(
      'invoiceId',
      isEqualTo: invoiceId,
    )
        .get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(
        doc.reference,
        {
          'status': EntityStatus.inactive.name,
          'updatedAt': Timestamp.now(),
        },
      );
    }

    await batch.commit();
  }
}
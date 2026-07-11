import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../models/base/entity_status.dart';
import '../../../../models/payment_model.dart';
import '../../base/base_firestore_datasource.dart';

class PaymentDataSource
    implements BaseFirestoreDataSource<PaymentModel> {
  PaymentDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>>
  _paymentCollection(
      String gymId,
      ) {
    return _firestore
        .collection(FirestorePaths.gyms)
        .doc(gymId)
        .collection(FirestorePaths.payments);
  }
  @override
  Future<void> create(
      String gymId,
      PaymentModel model,
      ) {
    return _paymentCollection(gymId)
        .doc(model.paymentId)
        .set(model.toMap());
  }

  @override
  Future<void> update(
      String gymId,
      PaymentModel model,
      ) {
    return _paymentCollection(gymId)
        .doc(model.paymentId)
        .update(model.toMap());
  }

  @override
  Future<PaymentModel?> get(
      String gymId,
      String id,
      ) async {
    final document = await _paymentCollection(gymId)
        .doc(id)
        .get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return PaymentModel.fromMap(
      document.data()!,
      document.id,
    );
  }
  @override
  Future<List<PaymentModel>> getAll(
      String gymId,
      ) async {
    final snapshot = await _paymentCollection(gymId)
        .orderBy(
      'paymentDate',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => PaymentModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  @override
  Future<void> softDelete(
      String gymId,
      String id,
      ) {
    return _paymentCollection(gymId)
        .doc(id)
        .update({
      'status': EntityStatus.inactive.name,
      'updatedAt': Timestamp.now(),
    });
  }
}
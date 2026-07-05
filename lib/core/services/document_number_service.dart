import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentNumberService {
  DocumentNumberService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const _systemCollection = 'system';

  Future<String> generateNumber({
    required String gymId,
    required String documentType,
    required String prefix,
  }) async {
    final year = DateTime.now().year;

    final counterRef = _firestore
        .collection(_systemCollection)
        .doc('${gymId}_${documentType}_$year');

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);

      int lastNumber = 0;

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          lastNumber = (data['lastNumber'] as int?) ?? 0;
        }
      }

      final nextNumber = lastNumber + 1;

      transaction.set(
        counterRef,
        {
          'gymId': gymId,
          'documentType': documentType,
          'year': year,
          'lastNumber': nextNumber,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      return '$prefix-$year-${nextNumber.toString().padLeft(6, '0')}';
    });
  }
}
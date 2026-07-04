import 'package:cloud_firestore/cloud_firestore.dart';

class IdGenerator {
  IdGenerator._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static Future<String> generate({
    required String prefix,
    required String counterDocument,
  }) async {
    return _firestore.runTransaction((transaction) async {
      final ref = _firestore
          .collection('system')
          .doc(counterDocument);

      final snapshot = await transaction.get(ref);

      int nextNumber = 1;

      if (snapshot.exists) {
        nextNumber =
            ((snapshot.data()?['value'] ?? 0) as int) + 1;
      }

      transaction.set(
        ref,
        {
          'value': nextNumber,
        },
      );

      return '$prefix${nextNumber.toString().padLeft(6, '0')}';
    });
  }

  static Future<String> newGymId() {
    return generate(
      prefix: 'GYM',
      counterDocument: 'gym_counter',
    );
  }

  static Future<String> newUserId() {
    return generate(
      prefix: 'USR',
      counterDocument: 'user_counter',
    );
  }

  static Future<String> newMemberId() {
    return generate(
      prefix: 'MBR',
      counterDocument: 'member_counter',
    );
  }

  static Future<String> newTrainerId() {
    return generate(
      prefix: 'TRN',
      counterDocument: 'trainer_counter',
    );
  }

  static Future<String> newAttendanceId() {
    return generate(
      prefix: 'ATT',
      counterDocument: 'attendance_counter',
    );
  }

  static Future<String> newInvoiceId() {
    return generate(
      prefix: 'INV',
      counterDocument: 'invoice_counter',
    );
  }

  static Future<String> newPaymentId() {
    return generate(
      prefix: 'PAY',
      counterDocument: 'payment_counter',
    );
  }

  static Future<String> newExpenseId() {
    return generate(
      prefix: 'EXP',
      counterDocument: 'expense_counter',
    );
  }

  static Future<String> newProductId() {
    return generate(
      prefix: 'PRD',
      counterDocument: 'product_counter',
    );
  }
}
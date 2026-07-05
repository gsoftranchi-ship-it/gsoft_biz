import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/user_model.dart';
import '../../../../models/gym_model.dart';
import '../../../../models/member_model.dart';

class FirestoreDataSource {
  FirestoreDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _usersCollection = 'users';
  static const String _gymsCollection = 'gyms';
  static const String _membersCollection = 'members';
  static const String _systemCollection = 'system';
  static const String _memberCounterDocument = 'member_counter';

  Future<UserModel?> getUser(String uid) async {
    final snapshot =
    await _firestore.collection(_usersCollection).doc(uid).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return UserModel.fromMap(
      data,
      snapshot.id,
    );
  }
  Future<GymModel?> getGym(
      String gymId,
      ) async {
    final snapshot =
    await _firestore
        .collection(_gymsCollection)
        .doc(gymId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return GymModel.fromMap(
      data,
      snapshot.id,
    );
  }
  Future<List<MemberModel>> getMembers() async {
    final snapshot = await _firestore
        .collection(_membersCollection)
        .orderBy('name')
        .get();

    return snapshot.docs
        .map(
          (doc) => MemberModel.fromMap(
        doc.id,
        doc.data(),
      ),
    )
        .toList();
  }
  Future<void> addMember(
      MemberModel member,
      ) async {
    await _firestore
        .collection(_membersCollection)
        .doc(member.memberId)
        .set(member.toMap());
  }
  Future<String> generateNextMemberId() async {
    final counterRef = _firestore
        .collection(_systemCollection)
        .doc(_memberCounterDocument);

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
          'lastNumber': nextNumber,
        },
        SetOptions(merge: true),
      );

      return 'MEM${nextNumber.toString().padLeft(6, '0')}';
    });
  }
  Future<void> updateMember(
      MemberModel member,
      ) async {
    await _firestore
        .collection(_membersCollection)
        .doc(member.memberId)
        .update(member.toMap());
  }
  Future<void> deleteMember(
      String id,
      ) async {
    await _firestore
        .collection(_membersCollection)
        .doc(id)
        .delete();
  }
  Future<List<MemberModel>> searchMembers(
      String keyword,
      ) async {
    final members = await getMembers();

    final query = keyword.trim().toLowerCase();

    return members.where((member) {

      return member.fullName
          .toLowerCase()
          .contains(query)

          ||

          member.memberId
              .toLowerCase()
              .contains(query);

    }).toList();
  }
}
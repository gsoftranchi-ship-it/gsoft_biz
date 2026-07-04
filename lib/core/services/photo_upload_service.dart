import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PhotoUploadService {
  PhotoUploadService._();

  static final FirebaseStorage _storage =
      FirebaseStorage.instance;

  static Future<String> uploadMemberPhoto({
    required String gymId,
    required String memberId,
    required File file,
  }) async {
    final ref = _storage
        .ref()
        .child('gyms')
        .child(gymId)
        .child('members')
        .child(memberId)
        .child('profile.jpg');

    await ref.putFile(file);

    return ref.getDownloadURL();
  }

  static Future<void> deleteMemberPhoto({
    required String gymId,
    required String memberId,
  }) async {
    final ref = _storage
        .ref()
        .child('gyms')
        .child(gymId)
        .child('members')
        .child(memberId)
        .child('profile.jpg');

    await ref.delete();
  }
}
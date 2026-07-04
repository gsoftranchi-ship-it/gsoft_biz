import 'dart:io';

import '../../../../core/services/photo_upload_service.dart';

class StorageDataSource {
  const StorageDataSource();

  Future<String> uploadMemberPhoto({
    required String gymId,
    required String memberId,
    required File file,
  }) {
    return PhotoUploadService.uploadMemberPhoto(
      gymId: gymId,
      memberId: memberId,
      file: file,
    );
  }

  Future<void> deleteMemberPhoto({
    required String gymId,
    required String memberId,
  }) {
    return PhotoUploadService.deleteMemberPhoto(
      gymId: gymId,
      memberId: memberId,
    );
  }
}
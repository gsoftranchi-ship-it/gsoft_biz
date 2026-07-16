import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;


/// ===============================================
/// Upload Categories
/// ===============================================
enum UploadCategory {
  memberPhoto,
  aadhaarCard,
  panCard,
  medicalReport,
  otherDocument,
  trainerPhoto,
  officeLogo,
  productImage,
  clientDocument,
  memberSignature,
  staffSignature,
}

/// ===============================================
/// Upload Result
/// ===============================================
class UploadResult {
  final bool success;
  final String downloadUrl;
  final String fileName;
  final String message;

  const UploadResult({
    required this.success,
    required this.downloadUrl,
    required this.fileName,
    required this.message,
  });

  factory UploadResult.success({
    required String url,
    required String fileName,
  }) {
    return UploadResult(
      success: true,
      downloadUrl: url,
      fileName: fileName,
      message: '',
    );
  }

  factory UploadResult.failure(
      String message,
      ) {
    return UploadResult(
      success: false,
      downloadUrl: '',
      fileName: '',
      message: message,
    );
  }
}

/// ===============================================
/// File Upload Service
///
/// RC1 Foundation
/// No Firebase implementation yet.
/// ===============================================
class FileUploadService {
  FileUploadService._();

  static final FileUploadService instance =
  FileUploadService._();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static const int maxImageSize = 10 * 1024 * 1024;
  static const int maxDocumentSize = 20 * 1024 * 1024;

  /// Build Firebase Storage path
  String buildStoragePath({
    required String gymId,
    required String memberId,
    required UploadCategory category,
    required String extension,
  }) {
    final fileName = buildFileName(
      category: category,
      extension: extension,
    );



    switch (category) {
      case UploadCategory.memberPhoto:
      case UploadCategory.aadhaarCard:
      case UploadCategory.panCard:
      case UploadCategory.medicalReport:
      case UploadCategory.otherDocument:
        return 'gyms/$gymId/members/$memberId/$fileName';

      case UploadCategory.trainerPhoto:
        return 'gyms/$gymId/trainers/$memberId/$fileName';

      case UploadCategory.officeLogo:
        return 'gyms/$gymId/office/$fileName';

      case UploadCategory.productImage:
        return 'gyms/$gymId/products/$memberId/$fileName';

      case UploadCategory.clientDocument:
        return 'gyms/$gymId/clients/$memberId/$fileName';

      case UploadCategory.memberSignature:
        return 'gyms/$gymId/members/$memberId/signatures/$fileName';

      case UploadCategory.staffSignature:
        return 'gyms/$gymId/members/$memberId/signatures/$fileName';
    }
  }

  /// Build standard filename
  String buildFileName({
    required UploadCategory category,
    required String extension,
  }) {
    final ext = extension.replaceAll('.', '').toLowerCase();

    switch (category) {
      case UploadCategory.memberPhoto:
        return 'profile.$ext';

      case UploadCategory.aadhaarCard:
        return 'aadhaar.$ext';

      case UploadCategory.panCard:
        return 'pan.$ext';

      case UploadCategory.medicalReport:
        return 'medical_report.$ext';

      case UploadCategory.otherDocument:
        final stamp = DateTime.now()
            .millisecondsSinceEpoch;
        return 'other_$stamp.$ext';

      case UploadCategory.trainerPhoto:
        return 'trainer.$ext';

      case UploadCategory.officeLogo:
        return 'office_logo.$ext';

      case UploadCategory.productImage:
        return 'product.$ext';

      case UploadCategory.clientDocument:
        return 'client_document.$ext';

      case UploadCategory.memberSignature:
        return 'member_signature.$ext';

      case UploadCategory.staffSignature:
        return 'staff_signature.$ext';
    }
  }

  /// Get extension from filename
  String extension(String fileName) {
    return p.extension(fileName).replaceAll('.', '');
  }

  /// Supported image?
  bool isImage(String fileName) {
    final ext = extension(fileName).toLowerCase();

    return const [
      'jpg',
      'jpeg',
      'png',
      'webp',
    ].contains(ext);
  }

  /// Supported PDF?
  bool isPdf(String fileName) {
    return extension(fileName).toLowerCase() == 'pdf';
  }

  /// Supported Office Document?
  bool isDocument(String fileName) {
    final ext = extension(fileName).toLowerCase();

    return const [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
    ].contains(ext);
  }

  /// Validate supported file
  bool isSupported(String fileName) {
    return isImage(fileName) ||
        isDocument(fileName);
  }
  String? _validateRequest({
    required String gymId,
    required String memberId,
    required XFile file,
  }) {
    if (gymId.trim().isEmpty) {
      return 'Gym ID is required.';
    }

    if (memberId.trim().isEmpty) {
      return 'Member ID is required.';
    }

    if (file.name.trim().isEmpty) {
      return 'Invalid file.';
    }

    if (!isSupported(file.name)) {
      return 'Unsupported file type.';
    }

    return null;
  }

  Future<String?> _validateFileSize(XFile file) async {
    final bytes = await file.length();

    if (isImage(file.name)) {
      if (bytes > maxImageSize) {
        return 'Image exceeds 10 MB.';
      }
    } else {
      if (bytes > maxDocumentSize) {
        return 'Document exceeds 20 MB.';
      }
    }

    return null;
  }
  Future<UploadResult> uploadFile({
    required String gymId,
    required String memberId,
    required UploadCategory category,
    required XFile file,
  }) async {
    try {
      final validation = _validateRequest(
        gymId: gymId,
        memberId: memberId,
        file: file,
      );

      if (validation != null) {
        return UploadResult.failure(validation);
      }

      final sizeValidation = await _validateFileSize(file);

      if (sizeValidation != null) {
        return UploadResult.failure(sizeValidation);
      }
      final bytes = await file.length();

      if (bytes == 0) {
        return UploadResult.failure(
          'Selected file is empty.',
        );
      }

      final ext = extension(file.name);

      final storagePath = buildStoragePath(
        gymId: gymId,
        memberId: memberId,
        category: category,
        extension: ext,
      );

      final data = await file.readAsBytes();

      final ref = _storage.ref(storagePath);

      await ref.putData(
        data,
        SettableMetadata(
          contentType: _contentType(ext),
        ),
      );

      final url = await ref.getDownloadURL();

      return UploadResult.success(
        url: url,
        fileName: file.name,
      );
    } on FirebaseException catch (e) {
      return UploadResult.failure(
        e.message ?? 'Upload failed.',
      );
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      return UploadResult.failure(
        'Unexpected upload error.',
      );
    }
  }
  Future<UploadResult> uploadImage({
    required String gymId,
    required String memberId,
    required UploadCategory category,
    required XFile image,
  }) {
    return uploadFile(
      gymId: gymId,
      memberId: memberId,
      category: category,
      file: image,
    );
  }
  Future<UploadResult> uploadBytes({
    required String gymId,
    required String memberId,
    required UploadCategory category,
    required Uint8List bytes,
    required String extension,
  }) async {
    try {
      if (gymId.trim().isEmpty) {
        return UploadResult.failure(
          'Gym ID is required.',
        );
      }

      if (memberId.trim().isEmpty) {
        return UploadResult.failure(
          'Member ID is required.',
        );
      }

      if (bytes.isEmpty) {
        return UploadResult.failure(
          'No data available for upload.',
        );
      }

      final storagePath = buildStoragePath(
        gymId: gymId,
        memberId: memberId,
        category: category,
        extension: extension,
      );

      final ref = _storage.ref(storagePath);

      await ref.putData(
        bytes,
        SettableMetadata(
          contentType: _contentType(extension),
        ),
      );

      final url = await ref.getDownloadURL();


      return UploadResult.success(
        url: url,
        fileName: p.basename(storagePath),
      );
    } on FirebaseException catch (e) {
      return UploadResult.failure(
        e.message ?? 'Upload failed.',
      );
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      return UploadResult.failure(
        'Unexpected upload error.',
      );
    }
  }
  String _contentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';

      case 'png':
        return 'image/png';

      case 'webp':
        return 'image/webp';

      case 'pdf':
        return 'application/pdf';

      case 'doc':
        return 'application/msword';

      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

      case 'xls':
        return 'application/vnd.ms-excel';

      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

      case 'ppt':
        return 'application/vnd.ms-powerpoint';

      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';

      default:
        return 'application/octet-stream';
    }
  }
  Future<bool> deleteFile({
    required String downloadUrl,
  }) async {
    try {
      await _storage.refFromURL(downloadUrl).delete();
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return false;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }
  Future<String?> getDownloadUrl({
    required String storagePath,
  }) async {
    try {
      return await _storage.ref(storagePath).getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      return null;
    }
  }
  Future<UploadResult> replaceFile({
    required String gymId,
    required String memberId,
    required UploadCategory category,
    required XFile newFile,
    String? oldDownloadUrl,
  }) async {
    final result = await uploadFile(
      gymId: gymId,
      memberId: memberId,
      category: category,
      file: newFile,
    );

    if (!result.success) {
      return result;
    }

    if (oldDownloadUrl != null && oldDownloadUrl.isNotEmpty) {
      await deleteFile(
        downloadUrl: oldDownloadUrl,
      );
    }

    return result;
  }
}
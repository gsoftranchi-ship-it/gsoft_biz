import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/member_form_controller.dart';

class MemberPhotoCard extends StatefulWidget {
  const MemberPhotoCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  @override
  State<MemberPhotoCard> createState() =>
      _MemberPhotoCardState();
}

class _MemberPhotoCardState
    extends State<MemberPhotoCard> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  Future<void> _pickImage(
      ImageSource source,
      ) async {
    final image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if (image == null) return;

    setState(() {
      _selectedImage = File(image.path);
    });

    // Firebase Storage upload
    // will be implemented next.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Colors.white12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.orange,
                ),
                SizedBox(width: 8),
                Text(
                  "Member Photo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.orange,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: _selectedImage != null
                    ? Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      _pickImage(
                        ImageSource.camera,
                      );
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                    ),
                    label: const Text(
                      "Camera",
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: FilledButton.icon(
                    onPressed: () {
                      _pickImage(
                        ImageSource.gallery,
                      );
                    },
                    icon: const Icon(
                      Icons.photo_library,
                    ),
                    label: const Text(
                      "Gallery",
                    ),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
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
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Member Photo",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
              _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : null,
              child: _selectedImage == null
                  ? const Icon(
                Icons.person,
                size: 70,
                color: Colors.grey,
              )
                  : null,
            ),

            const SizedBox(height: 20),

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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ProgressPhotoCard extends StatelessWidget {
  const ProgressPhotoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Progress Photos",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        size: 48,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        size: 48,
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
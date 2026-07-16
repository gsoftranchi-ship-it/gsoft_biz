import 'package:flutter/material.dart';



class MemberProfileHeader extends StatelessWidget {
  const MemberProfileHeader({
    super.key,
    this.photoUrl,
    required this.memberName,
    required this.memberId,
    required this.isActive,
  });

  final String? photoUrl;
  final String memberName;
  final String memberId;
  final bool isActive;

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: ClipOval(
                child: photoUrl != null && photoUrl!.isNotEmpty
                    ? Image.network(
                  photoUrl!,
                  headers: const {
                    'Accept': 'image/*',
                  },
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {


                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 48),
                    );
                  },
                )

                    : Container(
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.person,
                    size: 48,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              memberName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              memberId,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
            const SizedBox(height: 12),
            Chip(
              avatar: Icon(
                isActive
                    ? Icons.check_circle
                    : Icons.cancel,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: isActive
                  ? Colors.green
                  : Colors.red,
              label: Text(
                isActive
                    ? 'Active'
                    : 'Inactive',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
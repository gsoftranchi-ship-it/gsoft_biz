import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';



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
      color: Theme.of(context).cardColor,
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
                      color: AppColors.surface,
                      child: const Icon(Icons.person, size: 48),
                    );
                  },
                )

                    : Container(
                  color: AppColors.surface,
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
                color: AppColors.onDark,
                size: 18,
              ),
              backgroundColor: isActive
                  ? AppColors.success
                  : AppColors.danger,
              label: Text(
                isActive
                    ? 'Active'
                    : 'Inactive',
                style: const TextStyle(
                  color: AppColors.onDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
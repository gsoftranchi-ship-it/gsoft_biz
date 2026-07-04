import 'package:flutter/material.dart';

class MemberInformationCard extends StatelessWidget {
  const MemberInformationCard({
    super.key,
    required this.mobile,
    required this.email,
    required this.gender,
    required this.age,
  });

  final String mobile;
  final String email;
  final String gender;
  final int age;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),
            _infoRow(Icons.phone, "Mobile", mobile),
            _infoRow(Icons.email, "Email", email),
            _infoRow(Icons.people, "Gender", gender),
            _infoRow(Icons.cake, "Age", "$age Years"),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title),
          ),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/routes/route_names.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        "Settings",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    return SafeArea(
      child: ListView(

        padding: const EdgeInsets.all(16),

        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.business),
              ),
              title: const Text(
                "Gym Profile",
              ),
              subtitle: const Text(
                "Manage gym information, logo and business details",
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.gymProfile,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
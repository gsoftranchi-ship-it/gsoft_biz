import 'package:flutter/material.dart';

import '../../core/routes/route_names.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
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
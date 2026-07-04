import 'package:flutter/material.dart';

class MemberDetailsPage extends StatelessWidget {
  const MemberDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Member Details'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Attendance'),
              Tab(text: 'Payments'),
              Tab(text: 'Workout'),
              Tab(text: 'Diet'),
              Tab(text: 'Progress'),
              Tab(text: 'Medical'),
              Tab(text: 'Documents'),
              Tab(text: 'Renewals'),
              Tab(text: 'Reports'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ComingSoon('Profile'),
            _ComingSoon('Attendance'),
            _ComingSoon('Payments'),
            _ComingSoon('Workout'),
            _ComingSoon('Diet'),
            _ComingSoon('Progress'),
            _ComingSoon('Medical'),
            _ComingSoon('Documents'),
            _ComingSoon('Renewals'),
            _ComingSoon('Reports'),
          ],
        ),
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.construction,
                size: 56,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '$title module will be implemented in upcoming sprints.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
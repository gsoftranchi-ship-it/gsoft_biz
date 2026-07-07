import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/member_model.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() =>
      _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final _searchController = TextEditingController();

  MemberModel? _selectedMember;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider =
    context.watch<AttendanceProvider>();

    final memberProvider =
    context.watch<MemberProvider>();

    if (attendanceProvider.loading ||
        memberProvider.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (attendanceProvider.error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendance Check-In',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              attendanceProvider.error!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final members = memberProvider.members;

    final query = _searchController.text
        .trim()
        .toLowerCase();

    final filteredMembers = members.where((member) {
      if (query.isEmpty) {
        return true;
      }

      return member.fullName
          .toLowerCase()
          .contains(query) ||
          member.memberId
              .toLowerCase()
              .contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Check-In'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _markAttendance,
        icon: const Icon(Icons.check),
        label: const Text('Check In'),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by Member ID or Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          Expanded(
            child: filteredMembers.isEmpty
                ? const Center(
              child: Text(
                'No members found.',
              ),
            )
                : ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member =
                filteredMembers[index];

                final selected =
                    _selectedMember?.memberId ==
                        member.memberId;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        member.fullName.isEmpty
                            ? '?'
                            : member.fullName[0],
                      ),
                    ),
                    title: Text(
                      member.fullName,
                    ),
                    subtitle: Text(
                      member.memberId,
                    ),
                    trailing: selected
                        ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedMember = member;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _markAttendance() async {
    if (_selectedMember == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a member.'),
        ),
      );
      return;
    }

    // TODO(Sprint 18B):
    // Prevent duplicate attendance for the same member
    // on the same day.

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_selectedMember!.fullName} checked in successfully.',
        ),
      ),
    );

    // TODO:
    // Create AttendanceModel
    // Call attendanceProvider.markAttendance(...)
    // Refresh attendance list
  }

}




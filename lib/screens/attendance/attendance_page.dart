import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';
import '../../models/attendance_model.dart';
import '../../models/member_model.dart';
import '../../providers/auth_provider.dart';



class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final attendanceProvider =
    context.watch<AttendanceProvider>();
    final authProvider = context.read<AuthProvider>();

    final currentUser = authProvider.currentUser;

    final gymId = currentUser?.tenantInfo.gymId ?? "";

    final currentUserId = currentUser?.id ?? "";

    final memberProvider =
    context.watch<MemberProvider>();

    if (attendanceProvider.loading ||
        memberProvider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }



    if (attendanceProvider.error != null) {
      return Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              attendanceProvider.error!,
              textAlign: TextAlign.center,
            ),
          ),
      );
    }

    final members = memberProvider.activeMembers;
    final attendance = attendanceProvider.attendance;

    final today = DateTime.now();

    final todaysAttendance =
    attendance.where((record) {

      final date = record.attendanceDate;

      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;

    }).toList();

    final presentToday = todaysAttendance
        .where((e) => e.isPresent)
        .length;

    final absentToday =
        members - presentToday;

    final attendancePercent =
    members == 0
        ? 0.0
        : (presentToday / members) * 100;

    return SafeArea(
      child: Column(
          children: [

      Padding(
      padding: const EdgeInsets.fromLTRB(16,16,16,8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Attendance",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
          ),
        ],
      ),
    ),



    Expanded(
    child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Today's Attendance",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _summary(
                  "Present",
                  presentToday.toString(),
                  Colors.green,
                  Icons.check_circle,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Absent",
                  absentToday.toString(),
                  Colors.red,
                  Icons.cancel,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summary(
                  "Attendance %",
                  "${attendancePercent.toStringAsFixed(1)}%",
                  Colors.blue,
                  Icons.pie_chart,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summary(
                  "Members",
                  members.toString(),
                  Colors.orange,
                  Icons.groups,
                ),
              ),

            ],
          ),

          const SizedBox(height: 25),

          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search Member",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Today's Members",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...memberProvider.members
              .where((member) => member.isActive)
              .map((member) {

            final todayRecord = todaysAttendance.cast<AttendanceModel?>().firstWhere(
                  (record) => record?.memberId == member.memberId,
              orElse: () => null,
            );

            final checkInTime = todayRecord?.checkInTime == null
                ? "--"
                : TimeOfDay.fromDateTime(
              todayRecord!.checkInTime!,
            ).format(context);

            return _member(
              context,
              member,
              todayRecord,
              checkInTime,
              gymId,
              currentUserId,
            );
          }),

          const SizedBox(height: 80),
        ],
    ),
    ),

          ],
      ),
    );
  }

  Widget _summary(
      String title,
      String value,
      Color color,
      IconData icon,
      ) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          children: [

            CircleAvatar(
              backgroundColor:
              color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(title),

          ],
        ),
      ),
    );
  }

  Widget _member(
      BuildContext context,
      MemberModel member,
      AttendanceModel? attendance,
      String time,
      String gymId,
      String currentUserId,
      ) {
    final isPresent = attendance != null;
    final memberName = member.fullName;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            memberName.isNotEmpty ? memberName[0] : "?",
          ),
        ),

        title: Text(memberName),

        subtitle: Text(
          isPresent
              ? "Check In : $time"
              : "Not Checked In",
        ),

        trailing: attendance == null
            ? FilledButton(
          onPressed: () async {
            try {
              await context.read<AttendanceProvider>().markAttendanceForMember(
                member: member,
                currentUserId: currentUserId,
                gymId: gymId,
              );

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${member.fullName} checked in successfully.",
                  ),
                ),
              );
            } catch (e) {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
          child: const Text("Check In"),
        )
            : attendance.checkOutTime == null
            ? FilledButton(
          onPressed: () async {
            try {
              await context
                  .read<AttendanceProvider>()
                  .checkOutAttendance(
                attendance: attendance,
                gymId: gymId,
                currentUserId: currentUserId,
              );

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${member.fullName} checked out successfully.",
                  ),
                ),
              );
            } catch (e) {
              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
          child: const Text("Check Out"),
        )
            : const Chip(
          avatar: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 18,
          ),
          label: Text("Completed"),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';

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

    final memberProvider =
    context.watch<MemberProvider>();

    if (attendanceProvider.loading ||
        memberProvider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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

    final presentToday =
        todaysAttendance
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


    Padding(
    padding: const EdgeInsets.symmetric(horizontal:16),
    child: Align(
    alignment: Alignment.centerRight,
    child: FilledButton.icon(
    onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text("Attendance Marked Successfully"),
    ),
    );
    },
    icon: const Icon(Icons.check),
    label: const Text("Check In"),
    ),
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

          if (todaysAttendance.isEmpty)

            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    "No attendance recorded today.",
                  ),
                ),
              ),
            )

          else
            ...todaysAttendance.map((record) {

              final member =
              memberProvider.members.cast<dynamic>().firstWhere(
                    (m) => m?.memberId == record.memberId,
                orElse: () => null,
              );

              final memberName =
                  member?.fullName ?? record.memberId;

              final checkInTime =
              record.checkInTime == null
                  ? '--'
                  : TimeOfDay.fromDateTime(
                record.checkInTime!,
              ).format(context);

              return _member(
                memberName,
                checkInTime,
                record.isPresent,
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
      String name,
      String time,
      bool present,
      ) {

    return Card(

      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading: CircleAvatar(
          child: Text(name[0]),
        ),

        title: Text(name),

        subtitle: Text(
          present
              ? "Check In : $time"
              : "Absent",
        ),

        trailing: present

            ? FilledButton(
          onPressed: () {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$name Checked Out",
                ),
              ),
            );

          },
          child: const Text("Check Out"),
        )

            : FilledButton(
          onPressed: () {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$name Checked In",
                ),
              ),
            );

          },
          child: const Text("Check In"),
        ),
      ),
    );
  }
}
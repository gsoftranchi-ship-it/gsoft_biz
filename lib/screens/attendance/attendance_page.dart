import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';
import '../../models/attendance_model.dart';
import '../../models/member_model.dart';
import '../../providers/auth_provider.dart';
import '../../core/widgets/erp_page_header.dart';
import '../../core/widgets/erp_loading.dart';
import '../../core/widgets/erp_search_bar.dart';
import '../../core/widgets/erp_card.dart';
import '../../core/widgets/erp_status_chip.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/erp_empty_state.dart';


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
      return const ERPLoading(
        message: 'Loading attendance...',
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

            ERPPageHeader(
              title: 'Attendance',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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

          Text(
            "Today's Attendance",
            style: AppTypography.pageTitle,
          ),

          const SizedBox(height: AppSpacing.lg),

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

              const SizedBox(width: AppSpacing.md),

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

          const SizedBox(height: AppSpacing.xl),

          ERPSearchBar(
            controller: searchController,
            hint: 'Search Member',
            onChanged: (_) {
              setState(() {});
            },
            onClear: () {
              setState(() {});
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          const Text(
            "Today's Members",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          if (memberProvider.members
              .where((member) {
            if (!member.isActive) return false;

            final search =
            searchController.text.trim().toLowerCase();

            if (search.isEmpty) return true;

            return member.fullName.toLowerCase().contains(search) ||
                member.memberId.toLowerCase().contains(search);
          })
              .isEmpty)
            const ERPEmptyState(
              icon: Icons.people_outline,
              title: 'No Members Found',
              message: 'No active members match your search.',
            )
          else
            ...memberProvider.members
                .where((member) {
              if (!member.isActive) return false;

              final search =
              searchController.text.trim().toLowerCase();

              if (search.isEmpty) return true;

              return member.fullName.toLowerCase().contains(search) ||
                  member.memberId.toLowerCase().contains(search);
            })
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

    return ERPCard(

      child: Padding(

        padding: const EdgeInsets.all(AppSpacing.lg),

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

            const SizedBox(height: AppSpacing.md),

            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              title,
              style: AppTypography.bodySmall,
            ),

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

    return ERPCard(

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            memberName.isNotEmpty ? memberName[0] : "?",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          memberName,
          style: AppTypography.cardTitle,
        ),

        subtitle: Text(
          isPresent
              ? "Check In : $time"
              : "Not Checked In",
          style: AppTypography.bodySmall,
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
            : const ERPStatusChip(
          status: ERPStatus.completed,
        )
      ),
    );
  }
}
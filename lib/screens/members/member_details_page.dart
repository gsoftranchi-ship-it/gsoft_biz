import 'package:provider/provider.dart';
import '../../providers/attendance_provider.dart';
import 'package:flutter/material.dart';
import 'widgets/member_profile_header.dart';
import 'widgets/member_information_card.dart';
import 'widgets/membership_card.dart';
import 'widgets/member_quick_actions.dart';
import 'widgets/member_attendance_card.dart';
import 'widgets/attendance_history_card.dart';
import 'widgets/attendance_calendar_card.dart';
import 'widgets/member_payment_summary_card.dart';
import 'widgets/payment_history_card.dart';
import 'widgets/payment_quick_actions.dart';
import 'widgets/workout_summary_card.dart';
import 'widgets/workout_schedule_card.dart';
import 'widgets/workout_progress_card.dart';
import 'widgets/diet_summary_card.dart';
import 'widgets/daily_meal_plan_card.dart';
import 'widgets/health_progress_card.dart';
import 'widgets/progress_chart_card.dart';
import 'widgets/progress_photo_card.dart';
import 'widgets/medical_summary_card.dart';
import 'widgets/medical_history_card.dart';
import 'widgets/medical_alerts_card.dart';
import 'widgets/documents_summary_card.dart';
import 'widgets/member_documents_card.dart';
import 'widgets/document_actions_card.dart';
import 'widgets/renewal_summary_card.dart';
import 'widgets/renewal_history_card.dart';
import 'widgets/renewal_actions_card.dart';
import 'widgets/member_reports_summary_card.dart';
import 'widgets/member_reports_list_card.dart';
import 'widgets/member_reports_actions_card.dart';
import '../../models/member_model.dart';
import 'package:intl/intl.dart';
import 'add_member/add_member_page.dart';

class MemberDetailsPage extends StatefulWidget {
  final MemberModel member;

  const MemberDetailsPage({
    super.key,
    required this.member,
  });

  @override
  State<MemberDetailsPage> createState() =>
      _MemberDetailsPageState();
}

class _MemberDetailsPageState
    extends State<MemberDetailsPage> {

  @override
  Widget build(BuildContext context) {
    final attendanceProvider =
    context.watch<AttendanceProvider>();

    final memberAttendance =
    attendanceProvider.attendance
        .where(
          (e) =>
      e.memberId ==
          widget.member.memberId,
    )
        .toList();

    memberAttendance.sort(
          (a, b) =>
          b.attendanceDate.compareTo(
            a.attendanceDate,
          ),
    );

    final presentDays =
        memberAttendance
            .where((e) => e.isPresent)
            .length;

    final absentDays =
        memberAttendance
            .where((e) => !e.isPresent)
            .length;

    final totalDays =
        memberAttendance.length;

    final lastCheckIn =
    memberAttendance.isEmpty ||
        memberAttendance.first.checkInTime == null
        ? "--"
        : TimeOfDay.fromDateTime(
      memberAttendance.first.checkInTime!,
    ).format(context);

    return DefaultTabController(
      length: 10,
      child: Scaffold(
        backgroundColor: const Color(0xFF111827),
        appBar: AppBar(
          title: const Text('Member Details'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
                top: 8,
                bottom: 8,
              ),
              child: FilledButton.icon(
                onPressed: () async {
                  final navigator = Navigator.of(context);

                  final updated = await navigator.push<bool>(
                    MaterialPageRoute(
                      builder: (_) => AddMemberPage(
                        member: widget.member,
                      ),
                    ),
                  );

                  if (!mounted) return;

                  if (updated == true) {
                    navigator.pop(true);
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                ),
                label: const Text('Edit'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          ],
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
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MemberProfileHeader(
                    photoUrl: widget.member.photoUrl,
                    memberName: widget.member.fullName,
                    memberId: widget.member.memberId,
                    isActive: widget.member.isActive,
                  ),
                  MemberInformationCard(
                    mobile: widget.member.phone,
                    email: widget.member.email,
                    gender: widget.member.gender,
                    age: widget.member.age,
                  ),
                  MembershipCard(
                    plan: widget.member.membershipPlan,

                    joinDate: DateFormat(
                      'dd MMM yyyy',
                    ).format(widget.member.joiningDate),

                    expiryDate: widget.member.membershipExpiryDate == null
                        ? "--"
                        : DateFormat(
                      'dd MMM yyyy',
                    ).format(
                      widget.member.membershipExpiryDate!,
                    ),

                    remainingDays: widget.member.membershipExpiryDate == null
                        ? 0
                        : widget.member.membershipExpiryDate!
                        .difference(DateTime.now())
                        .inDays,
                  ),
                  MemberQuickActions(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MemberAttendanceCard(
                    presentDays: presentDays,
                    absentDays: absentDays,
                    totalDays: totalDays,
                    lastCheckIn: lastCheckIn,
                  ),
                  AttendanceHistoryCard(
                    attendance: memberAttendance,
                  ),
                  AttendanceCalendarCard(
                    attendance: memberAttendance,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MemberPaymentSummaryCard(
                    totalFee: widget.member.totalAmount,
                    paidAmount: widget.member.paidAmount,
                    dueAmount: widget.member.dueAmount,

                    lastPayment: "--",

                    nextDueDate: widget.member.nextDueDate == null
                        ? "--"
                        : DateFormat(
                      'dd MMM yyyy',
                    ).format(widget.member.nextDueDate!),
                  ),
                  PaymentHistoryCard(),
                  PaymentQuickActions(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  WorkoutSummaryCard(
                    trainer: widget.member.assignedTrainer,
                    program: widget.member.fitnessGoal,
                    week: 4,
                    completed: 82,
                  ),
                  WorkoutScheduleCard(),
                  WorkoutProgressCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children:  [
                  DietSummaryCard(
                    goal: widget.member.fitnessGoal,
                    calories: 0,
                    meals: 0,
                    trainer: widget.member.assignedTrainer,
                  ),
                  DailyMealPlanCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  HealthProgressCard(
                    currentWeight: widget.member.weight,

                    targetWeight: widget.member.weight,

                    currentBMI: widget.member.bmi,

                    targetBMI: widget.member.bmi,
                    bodyFat: 0.0,
                  ),
                  ProgressChartCard(),
                  ProgressPhotoCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MedicalSummaryCard(
                    bloodGroup: widget.member.bloodGroup,

                    allergies: widget.member.allergies.isEmpty
                        ? 0
                        : 1,

                    conditions: widget.member.medicalConditions.isEmpty
                        ? 0
                        : 1,

                    fitForWorkout: true,
                  ),
                  MedicalHistoryCard(),
                  MedicalAlertsCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  DocumentsSummaryCard(
                    profilePhoto: true,
                    aadhaar: widget.member.aadhaarNumber.isNotEmpty,

                    pan: widget.member.panNumber.isNotEmpty,
                    medicalReport: false,
                    otherDocuments: 2,
                  ),
                  MemberDocumentsCard(),
                  DocumentActionsCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  RenewalSummaryCard(
                    currentPlan: widget.member.membershipPlan,

                    expiryDate: widget.member.membershipExpiryDate == null
                        ? "--"
                        : DateFormat(
                      'dd MMM yyyy',
                    ).format(
                      widget.member.membershipExpiryDate!,
                    ),

                    remainingDays: widget.member.membershipExpiryDate == null
                        ? 0
                        : widget.member.membershipExpiryDate!
                        .difference(DateTime.now())
                        .inDays,

                    status: widget.member.membershipStatus,

                  ),
                  RenewalHistoryCard(),
                  RenewalActionsCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MemberReportsSummaryCard(
                    attendance: 128,
                    payments: 12,
                    workouts: 84,
                    progress: 9,
                  ),
                  MemberReportsListCard(),
                  MemberReportsActionsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
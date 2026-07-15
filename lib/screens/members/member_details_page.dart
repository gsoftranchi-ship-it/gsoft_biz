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
                    plan: "Gold Membership",
                    joinDate: "01 Jul 2026",
                    expiryDate: "31 Dec 2026",
                    remainingDays: 180,
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
                    totalFee: 12000,
                    paidAmount: 9000,
                    dueAmount: 3000,
                    lastPayment: "05 Jul 2026",
                    nextDueDate: "05 Aug 2026",
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
                    trainer: "Rahul Singh",
                    program: "Muscle Gain",
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
                    goal: "Muscle Gain",
                    calories: 2800,
                    meals: 5,
                    trainer: "Rahul Singh",
                  ),
                  DailyMealPlanCard(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  HealthProgressCard(
                    currentWeight: 74.5,
                    targetWeight: 70.0,
                    currentBMI: 24.2,
                    targetBMI: 22.0,
                    bodyFat: 18.5,
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
                    bloodGroup: "O+",
                    allergies: 0,
                    conditions: 0,
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
                    aadhaar: true,
                    pan: true,
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
                    currentPlan: "Gold Membership",
                    expiryDate: "31 Dec 2026",
                    remainingDays: 180,
                    status: "Active",
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
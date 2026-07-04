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
            SingleChildScrollView(
              child: Column(
                children: [
                  MemberProfileHeader(
                    memberName: "Demo Member",
                    memberId: "MBR000001",
                    isActive: true,
                  ),
                  MemberInformationCard(
                    mobile: "9876543210",
                    email: "member@gsoft.com",
                    gender: "Male",
                    age: 25,
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
                    presentDays: 22,
                    absentDays: 3,
                    totalDays: 25,
                    lastCheckIn: "Today 07:15 AM",
                  ),
                  AttendanceHistoryCard(),
                  AttendanceCalendarCard(),
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
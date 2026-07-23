import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/erp_card.dart';
import 'package:provider/provider.dart';
import '../../../models/gym_model.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../providers/member_provider.dart';
import '../../../providers/attendance_provider.dart';
import '../../../providers/invoice_provider.dart';


class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  String get currentDate {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    final now = DateTime.now();

    return "${now.day.toString().padLeft(2, '0')} "
        "${months[now.month - 1]} "
        "${now.year}";
  }
  String get currentTime {
    final now = DateTime.now();

    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }
  Widget _overviewItem(
      IconData icon,
      Color color,
      String value,
      String label,
      ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTypography.cardTitle.copyWith(
            fontSize: 22,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mobile = width < 500;

    final dashboardProvider = context.watch<DashboardProvider>();
    final memberProvider = context.watch<MemberProvider>();

    final attendanceProvider =
    context.watch<AttendanceProvider>();

    final invoiceProvider =
    context.watch<InvoiceProvider>();

    final GymModel? gym = dashboardProvider.gym;

    final gymName = gym?.gymName ?? "";

    final ownerName = gym?.ownerName ?? "";

    final logoUrl = gym?.logoUrl;

    final avatarRadius = mobile ? 34.0 : 42.0;
    final titleSize = mobile ? 18.0 : 24.0;

    return ERPCard(
      padding: EdgeInsets.all(
          mobile ? AppSpacing.lg : AppSpacing.xl,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //---------------- TOP ----------------

          Row(
            children: [

              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.scaffoldDark,
                child: ClipOval(
                  child: logoUrl != null && logoUrl.isNotEmpty
                      ? Image.network(
                    logoUrl,
                    width: avatarRadius * 4,
                    height: avatarRadius * 4,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/images/logo.png',
                    width: avatarRadius * 4,
                    height: avatarRadius * 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      greeting,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      gymName.isEmpty
                          ? "Power House Gym"
                          : gymName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize,
                      ),
                    ),
                    const SizedBox(height: 4),


                    if (ownerName.isNotEmpty)
                      Text(
                        "Owner : $ownerName",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.warning,
                    borderRadius:
                  BorderRadius.circular(14),
                ),
                child: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Notifications will be available in a future update.',
                        ),
                      ),
                    );
                  },
                  tooltip: "Notifications",
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: AppColors.success,
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  currentDate,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(
                Icons.access_time_rounded,
                size: 15,
                color: AppColors.success,
              ),

              const SizedBox(width: 6),

              Text(
                currentTime,
                style: const TextStyle(
                  color: AppColors.success,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

    ERPCard(
    padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.md,
    ),
    margin: EdgeInsets.zero,
    child:
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Business Overview",
                  style: AppTypography.sectionTitle,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _overviewItem(
                        Icons.people_alt_outlined,
                        AppColors.info,
                        memberProvider.totalMembers.toString(),
                        "Members",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.fact_check_outlined,
                        AppColors.success,
                        attendanceProvider.todayAttendance.toString(),
                        "Attendance",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.currency_rupee,
                        AppColors.success,
                        '₹${invoiceProvider.totalSales.toStringAsFixed(0)}',
                        "Collection",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.warning_amber_rounded,
                        AppColors.warning,
                        '₹${invoiceProvider.totalOutstanding.toStringAsFixed(0)}',
                        "Due",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
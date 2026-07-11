import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../models/gym_model.dart';
import '../../../providers/dashboard_provider.dart';

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
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
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

    final GymModel? gym = dashboardProvider.gym;

    final gymName = gym?.gymName ?? "";

    final ownerName = gym?.ownerName ?? "";

    final logoUrl = gym?.logoUrl;

    final avatarRadius = mobile ? 24.0 : 30.0;
    final titleSize = mobile ? 18.0 : 24.0;

    return Container(
      padding: EdgeInsets.all(mobile ? 16 : 22),

      decoration: BoxDecoration(
        color: const Color(0xFF081A33),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: Colors.white.withValues(alpha: .05),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .25),
            blurRadius: 20,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //---------------- TOP ----------------

          Row(
            children: [

              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.cardDark,
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
                    width: avatarRadius * 2,
                    height: avatarRadius * 2,
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
                        color: AppColors.textSecondary,
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
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),


                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: IconButton(
                    onPressed: null,
                    tooltip: "Coming Soon",
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

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Business Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _overviewItem(
                        Icons.people_alt_outlined,
                        AppColors.info,
                        "--",
                        "Members",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.fact_check_outlined,
                        AppColors.success,
                        "--",
                        "Attendance",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.currency_rupee,
                        AppColors.primary,
                        "--",
                        "Collection",
                      ),
                    ),
                    Expanded(
                      child: _overviewItem(
                        Icons.warning_amber_rounded,
                        AppColors.warning,
                        "--",
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
import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';
import '../../../core/constants/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mobile = width < 500;

    final avatarRadius = mobile ? 18.0 : 22.0;
    final titleSize = mobile ? 18.0 : 24.0;
    final revenueSize = mobile ? 24.0 : 32.0;
    final trendSize = mobile ? 48.0 : 70.0;
    return Container(
      padding: EdgeInsets.all(mobile ? 16 : 22),

      decoration: BoxDecoration(
        color: const Color(0xff1A1D22),

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
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Welcome To 👋",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    Text(
                      AppConfig.appName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize,
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            AppConfig.tagline,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),

          SizedBox(height: mobile ? 18 : 25),

          //---------------- REVENUE ----------------

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFF9800),
                  Color(0xffFB8C00),
                ],
              ),

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: mobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Today's Revenue",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "₹18,450",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: revenueSize,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "+18% This Month",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Center(
                      child: Icon(
                        Icons.trending_up_rounded,
                        size: trendSize,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
                : Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Today's Revenue",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "₹18,450",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: revenueSize,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                          BorderRadius.circular(
                              20),
                        ),

                        child: const Text(
                          "+18% This Month",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.trending_up_rounded,
                  color: Colors.white,
                  size: trendSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
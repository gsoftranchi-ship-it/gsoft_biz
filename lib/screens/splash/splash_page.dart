import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/config/app_config.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        RouteNames.login,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: AppColors.primary,
                size: 60,
              ),
            )
                .animate()
                .scale(duration: 700.ms)
                .fade(),

            const SizedBox(height: 30),

            Text(
              AppConfig.appName,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ).animate().fade().slideY(),

            const SizedBox(height: 12),

            Text(
              AppConfig.tagline,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ).animate().fade(delay: 400.ms),

            const SizedBox(height: 8),

            Text(
              AppConfig.city,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ).animate().fade(delay: 600.ms),

            const SizedBox(height: 60),

            const CircularProgressIndicator()
                .animate(onPlay: (c) => c.repeat())
                .rotate(),
          ],
        ),
      ),
    );
  }
}
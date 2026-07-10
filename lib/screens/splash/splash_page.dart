import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/dashboard_surface.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff071B33).withValues(alpha: .70),
              ),
              child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            )
                .animate()
                .scale(
              duration: 700.ms,
              curve: Curves.easeOutBack,
            )
                .fade(),

            const SizedBox(height: 30),

            const Text(
              "GYM ERP",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ).animate().fade().slideY(),

            const SizedBox(height: 10),

            const Text(
              "Stronger Today.\nStronger Tomorrow.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fade(delay: 300.ms),

            const SizedBox(height: 8),

            const Text(
              "Enterprise Edition",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ).animate().fade(delay: 500.ms),

            const SizedBox(height: 60),

            const CircularProgressIndicator(
              strokeWidth: 3,
            )
                .animate(onPlay: (c) => c.repeat())
                .rotate(),

            const SizedBox(height: 18),

            const Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white60,
                letterSpacing: 1,
              ),
            ),
          ],


        ),
              ),
            ),
        ),
    );
  }
}
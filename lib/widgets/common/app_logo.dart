import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showTitle;
  final bool showTagline;

  const AppLogo({
    super.key,
    this.size = 90,
    this.showTitle = true,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: size,
          width: size,
          fit: BoxFit.contain,
        ),

        if (showTitle) ...[
          const SizedBox(height: 16),
          Text(
            AppConfig.appName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ],

        if (showTagline) ...[
          const SizedBox(height: 6),
          Text(
            AppConfig.tagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ],
    );
  }
}
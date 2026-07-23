import 'package:flutter/material.dart';

class WorkspaceBackground extends StatelessWidget {
  final Widget child;

  const WorkspaceBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFF081A33),
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background/dashboard_surface.png',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: child,
    );
  }
}
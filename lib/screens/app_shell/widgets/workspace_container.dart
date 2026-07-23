import 'package:flutter/material.dart';

class WorkspaceContainer extends StatelessWidget {
  final Widget child;

  const WorkspaceContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        const DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF081A33),
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background/dashboard_surface.png',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),

        Container(
          color: Colors.black.withValues(alpha: 0.20),
        ),

        SafeArea(
          child: child,
        ),
      ],
    );
  }
}
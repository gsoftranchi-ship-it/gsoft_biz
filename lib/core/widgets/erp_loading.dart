import 'package:flutter/material.dart';

class ERPLoading extends StatelessWidget {
  final String? message;
  final double size;
  final EdgeInsetsGeometry padding;

  const ERPLoading({
    super.key,
    this.message,
    this.size = 36,
    this.padding = const EdgeInsets.all(32),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: const CircularProgressIndicator(),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
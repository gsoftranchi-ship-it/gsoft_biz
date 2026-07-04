import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String title;

  const EmptyWidget({
    super.key,
    this.title = "No Data Found",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_rounded,
            size: 70,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(title),
        ],
      ),
    );
  }
}
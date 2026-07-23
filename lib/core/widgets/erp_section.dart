import 'package:flutter/material.dart';

import 'erp_card.dart';
import 'erp_page_header.dart';

class ERPSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const ERPSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return ERPCard(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ERPPageHeader(
            title: title,
            subtitle: subtitle,
            trailing: trailing,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
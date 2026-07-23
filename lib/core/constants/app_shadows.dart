import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  /// Flat components
  static const List<BoxShadow> none = [];

  /// Small cards
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  /// Standard ERP cards
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  /// Dialogs & elevated panels
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x22000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  /// Hover effect
  static const List<BoxShadow> hover = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];
}
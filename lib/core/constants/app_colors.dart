import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //==============================================================
  // Semantic Color System (RC1.1)
  // These are framework colors. Existing colors remain untouched
  // for backward compatibility during migration.
  //==============================================================

  // Workspace
  static const Color workspaceBackground = Color(0xFF081A33);
  static const Color workspaceOverlay = Colors.transparent;

  // Surfaces
  static const Color surfaceDark = Color(0xFF20252B);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surface = Color(0xffF5F7FA);


  // Content (Dark Surface)
  static const Color onDark = Colors.white;
  static const Color onDarkSecondary = Color(0xFFB0BEC5);

  // Content (Light Surface)
  static const Color onLight = Color(0xFF1F2937);
  static const Color onLightSecondary = Color(0xFF6B7280);

  // Outline
  static const Color outline = Color(0xFFE5E7EB);
  static const Color outlineVariant = Color(0xFFECEFF3);

  // Disabled
  static const Color disabled = Color(0xFF9CA3AF);

  // Brand
  static const Color primary = Color(0xffFF9800);
  static const Color secondary = Color(0xffFFC107);


  // Dark Navigation
  static const Color scaffoldDark = Color(0xFF081A33);


  // Main Workspace
  static const Color scaffoldLight = Colors.transparent;


  // Cards
  static const Color cardLight = Color(0xFF313842);
  static const Color cardDark = surfaceDark;
  static const Color cardBackground = surfaceDark;

  // Borders
  static const Color border = Color(0x9886C8FF);
  static const Color cardBorder = Color(0x14FFFFFF);
  static const Color cardBorderHover = Color(0x40FF9800);


  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xffB0BEC5);
  static const Color textDisabled = disabled;

  // Status
  static const Color success = Color(0xff22C55E);
  static const Color warning = Color(0xffF59E0B);
  static const Color danger = Color(0xffEF4444);
  static const Color info = Color(0xff3B82F6);

  // Divider
  static const Color divider = Color(0xffECEFF3);

  // Shadow
  static const Color shadow = Color(0x1F3B82F6);
  static const Color cardShadow =  shadow;
  static const Color cardShadowHover = Color(0x403B82F6);

  // Icon
  static const Color iconPrimary = Colors.white;
  static const Color iconSecondary = Color(0xFFB0BEC5);

  // Input
  static const Color inputFill = surfaceDark;
  static const Color inputBorder = border;
  static const Color inputFocusBorder = primary;

  //==============================================================
  // Interaction States (Design System RC1)
  //==============================================================

  /// Mouse hover on clickable cards, list items, tiles, etc.
  static const Color hover = Color(0x14FFFFFF);

  /// Selected navigation/card state
  static const Color selected = Color(0x26FF9800);

  /// Keyboard / accessibility focus
  static const Color focus = primary;

  /// Scrollbar
  static const Color scrollbarThumb = Color(0xFF4B5563);
  static const Color scrollbarThumbHover = Color(0xFF6B7280);
  static const Color scrollbarTrack = Colors.transparent;

  /// Overlay
  static const Color overlayLight = Color(0x14000000);
  static const Color overlayDark = Color(0x66000000);

  // Grey
  static const Color grey = Colors.grey;

  // Navigation
  static const Color navBackground = scaffoldDark;
  static const Color navItem = onDarkSecondary;
  static const Color navItemHover = hover;
  static const Color navItemSelected = selected;
  static const Color navItemActive = primary;

  // Header
  static const Color headerBackground = Colors.transparent;
  static const Color headerTitle = textPrimary;
  static const Color headerSubtitle = textSecondary;

  // Tables
  static const Color tableHeader = surfaceDark;
  static const Color tableRow = cardDark;
  static const Color tableAlternateRow = cardLight;
  static const Color tableBorder = border;
  static const Color tableHover = hover;
  // Dialog
  static const Color dialogBackground = cardDark;
  static const Color dialogBarrier = overlayDark;
  // Status Backgrounds
  static const Color successBackground = Color(0x1A22C55E);
  static const Color warningBackground = Color(0x1AF59E0B);
  static const Color dangerBackground = Color(0x1AEF4444);
  static const Color infoBackground = Color(0x1A3B82F6);


}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: GoogleFonts.poppins().fontFamily,

    scaffoldBackgroundColor: Colors.transparent,

    primaryColor: AppColors.primary,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: Colors.transparent,
      error: AppColors.danger,
    ),

    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(
          color: AppColors.border,
          width: 1,
        ),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.cardDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF20252B),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(
        color: AppColors.onDark,
      ),
    ),

    dataTableTheme: const DataTableThemeData(
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.onDark,
      ),
      dataTextStyle: TextStyle(
        color: AppColors.onDark,
      ),
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: .8,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.workspaceOverlay,

      floatingLabelBehavior: FloatingLabelBehavior.always,

      labelStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w500,
      ),

      floatingLabelStyle: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
      ),

      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
      ),

      prefixIconColor: AppColors.onDarkSecondary,
      suffixIconColor: AppColors.onDarkSecondary,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: .20),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(
          color: AppColors.danger,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(
          color: AppColors.danger,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      side: const BorderSide(color: AppColors.border),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.onDarkSecondary;
      }),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.onDarkSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 0.35);
        }
        return AppColors.divider;
      }),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      textStyle: const TextStyle(
        color: AppColors.onDark,
        fontWeight: FontWeight.w500,
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.divider,
      circularTrackColor: AppColors.divider,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onDark,
        side: const BorderSide(
          color: AppColors.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.workspaceOverlay,
      selectedColor: AppColors.primary,
      disabledColor: AppColors.divider,
      deleteIconColor: AppColors.onDarkSecondary,
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      labelStyle: const TextStyle(
        color: AppColors.onDark,
      ),
      side: const BorderSide(
        color: AppColors.border,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.cardDark,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: AppColors.cardDark,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.onDark,
      textColor: AppColors.onDark,
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.cardDark,

      indicatorColor: AppColors.primary..withValues(alpha: 0.15),

      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
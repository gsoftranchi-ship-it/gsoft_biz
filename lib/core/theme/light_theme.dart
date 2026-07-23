import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_radius.dart';
import '../constants/app_colors.dart';


class LightTheme {
  LightTheme._();

  static ThemeData theme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    fontFamily: GoogleFonts.poppins().fontFamily,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: AppColors.surface,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.danger,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.onLight,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(
          color: AppColors.outline,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.outlineVariant,
      thickness: .8,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),

    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.onLight,
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(
        color: AppColors.onLight,
      ),
    ),

    dataTableTheme: const DataTableThemeData(
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.onLight,
      ),
      dataTextStyle: TextStyle(
        color: AppColors.onLight,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: AppColors.surfaceLight,

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
        color: AppColors.onLightSecondary,
      ),

      prefixIconColor: AppColors.onLightSecondary,
      suffixIconColor: AppColors.onLightSecondary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: BorderSide.none,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      side: const BorderSide(color: AppColors.outline),
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
        return AppColors.onLightSecondary;
      }),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return AppColors.onLightSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: .35);
        }
        return AppColors.outlineVariant;
      }),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.outline),
      ),
      textStyle: const TextStyle(
        color: AppColors.onLight,
        fontWeight: FontWeight.w500,
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.outlineVariant,
      circularTrackColor: AppColors.outlineVariant,
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
        foregroundColor: AppColors.onLight,
        side: const BorderSide(
          color: AppColors.outline,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
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

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primary,
      disabledColor: AppColors.outlineVariant,
      deleteIconColor: AppColors.onLightSecondary,
      labelStyle: const TextStyle(
        color: AppColors.onLight,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      side: const BorderSide(
        color: AppColors.outline,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surfaceLight,
      modalBackgroundColor: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.onLight,
      textColor: AppColors.onLight,
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
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

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surfaceLight,
      indicatorColor: AppColors.primary.withValues(alpha: .15),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
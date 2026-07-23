class AppDurations {
  AppDurations._();

  // Core
  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration normal = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);

  // Semantic aliases
  static const Duration hover = fast;
  static const Duration splash = normal;
  static const Duration pageTransition = medium;
  static const Duration dialog = medium;
  static const Duration snackbar = slow;
}
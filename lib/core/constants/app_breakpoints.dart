class AppBreakpoints {
  const AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobile(double width) => width < tablet;

  static bool isTablet(double width) =>
      width >= tablet && width < desktop;

  static bool isDesktop(double width) =>
      width >= desktop;
}
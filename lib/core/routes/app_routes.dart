import 'package:flutter/material.dart';
import '../../screens/auth/login_page.dart';
import '../../screens/splash/splash_page.dart';
import 'route_names.dart';
import '../../screens/app_shell/app_shell.dart';
import '../../screens/auth/register_partner_page.dart';

class AppRoutes {

  AppRoutes._();

  static String get splash => RouteNames.splash;

  static Map<String, WidgetBuilder> routes = {

    RouteNames.splash: (_) => const SplashPage(),

    RouteNames.login: (_) => const LoginPage(),

    RouteNames.registerPartner: (_) => const RegisterPartnerPage(),

    RouteNames.dashboard: (_) => const AppShell(),

  };

}
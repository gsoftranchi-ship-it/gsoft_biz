import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/config/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/member_provider.dart';
import 'providers/membership_provider.dart';
import 'core/config/app_dependencies.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';


class GSoftBizApp extends StatelessWidget {
  const GSoftBizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: AppDependencies.authRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            repository: AppDependencies.gymRepository,
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => MemberProvider(
            repository: AppDependencies.memberRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => MembershipProvider(
            repository: AppDependencies.membershipRepository,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
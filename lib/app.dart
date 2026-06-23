import 'package:flutter/material.dart';
import 'package:my_taxi/core/routing/app_routes.dart';
import 'package:my_taxi/core/theme/app_theme.dart';
import 'package:my_taxi/core/theme/theme_controller.dart';

class App extends StatelessWidget {
  final Locale locale;

  const App({
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          theme: AppTheme.light(locale),
          darkTheme: AppTheme.dark(locale),
          themeMode: themeMode,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_taxi/core/theme/app_theme.dart';
import 'package:my_taxi/core/theme/theme_controller.dart';
import 'package:my_taxi/screens/login/login_screen.dart';
import 'package:my_taxi/screens/splash_screen.dart';
import 'package:my_taxi/screens/home_screen.dart';
import 'package:my_taxi/screens/rides_screen.dart';
import 'package:my_taxi/screens/savedplaces_screen.dart';
import 'package:my_taxi/screens/settings_screen.dart';
import 'package:my_taxi/screens/wallet_screen.dart';
import 'package:my_taxi/screens/help_screen.dart';
import 'package:my_taxi/screens/login/signup_screen.dart';

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
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          theme: AppTheme.lightTheme(locale),
          darkTheme: AppTheme.darkTheme(locale),
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/rides': (context) => const RidesScreen(),
            '/wallet': (context) => const WalletScreen(),
            '/saved': (context) => const SavedplacesScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/help': (context) => const HelpScreen(),
            '/signup': (context) => const SignUpScreen(),
          },
        );
      },
    );
  }
}

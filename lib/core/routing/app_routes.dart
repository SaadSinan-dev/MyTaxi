import 'package:flutter/material.dart';
import 'package:my_taxi/features/auth/presentation/screens/login/login_screen.dart';
import 'package:my_taxi/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:my_taxi/features/home/presentation/screens/home_screen.dart';
import 'package:my_taxi/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        login: (context) => const LoginScreen(),
        signup: (context) => const SignUpScreen(),
        home: (context) => const HomeScreen(),
      };
}

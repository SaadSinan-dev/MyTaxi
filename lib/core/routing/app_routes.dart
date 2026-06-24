import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_taxi/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:my_taxi/features/auth/presentation/cubit/signup/sign_up_cubit.dart';
import 'package:my_taxi/features/auth/presentation/screens/login/login_screen.dart';
import 'package:my_taxi/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:my_taxi/features/help/presentation/screens/help_screen.dart';
import 'package:my_taxi/features/home/presentation/screens/home_screen.dart';
import 'package:my_taxi/features/home/presentation/widgets/startorder/start_order.dart';
import 'package:my_taxi/features/rides/presentation/screens/rides_screen.dart';
import 'package:my_taxi/features/save/presentation/screens/history_screen.dart';
import 'package:my_taxi/features/settings/presentation/screens/settings_screen.dart';
import 'package:my_taxi/features/splash/presentation/screens/splash_screen.dart';
import 'package:my_taxi/features/wallet/presentation/screens/wallet_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const rides = '/rides';
  static const wallet = '/wallet';
  static const saved = '/saved';
  static const settings = '/settings';
  static const help = '/help';
  static const startorder = '/startorder';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        login: (context) => BlocProvider(
              create: (_) => LoginCubit(),
              child: const LoginScreen(),
            ),
        signup: (context) => BlocProvider(
              create: (_) => SignUpCubit(),
              child: const SignUpScreen(),
            ),
        home: (context) => const HomeScreen(),
        startorder: (context) => const StartOrder(),
        rides: (context) => const RidesScreen(),
        wallet: (context) => const WalletScreen(),
        saved: (context) => const SavedplacesScreen(),
        settings: (context) => const SettingsScreen(),
        help: (context) => const HelpScreen(),
      };
}

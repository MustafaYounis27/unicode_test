import 'package:flutter/material.dart';
import 'package:unicode_test/core/routes_args.dart';
import 'package:unicode_test/presentation/views/auth/login_screen.dart';
import 'package:unicode_test/presentation/views/auth/register_screen.dart';
import 'package:unicode_test/presentation/views/home/home_screen.dart';
import 'package:unicode_test/presentation/views/manage_note/manage_note_screen.dart';
import 'package:unicode_test/presentation/views/splash/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String manageNote = '/manageNote';

  static final navigatorKey = GlobalKey<NavigatorState>();
}

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.splash),
        builder: (context) => const SplashScreen(),
      );
    case Routes.login:
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.login),
        builder: (context) => const LoginScreen(),
      );
    case Routes.register:
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.register),
        builder: (context) => const RegisterScreen(),
      );
    case Routes.home:
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.home),
        builder: (context) => const HomeScreen(),
      );
    case Routes.manageNote:
      var args = settings.arguments as ManageNoteScreenArgs;
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.manageNote),
        builder: (context) => ManageNoteScreen(note: args.note),
      );
    default:
      return MaterialPageRoute(
        settings: const RouteSettings(name: Routes.splash),
        builder: (context) => const SplashScreen(),
      );
  }
}

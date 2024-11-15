import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/home/presentation/pages/homescreen.dart';
import 'package:stimuler_task_app/features/login/presentation/pages/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        final args = settings.arguments as String; // Expect username as a string
        return MaterialPageRoute(builder: (_) => HomeScreen(username: args));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}

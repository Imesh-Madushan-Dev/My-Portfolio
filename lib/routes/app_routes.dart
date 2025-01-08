import 'package:flutter/material.dart';
import 'package:new_portfolio/pages/main_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String skills = '/skills';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
    }
  }
}

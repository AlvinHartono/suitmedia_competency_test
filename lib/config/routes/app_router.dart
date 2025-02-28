import 'package:flutter/material.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/pages/palindrome/first_screen.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/pages/third_screen.dart';
import 'package:suitmedia_competency_test/features/selected_user/presentation/pages/second_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const FirstScreenPage());
      case '/second-screen':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SecondScreenPage(user: args['user']),
        );

      case '/third-screen':
        return MaterialPageRoute(
          builder: (context) => ThirdScreenPage(onUserSelected: (p0) => p0),
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              ),
        );
    }
  }
}

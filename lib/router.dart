import 'package:flutter/material.dart';
import 'package:words_flutter/features/create/screens/create_screen.dart';
import 'package:words_flutter/features/home/screens/home_screen.dart';
import 'package:words_flutter/features/learn/screens/learn_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ReadTextFieldView.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ReadTextFieldView());
    case LearnWordView.routeName:
      final String word = routeSettings.arguments as String;

      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => LearnWordView(word: word));
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}

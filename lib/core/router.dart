import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screens/charts_screen.dart';
import '../screens/sliver_list_screen.dart';
import '../screens/list_demo_screen.dart';
import '../tubi_tv/tubi_navigation.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => ListDemoScreen()
        );
      case '/chart':
        return MaterialPageRoute(
          builder: (_) => ChartScreen()
        );
      case '/sliver':
        return MaterialPageRoute(
          builder: (_) => SliverScreen()
        );
      case '/tubi':
        return MaterialPageRoute(
          builder: (_) => TubiNavigation()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          )
        );
    }
  }
}

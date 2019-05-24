import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screens/charts_screen.dart';
import '../screens/sliver_list_screen.dart';
// import '../screens/list_demo_screen.dart';
import '../tubi_tv/tubi_navigation.dart';
import '../screens/store_screen.dart';
import '../douban/tab_bar_page.dart';
import '../sliver/sliver_menu.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => TabBarPage(),
          settings: settings
        );
      case '/store':
        return MaterialPageRoute(
          builder: (_) => StoreScreen(),
          settings: settings
        );
      case '/chart':
        return MaterialPageRoute(
          builder: (_) => ChartScreen(),
          settings: settings
        );
      case '/sliver':
        return MaterialPageRoute(
          builder: (_) => SliverScreen(),
          settings: settings
        );
      case '/sliver2':
        return MaterialPageRoute(
          builder: (_) => SliverPage(),
          settings: settings
        );
      case '/tubi':
        return MaterialPageRoute(
          builder: (_) => TubiNavigation(),
          settings: settings
        );
      // case '/douban':
      //   return MaterialPageRoute(
      //     builder: (_) => TabBarPage(),
      //     settings: settings
      //   );
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

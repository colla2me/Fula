import 'package:flutter/material.dart';
import 'page_keep_alive/airplay_screen.dart';
import 'page_keep_alive/email_screen.dart';
import 'page_keep_alive/home_screen.dart';
import 'page_keep_alive/pages_screen.dart';

class TabBarNavigation extends StatefulWidget {
  @override
  _TabBarNavigationState createState() => _TabBarNavigationState();
}

class _TabBarNavigationState extends State<TabBarNavigation> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  final _controller = PageController(
    initialPage: 0
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          AirPlayScreen(),
          EmailScreen(),
          HomeScreen(),
          PagesScreen()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'HOME',
                style: TextStyle(color: Colors.blue),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: Colors.blue,
              ),
              title: Text(
                'Email',
                style: TextStyle(color: Colors.blue),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: Colors.blue,
              ),
              title: Text(
                'PAGES',
                style: TextStyle(color: Colors.blue),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.airplay,
                color: Colors.blue,
              ),
              title: Text(
                'AIRPLAY',
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}

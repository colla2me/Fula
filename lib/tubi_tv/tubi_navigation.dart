import 'package:flutter/material.dart';
import 'home/home_page.dart';
import '../page_keep_alive/email_screen.dart';
import '../page_keep_alive/home_screen.dart';

class TubiNavigationBar extends StatelessWidget{

  final int currentTab;
  final ValueChanged<int> onSelectedTab;
  final titles = ["Home", "Browse", "Search"];
  final images = [
    "assets/icons/home_normal.png",
    "assets/icons/browse_normal.png",
    "assets/icons/search_normal.png"
  ];
  final selectedImages = [
    "assets/icons/home_selected.png",
    "assets/icons/browse_selected.png",
    "assets/icons/search_selected.png"
  ];

  TubiNavigationBar({Key key, this.currentTab, this.onSelectedTab}) : super(key: key ?? Key('TubiNavigationBar'));

  BottomNavigationBarItem _makeBarItem(int index) {
    var image = (index == currentTab ? selectedImages : images)[index];
    var selected = index == currentTab;
    var textColor = selected ? Color(0xffee5c32) : Colors.white;
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 26,
        height: 26,
        child: Image.asset(image, color: selected ? textColor : null),
      ),
      title: Text(
        titles[index],
        style:TextStyle(color: textColor, fontSize: 12)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xff26262d),
      type: BottomNavigationBarType.fixed,
      items: [_makeBarItem(0), _makeBarItem(1), _makeBarItem(2)],
      onTap: (index) => onSelectedTab(index)
    );
  }
}


class TubiNavigation extends StatefulWidget {
  @override
  _TubiNavigationState createState() => _TubiNavigationState();
}

class _TubiNavigationState extends State<TubiNavigation> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  final _controller = PageController(
    initialPage: 0
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Widget _buildOffstagePage(Widget pageView, int index) {
  //   return Offstage(
  //     offstage: _currentIndex == index,
  //     child: pageView,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          EmailScreen(),
          HomeScreen()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: TubiNavigationBar(
        currentTab: _currentIndex,
        onSelectedTab: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

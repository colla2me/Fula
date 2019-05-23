import 'package:flutter/material.dart';
import 'movie_page.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =TabController(
      length: 3,
      vsync: this
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NestedScrollView

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: "电影"),
            Tab(text: "电视"),
            Tab(text: "综艺")
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          MoviePage(),
          MoviePage(),
          MoviePage()
        ],
      ),
    );
  }
}

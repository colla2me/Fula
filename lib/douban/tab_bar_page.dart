import 'package:flutter/material.dart';
import 'movie_page.dart';
import 'sliver_douban_header.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {

  TabController _controller;

  List<String> _tabs = [
    "电影",
    "电视",
    "综艺"
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _getSliverAppBar(BuildContext context, bool isScrolled) {
    return SliverAppBar(
      title: Text('Douban'),
      pinned: true,
      expandedHeight: 200.0,
      forceElevated: isScrolled,
      // backgroundColor: Colors.white,
      bottom: TabBar(
        controller: _controller,
        indicatorColor: Colors.greenAccent,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
      ),
    );
  }

  Widget _getSliverToBoxAdapter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 36,
        child: TextField(
          onSubmitted: (text) {},
          onTap: () {},
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '用一部电影来形容你的2019',
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey,
              height: 0.5
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 25,
              color: Colors.grey
            ),
          ),
          style: TextStyle(
            fontSize: 17,
            color: Colors.black
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(18.0)
        ),
      )
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      controller: _controller,
      indicatorColor: Colors.greenAccent,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: <Widget>[
        Tab(text: "电影"),
        Tab(text: "电视"),
        Tab(text: "综艺")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return <Widget>[
                // SliverOverlapAbsorber(
                //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                //   child: _getSliverAppBar(context, isScrolled)
                // ),
                _getSliverToBoxAdapter(context),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: SliverDoubanHeader(
                    minHeight: 50,
                    maxHeight: 50,
                    child: Container(
                      color: Color(0xff26262d),
                      child: _buildTabBar(context),
                    )
                  ),
                )
              ];
            },
            body: TabBarView(
              controller: _controller,
              children: <Widget>[
                MoviePage(),
                Container(),
                Container()
              ],
            ),
          ),
        )
      ),
    );
  }
}

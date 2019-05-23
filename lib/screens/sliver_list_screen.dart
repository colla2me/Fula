import 'package:flutter/material.dart';

class SliverScreen extends StatefulWidget {
  @override
  _SliverScreenState createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverToBoxAdapter(),
          _buildPresistentHeader(),
          _buildSliverPadding(context),
          _buildSliverToBoxAdapter(),
          _buildPresistentHeader(),
          _buildSliverFixedExtentList(context),
          _buildSliverToBoxAdapter(),
          _buildPresistentHeader(),
          // _buildSliverFillViewPort()
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.pinkAccent.withOpacity(0.8),
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text("Sliver Demo"),
        background: Image.network(
          "https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        color: Colors.pinkAccent.withOpacity(0.8),
        child: Center(
          child: Text(
            'SliverToBoxAdapter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSliverGridFixed(BuildContext context) {
  //   return SliverGrid(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 5,
  //       mainAxisSpacing: 6,
  //       crossAxisSpacing: 6,
  //       // childAspectRatio: 4
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         return Container(
  //           alignment: Alignment.center,
  //           color: Colors.teal[100 * (index % 10)],
  //           child: Text('Sliver Grid Item $index'),
  //         );
  //       },
  //       childCount: 10
  //     ),
  //   );
  // }

  Widget _buildPresistentHeader() {
    return SliverPersistentHeader(
      delegate: _DefaultSliverPersistentHeader(
        minHeight: 120,
        maxHeight: 120,
        child: Container(
          child: Center(
            child: Text('Sliver Persistent Header', style: TextStyle(fontSize: 24)),
          ),
          color: Colors.tealAccent,
        )
      ),
    );
  }

  Widget _buildSliverPadding(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(12),
      sliver: _buildSliverGrid(context)
    );
  }

  Widget _buildSliverGrid(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 10)],
            child: Text('Sliver Grid Item $index'),
          );
        },
        childCount: 10
      ),
    );
  }

  Widget _buildSliverFixedExtentList(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment:Alignment.center,
            color: Colors.lightBlue[100 * (index % 10)],
            child:Text("Sliver Fixed Extent List Item $index")
          );
        },
        childCount: 10,
      ),
    );
  }

  Widget _buildSliverFillViewPort() {
    return SliverFillViewport(
      delegate: SliverChildListDelegate([
        Container(
          color: Colors.orangeAccent.withOpacity(0.8),
          child: Center(
            child: Text(
              'SliverFillViewPort',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              )
            ),
          )
        )
      ]),
    );
  }
}

class _DefaultSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _DefaultSliverPersistentHeader({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_DefaultSliverPersistentHeader oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
          maxHeight != oldDelegate.maxHeight ||
          child != oldDelegate.child;
  }
}

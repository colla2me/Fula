import 'package:flutter/material.dart';
import 'vertical_button.dart';

class MoviePage extends StatefulWidget {

  MoviePage({Key key}) : super(key: key ?? Key('MoviePage'));

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  Widget _buildToolBox(BuildContext context) {
    final style = TextStyle(
      color: Colors.grey,
      fontSize: 12
    );
    final List<Map<String, String>> items = [
      {'title': '找电影', 'icon': 'assets/icons/find_movie.png'},
      {'title': '豆瓣榜单', 'icon': 'assets/icons/douban_top.png'},
      {'title': '豆瓣猜', 'icon': 'assets/icons/douban_guess.png'},
      {'title': '豆瓣片单', 'icon': 'assets/icons/douban_film_list.png'}
    ];
    return SliverToBoxAdapter(
      child: Container(
        height: 90,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((item) => VerticalButton(
              item['icon'],
              title: Text(
                item['title'],
                style: style
              ),
              onTap: () {},
            ),
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildMovieStackItem({double left = 0, double opacity = 0, double scale = 1.0, Widget child}) {
    return Positioned(
      left: left,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 100,
          height: 140,
          child: child,
          foregroundDecoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: ExactAssetImage('assets/icons/2018.jpg'),
              fit: BoxFit.cover,
            )
          )
        ),
      ),
    );
  }

  Widget _buildTodayMovieBox(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: <Widget>[
            Container(
              height: 125,
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.6),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 180),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '今日可播放电影已更新',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '全部 36 >',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              )
            ),

            _buildMovieStackItem(left: 85, opacity: 0.6, scale: 0.9),
            _buildMovieStackItem(left: 50, opacity: 0.4, scale: 0.95),
            _buildMovieStackItem(
              left: 15,
              child: Center(
                child: Image.asset(
                  'assets/icons/ic_action_playable_video_s.png',
                  width: 36,
                  height: 36,
                ),
              )
            ),

            Positioned(
              right: 10,
              bottom: 10,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/icons/sofa.png',
                    width: 15,
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      '看电影',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          _buildToolBox(context),
          _buildTodayMovieBox(context),
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import '../../json_models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeHeader extends StatefulWidget {
  final List<Movie> movies;

  HomeHeader({Key key, this.movies}) : super(key: key ?? Key('tubi_home_header'));

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  int _currentPage = 0;

  Widget _buildBottomBoard() {
    final movie = widget.movies[_currentPage];
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87]
            )
          ),
        ),

        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                movie.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22,
                  color:Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),

              RichText(
                text: TextSpan(
                  text: '${_currentPage + 1}',
                  style: TextStyle(
                    color: Color(0xffee5c32),
                    fontSize: 12
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' / ${widget.movies.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      )
                    )
                  ]
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          key: PageStorageKey(context),
          itemCount: widget.movies.length,
          itemBuilder: (context, index) {
            return _PageItem(
              movie: widget.movies[index]
            );
          },
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
        _buildBottomBoard(),
      ],
    );
  }
}

class _PageItem extends StatelessWidget {
  final Movie movie;
  _PageItem({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              imageUrl: movie.heroImages.first,
              fit: BoxFit.cover,
            )
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87]
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

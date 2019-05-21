import 'package:flutter/material.dart';
import '../../json_models/movie.dart';

class HomeHeader extends StatefulWidget {
  final List<Movie> movies;

  HomeHeader({Key key, this.movies}) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {

  int _currentPage = 0;
  final PageController _controller= PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        key: PageStorageKey(context),
        controller: _controller,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return _PageItem(
            movie: widget.movies[index],
            pageNo: index,
            total: widget.movies.length,
          );
        },
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
    );
  }
}

class _PageItem extends StatelessWidget {
  final Movie movie;
  final int pageNo;
  final int total;

  _PageItem({Key key, this.movie, this.pageNo, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(movie.heroImages.first, fit:BoxFit.cover),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
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
                      text: '${pageNo + 1}',
                      style: TextStyle(
                        color: Color(0xffee5c32),
                        fontSize: 12
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '/ $total',
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
            ),
          )
        ],
      ),
    );
  }
}

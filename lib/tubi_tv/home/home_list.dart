import 'package:flutter/material.dart';
import '../../json_models/home.dart';
import '../../json_models/movie_list.dart';
import '../../json_models/movie.dart';
import 'home_header.dart';

class HomeList extends StatelessWidget {

  List<MovieList> _allMovieList = [];
  List<Movie> _featuredMovies = [];
  final HomeModel homeModel;
  HomeList({Key key, this.homeModel})
  : _allMovieList = homeModel.movieListExcludeFeatured(),
    _featuredMovies = homeModel.getFeaturedMovies(),
    super(key:key);

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        FlatButton(
          child: Image.asset("assets/icons/iconOverflow.png"),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildListView(MovieList movieList) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.childrenMovies.length,
        itemBuilder: (context, index) {
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff26262d),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Image.asset('assets/icons/icon_nav_logo.png'),
            pinned: true,
            backgroundColor: Color(0xff26262d),
            expandedHeight: MediaQuery.of(context).size.width,
            flexibleSpace: FlexibleSpaceBar(
              background: HomeHeader(movies: _featuredMovies),
            ),
          ),

        ],
      ),
    );
  }
}

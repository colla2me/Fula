import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../json_models/home.dart';
import '../../json_models/movie_list.dart';
import '../../json_models/movie.dart';
import 'home_header.dart';
import '../movie/movie_page.dart';

class HomeList extends StatelessWidget {
  final List<MovieList> _allMovieList;
  final List<Movie> _featuredMovies;
  final HomeModel homeModel;
  HomeList({Key key, this.homeModel})
  : _allMovieList = homeModel.movieListExcludeFeatured() ?? [],
    _featuredMovies = homeModel.getFeaturedMovies() ?? [],
    super(key:key);

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          SizedBox(
            width: 54,
            child: FlatButton(
              child: Image.asset(
                "assets/icons/iconOverflow.png",
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView(List<Movie> movies) {
    return Container(
      height: 250,
      padding: EdgeInsets.only(left: 16),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _buildListItem(context, movie);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Movie movie) {
    return GestureDetector(
      child: Container(
        width: 130,
        padding: EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: movie.posterarts.first,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: EdgeInsets.only(top: 14, bottom: 10),
              child: Text(
                movie.title,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MoviePage(movie: movie)
          )
        );
      },
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

          SliverFixedExtentList(
            itemExtent: 301,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: <Widget>[
                    _buildSectionTitle(_allMovieList[index].title),
                    _buildListView(_allMovieList[index].childrenMovies),
                    Divider(
                      height: 1,
                      color: Colors.white24,
                    )
                  ],
                );
              },
              childCount: _allMovieList.length
            ),
          )
        ],
      ),
    );
  }
}

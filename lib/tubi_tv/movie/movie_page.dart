import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../json_models/movie.dart';
import '../../services/api_client.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  MoviePage({Key key, this.movie}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  Movie get movie => widget.movie;

  ScrollController _controller;

  ApiClient _apiClient = ApiClient();

  List<Movie> _movies = [];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _apiClient.fetchRelatedMovies(id: movie.id).then((movies) => this.setState(() { this._movies =movies; }));
  }

   Widget _buildMovieBar(BuildContext context) {
    return SliverAppBar(
      // backgroundColor: Color(0xff26262d),
      backgroundColor: Colors.transparent,
      // expandedHeight: 150,
      pinned: true,
      title: Text(
        movie.title,
        style: TextStyle(
          color: Colors.white
        ),
      )
    );
  }

  Widget _buildMovieBackground(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
      // padding: EdgeInsets.only(top: 100),
          width: size.width,
          height: size.width,
          child: CachedNetworkImage(
            imageUrl: movie.backgrounds.first,
            fit: BoxFit.cover,
          )
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xff26262d)]
              )
            ),
          ),
        )
      ],
    );
    // return Container(
    //   // padding: EdgeInsets.only(top: 100),
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.width,
    //   child: CachedNetworkImage(
    //     imageUrl: movie.backgrounds.first,
    //     fit: BoxFit.cover,
    //   ),
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.bottomCenter,
    //       end: Alignment.center,
    //       stops: [0.5, 1.0],
    //       colors: [Colors.transparent, Color(0xff26262d)]
    //     )
    //   ),
    // );
  }

  Widget _buildMoviePoster() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      height: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 124,
            height: 180,
            margin: EdgeInsets.only(left: 15, bottom: 15),
            alignment: Alignment.bottomLeft,
            child: CachedNetworkImage(
              imageUrl: movie.posterarts.first,
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.white30,
                  offset: Offset(0, 5),
                  blurRadius: 10
                )
              ]
            ),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30),
                Text(
                  '(${movie.year}) · ${movie.duration}\n${movie.tags.join()} ',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(6),
            child: Text(
              'TV-MA',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff474747),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          stops: [0.5, 1.0],
          colors: [Colors.transparent, Color(0xff26262d)]
        )
      ),
    );
  }

  Widget _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMoviePoster(),
          Container(
            color: Color(0xff26262d),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildToolBar(),
                _buildDescription(),
                _buildStarrings(),
                _buildDivider(),
                _buildYouMayLike()
              ],
            )
          )
        ],
      )
    );
  }

  // Widget _buildSliverFillViewPort() {
  //   return SliverFillViewport(
  //     delegate: SliverChildListDelegate([
  //       Container(
  //         color: Color(0xff26262d),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             _buildToolBar(),
  //             _buildDescription(),
  //             _buildStarrings(),
  //             _buildDivider(),
  //             _buildYouMayLike()
  //           ],
  //         )
  //       )
  //     ]),
  //   );
  // }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.white24,
    );
  }

  Widget _buildBarItem({Widget icon, String title, VoidCallback onPress}) {
    return Column(
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: onPress,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12
          ),
        )
      ],
    );
  }

  Widget _buildToolBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildBarItem(
          icon: Image.asset("assets/icons/add_to_queue_normal.png"),
          title: 'My Queue',
          onPress: () {}
        ),
        IconButton(
          iconSize: 100,
          padding: EdgeInsets.all(0),
          icon: Image.asset("assets/icons/play_large_normal.png"),
          onPressed: () {},
        ),
        _buildBarItem(
          icon: Image.asset("assets/icons/share_normal.png"),
          title: 'Share',
          onPress: () {}
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Text(
        movie.description,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
      ),
    );
  }

  Widget _buildStarrings() {
    var textSpans = List<TextSpan>();
    if (movie.directors != null && movie.directors.isNotEmpty) {
      textSpans.addAll([
        TextSpan(text: 'Director.........  ', style: TextStyle(color: Colors.grey)),
        TextSpan(
            text: movie.directors.join(', '),
            style: TextStyle(color: Colors.white)
          )
      ]);
    }

    if (movie.actors != null && movie.actors.isNotEmpty) {
      textSpans.addAll([
        TextSpan(text: '\n'),
        TextSpan(text: '\n'),
        TextSpan(text: 'Starring.........  ', style: TextStyle(color: Colors.grey)),
        TextSpan(
          text: movie.actors.join(', '),
          style: TextStyle(color: Colors.white)
        )
      ]);
    }

    return Container(
      margin: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 30),
      child: RichText(
        text: TextSpan(
          children: textSpans,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10
          )
        ),
      )
    );
  }

  Widget _buildYouMayLike() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 15, bottom: 10),
          child: Text(
            'You May Also Like',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 16),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _movies.length,
            itemBuilder: (context, index) {
              final movie = _movies[index];
              return _buildListItem(context, movie);
            },
          ),
        )
      ],
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
    return Scaffold(
      backgroundColor: Color(0xff26262d),
      body: Stack(
        children: <Widget>[
          _buildMovieBackground(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                _buildMovieBar(context),
                _buildSliverToBoxAdapter()
              ],
            ),
          )
        ],
      ),
    );
  }
}

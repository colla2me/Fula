import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {

  MoviePage({Key key}) : super(key: key ?? Key('MoviePage'));

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Douban Movie'),
        ),
      ),
    );
  }
}

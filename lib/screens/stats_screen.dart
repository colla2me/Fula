import 'package:flutter/material.dart';
import '../widgets/round_button.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {

  List<Widget> _boxes = [
    ColorfulBox(color: Colors.redAccent),
    ColorfulBox(color: Colors.orangeAccent)
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      // color: Colors.white,
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          RoundButton(
            onPress: () {
              _boxes.add(_boxes.removeAt(0));
              setState(() {});
            },
            backgrondColor: Colors.redAccent,
            title: Text('Login'),
          ),

          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _boxes
            ),
          )
        ],
      ),
    );
  }
}

class ColorfulBox extends StatelessWidget {

  final Color color;

  ColorfulBox({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

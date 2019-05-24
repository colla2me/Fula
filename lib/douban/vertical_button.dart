import 'package:flutter/material.dart';

class VerticalButton extends StatelessWidget {
  final String resource;
  final double iconSize;
  final Widget title;
  final double spacing;
  final VoidCallback onTap;

  VerticalButton(this.resource, {Key key, this.iconSize = 45, this.title, this.spacing = 0, this.onTap}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Image.asset(resource),
          iconSize: iconSize,
          onPressed: onTap,
        ),
        Container(
          margin: EdgeInsets.only(top: spacing),
          child: title
        )
      ],
    );
  }
}

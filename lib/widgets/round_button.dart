import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color backgrondColor;
  final Text title;
  final Function onPress;

  RoundButton({
    this.backgrondColor,
    this.title,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              onPressed: onPress,
              color: backgrondColor,
              splashColor: backgrondColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: title,
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

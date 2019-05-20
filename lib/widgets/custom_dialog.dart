import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final Image image;
  final Text title;
  final Text detail;
  final VoidCallback onPress;

  CustomDialog({
    Key key,
    @required this.image,
    @required this.title,
    this.detail,
    this.onPress
  }) : super(key: key ?? Key('CustomDialog'));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
          minWidth: size.width * 0.4,
          maxHeight: size.height * 0.6
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)
                )
              ),
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: 1.4,
                child: image,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 16),
              child: title,
            ),

            Padding(
              padding: EdgeInsets.all(8),
              child: detail,
            ),

            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.grey,
                    onPressed: () { Navigator.of(context).pop(); },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),

                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {},
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  )
                ],
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       RaisedButton(
            //         color: Colors.grey,
            //         onPressed: () { Navigator.of(context).pop(); },
            //         child: Text(
            //           'Cancel',
            //           style: TextStyle(
            //             color: Colors.white
            //           )
            //         ),
            //       ),

            //       RaisedButton(
            //         color: Colors.green,
            //         onPressed: () {},
            //         child: Text(
            //           'OK',
            //           style: TextStyle(
            //             color: Colors.white
            //           )
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

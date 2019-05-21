import 'package:flutter/material.dart';

class AppSampleTheme {
  static get theme {
    final originalTextTheme = ThemeData.dark().textTheme;
    final originalBody1 =originalTextTheme.body1;

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.cyan[100],
      backgroundColor: Colors.grey[800],
      toggleableActiveColor: Colors.cyan[300],
      textTheme: originalTextTheme.copyWith(
        body1: originalBody1.copyWith(decorationColor: Colors.transparent)
      )
    );
  }

  static get tubiTheme {
    return ThemeData(
      fontFamily: 'Vaud',
      brightness: Brightness.dark,
      primaryColor: Color(0xff26262d),
      backgroundColor: Color(0xff26262d)
    );
  }
}

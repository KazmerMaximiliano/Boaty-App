import 'package:flutter/material.dart';

class BoatyTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: appBarTheme,
      primarySwatch: Colors.blue,
      fontFamily: "Nunito",
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

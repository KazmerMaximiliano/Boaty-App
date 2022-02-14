import 'package:flutter/material.dart';

class TextsStyles {
  double fontSizeByWidth(context, int percent) {
    Size screenSize = MediaQuery.of(context).size;
    return (((screenSize.width / 5) / 100) * percent);
  }

  TextStyle get appBarTextStyle => TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontFamily: "Campton",
      );

  TextStyle get title => TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: "Campton",
      );

  TextStyle get description => TextStyle(
        color: Colors.black,
        fontSize: 15,
      );

  TextStyle get bold => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "Campton",
      );

  TextStyle get button => TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: "Campton",
      );

  TextStyle get fab => TextStyle(
        fontSize: 18,
        fontFamily: "Campton",
      );

  TextStyle get emptysMessages => TextStyle(
        fontSize: 20,
        //fontFamily: "Nunito",
      );

  TextStyle get preCheckoutDates => TextStyle(
        fontSize: 18,
        //fontFamily: "Nunito",
        color: Colors.white,
      );

  TextStyle get preCheckout => TextStyle(
        fontSize: 18,
        //fontFamily: "Nunito",
      );
  //TextStyle get titleStyle => TextStyle();
}

import 'package:boaty/src/globals/styles/styles.dart';
import 'package:flutter/material.dart';

class BoatyLogo {
  static Widget get boat =>
      _Logo(icon: "assets/logo/boaty_boat.png", height: 45);
  static Widget get text =>
      _Logo(icon: "assets/logo/boaty_text.png", height: 40);
  static Widget get full =>
      _Logo(icon: "assets/logo/boaty_full.png", height: 45);
  static Widget get fullBig =>
      _Logo(icon: "assets/logo/boaty_full.png", height: 55);

  static Widget get favsEmpty =>
      _Logo(icon: "assets/logo/favoritos.png", height: 200);
  static Widget get congrats =>
      _Logo(icon: "assets/logo/reservacion/congrats.png", height: 200);
  static Widget get tickets =>
      _Logo(icon: "assets/logo/reservacion/tickets.png", height: 200);
}

class _Logo extends StatelessWidget {
  const _Logo({
    required this.icon,
    this.height = 30,
  });
  final String icon;
  final int height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '$icon',
      height: Styles.texts.fontSizeByWidth(context, height),
    );
  }
}

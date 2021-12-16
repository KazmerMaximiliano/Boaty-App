import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messagerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnacbar(String message) {
    final snackBar = new SnackBar(
      backgroundColor: BoatyColors.orange,
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(message),
          FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            color: Colors.white,
          ),
        ],
      ),
    );

    messagerKey.currentState!.showSnackBar(snackBar);
  }
}

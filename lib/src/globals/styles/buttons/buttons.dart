import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

class ButtonsStyles {
  ButtonStyle get fabElevated {
    return ButtonStyle(
      shape: MaterialStateProperty.resolveWith(
        (states) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => BoatyColors.primary,
      ),
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      ),
    );
  }

  ButtonStyle get largeButton {
    return ButtonStyle(
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => BoatyColors.primary,
      ),
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }

  ButtonStyle get circular {
    return ButtonStyle(
      shape: MaterialStateProperty.resolveWith(
        (states) => CircleBorder(),
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => BoatyColors.primary,
      ),
    );
  }
}

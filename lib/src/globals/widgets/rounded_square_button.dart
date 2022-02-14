import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

class RoundedSquareButton extends StatelessWidget {
  const RoundedSquareButton(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        padding: MaterialStateProperty.resolveWith(
          (states) => EdgeInsets.all(50),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => BoatyColors.primary,
        ),
      ),
      child: Text(title),
      onPressed: onTap,
    );
  }
}

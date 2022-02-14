import 'package:boaty/src/globals/styles/styles.dart';
import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final String title;
  final onPressed;
  final EdgeInsets padding;
  final EdgeInsets innerPadding;

  const RegularButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.all(8.0),
    this.innerPadding = const EdgeInsets.all(8.0),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) => innerPadding),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Text("$title", style: Styles.texts.button),
        onPressed: onPressed,
      ),
    );
  }
}

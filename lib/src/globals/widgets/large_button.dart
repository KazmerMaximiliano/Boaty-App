import 'package:boaty/src/globals/styles/styles.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.all(8.0),
    this.textStyle,
  }) : super(key: key);
  final String title;
  final void Function() onPressed;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: Styles.buttons.largeButton,
            child: Text("$title", style: textStyle ?? Styles.texts.button),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

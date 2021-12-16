import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectableOutlinedButton extends StatelessWidget {
  const SelectableOutlinedButton({
    Key? key,
    required this.child,
    this.selected = false,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final bool selected;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.all(16.0),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => selected ? BoatyColors.primary : Colors.white,
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

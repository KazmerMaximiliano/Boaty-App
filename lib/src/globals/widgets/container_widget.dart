import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

class InputContainerWidget extends StatelessWidget {
  const InputContainerWidget({
    Key? key,
    required this.child,
    this.validated = true,
  }) : super(key: key);

  final Widget child;
  final bool validated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: validated ? BoatyColors.grey : BoatyColors.orange,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: child,
      ),
    );
  }
}

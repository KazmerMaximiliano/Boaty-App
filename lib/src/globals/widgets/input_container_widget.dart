import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

class InputContainerWidget extends StatelessWidget {
  final Widget input;
  final String? validator;

  const InputContainerWidget({
    Key? key,
    required this.input,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    validator != null ? BoatyColors.orange : BoatyColors.grey,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                input,
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, validator != null ? 16.0 : 0.0, 0.0, 0.0),
            width: double.infinity,
            child: Text(
              (validator != null ? validator : '').toString(),
              style: TextStyle(
                color: BoatyColors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

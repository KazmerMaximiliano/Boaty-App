import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  EmptyWidget({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text),
      ),
    );
  }
}

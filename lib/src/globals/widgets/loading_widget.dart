import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({this.text = ""});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Visibility(
              visible: text != "",
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

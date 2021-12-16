import 'package:flutter/material.dart';

void customAlertDialog(BuildContext context, List<Widget> widgets) {
  showDialog(
    context: context,
    builder: (BuildContext context) => _CustomAlertDialog(
      widgets: widgets,
    ),
  );
}

class _CustomAlertDialog extends StatelessWidget {
  _CustomAlertDialog({required this.widgets});
  final List<Widget> widgets;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        child: Container(
          margin: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

enum SnackState { ok, error, loading }

void showCustomSnackbar(
  BuildContext context, {
  required String mensaje,
  required SnackState snackState,
  bool checkIconIfOk = false,
}) {
  Color bgColor = BoatyColors.primary;
  Widget icon = Icon(Icons.check);

  switch (snackState) {
    case SnackState.ok:
      bgColor = BoatyColors.primary;
      icon =
          checkIconIfOk ? Icon(Icons.check, color: Colors.white) : SizedBox();
      break;
    case SnackState.error:
      bgColor = BoatyColors.orange;
      icon = Icon(Icons.warning_amber_rounded, color: Colors.white);
      break;

    case SnackState.loading:
      bgColor = BoatyColors.amber;
      icon = CircularProgressIndicator(color: Colors.white);
      break;
  }

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: bgColor,
        content: Row(
          children: [
            Expanded(
              child: Text(
                mensaje,
                style: TextStyle(color: Colors.white),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
}

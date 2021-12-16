import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/dialogs/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

void confirmAlertDialogWithIcon(
  BuildContext context,
  String mensaje,
  void Function() onConfirm,
  IconData iconData,
) {
  customAlertDialog(
    context,
    [
      Icon(
        iconData,
        color: BoatyColors.red,
      ),
      Text(
        mensaje,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn("Ingresar", onConfirm)
          ],
        ),
      )
    ],
  );
}

Widget _btn(String msg, void Function() action) {
  return Expanded(
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => BoatyColors.primary,
        ),
      ),
      child: Text('$msg'),
      onPressed: action,
    ),
  );
}

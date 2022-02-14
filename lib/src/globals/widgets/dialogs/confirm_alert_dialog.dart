import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/dialogs/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

void confirmAlertDialog(
  BuildContext context,
  String mensaje,
  void Function() onConfirm,
) {
  customAlertDialog(
    context,
    [
      Text(
        mensaje,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            _btn('Cancelar', () => Navigator.pop(context)),
            Spacer(),
            _btn("Confirmar", onConfirm)
          ],
        ),
      )
    ],
  );
}

Widget _btn(String msg, void Function() action) {
  return Expanded(
    child: ElevatedButton(
      style: Styles.buttons.largeButton,
      child: Text('$msg'),
      onPressed: action,
    ),
  );
}

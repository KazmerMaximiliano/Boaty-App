import 'package:flutter/material.dart';
import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/congrats/reserva_congrats_body.dart';

class ReservaCongratsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: Boaty.appBar(),
        body: ReservaCongratsBody(),
      ),
    );
  }
}

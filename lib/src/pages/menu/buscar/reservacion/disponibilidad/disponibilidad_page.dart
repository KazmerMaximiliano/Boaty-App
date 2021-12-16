import 'package:flutter/material.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/disponibilidad/disponibilidad_body.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/reserva_step_page.dart';

class DisponibilidadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReservaStepPage(
      title: "Disponibilidad",
      body: DisponibilidadBody(),
    );
  }
}

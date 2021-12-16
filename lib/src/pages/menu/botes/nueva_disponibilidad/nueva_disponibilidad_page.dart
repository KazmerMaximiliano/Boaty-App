import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/pages/menu/botes/nueva_disponibilidad/disponibilidad_params.dart';
import 'package:boaty/src/pages/menu/botes/nueva_disponibilidad/nueva_disponibilidad_body.dart';
import 'package:flutter/material.dart';

class NuevaDisponibilidadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DisponibilidadArguments;

    return Scaffold(
      appBar: Boaty.appBar(
          title: 'Nueva Disponibilidad',
          leadingIcon: AppBarLeadingIcon.back,
        ),
      body: NuevaDisponibilidadBody(bote: args.bote),
    );
  }
}

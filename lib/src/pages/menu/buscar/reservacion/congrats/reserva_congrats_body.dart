import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:flutter/material.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/services/providers/reservacion/reservacion_provider.dart';

class ReservaCongratsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BoatyLogo.congrats,
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
            child: Text(
              "¡Gracias!",
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 24,),
          Text(
            "Los datos de tu reservación han sido cargados y pronto podras verlo en la sección 'Reservas'",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 24,),
          Text(
            "Que disfrutes la experiencia.",
            style: TextStyle(fontSize: 18),
          ),
          LargeButton(
            padding: const EdgeInsets.only(top: 24.0),
            onPressed: () { 
              ReservacionProvider().reset(context);
             },
            title: "Buscar nuevos botes",
            textStyle: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

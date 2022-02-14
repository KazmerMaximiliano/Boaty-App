import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/services/providers/reservacion/reservacion_provider.dart';
import 'package:boaty/src/services/reservations_service.dart';
import 'package:flutter/material.dart';

class PreCheckoutBody extends StatefulWidget {
  @override
  _PreCheckoutBodyState createState() => _PreCheckoutBodyState();
}

class _PreCheckoutBodyState extends State<PreCheckoutBody> {
  final _reservacion = ReservacionProvider();
  final reservationService = new ReservationService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _reservacion.diasContainer,
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 32.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Tipo de alquiler", style: Styles.texts.preCheckout),
          //       Text(
          //         "${_reservacion.tipoPagoToString}",
          //         style: TextStyle(fontSize: 15),
          //       ),
          //     ],
          //   ),
          // ),
          _row(),
          Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Center(
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: Styles.buttons.largeButton,
                child: Text(loading ? "Reservando..." : "Reservar", style:  Styles.texts.fab),
                onPressed: loading ? null : () async {
                  setState(() {
                    loading = true;
                  });

                  final resp = await reservationService.setReservation(_reservacion);

                  if(resp != null) {
                    showCustomSnackbar(
                      context,
                      mensaje: resp.toString(),
                      snackState: SnackState.error,
                    );

                    setState(() {
                      loading = false;
                    });
                  } else {
                    ReservacionProvider().goToNextStep(context);
                  }
                },
              ),
            ),
          ),
        )
              // LargeButton(
          //   padding: ,
          //   title: "Siguiente",
          //   textStyle: Styles.texts.fab,
          //   onPressed: loading ? null : () async {
          //     // 
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _row() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text("Número de pasajeros:", style: Styles.texts.preCheckout),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
              onPressed: () {
                if (_reservacion.cantPasajeros > 1) _reservacion.cantPasajeros--;
                setState(() {});
              },
              style: Styles.buttons.circular,
              child: Icon(Icons.remove_outlined, color: Colors.white),
            ),
            Text(
              "${_reservacion.cantPasajeros}",
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: () {
                if (_reservacion.cantPasajeros < _reservacion.bote.capacity!) {
                  _reservacion.cantPasajeros++;
                  setState(() {});
                } else {
                  showCustomSnackbar(
                    context,
                    mensaje: "El número de pasajeros no puede superar la capcidad del bote",
                    snackState: SnackState.error,
                  );
                }
              },
              style: Styles.buttons.circular,
              child: Icon(Icons.add_outlined, color: Colors.white),
            ),
            ],
          )
        ],
      ),
    );
  }
}

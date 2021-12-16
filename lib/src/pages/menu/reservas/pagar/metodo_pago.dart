import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago_params.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';

class MetodoPagoPage extends StatelessWidget {
  const MetodoPagoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MetodoPagoArguments;
    final paymentService = new PaymentService();

    return Scaffold(
      appBar: Boaty.appBar(
        title: 'Checkout',
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            SizedBox(height: 32,),
            Container(
              margin: EdgeInsets.only(left: 18),
              child: Text('Seleccionar método de pago', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 32,),
            LargeButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MetodoTarjeta', arguments: MetodoPagoArguments(reservationID: args.reservationID));
              }, 
              title: 'Tarjetas'
            ),
            // SizedBox(height: 6,),
            // LargeButton(
            //   onPressed: () {
              
            //   }, 
            //   title: 'Transferencia'
            // ),
            SizedBox(height: 6,),
            LargeButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MetodoCrypto', arguments: MetodoPagoArguments(reservationID: args.reservationID));
              }, 
              title: 'Criptomonedas'
            ),
            SizedBox(height: 6,),
          ],
        ),
      ),
    );
  }
}
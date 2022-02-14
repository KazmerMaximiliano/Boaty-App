import 'package:flutter/material.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/pre_checkout/pre_checkout_body.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/reserva_step_page.dart';

class PreCheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ReservaStepPage(
      title: "Pre checkout",
      body: PreCheckoutBody(),
    );
  }
}

import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:flutter/material.dart';

class MetodoPagoCongrats extends StatelessWidget {
  const MetodoPagoCongrats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(),
      body: Padding(
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
              "Ya has pagado tu resevacion, por favor no olvides dejarnos una calificación en la pestaña de reservas",
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
              onPressed: () => Navigator.pushNamed(context, '/'),
              title: "Volver",
              textStyle: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
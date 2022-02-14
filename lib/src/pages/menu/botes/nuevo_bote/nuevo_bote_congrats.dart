import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:flutter/material.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';

class NuevoBoteCongrats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BoatyLogo.congrats,
              SizedBox(height: 24,),
              Text(
                "Los datos del bote han sido registrado correctamente. Dirigite a la sección 'Botes' para agregar disponibilidades al mismo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 24,),
              LargeButton(
                padding: const EdgeInsets.only(top: 24.0),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                title: "Volver",
                textStyle: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
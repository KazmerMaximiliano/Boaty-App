import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/pages/menu/ayuda/ayuda_body.dart';
import 'package:flutter/material.dart';

class AyudaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(title: "Preguntas frecuentes"),
      body: AyudaBody(),
    );
  }
}

import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/pages/menu/buscar/body/buscar_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.notLoggedAppBar,
      body: Center(
        child: BuscarBotesBody(),
      ),
    );
  }
}

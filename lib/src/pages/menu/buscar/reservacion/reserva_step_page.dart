import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/widgets/boaty_app_bar.dart';
import 'package:boaty/src/services/providers/reservacion/reservacion_provider.dart';
import 'package:flutter/material.dart';

class ReservaStepPage extends StatelessWidget {
  ReservaStepPage({required this.title, required this.body});
  final String title;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ReservacionProvider().onWillPop(context),
      child: Scaffold(
        appBar: Boaty.appBar(
          title: title,
          leadingIcon: AppBarLeadingIcon.back,
          onBack: ReservacionProvider().back(context),
        ),
        body: body,
      ),
    );
  }
}

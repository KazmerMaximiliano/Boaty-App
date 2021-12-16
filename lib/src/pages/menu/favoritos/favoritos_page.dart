import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/loading_widget.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/boats_service.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(title: "Favoritos"),
      body: FavoritosEmpty(),
    );
  }
}

class FavoritosEmpty extends StatelessWidget {
  final boatsService = new BoatsService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bote>>(
      future: boatsService.getFavouritesBoats(),
      builder: (BuildContext context, AsyncSnapshot<List<Bote>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, i) => snapshot.data![i].toWidget,
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 125),
                BoatyLogo.favsEmpty,
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'No añadiste ningún\nbote a tus favoritos',
                    style: Styles.texts.emptysMessages,
                  ),
                ),
              ],
            );
          }
        }
        return LoadingWidget();
      },
    );
  }
}
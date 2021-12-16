import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/loading_widget.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/boats_service.dart';
import 'package:flutter/material.dart';

class BotesList extends StatelessWidget {
  BotesList({Key? key, required this.filters}) : super(key: key);
  final String filters;
  final boatsService = new BoatsService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bote>>(
      future: boatsService.getBoats(filters),
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
                BoatyLogo.favsEmpty,
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'No se encontro ningun bote',
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

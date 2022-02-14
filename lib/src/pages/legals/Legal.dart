import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';

class Legal extends StatelessWidget {
  const Legal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: FutureBuilder(
        future: loadAssets(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: new Text(
                        snapshot.data,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: BoatyColors.primary,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<String> loadAssets(BuildContext context) async {
  return await DefaultAssetBundle.of(context).loadString('assets/LEGALES.txt');
}
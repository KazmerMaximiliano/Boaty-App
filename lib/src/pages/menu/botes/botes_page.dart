import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/permission_service.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';

class BotesPage extends StatelessWidget {
  const BotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BotesContainer();
  }
}

class BotesContainer extends StatefulWidget {
  @override
  State<BotesContainer> createState() => _BotesContainerState();
}

class _BotesContainerState extends State<BotesContainer> {
  final boatsService = new BoatsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(),
      body: FutureBuilder<List<Bote>>(
      future: boatsService.getOwnerBoats(),
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final permissionService = new PermissionService();
          final check = await permissionService.checkPermissions();
          
          if(check) {
            Navigator.pushNamed(context, '/NuevoBote').then((value) => 
              setState(() {})
            );
          } else {
            Navigator.pushNamed(context, '/Permisos').then((value) => 
              setState(() {})
            );
          }
          
        },
        backgroundColor: BoatyColors.secondary,
        elevation: 2,
        child: Icon(Icons.add),
      ),
    );
  }
}



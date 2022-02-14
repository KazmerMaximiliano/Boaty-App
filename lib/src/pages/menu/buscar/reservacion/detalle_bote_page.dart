import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/boaty_app_bar.dart';
import 'package:boaty/src/globals/widgets/loading_widget.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/pages/menu/botes/nueva_disponibilidad/disponibilidad_params.dart';
import 'package:boaty/src/services/providers/reservacion/reservacion_provider.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';

class DetalleBotePage extends StatelessWidget {
  final Bote bote;
  const DetalleBotePage({Key? key, required this.bote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetalleBotePageBody(bote: bote);
  }
}

class DetalleBotePageBody extends StatefulWidget {
  final Bote bote;
  DetalleBotePageBody({ required this.bote });

  @override
  _DetalleBotePageBodyState createState() => _DetalleBotePageBodyState();
}

class _DetalleBotePageBodyState extends State<DetalleBotePageBody> {
  final authService = new AuthService();
  final boatsService = new BoatsService();
  Bote? bote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(leadingIcon: AppBarLeadingIcon.back),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FutureBuilder<Bote?>(
          future: boatsService.getBoatById(widget.bote.id),
          builder: (BuildContext context, AsyncSnapshot<Bote?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                bote = snapshot.data;
                return bote!.widget(ShowIn.detalle);
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 125),
                    BoatyLogo.favsEmpty,
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Ha ocurrido un error al cargar\nlos datos del bote',
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: Styles.buttons.largeButton,
            child: Text(
              authService.readUser().roles!.contains('owner') ? 
              "Modificar Disponibilidad" : 
              "Verificar Disponibilidad", 
              style: Styles.texts.button
            ),
            onPressed: () {
              final _prefs = SharedPrefs();
              if (_prefs.logged) {
                authService.readUser().roles!.contains('owner') ?
                Navigator.pushNamed(
                  context, "/NuevaDisponibilidad", 
                  arguments: DisponibilidadArguments(bote: bote ?? widget.bote)
                ).then((value) { setState(() {}); }) : ReservacionProvider().initReserva(context, widget.bote);
              } else {
                Navigator.pushNamed(context, '/Login');
              }
            },
          ),
        ),
      ),
    );
  }
}
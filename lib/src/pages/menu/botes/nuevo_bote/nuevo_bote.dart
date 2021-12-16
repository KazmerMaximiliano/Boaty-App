import 'dart:convert';

import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/globals/widgets/regular_button.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote_congrats.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote_fotos.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote_general.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote_price.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote_ubicacion.dart';
import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class NuevoBote extends StatelessWidget {
  const NuevoBote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NuevoBoteForm(),
    );
  }
}

class NuevoBoteForm extends StatefulWidget {
  const NuevoBoteForm({Key? key}) : super(key: key);

  @override
  _NuevoBoteFormState createState() => _NuevoBoteFormState();
}

class _NuevoBoteFormState extends State<NuevoBoteForm> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BotesFormProvider(),
      child: NuevoBoteFormSteps()
    );
  }
}

class NuevoBoteFormSteps extends StatefulWidget {
  NuevoBoteFormSteps({Key? key}) : super(key: key);

  @override
  _NuevoBoteFormStepsState createState() => _NuevoBoteFormStepsState();
}

class _NuevoBoteFormStepsState extends State<NuevoBoteFormSteps> {
  final List<Widget> formSteps = [
    NuevoBoteGeneral(),
    NuevoBotePrice(),
    NuevoBoteUbicacion(),
    NuevoBoteFotos(),
    NuevoBoteCongrats()
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPrefs();
    final boatsService = new BoatsService();
    final botesForm = Provider.of<BotesFormProvider>(context);

    return Scaffold(
      appBar: Boaty.appBar(
        title: 'Nueva embarcación',
        onBack: () {
          if(botesForm.formStep > 0) {
            botesForm.formStep--;
          } else {
            Navigator.pop(context);
          }
        }
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
              ),
              Form(
                key: botesForm.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: formSteps[botesForm.formStep],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: botesForm.formStep < 4 ? Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
          child: RegularButton(
            onPressed: botesForm.isLoading ? null : () async {
              if (botesForm.SectionsValidator()) {
                if (botesForm.formStep == 1) {
                  final bool LocationPermission = await getLocationPermissions();
                          
                  if(!LocationPermission) {
                    showCustomSnackbar(
                      context,
                      mensaje: "Debes habilitar los permisos de ubicación para continuar con el formulario",
                      snackState: SnackState.error,
                    );
                    return;
                  }
                }
                if (botesForm.formStep < 3) {
                  botesForm.formStep++;
                } else {
                  botesForm.isLoading = true;

                  final List base64PhotosList = [];

                  botesForm.photosFilesList.forEach((key, value) { 
                    var bytesPhotos = value.readAsBytesSync();
                    base64PhotosList.add(base64Encode(bytesPhotos));
                  });

                  final Map<String, dynamic> body = {
                    'title': botesForm.title,
                    'description': botesForm.description,
                    'price': botesForm.price,
                    'capacity': botesForm.capacity,
                    'coord': botesForm.coord,
                    'type_id': botesForm.type_id,
                    'photos': json.encode(base64PhotosList),
                    'owner_id': jsonDecode(prefs.user)['id']
                  };

                  final response = await boatsService.saveBoat(body);

                  botesForm.isLoading = false;
                  if (response != null) {
                    showCustomSnackbar(
                      context,
                      mensaje: response,
                      snackState: SnackState.error,
                    );
                  } else {
                    botesForm.formStep++;
                  }
                }
                
              } else {
                showCustomSnackbar(
                  context,
                  mensaje: "Uno o mas datos son incorrectos",
                  snackState: SnackState.error,
                );
              }
            },
            title: botesForm.isLoading ? 'Guardando...' : 'Siguiente',
            padding: EdgeInsets.only(top: 24.0),
            innerPadding: EdgeInsets.all(16.0),
          ),
        ),
      ) : null,
    );
  }
}

Future<bool> getLocationPermissions() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return false;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  return true;
}
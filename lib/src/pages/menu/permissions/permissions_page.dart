import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/services/permission_service.dart';
import 'package:flutter/material.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(
        title: 'Permisos',
        onBack: () {
          Navigator.pop(context);
        }
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 48,),
              Text('Acepta los permisos para continuar', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
              SizedBox(height: 36,),
              Text('Para continuar con el registro de una embarcación necesitas aceptar los permisos de acceso a la ubicación y la cámara', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              SizedBox(height: 36,),
              Text('De lo contrario, no podrás realizar el correcto registro de una nueva embarcación', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              SizedBox(height: 36,),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Styles.buttons.largeButton,
                      child: Text('Aceptar', style: Styles.texts.button),
                      onPressed: () async {
                        final permissionService = new PermissionService();
                        final check = await permissionService.callPermissions();

                        if(check) {
                          Navigator.pushNamed(context, "/NuevoBote");
                        } else {
                          showCustomSnackbar(
                            context, 
                            mensaje: "Debes aceptar todos los permisos para continuar", 
                            snackState: SnackState.error
                          );
                        }
                      }
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
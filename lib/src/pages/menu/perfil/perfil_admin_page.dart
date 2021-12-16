import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/models/user.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PerfilAdminWidget();
  }
}
class PerfilAdminWidget extends StatefulWidget {
  @override
  _PerfilAdminWidgetState createState() => _PerfilAdminWidgetState();
}

class _PerfilAdminWidgetState extends State<PerfilAdminWidget> {
  bool inProcess = false;
  final auth = new AuthService();


  @override
  Widget build(BuildContext context) {
    final _prefs = SharedPrefs();
    final String _baseUrl = dotenv.env['ASSETS_URL'].toString();
    final authService = new AuthService();
    Future<BoatyUser> readUser() async { return authService.readUser(); }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Boaty.appBar(
        title: 'Admin / Perfil'
      ),
      body: FutureBuilder<BoatyUser>(
        future: readUser(),
        builder: (BuildContext context, AsyncSnapshot<BoatyUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              final user = snapshot.data;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 48),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 32,),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage('$_baseUrl${user!.photo}'),
                            minRadius: 24,
                            maxRadius: 48,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 18),
                            width: screenSize.width * 0.45,
                            child: Column(
                              children: [
                                Text('${user.firstName}', maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false, style: TextStyle(fontSize: 32)),
                                Text('${user.lastName}', maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false, style: TextStyle(fontSize: 32))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 18,),
                      LargeButton(
                        onPressed: () async {
                          if (await canLaunch('https://stripe.com/es-us')) {
                            await launch('https://stripe.com/es-us');
                          } else {
                            print('No se puede acceder a la facturación');
                          }
                        }, 
                        title: 'Facturación'
                      ),
                      SizedBox(height: 6,),
                      LargeButton(
                        onPressed: () async {
                          // TODO: Definir ruta de boaty
                          if (await canLaunch('boaty.kazmermaximiliano.com')) {
                            await launch('boaty.kazmermaximiliano.com');
                          } else {
                            print('No se puede acceder a la facturación');
                          }   
                        }, 
                        title: 'Facturación cripto'
                      ),
                      SizedBox(height: 6,),
                      LargeButton(
                        onPressed: () {
                          _prefs.adminView = false;
                          Navigator.pushReplacementNamed(context, '/');
                        }, 
                        title: 'Quiero alquilar un bote'
                      ),
                      SizedBox(height: 6,),
                      LargeButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/EditarPerfil').then((value) => setState(() {}));
                        }, 
                        title: 'Editar perfil'
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => inProcess ? Colors.black12 : Colors.white,
                                ),
                                padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.symmetric(vertical: 20),
                                ),
                              ),
                              child: Text(
                                inProcess ? "Saliendo..." : "Cerrar Sesión", 
                                style:  TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Campton",
                                  color: Colors.black87
                                ),
                              ),
                              onPressed: inProcess ? null : () async {
                                setState(() {
                                  inProcess = true;
                                });
                                await AuthService().logout(context);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              );
            } else {
              return EmptyWidget(text: "La información de la cuenta de este usuario esta vacia");
            }
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
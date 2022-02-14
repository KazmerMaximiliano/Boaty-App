import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/models/user.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PerfilWidget();
  }
}

class PerfilWidget extends StatefulWidget {
  @override
  _PerfilWidgetState createState() => _PerfilWidgetState();
}

class _PerfilWidgetState extends State<PerfilWidget> {
  final _prefs = SharedPrefs();
  bool inProcess = false;

  @override
  Widget build(BuildContext context) {
    final String _baseUrl = dotenv.env['ASSETS_URL'].toString();
    final authService = new AuthService();
    Future<BoatyUser> readUser() async { return authService.readUser(); }
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Boaty.appBar(
        title: 'Perfil'
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
                                Text(
                                  '${user.firstName}', 
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(fontSize: 32)
                                ),
                                Text(
                                  '${user.lastName}', 
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(fontSize: 32)
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 18,),
                      // LargeButton(
                      //   onPressed: () {}, 
                      //   title: 'Perfil'
                      // ),
                      SizedBox(height: 6,),
                      // LargeButton(
                      //   onPressed: () {}, 
                      //   title: 'Medios de pago'
                      LargeButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/EditarPerfil').then((value) => setState(() {}));
                        }, 
                        title: 'Editar perfil'
                      ),
                      LargeButton(
                        onPressed: () async {                              
                          if(user.roles!.contains('owner')) {
                            _prefs.adminView = true;
                            Navigator.pushReplacementNamed(context, '/');
                          } else {
                            await authService.addOwnerRole();
                            _prefs.adminView = true;
                            Navigator.pushReplacementNamed(context, '/ConnectStripeAccount');
                          }
                        }, 
                        title: 'Soy dueño de un bote'
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
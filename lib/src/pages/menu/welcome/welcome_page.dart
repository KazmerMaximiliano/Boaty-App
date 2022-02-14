import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/services/auth_service.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeWidget();
  }
}
class WelcomeWidget extends StatefulWidget {
  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  bool inProcess = false;
  final authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Boaty.appBar(),
      body: inProcess ? Center(child: LoadingWidget(),) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('¡Bienvenido!', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 32.0,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: _size.width / 2,
                  height: _size.width / 2,
                  padding: EdgeInsets.fromLTRB(24.0, 24.0, 12.0, 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BoatyColors.primary,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/Menu');
                      },
                      child: Center(child: 
                        Text(
                            'Quiero alquilar\nun bote', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                    ),
                  ),
                ),

                Container(
                  width: _size.width / 2,
                  height: _size.width / 2,
                  padding: EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BoatyColors.primary,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        authService.addOwnerRole();
                        Navigator.pushReplacementNamed(context, '/ConnectStripeAccount');
                      },
                      child: Center(child: 
                        Text(
                            'Soy dueño\nde un bote', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 128.0,)
          ],
        ),
      ),
    );
  }
}

import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/input_container_widget.dart';
import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/services/stripe_service.dart';
import 'package:flutter/material.dart';

class ConnectStripeAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectStripeAccounWidget();
  }
}

class ConnectStripeAccounWidget extends StatefulWidget {
  @override
  _ConnectStripeAccounWidgetState createState() => _ConnectStripeAccounWidgetState();
}

class _ConnectStripeAccounWidgetState extends State<ConnectStripeAccounWidget> {
  bool inProcess = false;
  bool acceptCrypto = false;
  String? cryptoDivisa;
  String? cryptoAddres;
  final stripeService = new StripeService();
  static final _prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 48,),
              Text('Finaliza el registro de tu cuenta en Stripe', textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
              SizedBox(height: 36,),
              Text('Serás redirigido a la página de stripe para completar tu registro. Este proceso puede durar varios minutos. Asegúrate de completarlo antes de continuar en Boaty.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              SizedBox(height: 36,),
              Text('Si deseas recibir pagos con criptos, por favor marca la casilla a continuación y escribe tu dirección.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              SizedBox(height: 36,),
              Container(
                child: ListTile(
                  onTap:() {
                    setState(() {
                      acceptCrypto = !acceptCrypto;
                    });
                  },
                  leading: Icon(
                    acceptCrypto ? Icons.check_box : Icons.check_box_outline_blank, 
                    color: BoatyColors.primary,
                  ),
                  title: Text(
                    'Deseo recibir pagos con criptos'
                  ),
                ),
              ),
              SizedBox(height: 18,),
              acceptCrypto ? Column(
                children: [
                  InputContainerWidget(
                    input: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Divisa',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        cryptoDivisa = value;
                        setState(() {});
                      },
                    ),
                    validator: cryptoDivisaValidator(cryptoDivisa)
                  ),
                  InputContainerWidget(
                    input: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Dirección',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        cryptoAddres = value;
                        setState(() {});
                      },
                    ),
                    validator: cryptoAddresValidator(cryptoAddres)
                  ),
                ],
              ) : Container(),
              SizedBox(height: 18,),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Styles.buttons.largeButton,
                      child: Text(inProcess ? 'Accediendo...' : 'Continuar', style: Styles.texts.button),
                      onPressed: inProcess ? null : () async {
                        setState(() {
                          inProcess = true;
                        });
                        if (acceptCrypto) {
                          final resp = await stripeService.setCryptoAddress(cryptoAddres, cryptoDivisa);
                          if (resp != null) {
                            NotificationsService.showSnacbar('Crypto Ha ocurrido un error');
                            return;
                          }
                        }

                        final String? stripeUrl = await stripeService.connectStripeAccount();
                        print(stripeUrl);

                        if (stripeUrl != null) {
                          _prefs.adminView = true;
                          stripeService.openStripeUrl(stripeUrl);
                          Navigator.pushReplacementNamed(context, "/Menu");
                        } else {
                          NotificationsService.showSnacbar('Ha ocurrido un error');
                        }

                        setState(() {
                          inProcess = false;
                        });
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

String? cryptoAddresValidator(value) {
  if (value != null) {
    return value.length > 6 ? null : 'La dirección es muy corta';
  } else {
    return null;
  }
}

String? cryptoDivisaValidator(value) {
  if (value != null) {
    return value.length > 2 ? null : 'La divisa es muy corta';
  } else {
    return null;
  }
}
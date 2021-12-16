import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago_params.dart';
import 'package:boaty/src/providers/pagos_form_provider.dart';
import 'package:boaty/src/services/notifications_service.dart';
import 'package:boaty/src/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetodoCrypto extends StatelessWidget {
  const MetodoCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MetodoPagoArguments;
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: ChangeNotifierProvider(
        create: (_) => PagosCryptosProvider(),
        child: MetodoCryptoForm(reservationID: args.reservationID),
      ),
    );
  }
}

class MetodoCryptoForm extends StatefulWidget {
  String reservationID;
  MetodoCryptoForm({Key? key, required this.reservationID}) : super(key: key);

  @override
  _MetodoCryptoFormState createState() => _MetodoCryptoFormState();
}

class _MetodoCryptoFormState extends State<MetodoCryptoForm> {
  @override
  Widget build(BuildContext context) {
    final cryptoForm = Provider.of<PagosCryptosProvider>(context);
    final paymentService = new PaymentService();

    return FutureBuilder(
      future: paymentService.getOwnerWallet(widget.reservationID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return Container(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                    child: Column(
                      children: [
                        SizedBox(height: 24,),
                        Text(
                          "Para completar el pago con criptos, por favor envíanos la dirección por la cual realizarás la transferencia y posteriormente, realiza la transferencia a la siguiente dirección.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 24,),
                        Text(
                          "El pago puede tardar hasta 48hs en procesarse, hasta que el mismo no se procese, el estado de tu reservación no sera modificado. NO vuelvas a intentar pagar la reservación si ya has pagado la misma y aun no se ha procesado el pago.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 36,),
                        Text(
                          snapshot.data,
                          textAlign: TextAlign.center,
                          
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 36,),
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Dirección',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              cryptoForm.walletAddress = value;
                              setState(() {});
                            },
                          ),
                          validator: 
                            cryptoForm.walletAddress.length > 0 ? 
                              cryptoForm.walletAddressValidator(cryptoForm.walletAddress) : 
                              null,
                        ),
                        Container(
                          width: double.infinity,
                          child: RegularButton(
                            onPressed: cryptoForm.isLoading || !cryptoForm.isValidForm()
                              ? null
                              : () async {
                                  cryptoForm.isValidForm();
                                  
                                  FocusScope.of(context).unfocus();

                                  if (!cryptoForm.isValidForm()) return;
                                  cryptoForm.isLoading = true;

                                  final Map<String, dynamic> body = {
                                    'wallet_id': cryptoForm.walletAddress,
                                    'reservation_id': widget.reservationID,
                                    'payment_method': 'Cripto Divisa'
                                  };

                                  final errorMessage = await paymentService.cryptoPay(body);

                                  if (errorMessage == null) {
                                    Navigator.pushNamed(context, '/MetodoPagoCongrats');
                                  } else {
                                    NotificationsService.showSnacbar(errorMessage);
                                    cryptoForm.isLoading = false;
                                  }
                                },
                            title: cryptoForm.isLoading
                                ? 'Pagando...'
                                : 'Pagar',
                            padding: EdgeInsets.only(top: 6.0),
                            innerPadding: EdgeInsets.all(16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );  
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'El dueño de esta embarcación\nno acepta criptomodenas\ncomo forma de pago.\nlo sentimos mucho.',
                    style: Styles.texts.emptysMessages,
                  ),
                ),
              ],
            );
          }
        } else {
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Ha ocurrido un error',
                    style: Styles.texts.emptysMessages,
                  ),
                ),
              ],
            );
        }
      }
    );
  }
}
import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago_params.dart';
import 'package:boaty/src/providers/pagos_form_provider.dart';
import 'package:boaty/src/services/notifications_service.dart';
import 'package:boaty/src/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:provider/provider.dart';

class MetodoTarjeta extends StatelessWidget {
  const MetodoTarjeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MetodoPagoArguments;
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: ChangeNotifierProvider(
        create: (_) => PagosTarjetasProvider(),
        child: MetodoTarjetaForm(reservationID: args.reservationID),
      ),
    );
  }
}

class MetodoTarjetaForm extends StatefulWidget {
  String reservationID;
  MetodoTarjetaForm({Key? key, required this.reservationID}) : super(key: key);

  @override
  _MetodoTarjetaFormState createState() => _MetodoTarjetaFormState();
}

class _MetodoTarjetaFormState extends State<MetodoTarjetaForm> {
  @override
  Widget build(BuildContext context) {
    final tarjetasForm = Provider.of<PagosTarjetasProvider>(context);
    final paymentService = new PaymentService();

    return Container(
      child: ListView(
        children: [
          CreditCardWidget(
              labelCardHolder: 'Nombre',
              cardBgColor: BoatyColors.primary,
              cardNumber: tarjetasForm.cardNumber,
              expiryDate: tarjetasForm.expiryDate, 
              cardHolderName: tarjetasForm.cardHolderName,
              cvvCode: tarjetasForm.cvvCode,
              showBackView: tarjetasForm.showBackView,
              onCreditCardWidgetChange: (creditCardBrand) {
                
              },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Column(
              children: [
                InputContainerWidget(
                  input: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    decoration: InputDecoration(
                      labelText: 'Número',
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      new CardInputFormater()
                    ],
                    onTap: () {
                      tarjetasForm.showBackView = false;
                    },
                    onChanged: (value) {
                      tarjetasForm.cardNumber = value;
                      setState(() {});
                    },
                  ),
                  validator: 
                    tarjetasForm.cardNumber.length > 0 ? 
                      tarjetasForm.cardNumberValidator(tarjetasForm.cardNumber) : 
                      null,
                ),
                InputContainerWidget(
                  input: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    decoration: InputDecoration(
                      labelText: 'Fecha de vencimiento',
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      new expInputFormatter()
                    ],
                    onTap: () {
                      tarjetasForm.showBackView = false;
                    },
                    onChanged: (value) {
                      tarjetasForm.expiryDate = value;
                      setState(() {});
                    },
                  ),
                  validator: 
                    tarjetasForm.expiryDate.length > 0 ? 
                      tarjetasForm.expiryDateValidator(tarjetasForm.expiryDate) : 
                      null,
                ),
                InputContainerWidget(
                  input: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      tarjetasForm.showBackView = false;
                    },
                    onChanged: (value) {
                      tarjetasForm.cardHolderName= value;
                      setState(() {});
                    },
                  ),
                  validator: 
                    tarjetasForm.cardHolderName.length > 0 ? 
                      tarjetasForm.cardHolderNameValidator(tarjetasForm.cardHolderName) : 
                      null,
                ),
                InputContainerWidget(
                  input: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    decoration: InputDecoration(
                      labelText: 'CVC',
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      tarjetasForm.showBackView = true;
                    },
                    onChanged: (value) {
                      tarjetasForm.cvvCode= value;
                      setState(() {});
                    },
                  ),
                  validator: 
                    tarjetasForm.cvvCode.length > 0 ? 
                      tarjetasForm.cvvCodeValidator(tarjetasForm.cvvCode) : 
                      null,
                ),
                Container(
                  width: double.infinity,
                  child: RegularButton(
                    onPressed: tarjetasForm.isLoading || !tarjetasForm.isValidForm()
                      ? null
                      : () async {
                          tarjetasForm.isValidForm();
                          
                          FocusScope.of(context).unfocus();

                          if (!tarjetasForm.isValidForm()) return;
                          tarjetasForm.isLoading = true;

                          final Map<String, dynamic> body = {
                            'card_number': tarjetasForm.cardNumber.replaceAll(' ', ''),
                            'exp_month': tarjetasForm.expiryDate.split('/')[0],
                            'exp_year': '20${tarjetasForm.expiryDate.split('/')[1]}',
                            'cvc': tarjetasForm.cvvCode,
                            'reservation_id': widget.reservationID
                          };

                          final errorMessage = await paymentService.creditCardPay(body);

                          if (errorMessage == null) {
                            Navigator.pushNamed(context, '/MetodoPagoCongrats');
                          } else {
                            NotificationsService.showSnacbar(errorMessage);
                            tarjetasForm.isLoading = false;
                          }
                        },
                    title: tarjetasForm.isLoading
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
  }
}

class CardInputFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); 
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}

class expInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length)
    );
  }
}
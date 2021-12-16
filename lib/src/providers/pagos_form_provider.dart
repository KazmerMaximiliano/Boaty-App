import 'package:flutter/material.dart';

class PagosTarjetasProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _showBackView = false;
  bool get showBackView => _showBackView;
  set showBackView(bool value) {
    _showBackView = value;
    notifyListeners();
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  String? cardNumberValidator(value) {
    final cardNumberValue = value.toString().replaceAll(' ', '');
    return cardNumberValue.length == 16 ? null : 'El número de la tarjeta debe contener 16 caracteres';
  }

  String? expiryDateValidator(value) {
    final expiryDateValue = value.toString().replaceAll('/', '');
    return expiryDateValue.length == 4 ? null : 'La fecha de vencimiento debe contener 4 caracteres';
  }

  String? cardHolderNameValidator(value) {
    return value.length > 4 ? null : 'El nombre es muy corto';
  }

  String? cvvCodeValidator(value) {
    return value.length == 3 ? null : 'El codigo cvv debe contener 3 caracteres';
  }

  bool isValidForm() {
    return  cardNumberValidator(cardNumber)         == null &&
            expiryDateValidator(expiryDate)         == null &&
            cardHolderNameValidator(cardHolderName) == null &&
            cvvCodeValidator(cvvCode)               == null;
  }
}

class PagosCryptosProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String walletAddress = '';

  String? walletAddressValidator(value) {
    return value.length > 4 ? null : 'La dirección es muy corta';
  }


  bool isValidForm() {
    return walletAddressValidator(walletAddress) == null;
  }
}
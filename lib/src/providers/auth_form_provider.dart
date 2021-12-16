import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String email = '';
  String password = '';

  String? emailValidator(value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value ?? '') ? null : 'El correo no es valido';
  }

  String? passwordValidator(value) {
    return value.length >= 4 ? null : 'La contraseña es muy corta';
  }

  bool isValidForm() {
    bool validEmail = emailValidator(email) == null;
    bool validPassword = passwordValidator(password) == null;
    return validEmail && validPassword;
  }
}

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String password = '';
  String passwordConfirm = '';
  dynamic address = '';
  dynamic birthday = '';

  String? paisValidator(value) {
    return value != 'País' ? null : 'Seleccione un país';
  }

  String? phoneValidator(value) {
    return value.length >= 6 ? null : 'Introduce un número valido';
  }

  String? firstNameValidator(value) {
    return value.length >= 4 ? null : 'El nombre es muy corto';
  }

  String? lastNameValidator(value) {
    return value.length >= 4 ? null : 'El apellido es muy corto';
  }

  String? emailValidator(value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value ?? '') ? null : 'El correo no es valido';
  }

  String? passwordValidator(value) {
    return value.length >= 4 ? null : 'La contraseña es muy corta';
  }

  String? passwordConfirmValidator(value, valueConfirm) {
    return value.length >= 4 && value == valueConfirm
        ? null
        : 'Las contraseñas no coinciden';
  }

  String? birthdayValidator(value) {
    return value != '' ? null : 'Seleccione una fecha';
  }

  bool isValidForm() {
    bool validPais = paisValidator(address) == null;
    bool validPhone = phoneValidator(phone) == null;
    bool validFirstName = firstNameValidator(firstName) == null;
    bool validLastName = lastNameValidator(lastName) == null;
    bool validEmail = emailValidator(email) == null;
    bool validPassword = passwordValidator(password) == null;
    bool validPasswordConfirm = passwordConfirmValidator(password, passwordConfirm) == null;
    
    return validPais && validPhone && validFirstName && validLastName && validEmail && validPassword && validPasswordConfirm;
  }

  bool isValidEditForm() {
    bool validPais = paisValidator(address) == null;
    bool validPhone = phoneValidator(phone) == null;
    bool validFirstName = firstNameValidator(firstName) == null;
    bool validLastName = lastNameValidator(lastName) == null;
    bool validEmail = emailValidator(email) == null;
    
    return validPais && validPhone && validFirstName && validLastName && validEmail;
  }
}

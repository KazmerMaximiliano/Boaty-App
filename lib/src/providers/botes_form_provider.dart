import 'dart:io';

import 'package:flutter/material.dart';

class BotesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _formStep = 0;
  int get formStep => _formStep;
  set formStep(int value) {
    _formStep = value;
    notifyListeners();
  }

  Map<int, File> _photosFilesList = {};
  Map<int, File> get photosFilesList => _photosFilesList;
  set photosFilesList(Map<int, File> value) {
    _photosFilesList = value;
    notifyListeners();
  }

  String type_id = '0';
  String title = '';
  String description = '';
  String capacity = '';
  String price = '';
  String coord = '';

  String? typeValidator(value) {
    return value != '0' ? null : 'Seleccione un tipo de embarcación';
  }

  String? titleValidator(value) {
    return value.length >= 4 ? null : 'El título es muy corto';
  }

  String? descriptionValidator(value) {
    return value.length >= 12 ? null : 'La descripción es muy corta';
  }

  String? capacityValidator(value) {
    return value.length >= 1 ? null : 'La capacidad debe ser mayor a 0';
  }

  String? priceValidator(value) {
    return value.length >= 1 ? null : 'El precio debe ser mayor a 0';
  }

  String? coordValidator(value) {
    return value != '' ? null : 'Seleccione una ubicación valida';
  }

  String? photosValidator(value) {
    return value.length > 0 ? null : 'Deve elegir al menos una foto';
  }

  bool isValidSectionGeneral() {
    bool typeValid = typeValidator(type_id) == null;
    bool titleValid = titleValidator(title) == null;
    bool descriptionValid = descriptionValidator(description) == null;

    return typeValid && titleValid && descriptionValid;
  }

  bool isValidSectionPrice() {
    bool capacityValid = capacityValidator(capacity) == null;
    bool priceValid = priceValidator(price) == null;

    return capacityValid && priceValid;
  }

  bool SectionsValidator() {
    switch(formStep) {
      case 0:
        return isValidSectionGeneral();
      case 1:
        return isValidSectionPrice();
      case 2:
        return coordValidator(coord) == null;
      case 3:
        return photosValidator(photosFilesList) == null;
      default:
        return true;
    }
  } 

  bool isValidForm() {
    bool typeValid = typeValidator(type_id) == null;
    bool titleValid = titleValidator(title) == null;
    bool descriptionValid = descriptionValidator(description) == null;
    bool capacityValid = capacityValidator(capacity) == null;
    bool priceValid = priceValidator(price) == null;
    bool coordValid = coordValidator(coord) == null;
    bool photosValid = photosValidator(photosFilesList) == null;
    
    return typeValid && titleValid && descriptionValid && capacityValid && priceValid && coordValid && photosValid;
  }
}

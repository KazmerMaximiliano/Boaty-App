import 'package:boaty/src/pages/auth/register/dropdowns/meses.dart';
import 'package:flutter/material.dart';
import 'package:boaty/src/pages/auth/register/dropdowns/paises.dart';

class RegisterDropdowns {
  static List<String> getCountries() {
    return List.from(['País'])..addAll(Paises().getPaises());
  }

  static List<String> getYears() {
    final List<String> yearsArray = ["Año"];
    DateTime now = new DateTime.now();

    for (var i = 1; i < (now.year - 150); i++) {
      yearsArray.add(i.toString());
    }

    return yearsArray;
  }

  static List<String> getMonths() {
    final months = Meses().getMonths();
    final List<String> monthsArray = ["Mes"];

    months.forEach((element) {
      monthsArray.add(element['name']);
    });

    return monthsArray;
  }

  static List<String> getDays(month) {
    final months = Meses().getMonths();
    final List<String> daysArray = [];

    for (var i = 1;
        i < months.where((e) => e["name"] == month).first['days'];
        i++) {
      daysArray.add(i.toString());
    }

    return daysArray;
  }

  static List<DropdownMenuItem<String>> items(List<String> list) {
    final items =
        list.map((String showedOption) => _option(showedOption)).toList();
    return items;
  }

  static DropdownMenuItem<String> _option(String showedOption) {
    return DropdownMenuItem<String>(
      value: showedOption,
      child: Text(showedOption),
    );
  }

  static List<DropdownMenuItem<String>> get paisesToItems =>
      items(getCountries());
  static List<DropdownMenuItem<String>> get mesesToItems => items(getMonths());
  static List<DropdownMenuItem<String>> diasToItems(month) =>
      items(getDays(month));
  static List<DropdownMenuItem<String>> get aniosToItems => items(getYears());
}

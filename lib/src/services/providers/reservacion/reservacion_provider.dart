import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/congrats/reserva_congrats_page.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/disponibilidad/disponibilidad_page.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/pre_checkout/pre_checkout_page.dart';
import 'package:boaty/src/services/navigate_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:boaty/src/services/date_time_extensions/date_time_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as dev;

enum TipoPago { tarjeta, transferencia, paypal, cripto, noEspecificado }

enum ReservaStep { disponibilidad, precheckout, congrats }

extension TipoPagoExt on TipoPago {
  String get buttonTitle {
    String tipo = "";
    switch (this) {
      case TipoPago.noEspecificado:
        tipo = "No Especificado";
        break;
      case TipoPago.tarjeta:
        tipo = "Tarjeta de crédito o débito";
        break;
      case TipoPago.transferencia:
        tipo = "Transferencia";
        break;
      case TipoPago.cripto:
        tipo = "Criptomonedas";
        break;
      case TipoPago.paypal:
        tipo = "PayPal";
        break;
    }
    return tipo;
  }

  Widget buttonIcon(bool selected) {
    final color = selected ? BoatyColors.grey : BoatyColors.primary;
    Widget icon = Icon(Icons.error_outline_outlined, color: color);
    switch (this) {
      case TipoPago.noEspecificado:
        icon = Icon(Icons.error_outline_outlined, color: color);
        break;
      case TipoPago.tarjeta:
        icon = Icon(Icons.credit_card_rounded, color: color);
        break;
      case TipoPago.transferencia:
        icon = Icon(Icons.sync_alt_rounded, color: color);
        break;
      case TipoPago.cripto:
        icon = FaIcon(FontAwesomeIcons.bitcoin, color: color);
        break;
      case TipoPago.paypal:
        icon = FaIcon(FontAwesomeIcons.paypal, color: color);
        break;
    }
    return icon;
  }
}

class ReservacionProvider {
  ReservacionProvider._();
  static final ReservacionProvider _instance = ReservacionProvider._();
  factory ReservacionProvider() => _instance;

  ReservaStep _step = ReservaStep.disponibilidad;

  Bote _bote = Bote();
  List<DateTime> _dias = <DateTime>[];
  int _cantPasajeros = 1;
  TipoPago _tipoPago = TipoPago.noEspecificado;
  bool _success = true;

  void initReserva(BuildContext context, Bote bote) {
    setBote = bote;
    Nav.pushIntoMenu(context, _stepRouteWidget);
  }

  ReservaStep get step => _step;

  ReservaStep get _nextStep {
    ReservaStep next;
    switch (_step) {
      case ReservaStep.disponibilidad:
        next = ReservaStep.precheckout;
        break;
      case ReservaStep.precheckout:
        // next = ReservaStep.metodopago;
        next = ReservaStep.congrats;
        break;
      // case ReservaStep.metodopago:
      // next = _success ? ReservaStep.congrats : ReservaStep.error;
      // break;
      default:
        next = ReservaStep.disponibilidad;
        break;
    }
    return next;
  }

  ReservaStep get _previousStep {
    ReservaStep prev;
    switch (_step) {
      case ReservaStep.precheckout:
        prev = ReservaStep.disponibilidad;
        break;
      // case ReservaStep.metodopago:
      //   prev = ReservaStep.precheckout;
      //   break;
      case ReservaStep.congrats:
      default:
        prev = ReservaStep.disponibilidad;
        break;
    }
    return prev;
  }

  Bote get bote => _bote;
  set setBote(Bote nuevoBote) => _bote = nuevoBote;
  List<DateTime> get dias => _dias;
  set setDias(List<DateTime> nuevosDias) => _dias = nuevosDias;
  int get cantPasajeros => _cantPasajeros;
  set cantPasajeros(int nuevoCant) => _cantPasajeros = nuevoCant;

  TipoPago get tipoPago => _tipoPago;
  set setTipoPago(TipoPago nuevoTipo) => _tipoPago = nuevoTipo;

  void _clearData() {
    _bote = Bote();
    _dias = <DateTime>[];
    _cantPasajeros = 1;
    _tipoPago = TipoPago.noEspecificado;
  }

  Widget get _stepRouteWidget {
    Widget widget;
    switch (_step) {
      case ReservaStep.disponibilidad:
        widget = DisponibilidadPage();
        break;
      case ReservaStep.precheckout:
        widget = PreCheckoutPage();
        break;
      // case ReservaStep.metodopago:
      //   widget = MetodoPagoPage();
      //   break;
      // case ReservaStep.error:
      //   widget = ReservaErrorPage();
      //   break;
      case ReservaStep.congrats:
        widget = ReservaCongratsPage();
        break;
    }
    return widget;
  }

  void reset(BuildContext context) {
    _step = ReservaStep.disponibilidad;
    _clearData();
    Navigator.pushReplacementNamed(context, '/');
  }

  void _setPreviousStep() => _step = _previousStep;
  void _setNextStep() => _step = _nextStep;

  void Function() back(BuildContext context) {
    return () {
      _setPreviousStep();
      if (_step == ReservaStep.disponibilidad) _clearData();
      if (Navigator.of(context).canPop()) Navigator.pop(context);
    };
  }

  Future<bool> Function() onWillPop(BuildContext context) {
    return () async {
      _setPreviousStep();
      if (Navigator.of(context).canPop()) Navigator.pop(context);
      return false;
    };
  }

  void goToNextStep(BuildContext context) {
    dev.log(this.toStr);
    final ok = _validate(context);
    if (ok) {
      _setNextStep();
      Nav.pushIntoMenu(context, _stepRouteWidget);
    }
  }

  bool _validate(BuildContext context) {
    String msg = "";
    switch (_step) {
      case ReservaStep.disponibilidad:
        if (_dias.isEmpty) msg = "Seleccione uno o más días";
        break;
      case ReservaStep.precheckout:
        if (!(_cantPasajeros >= 1))
          msg = "Debe haber al menos un adulto en la embarcación";
        break;
      // case ReservaStep.metodopago:
      //   if (_tipoPago == TipoPago.noEspecificado)
      //     msg = "Seleccione un tipo de pago válido";
      //   break;
      default:
        msg = "";
        break;
    }
    if (msg.isNotEmpty) {
      showCustomSnackbar(
        context,
        mensaje: msg,
        snackState: SnackState.error,
      );
    }
    final todoOk = msg.isEmpty;
    return todoOk;
  }

  Widget get diasContainer {
    Map<String, List<int>> fechas = {};

    _dias.map((DateTime d) {
      if (fechas.containsKey("${d.monthToString}")) {
        fechas["${d.monthToString}"]!.add(d.day);
      } else {
        fechas["${d.monthToString}"] = <int>[d.day];
      }
    }).toList();

    String _diasDelMes(String key) {
      List<int> dias = fechas[key]!;
      String month = "$key: ";
      for (int dia in dias) {
        month += "$dia";
        if (dia != dias.last) month += " - ";
      }
      return month;
    }

    String dates() {
      String dates = "";
      fechas.keys.map((String key) {
        dates += "${_diasDelMes(key)}";
        if (key != fechas.keys.last) dates += "\n";
      }).toList();
      return dates;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        margin: const EdgeInsets.only(bottom: 32.0),
        decoration: BoxDecoration(
          color: BoatyColors.lightBlue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text("${dates()}", style: Styles.texts.preCheckoutDates),
      ),
    );
  }

  String get tipoPagoToString {
    String tipo = "";
    switch (tipoPago) {
      case TipoPago.noEspecificado:
        tipo = "No Especificado";
        break;
      case TipoPago.tarjeta:
        tipo = "Tarjeta";
        break;
      case TipoPago.transferencia:
        tipo = "Transferencia";
        break;
      case TipoPago.cripto:
        tipo = "Cripto";
        break;
      case TipoPago.paypal:
        tipo = "PayPal";
        break;
    }
    return tipo;
  }

  String get toStr {
    return """
    Reservacion Data:
    Bote: $_bote
    Dias: $_dias
    Cantidad de Pasajeros: $_cantPasajeros
    Tipo de Pago: $_tipoPago
    """;
  }
}

extension ListDateTimeExt on List<DateTime> {
  void ordenar() {
    List<int> meses = [];
    this.map((DateTime d) {
      if (!(meses.contains(d.month))) meses.add(d.month);
    }).toList();
    meses.sort((a, b) => a.compareTo(b));
    for (int m in meses) {
      List<DateTime> diasDelMes = [];
      for (DateTime d in this) {
        if (d.month == m) diasDelMes.add(d);
      }
      for (DateTime dia in diasDelMes) {
        this.remove(dia);
      }
      diasDelMes.sort((a, b) => a.day.compareTo(b.day));
      this.addAll(diasDelMes);
    }
  }

  bool containsThisDay(DateTime dateTime) {
    final DateTime find = dateTime.toParsed;
    final bool contained = this.contains(find);
    return contained;
  }
}

import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:boaty/src/services/providers/reservacion/reservacion_provider.dart';
import 'package:boaty/src/globals/widgets/large_button.dart';
import 'package:boaty/src/globals/styles/styles.dart';

class DisponibilidadBody extends StatefulWidget {
  @override
  _DisponibilidadPageState createState() => _DisponibilidadPageState();
}

class _DisponibilidadPageState extends State<DisponibilidadBody> {
  final _reserva = ReservacionProvider();
  List<DateTime> _selectedDays = [];
  late DateTime _fechaDesdeValida;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final _style = Styles.calendar;

  final List<DateTime> _diasOcupados = [];
  final List<DateTime> _diasDisponibles = [];

  @override
  void initState() {
    super.initState();

    if (_reserva.bote.availables != null) {
      _reserva.bote.availables!.forEach((e) { 
        _diasDisponibles.add(DateTime.parse(e));
      });
    }

    if (_reserva.bote.reserved != null) {
      _reserva.bote.reserved!.forEach((e) { 
        _diasOcupados.add(DateTime.parse(e));
      });
    }

    final DateTime _ya = DateTime.now();
    final Duration _quitar = Duration(
      minutes: _ya.minute,
      hours: _ya.hour,
      seconds: _ya.second,
      milliseconds: _ya.millisecond,
      microseconds: _ya.microsecond,
    );
    final DateTime _hoy = _ya.subtract(_quitar);
    _fechaDesdeValida = _hoy.subtract(Duration(days: 1));
  }

  static const Map<CalendarFormat, String> _availableCalendarFormats = {
    CalendarFormat.month: "Mes",
    CalendarFormat.week: "Semana",
  };

  void _onFormatChanged(CalendarFormat _format) {
    setState(() {
      format = _format;
    });
  }

  void _onDaySelected(DateTime selectDay, DateTime focusDay) {
    selectedDay = selectDay;
    focusedDay = focusDay;
    final bool esUnDiaDisponible = _diasDisponibles.contains(selectDay);
    final bool esUnDiaOcupado = _diasOcupados.contains(selectedDay);
    final bool elDiaYaPaso = selectedDay.isBefore(_fechaDesdeValida);
    if(esUnDiaDisponible) {
      if (!esUnDiaOcupado && !elDiaYaPaso) {
        if (_selectedDays.contains(selectDay)) {
          _selectedDays.remove(selectDay);
        } else {
          _selectedDays.add(selectDay);
        }
        _reserva.setDias = _selectedDays;
        setState(() {});
      }
    } else {
      showCustomSnackbar(
        context,
        mensaje: "Este día no esta disponible para una reservación",
        snackState: SnackState.error,
      );
    }
  }

  bool _selectedDayPredicate(DateTime date) => _selectedDays.contains(date);

  void _onDisabledDayTapped(DateTime disabledDay) {
    showCustomSnackbar(
      context,
      mensaje: "Este día esta ocupado",
      snackState: SnackState.error,
    );
  }

  bool _enabledDayPredicate(DateTime day) =>
      _diasDisponibles.contains(day);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TableCalendar(
            locale: "es_ES",
            focusedDay: selectedDay,
            firstDay: DateTime.now().subtract(Duration(days: 3650)),
            lastDay: DateTime.now().add(Duration(days: 3650)),
            calendarStyle: _style.calendarStyle,
            headerStyle: _style.headerStyle,
            calendarFormat: format,
            availableCalendarFormats: _availableCalendarFormats,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onFormatChanged: _onFormatChanged,
            onDaySelected: _onDaySelected,
            onDisabledDayTapped: _onDisabledDayTapped,
            enabledDayPredicate: _enabledDayPredicate,
            selectedDayPredicate: _selectedDayPredicate,
          ),
          Spacer(),
          LargeButton(
            padding: const EdgeInsets.all(32.0),
            title: "Siguiente / Registrarse",
            textStyle: Styles.texts.fab,
            onPressed: () {
              _reserva.dias.ordenar();
              _reserva.goToNextStep(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/services/date_time_extensions/date_time_extension.dart';

class NuevaDisponibilidadBody extends StatefulWidget {
  NuevaDisponibilidadBody({required this.bote});
  final Bote bote;

  @override
  _NuevaDisponibilidadPageState createState() => _NuevaDisponibilidadPageState(bote: bote);
}

class _NuevaDisponibilidadPageState extends State<NuevaDisponibilidadBody> {
  _NuevaDisponibilidadPageState({required this.bote});
  final Bote bote;
  bool isLoading = false;
  final boatsService = new BoatsService();

  List<DateTime> _selectedDays = [];
  final List<DateTime> _diasOcupados = [];
  late DateTime _fechaDesdeValida;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final _style = Styles.calendar;

  @override
  void initState() {
    super.initState();

    if (bote.availables != null) {
      bote.availables!.forEach((e) { 
        _selectedDays.add(DateTime.parse(e).toUtc());
      });
    }

    if (bote.reserved != null) {
      bote.reserved!.forEach((e) { 
        _diasOcupados.add(DateTime.parse(e).toUtc());
      });
    }

    print(_diasOcupados);

    final DateTime _ya = DateTime.now();
    final Duration _quitar = Duration(
      minutes: _ya.minute,
      hours: _ya.hour,
      seconds: _ya.second,
      milliseconds: _ya.millisecond,
      microseconds: _ya.microsecond,
    );
    final DateTime _hoy = _ya.subtract(_quitar);
    _fechaDesdeValida = _hoy;
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
    final bool esUnDiaOcupado = _diasOcupados.contains(selectDay.toParsed);
    final bool elDiaYaPaso = selectedDay.isBefore(_fechaDesdeValida);
    if (!esUnDiaOcupado && !elDiaYaPaso) {
      if (_selectedDays.contains(selectDay)) {
        _selectedDays.remove(selectDay);
      } else {
        _selectedDays.add(selectDay);
      }
      setState(() {});
    } else {
      showCustomSnackbar(
        context,
        mensaje: "Este día no esta disponible para una nueva disponibilidad",
        snackState: SnackState.error,
      );
    }
  }

  bool _selectedDayPredicate(DateTime date) => _selectedDays.contains(date);

  void _onDisabledDayTapped(DateTime disabledDay) {
    showCustomSnackbar(
      context,
      mensaje: "Este día esta reservado",
      snackState: SnackState.error,
    );
  }

  bool _enabledDayPredicate(DateTime day) {
    if (_diasOcupados.contains(day)) {
      return false;
    }
    return true;
  }

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
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: Styles.buttons.largeButton,
                  child: Text(isLoading ? "Actualizando..." : "Actualizar", style: Styles.texts.fab),
                  onPressed: isLoading ? null : () async {
                    isLoading = true;
                    setState(() {});

                    final response = await boatsService.updateAvailavilitis(_selectedDays, bote.id);

                    isLoading = false;
                    setState(() {});

                    if (response != null) {
                      showCustomSnackbar(
                        context,
                        mensaje: response,
                        snackState: SnackState.error,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioStyles {
  BoxDecoration get disabledDecoration => BoxDecoration(
        color: BoatyColors.grey,
        shape: BoxShape.circle,
      );

  TextStyle get disabledTextStyle => TextStyle(color: Colors.black);

  BoxDecoration get selectedDecoration => BoxDecoration(
        color: BoatyColors.blue,
        shape: BoxShape.circle,
      );

  TextStyle get selectedTextStyle => TextStyle(color: Colors.white);

  BoxDecoration get todayDecoration => BoxDecoration(
        color: BoatyColors.amber,
        shape: BoxShape.circle,
      );

  HeaderStyle get headerStyle {
    return HeaderStyle(
      formatButtonVisible: true,
      titleCentered: true,
      formatButtonShowsNext: false,
      formatButtonDecoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5.0),
      ),
      formatButtonTextStyle: TextStyle(
        color: Colors.white,
      ),
    );
  }

  CalendarStyle get calendarStyle {
    return CalendarStyle(
      disabledDecoration: this.disabledDecoration,
      disabledTextStyle: this.disabledTextStyle,
      selectedDecoration: this.selectedDecoration,
      selectedTextStyle: this.selectedTextStyle,
      isTodayHighlighted: true,
      todayDecoration: this.todayDecoration,
    );
  }
}

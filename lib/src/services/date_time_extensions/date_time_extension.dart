extension DateTimeExtension on DateTime {
  String get monthToString {
    String m = "";
    switch (this.month) {
      case 1:
        m = "Enero";
        break;
      case 2:
        m = "Febrero";
        break;
      case 3:
        m = "Marzo";
        break;
      case 4:
        m = "Abril";
        break;
      case 5:
        m = "Mayo";
        break;
      case 6:
        m = "Junio";
        break;
      case 7:
        m = "Julio";
        break;
      case 8:
        m = "Agosto";
        break;
      case 9:
        m = "Septiembre";
        break;
      case 10:
        m = "Octubre";
        break;
      case 11:
        m = "Noviembre";
        break;
      case 12:
        m = "Diciembre";
        break;
    }
    return m;
  }

  String numberToStringWithZero(int number) {
    String m = "0";

    if (number >= 10) {
      m = number.toString();
    } else {
      m = "0$number";
    }

    return m;
  }

  String get toParsedString {
    final mes = "${this.numberToStringWithZero(this.month)}";
    final dia = "${this.numberToStringWithZero(this.day)}";
    final String str = "${this.year}-$mes-$dia";

    return str;
  }

  DateTime get toParsed {
    return DateTime.parse("${this.toParsedString}");
  }
}

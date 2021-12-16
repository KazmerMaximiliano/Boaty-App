class Meses {
  final List<Map<String, dynamic>> months = [
    {"name": "Enero", "short": "Ene", "number": 1, "days": 31},
    {"name": "Febrero", "short": "Feb", "number": 2, "days": 28},
    {"name": "Marzo", "short": "Mar", "number": 3, "days": 31},
    {"name": "Abril", "short": "Abr", "number": 4, "days": 30},
    {"name": "Mayo", "short": "May", "number": 5, "days": 31},
    {"name": "Junio", "short": "Jun", "number": 6, "days": 30},
    {"name": "Julio", "short": "Jul", "number": 7, "days": 31},
    {"name": "Agosto", "short": "Ago", "number": 8, "days": 31},
    {"name": "Septiembre", "short": "Sep", "number": 9, "days": 30},
    {"name": "Octubre", "short": "Oct", "number": 10, "days": 31},
    {"name": "Noviembre", "short": "Nov", "number": 11, "days": 30},
    {"name": "Diciembre", "short": "Dec", "number": 12, "days": 31}
  ];

  List<Map<String, dynamic>> getMonths() {
    return months;
  }
}

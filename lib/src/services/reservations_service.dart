import 'dart:convert';

import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/models/reservation.dart';
import 'package:boaty/src/models/user.dart';
import 'package:boaty/src/services/boats_service.dart';
import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReservationService extends ChangeNotifier {
  final authService = new AuthService();
  final boatsService = new BoatsService();
  final String _baseUrl = dotenv.env['URL'].toString();
  static final _prefs = SharedPrefs();

  Future<List?> getReservations() async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/reservations');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);
  
    if (resp.statusCode == 200) {
      final decodeData = json.decode(resp.body);
      final List data = [];

      for (var i = 0; i < decodeData['data'].length; i++) {
        final element = decodeData['data'][i];
        final bote = await boatsService.getBoatById(element['boat_id']);

        data.add({
          'reservation': Reservation.fromJson(element),
          'boat': bote
        });
      }
      
      return data;
    } else {
      return [];
    }
  }

  Future<String?> setReservation(reservation) async {
    final BoatyUser user = await authService.readUser();
    final String token = await authService.readToken();

    final url = Uri.parse('$_baseUrl/reservations');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final List<String> dias = [];
    reservation.dias.forEach((e) => {
      dias.add(e.toString())
    });

    final Map<String, dynamic> body = {
      'boat_id': reservation.bote.id.toString(),
      'amount': reservation.bote.price.toString(),
      'client_id': user.id.toString(),
      'reserved_days': dias
    };

    final resp = await http.post(url, body: jsonEncode(body), headers: headers);

    if (resp.statusCode == 201) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> cancelReservation(id) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/cancel-reservation/$id');
    final Map<String, String> headers = {
      "Authorization": "Bearer $token"
    };

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> rateReservation(body) async {
    final String token = await authService.readToken();

    final url = Uri.parse('$_baseUrl/ratings');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(url, body: jsonEncode(body), headers: headers);
    if (resp.statusCode == 201) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }
}
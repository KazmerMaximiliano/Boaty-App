import 'dart:convert';

import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PaymentService extends ChangeNotifier {
  final authService = new AuthService();
  final String _baseUrl = dotenv.env['URL'].toString();
  static final _prefs = SharedPrefs();

  Future<String?> creditCardPay(body) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/confirm');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(url, body: json.encode(body), headers: headers);

    if (resp.statusCode == 201) {
      return null;
    } else {
      print(resp.body);
      return 'Ha ocurrido un error';
    }
  }

  Future<Map<String, String>?> getOwnerWallet(id) async {
    final String token = await authService.readToken();
    final url = Uri.parse("$_baseUrl/get-crypto-address");
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if(resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);

      return {
        'address': decodedData['address'],
        'currency': decodedData['currency']
      };
    } else {
      return null;
    }
  }

  Future<String?> cryptoPay(body) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/cripto-pay');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(url, body: json.encode(body), headers: headers);

    if (resp.statusCode == 201) {
      return null;
    } else {
      print(resp.body);
      return 'Ha ocurrido un error';
    }
  }
}
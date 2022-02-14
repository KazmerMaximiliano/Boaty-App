import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class StripeService extends ChangeNotifier {
  final authService = new AuthService();
  final String _baseUrl = dotenv.env['URL'].toString();
  static final _prefs = SharedPrefs();

  Future<String?> connectStripeAccount() async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/connect');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);
    
    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      return null;
    }
  }

  void openStripeUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }    
  }

  Future<String?> setCryptoAddress(address, divisa) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/set-crypto-address');
    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };

    final Map<String, dynamic> body = {
      'crypto_currency': divisa,
      'crypto_address': address,
    };

    final resp = await http.post(url, body: body, headers: headers);

    if (resp.statusCode == 200) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }
}
import 'dart:convert';

import 'package:boaty/src/models/bote.dart';
import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BoatsService extends ChangeNotifier {
  final authService = new AuthService();
  final String _baseUrl = dotenv.env['URL'].toString();
  static final _prefs = SharedPrefs();

  Future<List<Bote>> getBoats(filters) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/boats/$filters');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      print(decodedData);
      final List<Bote> arrayData = [];

      decodedData['data'].forEach((element) => {
        arrayData.add(new Bote.fromJson(element))
      });

      return arrayData;
    } else {
      return [];
    }
  }

  Future<List<Bote>> getOwnerBoats() async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/owner-boats');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final List<Bote> arrayData = [];

      decodedData['data'].forEach((element) => {
        arrayData.add(new Bote.fromJson(element))
      });

      return arrayData;
    } else {
      return [];
    }
  }

  Future<Bote?> getBoatById(id) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/boats/show/$id');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      return new Bote.fromJson(decodedData['data']);
    } else {
      return null;
    }
  }

  Future setUnsetFaouriteBoat(id, like) async {
    final String token = await authService.readToken();
    final setUrl = Uri.parse('$_baseUrl/boat/favourite');
    final unSetUrl = Uri.parse('$_baseUrl/boat/unfavourite');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    if(like) {
      final resp = await http.post(setUrl, headers: headers, body: {
        'favourites_boat': id.toString()
      });
    } else {
      final resp = await http.post(unSetUrl, headers: headers, body: {
        'unfavourite_boat': id.toString()
      });
    }
  }

  Future<List<Bote>> getFavouritesBoats() async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/user-favourites-boats');
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      final List<Bote> arrayData = [];

      decodedData['data'].forEach((element) => {
        arrayData.add(new Bote.fromJson(element))
      });

      return arrayData;
    } else {
      return [];
    }
  }

  Future<String?> saveBoat(body) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/boats');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(url, body: json.encode(body), headers: headers);

    if (resp.statusCode == 201) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> updateAvailavilitis(dates, boatID) async {
    final String token = await authService.readToken();
    final url = Uri.parse('$_baseUrl/update-availavilities/$boatID');
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final List<String> datesArray = [];
    dates.forEach((e) => {
      datesArray.add(e.toString())
    });

    final Map<String, dynamic> body = {
      'dates': datesArray,
    };

    final resp = await http.put(url, body: json.encode(body), headers: headers);

    if (resp.statusCode == 200) {
      return null;
    } else {
      return 'Ha ocurrido un error';
    }
  }
}
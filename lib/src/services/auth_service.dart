import 'dart:convert';
import 'dart:io';

import 'package:boaty/src/models/user.dart';
import 'package:boaty/src/services/services.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['URL'].toString();
  final storage = FlutterSecureStorage();
  static final _prefs = SharedPrefs();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> register(
    String firstName,
    String lastName,
    String phone,
    String address,
    DateTime birthday,
    String email,
    String password,
    String passwordConfirm,
  ) async {
    final Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'birthday': birthday.toString(),
      'address': address,
      'email': email,
      'password': password,
      'password_confirm': passwordConfirm,
    };

    final url = Uri.parse("$_baseUrl/register");

    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final resp = await http.post(url, body: body, headers: headers);

    if (resp.statusCode == 201) {
      await this.login(email, password);
      return null;
    } else {
      return 'Los datos ingresados son incorrectos';
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse("$_baseUrl/login");

    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final resp = await http.post(url, body: body, headers: headers);

    if (resp.statusCode == 200) {
      await storage.write(key: 'token', value: resp.body);
      _prefs.logged = true;
      await this.user();
      return null;
    } else {
      _prefs.logged = false;
      return 'Los datos son incorrectos';
    }
  }

  Future<String?> loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    var credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    await _auth.signInWithCredential(credential);

    String? token = googleSignInAuthentication.accessToken;
    String deviceName = await getDeviceInfo();

    final Map<String, dynamic> body = {
      'token': token,
      'device_name': deviceName,
    };

    final url = Uri.parse("$_baseUrl/auth/google");

    final resp = await http.post(url, body: body);

    if (resp.statusCode == 200) {
      await storage.write(key: 'token', value: resp.body);
      _prefs.logged = true;
      await this.user();
      return null;
    } else {
      _prefs.logged = false;
      return 'Los datos son incorrectos';
    }
  }

  Future<String?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final String token = result.accessToken!.token;
      String deviceName = await getDeviceInfo();

      final Map<String, dynamic> body = {
        'token': token,
        'device_name': deviceName,
      };

      final url = Uri.parse("$_baseUrl/auth/facebook");

      final resp = await http.post(url, body: body);

      if (resp.statusCode == 200) {
        await storage.write(key: 'token', value: resp.body);
        _prefs.logged = true;
        await this.user();
        return null;
      } else {
        _prefs.logged = false;
        return 'Los datos son incorrectos';
      }
    }

    return 'Ha ocurrido un error';
  }

  Future<String?> loginWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        if (result.credential!.email == null) {
          return "Necesitamos conocer tu Email";
        } else {
          String deviceName = await getDeviceInfo();

          final Map<String, dynamic> body = {
            'email': result.credential!.email,
            'name':
                '${result.credential!.fullName!.familyName} ${result.credential!.fullName!.givenName}',
            'device_name': deviceName,
          };

          final url = Uri.parse("$_baseUrl/auth/apple");

          final resp = await http.post(url, body: body);

          if (resp.statusCode == 200) {
            await storage.write(key: 'token', value: resp.body);
            _prefs.logged = true;
            await this.user();
            return null;
          } else {
            _prefs.logged = false;
            return 'Ha ocurrido un error inesperado';
          }
        }

      case AuthorizationStatus.error:
        return 'Ha fallado la autenticación';

      case AuthorizationStatus.cancelled:
        return 'Se ha cancelado la autenticación';

      default:
        return 'Ha ocurrido un error inesperado';
    }
  }

  Future addOwnerRole() async {
    final token = await readToken();
    final url = Uri.parse("$_baseUrl/add-owner-role");
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      _prefs.user = resp.body;
      return null;
    } else {
      _prefs.logged = false;
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> updateAccount(
    String firstName,
    String lastName,
    String phone,
    String address,
    dynamic birthday,
    String email,
  ) async {
    final token = await readToken();

    final Map<String, dynamic> body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'birthday': birthday.toString(),
      'address': address,
      'email': email,
    };

    final url = Uri.parse("$_baseUrl/update_account");

    final Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };

    final resp = await http.post(url, body: body, headers: headers);

    if (resp.statusCode == 200) {
      await this.user();
      return null;
    } else {
      return 'Los datos ingresados son incorrectos';
    }
  }

  Future user() async {
    final token = await readToken();
    final url = Uri.parse("$_baseUrl/user");
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    final resp = await http.get(url, headers: headers);

    if (resp.statusCode == 200) {
      _prefs.user = resp.body;
      final BoatyUser user = BoatyUser.fromJson(json.decode(_prefs.user));
      _prefs.adminView = user.roles!.contains('owner');
      return null;
    } else {
      _prefs.logged = false;
      return 'Los datos son incorrectos';
    }
  }

  BoatyUser readUser() {
    final BoatyUser user = BoatyUser.fromJson(json.decode(_prefs.user));
    return user;
  }

  Future<String> readStateUser() async {
    final token = await this.readToken();

    if (token != '') {
      final BoatyUser user = BoatyUser.fromJson(json.decode(_prefs.user));

      if (user.roles!.contains('owner') && !user.roles!.contains('admin')) {
        if (user.stripeId != null) {
          return 'logged';
        } else {
          return 'pending_stripe_account';
        }
      } else {
        return 'logged';
      }
    } else {
      return 'not_logged';
    }
  }

  Future logout(BuildContext context) async {
    final token = await readToken();
    final url = Uri.parse("$_baseUrl/logout");
    final Map<String, String> headers = {"Authorization": "Bearer $token"};

    await http.get(url, headers: headers);

    await storage.delete(key: 'token');
    _prefs.logged = false;
    Navigator.of(context).pushReplacementNamed('/');
  }

  Future<String> readToken() async {
    String token = await storage.read(key: 'token') ?? '';

    if (token == '' || !_prefs.logged) {
      _prefs.logged = false;
      return '';
    } else {
      return token;
    }
  }

  Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = 'unknown';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceName =
          '${androidInfo.model}${androidInfo.version.toString()}${androidInfo.androidId}'
              .replaceAll(' ', '');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceName =
          '${iosInfo.model}${iosInfo.systemVersion.toString()}${iosInfo.identifierForVendor}'
              .replaceAll(' ', '');
    }

    return deviceName;
  }
}

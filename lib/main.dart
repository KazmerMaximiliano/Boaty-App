import 'package:boaty/src/boaty_app.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = SharedPrefs();
  await prefs.initPrefs();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // initializeDateFormatting();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp();

  runApp(BoatyApp());
}

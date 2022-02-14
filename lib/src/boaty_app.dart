import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/routes/boaty_routes.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BoatyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boaty',
      theme: Boaty.theme,
      initialRoute: BoatyRoutes.initialRoute,
      routes: BoatyRoutes.routes,
      scaffoldMessengerKey: NotificationsService.messagerKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('es')
      ],
    );
  }
}

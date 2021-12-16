import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/pages/home/home_page.dart';
import 'package:boaty/src/pages/menu/menu.dart';
import 'package:boaty/src/pages/stripe/connect_stripe_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boaty/src/services/services.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readStateUser(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget();
            }
            if (snapshot.data == 'logged') {
                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => BoatyMenu(),
                        transitionDuration: Duration(seconds: 0)));
                });
            } else if (snapshot.data == 'pending_stripe_account') {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ConnectStripeAccountPage(),
                        transitionDuration: Duration(seconds: 0)));
                });
            } else {
                Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomePage(),
                        transitionDuration: Duration(seconds: 0)));
                });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
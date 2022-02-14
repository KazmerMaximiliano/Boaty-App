import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Nav {
  static void pushToWidget(BuildContext context, Widget route) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => route));
  }

  static void pushToNamed(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  static void pushIntoMenu(BuildContext context, Widget page) {
    pushNewScreen(context, screen: page);
  }

  // static void goToFinishRegister(
  //   BuildContext context,
  //   FinishRegisterDataArguments args,
  // ) {
  //   Navigator.of(context).push(
  //     Platform.isAndroid
  //         ? MaterialPageRoute(builder: (_) => FinishRegisterPage(args: args))
  //         : CupertinoPageRoute(builder: (_) => FinishRegisterPage(args: args)),
  //   );
  // }

  // static void goToEmailLogin(
  //   BuildContext context,
  //   EmailLoginDataArguments args,
  // ) {
  //   Navigator.of(context).push(
  //     Platform.isAndroid
  //         ? MaterialPageRoute(builder: (_) => EmailLoginPage())
  //         : CupertinoPageRoute(builder: (_) => EmailLoginPage()),
  //   );
  // }
}

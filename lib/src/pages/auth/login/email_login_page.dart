import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/pages/auth/login/email_login_form.dart';
import 'package:boaty/src/providers/auth_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: EmailLoginForm(),
      ),
    );
  }
}

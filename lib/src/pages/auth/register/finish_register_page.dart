import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/pages/auth/register/finish_register_form.dart';
import 'package:boaty/src/providers/auth_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: FinishRegisterForm(),
      ),
    );
  }
}

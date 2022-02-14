import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/providers/auth_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishRegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      child: Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: BoatyLogo.fullBig,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

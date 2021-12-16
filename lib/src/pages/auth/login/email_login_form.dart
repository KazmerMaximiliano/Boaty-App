import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/widgets/widgets.dart';
import 'package:boaty/src/providers/auth_form_provider.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EmailLoginForm extends StatefulWidget {
  const EmailLoginForm({Key? key}) : super(key: key);

  @override
  _EmailLoginFormState createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      children: [
                        InputContainerWidget(
                          input: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              loginForm.email = value;
                              setState(() {});
                            },
                          ),
                          validator:
                            loginForm.email.length > 0 ?
                              loginForm.emailValidator(loginForm.email) :
                              null,
                        ),
                        InputContainerWidget(
                          input: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              loginForm.password = value;
                              setState(() {});
                            },
                          ),
                          validator: 
                            loginForm.password.length > 0 ? 
                              loginForm.passwordValidator(loginForm.password) : 
                              null,
                        ),
                        SizedBox(height: 24.0),
                        RegularButton(
                          onPressed: loginForm.isLoading || !loginForm.isValidForm()
                              ? null
                              : () async {
                                  loginForm.isValidForm();
                                  
                                  FocusScope.of(context).unfocus();

                                  if (!loginForm.isValidForm()) return;
                                  loginForm.isLoading = true;

                                  final authService = Provider.of<AuthService>(
                                      context,
                                      listen: false);

                                  final String? errorMessage =
                                      await authService.login(
                                          loginForm.email, loginForm.password);

                                  if (errorMessage == null) {
                                    Navigator.pushReplacementNamed(context, '/');
                                  } else {
                                    NotificationsService.showSnacbar(
                                        errorMessage);
                                    loginForm.isLoading = false;
                                  }
                                },
                          title: loginForm.isLoading
                              ? 'Ingresando...'
                              : 'Iniciar Sesión',
                          padding: EdgeInsets.only(top: 24.0),
                          innerPadding: EdgeInsets.all(16.0),
                        )
                      ],
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
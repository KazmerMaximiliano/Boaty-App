import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/snackbar/snackbar.dart';
import 'package:boaty/src/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LoginMethods { facebook, google, email }

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.backAppBar,
      body: _LoginPageBody(),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody({Key? key}) : super(key: key);

  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  List<Widget> _buttons = [];
  bool _inProcess = false;

  @override
  void initState() {
    super.initState();
    _buttons = [
      _button(LoginMethods.facebook),
      _button(LoginMethods.google),
      _button(LoginMethods.email),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 64),
              child: BoatyLogo.fullBig,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Legal');
                },
                child: Text(
                  'Al continuar aceptas nuestras Condiciones de Uso y Politica de Privacidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(height: 32,),
            Expanded(
              child: Container(
                width: double.infinity,
                child: _inProcess ?
                  Center(
                    child: CircularProgressIndicator(
                      color: BoatyColors.blue,
                    ),
                  ) 
                  : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _buttons.length,
                  itemBuilder: (_, i) => _buttons[i],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Recomendamos ingresar/registrarte con correo electrónico si eres dueño de un bote y deseas publicarlo en la aplicación',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
            Text('¿Aún no tienes una cuenta?'),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/FinishRegisterPage');
              },
              child: Text('Registrarse'),
            )
          ],
        ),
      ),
    );
  }

  Widget _button(LoginMethods method) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) =>
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 8.0,
                right: 16.0,
              ),
              child: Icon(_logo(method), size: 35),
            ),
            Text("Ingresar con ${_titulo(method)}"),
          ],
        ),
        onPressed: () {
          switch (method) {
            case LoginMethods.google:
              _loginWithGoogle(context);
              break;
            case LoginMethods.facebook:
              _loginWithFacebook(context);
              break;
            case LoginMethods.email:
              Navigator.pushReplacementNamed(context, '/EmailLogin');
              break;
          }
        },
      ),
    );
  }

  String _titulo(LoginMethods method) {
    String titulo = "";
    switch (method) {
      case LoginMethods.google:
        titulo = "Google";
        break;
      case LoginMethods.facebook:
        titulo = "Facebook";
        break;
      case LoginMethods.email:
        titulo = "Correo Electrónico";
        break;
    }
    return titulo;
  }

  IconData _logo(method) {
    IconData icon = Icons.facebook;
    switch (method) {
      case LoginMethods.google:
        icon = FontAwesomeIcons.google;
        break;
      case LoginMethods.facebook:
        icon = Icons.facebook;
        break;
      case LoginMethods.email:
        icon = Icons.email_outlined;
        break;
    }
    return icon;
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    setState(() {
      _inProcess = true;
    });

    final authService = new AuthService();

    final googleLogin = await authService.loginWithGoogle();
    if (googleLogin == null) {
      setState(() {
        _inProcess = false;
      });

      Navigator.pushReplacementNamed(context, '/');
      
    } else { 
      setState(() {
        _inProcess = false;
      });

      showCustomSnackbar(
        context,
        mensaje: "Ha ocurrido un error inesperado",
        snackState: SnackState.error,
      );
    }
  }

  Future<void> _loginWithFacebook(BuildContext context) async {
    setState(() {
      _inProcess = true;
    });

    final authService = new AuthService();

    final facebookLogin = await authService.loginWithFacebook();
    if (facebookLogin == null) {
      setState(() {
        _inProcess = false;
      });

      Navigator.pushReplacementNamed(context, '/');
      
    } else { 
      setState(() {
        _inProcess = false;
      });

      showCustomSnackbar(
        context,
        mensaje: "Ha ocurrido un error inesperado",
        snackState: SnackState.error,
      );
    }
  }
}

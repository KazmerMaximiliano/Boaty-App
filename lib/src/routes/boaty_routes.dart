import 'package:boaty/src/pages/initial_page.dart';
import 'package:boaty/src/pages/legals/Legal.dart';
import 'package:boaty/src/pages/menu/botes/nueva_disponibilidad/nueva_disponibilidad_page.dart';
import 'package:boaty/src/pages/menu/botes/nuevo_bote/nuevo_bote.dart';
import 'package:boaty/src/pages/menu/perfil/edit_perfil_page.dart';
import 'package:boaty/src/pages/menu/perfil/perfil_admin_page.dart';
import 'package:boaty/src/pages/menu/perfil/perfil_page.dart';
import 'package:boaty/src/pages/menu/permissions/permissions_page.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_crypto.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago_congrats.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_tarjeta.dart';
import 'package:boaty/src/pages/stripe/connect_stripe_account.dart';
import 'package:flutter/material.dart';
import 'package:boaty/src/pages/auth/login/email_login_page.dart';
import 'package:boaty/src/pages/auth/login/login_page.dart';
import 'package:boaty/src/pages/auth/register/finish_register_page.dart';
import 'package:boaty/src/pages/home/home_page.dart';
import 'package:boaty/src/pages/menu/ayuda/ayuda_page.dart';
import 'package:boaty/src/pages/menu/welcome/welcome_page.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/congrats/reserva_congrats_page.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/disponibilidad/disponibilidad_page.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/pre_checkout/pre_checkout_page.dart';
import 'package:boaty/src/pages/menu/menu.dart';
import 'package:boaty/src/pages/menu/reservas/reservas_page.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:boaty/src/services/services.dart';

class BoatyRoutes {
  static final _prefs = SharedPrefs();

  static Map<String, StatelessWidget Function(BuildContext context)>
      get routes {
    return {
      //"/newRoute": (_) => Widget(),
      "/": (_) => InitialPage(),
      "/Menu": (_) => BoatyMenu(),
      "/Home": (_) => HomePage(),
      "/Login": (_) => LoginPage(),
      "/EmailLogin": (_) => EmailLoginPage(),
      "/PerfilAdmin": (_) => PerfilAdminPage(),
      "/Perfil": (_) => PerfilPage(),
      "/ConnectStripeAccount": (_) => ConnectStripeAccountPage(),
      "/FinishRegisterPage": (_) => FinishRegisterPage(),
      "/Welcome": (_) => WelcomePage(),
      "/Ayuda": (_) => AyudaPage(),
      "/Reservas": (_) => ReservasPage(),
      "/Disponibilidad": (_) => DisponibilidadPage(),
      "/PreCheckout": (_) => PreCheckoutPage(),
      "/ReservaCongrats": (_) => ReservaCongratsPage(),
      "/MetodoPago": (_) => MetodoPagoPage(),
      "/MetodoTarjeta": (_) => MetodoTarjeta(),
      "/MetodoCrypto": (_) => MetodoCrypto(),
      "/MetodoPagoCongrats": (_) => MetodoPagoCongrats(),
      "/NuevoBote": (_) => NuevoBote(),
      "/NuevaDisponibilidad": (_) => NuevaDisponibilidadPage(),
      "/EditarPerfil": (_) => EditPerfilPage(),
      "/Permisos": (_) => PermissionsPage(),
      "/Legal": (_) => Legal()
    };
  }

  static String get initialRoute => "/";
  static StatelessWidget get initialWidget => InitialPage();
}

import 'package:boaty/src/globals/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoatyIcons {
  static String get buscar => "menu/buscar";
  static String get favoritos => "menu/favoritos";
  static String get favoritosfill => "menu/favoritosfill";
  static _MenuIcons get menu => _MenuIcons();
  static _FiltrosIcons get filtros => _FiltrosIcons();
}

class _MenuIcons {
  String get buscar => "menu/buscar";
  String get ayuda => "menu/ayuda";
  String get reservas => "menu/reservas";
  String get botes => "menu/botes";
  String get perfil => "menu/perfil";
  String get favoritos => "menu/favoritos";
}

class _FiltrosIcons {
  String get fechaDeUso => "filtros/fecha_de_uso";
  String get tipoEmbarcacion => "filtros/tipo_embarcacion";
  String get ubicacion => "filtros/ubicacion";
}

class BoatyIcon extends StatelessWidget {
  const BoatyIcon({
    required this.icon,
    this.height = 30,
    this.color = Colors.black,
  });
  final String icon;
  final int height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      color: color,
      height: Styles.texts.fontSizeByWidth(context, height),
    );
  }
}

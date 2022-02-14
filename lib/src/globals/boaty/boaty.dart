import 'package:boaty/src/globals/theme/boaty_theme.dart';
import 'package:boaty/src/globals/widgets/boaty_app_bar.dart';
import 'package:flutter/material.dart';

/// clase para acceder a metodos o variables globales / generales de la app.
class Boaty {
  static PreferredSize appBar({
    String title = "",
    AppBarTrailingIcon trailingIcon = AppBarTrailingIcon.none,
    AppBarLeadingIcon leadingIcon = AppBarLeadingIcon.none,
    void Function()? onBack,
  }) {
    return PreferredSize(
      child: BoatyAppBar(
        title: title,
        trailingIcon: trailingIcon,
        leadingIcon: leadingIcon,
        onBack: onBack,
      ),
      preferredSize: Size.fromHeight(80),
    );
  }

  static PreferredSize get backAppBar {
    return PreferredSize(
      child: BoatyAppBar(
        withLogo: false,
        leadingIcon: AppBarLeadingIcon.back,
      ),
      preferredSize: Size.fromHeight(80),
    );
  }

  static PreferredSize get notLoggedAppBar {
    return PreferredSize(
      child: NotLoggedAppBar(),
      preferredSize: Size.fromHeight(60),
    );
  }

  static ThemeData get theme => BoatyTheme.theme;
  static AppBarTheme get appBarTheme => BoatyTheme.appBarTheme;
}

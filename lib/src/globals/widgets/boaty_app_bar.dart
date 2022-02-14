import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:flutter/material.dart';

enum AppBarTrailingIcon { none }
enum AppBarLeadingIcon { back, none }

/* _scaffoldKey.currentState.openDrawer(), */

class BoatyAppBar extends StatefulWidget {
  BoatyAppBar({
    this.title = "",
    this.trailingIcon = AppBarTrailingIcon.none,
    this.leadingIcon = AppBarLeadingIcon.none,
    this.withLogo = true,
    this.onBack,
  });
  final String title;
  final AppBarTrailingIcon trailingIcon;
  final AppBarLeadingIcon leadingIcon;
  final bool withLogo;
  final void Function()? onBack;

  @override
  _BoatyAppBarState createState() => _BoatyAppBarState();
}

class _BoatyAppBarState extends State<BoatyAppBar> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: _getLeadingIcon(),
      leadingWidth: widget.leadingIcon != AppBarLeadingIcon.none ? 100 : 56,
      actions: _getTrailingIcon(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Center(
          child: Text(
            widget.title,
            style: Styles.texts.appBarTextStyle,
          ),
        ),
      ),
      title: Visibility(visible: widget.withLogo, child: BoatyLogo.boat),
      centerTitle: true,
    );
  }

  Widget _getLeadingIcon() {
    Widget leading;
    switch (widget.leadingIcon) {
      case AppBarLeadingIcon.none:
        final none = SizedBox();
        leading = none;
        break;
      case AppBarLeadingIcon.back:
        final backButton = TextButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                size: Styles.texts.fontSizeByWidth(context, 30),
              ),
              SizedBox(width: 4),
              Text("Volver"),
            ],
          ),
          onPressed: widget.onBack.runtimeType != Null
              ? widget.onBack
              : () {
                  if (Navigator.of(context).canPop()) Navigator.pop(context);
                },
        );
        leading = backButton;
        break;
      default:
        leading = SizedBox();
        break;
    }
    final leadingIcon = Visibility(
      visible: widget.leadingIcon != AppBarLeadingIcon.none,
      child: leading,
    );
    return leadingIcon;
  }

  List<Widget> _getTrailingIcon() {
    List<Widget> trailing = [];
    switch (widget.trailingIcon) {
      case AppBarTrailingIcon.none:
        break;
    }
    return trailing;
  }
}

class NotLoggedAppBar extends StatelessWidget {
  const NotLoggedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoatyLogo.full,
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/Login");
              },
              child: Text("Ingresar"),
            ),
          ],
        ),
      ),
    );
  }
}

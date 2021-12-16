import 'package:boaty/src/pages/menu/perfil/perfil_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:boaty/src/pages/menu/ayuda/ayuda_page.dart';
import 'package:boaty/src/pages/menu/botes/botes_page.dart';
import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/pages/menu/favoritos/favoritos_page.dart';
import 'package:boaty/src/pages/menu/perfil/perfil_page.dart';
import 'package:boaty/src/pages/menu/reservas/reservas_page.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/icons/boaty_icons.dart';
import 'package:boaty/src/pages/menu/buscar/buscar_page.dart';

class _MenuItem {
  final Widget inactiveIcon;
  final Widget activeIcon;
  final Widget page;
  final String title;

  final GlobalKey key = GlobalKey<NavigatorState>();
  _MenuItem({
    required this.inactiveIcon,
    required this.activeIcon,
    required this.page,
    required this.title,
  });
}

final SharedPrefs _prefs = SharedPrefs();
final int _iconSize = 34;

_MenuItem _item(Widget page, String icon, String title) {
  return _MenuItem(
    inactiveIcon: BoatyIcon(
      icon: icon,
      color: BoatyColors.grey,
      height: _iconSize,
    ),
    activeIcon: BoatyIcon(
      icon: icon,
      color: BoatyColors.orange,
      height: _iconSize,
    ),
    page: page,
    title: title,
  );
}

final List<_MenuItem> _menu = [
  _item(BuscarPage(), BoatyIcons.menu.buscar, "Buscar"),
  _item(FavoritosPage(), BoatyIcons.menu.favoritos, "Favoritos"),
  _item(ReservasPage(), BoatyIcons.menu.reservas, "Reservas"),
  _item(PerfilPage(), BoatyIcons.menu.perfil, "Perfil"),
];

final List<_MenuItem> _menuOwner = [
  _item(BuscarPage(), BoatyIcons.menu.buscar, "Buscar"),
  _item(BotesPage(), BoatyIcons.menu.botes, "Botes"),
  _item(PerfilAdminPage(), BoatyIcons.menu.perfil, "Admin"),
  _item(AyudaPage(), BoatyIcons.menu.ayuda, "Ayuda"),
];

class BoatyMenu extends StatelessWidget {
  const BoatyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MenuWidget(),
    );
  }
}
class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int _bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<_MenuItem> pages = _prefs.adminView ? _menuOwner : _menu;

    return Scaffold(
      body: pages[_bottomBarIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _bottomBarIndex,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (i) {
          setState(() {
            _bottomBarIndex = i;
          });
        },
        items: _bottomNavBarItems(),
    ),
    );
  }

  List<BottomNavigationBarItem> _bottomNavBarItems() {
    List<_MenuItem> pages = _prefs.adminView ? _menuOwner : _menu;
    return pages
      .map((_MenuItem i) => BottomNavigationBarItem(
          label: "${i.title}",
          icon: i.inactiveIcon,
          activeIcon: i.activeIcon,
          tooltip: "${i.title}",
        ))
      .toList();
  }
}
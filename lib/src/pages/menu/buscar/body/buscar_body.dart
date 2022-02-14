import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/icons/boaty_icons.dart';
import 'package:boaty/src/pages/menu/buscar/body/botes_list.dart';
import 'package:flutter/material.dart';

class BuscarBotesBody extends StatefulWidget {
  const BuscarBotesBody({Key? key}) : super(key: key);
  @override
  _BuscarBotesBodyState createState() => _BuscarBotesBodyState();
}

class _BuscarBotesBodyState extends State<BuscarBotesBody> {
  final _formKey = GlobalKey<FormState>();
  final _busqueda = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textField(),
          Expanded(
            child: Container(
              width: double.infinity,
              child: BotesList(filters: _busqueda.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: BoatyColors.grey,
      ),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: TextFormField(
        controller: _busqueda,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            child: BoatyIcon(icon: BoatyIcons.buscar),
          ),
          labelText: "¿Qué buscás?",
          border: InputBorder.none,
        ),
        onChanged: (v) => setState(() {}),
      ),
    );
  }
}

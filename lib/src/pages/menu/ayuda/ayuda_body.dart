import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/pages/menu/ayuda/models/pregunta.dart';
import 'package:boaty/src/pages/menu/ayuda/models/preguntas_provider.dart';
import 'package:flutter/material.dart';

class AyudaBody extends StatefulWidget {
  const AyudaBody({Key? key}) : super(key: key);

  @override
  _AyudaBodyState createState() => _AyudaBodyState();
}

class _AyudaBodyState extends State<AyudaBody> {
  List<Pregunta> _preguntas = [];
  @override
  void initState() {
    super.initState();
    _preguntas = PreguntasProvider.adminQuestions;
  }

  Widget _mostrarPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool expandido) {
        setState(() {
          _preguntas[index].expanded = !expandido;
        });
      },
      elevation: 0,
      dividerColor: BoatyColors.grey,
      children: _preguntas.map<ExpansionPanel>((Pregunta preg) {
        return ExpansionPanel(
          backgroundColor: Colors.white,
          isExpanded: preg.expanded,
          headerBuilder: (BuildContext context, bool expandido) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text(
                        '${_preguntas.indexOf(preg) + 1}. ${preg.question}')));
          },
          canTapOnHeader: true,
          body: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(title: Text('${preg.answer}')),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(child: _mostrarPanel()),
    );
  }
}

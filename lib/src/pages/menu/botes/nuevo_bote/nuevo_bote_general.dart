import 'package:boaty/src/globals/widgets/input_container_widget.dart';
import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NuevoBoteGeneral extends StatefulWidget {
  NuevoBoteGeneral({Key? key}) : super(key: key);

  @override
  _NuevoBoteGeneralState createState() => _NuevoBoteGeneralState();
}

class _NuevoBoteGeneralState extends State<NuevoBoteGeneral> {
  String tipoSeleccionado = '0';

  @override
  Widget build(BuildContext context) {
    final botesForm = Provider.of<BotesFormProvider>(context);

    return Expanded(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              InputContainerWidget(
                input: DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (select) {
                    tipoSeleccionado = select!;
                    botesForm.type_id = tipoSeleccionado;
                    setState(() {});
                  },
                  value: tipoSeleccionado,
                  items: [
                    DropdownMenuItem(
                      child: Text('Tipo de embarcación'), 
                      value: '0',
                    ),
                    DropdownMenuItem(
                      child: Text('Velero'), 
                      value: '1',
                    ),
                    DropdownMenuItem(
                      child: Text('Yate'), 
                      value: '2',
                    ),
                    DropdownMenuItem(
                      child: Text('Goleta'), 
                      value: '3',
                    ),
                    DropdownMenuItem(
                      child: Text('Catamaran'), 
                      value: '4',
                    ),
                    DropdownMenuItem(
                      child: Text('Lancha'), 
                      value: '5',
                    )
                  ],
                ),
                validator:
                  tipoSeleccionado != '0' ?
                    botesForm.typeValidator(tipoSeleccionado) :
                    null,
              ),
              InputContainerWidget(
                input: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    botesForm.title = value;
                    setState(() {});
                  },
                ),
                validator:
                  botesForm.title.length > 0 ? 
                    botesForm.titleValidator(botesForm.title) :
                    null,
              ),
              InputContainerWidget(
                input: TextFormField(
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Descripción',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    botesForm.description = value;
                    setState(() {});
                  },
                ),
                validator:
                  botesForm.description.length > 0 ? 
                    botesForm.descriptionValidator(botesForm.description) :
                    null,
              )
            ],
          ),
        ),
      ),
    );       
  }
}
import 'package:boaty/src/globals/widgets/input_container_widget.dart';
import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NuevoBotePrice extends StatefulWidget {
  NuevoBotePrice({Key? key}) : super(key: key);

  @override
  _NuevoBotePriceState createState() => _NuevoBotePriceState();
}

class _NuevoBotePriceState extends State<NuevoBotePrice> {
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
                input: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: InputDecoration(
                    labelText: 'Precio',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    botesForm.price = value;
                    setState(() {});
                  },
                ),
                validator:
                  botesForm.price.length > 0 ?
                    botesForm.priceValidator(botesForm.price) :
                    null,
              ),
              InputContainerWidget(
                input: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: InputDecoration(
                    labelText: 'Capacidad',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    botesForm.capacity = value;
                    setState(() {});
                  },
                ),
                validator:
                  botesForm.capacity.length > 0 ?
                    botesForm.capacityValidator(botesForm.capacity) :
                    null,
              ),
            ],
          ),
        ),
      ),
    );       
  }
}
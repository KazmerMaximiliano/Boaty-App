import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';


class NuevoBoteUbicacion extends StatefulWidget {
  NuevoBoteUbicacion({Key? key}) : super(key: key);

  @override
  _NuevoBoteUbicacionState createState() => _NuevoBoteUbicacionState();
}

class _NuevoBoteUbicacionState extends State<NuevoBoteUbicacion> {
  final String _mapStyle = 'https://api.mapbox.com/styles/v1/boatytuti/ckx97nory08pt15qudiiis0vk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYm9hdHl0dXRpIiwiYSI6ImNrd3AxaW9pajA4YmUybm80Nm1tczN0MDAifQ.rzh9HC-CrBJ7O9Q-x88QXw';
  final String _mapToken = 'pk.eyJ1IjoiYm9hdHl0dXRpIiwiYSI6ImNreDk4aGF4YzBkM3MydW9jdGNja2ZkbHEifQ.9zd9ndwPe3aqjCaS6Vo6gw';
  late final MapController _mapController;
  LatLng? _boatMarker;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = _boatMarker != null ? [
      Marker(
        width: 30.0,
        height: 30.0,
        point: _boatMarker ?? LatLng(0, 0),
        builder: (ctx) => Container(
          child: Icon(
            Icons.anchor, 
            color: BoatyColors.secondary,
            size: 30,
          ),
        ),
      )
    ] : [];

    final botesForm = Provider.of<BotesFormProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    LatLng position = LatLng(40.4378698, -3.8196204);

    return Column(
      children: [
        Container(
          height: screenSize.height * 0.60,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              center: position,
              zoom: 4,
              onTap: (tap, LatLng position) {
                setState(() {
                  _boatMarker = position;
                  botesForm.coord = '${position.latitude} ${position.longitude}';
                });
              },
            ),
            layers: [
              TileLayerOptions(
              urlTemplate: _mapStyle,
              additionalOptions: {
                'accessToken': _mapToken,
                'id': 'mapbox.mapbox-streets-v8'
              }),
              MarkerLayerOptions(markers: markers)
            ],
          ),
        ),
      ],
    );
  } 

}
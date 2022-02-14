import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
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

    return FutureBuilder(
      future: _determinePosition(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          LatLng position = LatLng(snapshot.data.latitude, snapshot.data.longitude);

          return Column(
            children: [
              // Text('Manten presionada una ubicación en el mapa para establecerla como la ubicación de la embarcación', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
              // SizedBox(height: 36,),
              Container(
                height: screenSize.height * 0.60,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    center: position,
                    zoom: 16.8,
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
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: BoatyColors.primary
            ),
          );
        }
      }
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }
}
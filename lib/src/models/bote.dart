import 'dart:convert';

import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/models/foto.dart';
import 'package:boaty/src/pages/menu/buscar/reservacion/detalle_bote_page.dart';
import 'package:boaty/src/services/navigate_service.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bote {
  final int? id;
  final String? titulo;
  final String? descripcion;
  final String? price;
  final int? capacity;
  final String? coords;
  final List<Foto>? fotos;
  final int? type_id;
  final int? owner_id;
  final List? availables;
  final List? reserved;
  final List<dynamic>? rating;

  Bote({
    this.id,
    this.titulo,
    this.descripcion,
    this.price,
    this.capacity,
    this.coords,
    this.fotos,
    this.type_id,
    this.owner_id,
    this.availables,
    this.reserved,
    this.rating,
  });

  factory Bote.fromJson(json) {
    List<Foto> _fotos = [];
    
    if (json['gallery'].isNotEmpty) {
      json['gallery']!.forEach((f) {
        f['favourite'] = json['favourite'];
        _fotos.add(Foto.fromJson(f));
      });
    } else {
      Map<String, dynamic> placeholderImage = {
        "path": "/img/boaty_boat.png",
        "favourite": false,
        "boat_id": json['id']
      };

      _fotos.add(Foto.fromJson(placeholderImage));
    }

    

    return Bote(
      id: json['id'],
      titulo: json['title'],
      descripcion: json['description'],
      price: json['price'],
      capacity: json['capacity'],
      coords: json['coords'],
      type_id: json['type_id'],
      owner_id: json['owner_id'],
      availables: json['availables'],
      reserved: json['reserved'],
      rating: json['rating'],
      fotos: _fotos,
    );
  }

  Widget get title => Text("$titulo", style: Styles.texts.title);

  Widget get description {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "$descripcion", 
        style: Styles.texts.description
      ),
    );
  }

  Widget get _star => Icon(Icons.star_border_rounded, color: BoatyColors.amber);

  Widget get _stars {
    double summation = 0;
    double rate = 0;

    if (rating != null && rating!.length > 0) {
      rating!.forEach((e) { 
        summation += e;
      });

      rate = summation / rating!.length;
    }

    return RatingBarIndicator(
        rating: rate != 0 ? rate : 5,
        itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 30.0,
        direction: Axis.horizontal,
    );
  }

  Widget widget([ShowIn showIn = ShowIn.home]) {
    final _prefs = new SharedPrefs();
    
    List<Widget> _column = [];
    if (showIn == ShowIn.home) {
      _column = [
        title,
        description,
        Builder(
          builder: (_) {
            return _prefs.logged ? TextButton(
              child: Text('Ver detalle',
                  style: TextStyle(color: BoatyColors.blue)),
              onPressed: () => {
                Nav.pushToWidget(_, DetalleBotePage(bote: this))
              },
            ) : Container();
          },
        ),
      ];
    } else {
      _column = [
        title,
        description,
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "\$$price",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Row(
          children: [
            _stars,
            Spacer(),
            // TODO:
            // IconButton(
            //   onPressed: () {
            //   },
            //   icon: Icon(Icons.share_rounded),
            // ),
          ],
        ),
        SizedBox(height: 100),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fotos!.toCarousel,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _column,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get toWidget => widget(ShowIn.home);
}

enum ShowIn { home, detalle }

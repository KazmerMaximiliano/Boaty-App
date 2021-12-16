import 'package:boaty/src/globals/boaty/boaty.dart';
import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/logo/boaty_logo.dart';
import 'package:boaty/src/globals/styles/styles.dart';
import 'package:boaty/src/pages/menu/reservas/pagar/metodo_pago_params.dart';
import 'package:boaty/src/services/reservations_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReservasPage extends StatelessWidget {
  const ReservasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReservasPageView();
  }
}
class ReservasPageView extends StatefulWidget {
  @override
  _ReservasPageViewState createState() => _ReservasPageViewState();
}

class _ReservasPageViewState extends State<ReservasPageView> {
  final reservationService = new ReservationService();

  double reservationRating = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Boaty.appBar(title: "Reservas"),
      body: FutureBuilder(
        future: reservationService.getReservations(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // CARGANDO
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: BoatyColors.primary,
                  ),
                ),
              );
            }
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              final reservas = snapshot.data;

              final String _baseUrl = dotenv.env['ASSETS_URL'].toString();
              final reservationService = new ReservationService();
              
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: reservas.length,
                itemBuilder: (_, i) {
                  final int status = reservas[i]['reservation'].status;

                  final String id = reservas[i]['reservation'].id.toString();
                  final String titulo = reservas[i]['boat'].titulo.toString();
                  final String amount = reservas[i]['reservation'].amount.toString();
                  final String imgUrl = '$_baseUrl${reservas[i]['boat'].fotos[0].url}';

                  List<Widget> setChildrens() {
                    final List<Widget> childrensList = [];

                    if (status == 0) {
                      childrensList.add(
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/MetodoPago", arguments: MetodoPagoArguments(reservationID: id));
                          }, 
                          child: Text('Pagar', style: TextStyle(color: BoatyColors.blue),),
                        ),
                      );
                    }
                    if (status < 2) {
                      childrensList.add(
                          TextButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) { 
                                return AlertDialog(
                                  title: Text(
                                    '¿Estas seguro?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  content: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.resolveWith(
                                              (states) => RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            backgroundColor: MaterialStateProperty.resolveWith(
                                              (states) => BoatyColors.primary,
                                            ),
                                          ),
                                          child: Text('NO'),
                                          onPressed: () => Navigator.pop(context, 'no')
                                        ),
                                        SizedBox(width: 16),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.resolveWith(
                                              (states) => RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            backgroundColor: MaterialStateProperty.resolveWith(
                                              (states) => BoatyColors.primary,
                                            ),
                                          ),
                                          child: Text('SI'),
                                          onPressed: () {
                                  
                                            // await reservationService.cancelReservation(id);
                                            Navigator.pop(context, 'yes');
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).then((exit) async {
                              if (exit == 'yes') {

                                await reservationService.cancelReservation(id); 
                                setState(() {

                                });
                              }
                            }),
                            child: Text('Cancelar', style: TextStyle(color: BoatyColors.orange),),
                          ),
                      );
                    }
                    if (status == 2) {
                      childrensList.add(
                        TextButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      '¿Cómo calificarías tu experiencia?', 
                                      style: TextStyle(fontSize: 18), 
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24,),
                                    RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        reservationRating = rating;
                                      },
                                    ),
                                    SizedBox(height: 24,),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () async {
                                          final Map<String, dynamic> body = {
                                            'reservation_id': id,
                                            'rate': reservationRating
                                          };

                                          final resp = await reservationService.rateReservation(body);

                                          if (resp == null) {
                                            setState(() {
                                              
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text('Calificar')
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ), 
                          child: Text('Calificar', style: TextStyle(color: BoatyColors.blue),),
                        ),
                      );
                    }
                    if (status == 3 || status == 4) {
                      childrensList.add(
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            status == 3 ? 
                            'Completada' :
                            'Cancelada',
                            style: TextStyle(
                              color: status == 3 ?
                              Colors.blue :
                              BoatyColors.orange
                            ),
                          ),
                        ),
                      );
                    }

                    return childrensList;
                  };

                  return ReservationTile(
                    amount: amount, 
                    imgUrl: imgUrl, 
                    titulo: titulo,
                    children: setChildrens(),
                  );
                },
              );
            } else {
              return ReservasEmpty();
            }
          }
          // ERROR
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ha ocurrido un error',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            }
            // NO DATA     
            return ReservasEmpty();
        }
      ),
    );
  }
}

class ReservationTile extends StatelessWidget {
  final String imgUrl;
  final String titulo;
  final String amount;
  final List<Widget> children;

  const ReservationTile({
    Key? key,
    required this.imgUrl,
    required this.titulo,
    required this.amount,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), 
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 75,
              child: Center(child: BoatyLogo.boat)
            ),
          ),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Padding(
                padding: EdgeInsets.only(left: 12,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo.length > 30 ?
                      '${titulo.substring(0, 30)}...':
                      titulo
                    ),
                    SizedBox(height: 6,),
                    Text('U\$D $amount'),
                  ],
                ),
              ),
              Row(
                children: children
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ReservasEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 125),
        BoatyLogo.tickets,
        SizedBox(height: 10),
        Center(
          child: Text(
            'No tenés reservas\nhasta el momento',
            style: Styles.texts.emptysMessages,
          ),
        ),
      ],
    );
  }
}
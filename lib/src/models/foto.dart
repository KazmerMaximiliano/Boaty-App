import 'package:boaty/src/globals/colors/boaty_colors.dart';
import 'package:boaty/src/globals/icons/boaty_icons.dart';
import 'package:boaty/src/globals/widgets/cached_network_image.dart';
import 'package:boaty/src/globals/widgets/dialogs/confirm_alert_dialog_with_icon.dart';
import 'package:boaty/src/globals/widgets/empty_widget.dart';
import 'package:boaty/src/services/boats_service.dart';
import 'package:boaty/src/services/services.dart';
import 'package:boaty/src/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Foto {
  final String _baseUrl = dotenv.env['ASSETS_URL'].toString();
  String url;
  bool favourite;
  int boatId;

  Foto({
    required this.url, 
    required this.favourite, 
    required this.boatId
  });

  // ignore: unnecessary_brace_in_string_interps
  factory Foto.fromJson(json) => Foto(
    url: json["path"], 
    favourite: json['favourite'], 
    boatId: json['boat_id']
  );

  Widget get toWidget => _FotoWidget(url: '$_baseUrl${this.url}');
}

class _FotoWidget extends StatelessWidget {
  const _FotoWidget({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      height: 350,
      width: _size.width,
      padding: EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetImage(url: '$url'),
      ),
    );
  }
}

extension FotosList on List<Foto> {
  List<Widget> get toWidgets => this.map((f) => f.toWidget).toList();
  Widget get toCarousel => _ToCarousel(list: this);
}

class _ToCarousel extends StatefulWidget {
  const _ToCarousel({Key? key, required this.list}) : super(key: key);
  final List<Foto> list;

  @override
  _ToCarouselState createState() => _ToCarouselState();
}

class _ToCarouselState extends State<_ToCarousel> {
  Widget _dot(bool selected, bool isFirst) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? 0 : 10),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? BoatyColors.secondary : BoatyColors.inactive,
          borderRadius: BorderRadius.circular(32),
        ),
        width: 10,
        height: 10,
      ),
    );
  }

  void _likePressed(boatID) {
    final boatService = new BoatsService();

    setState(() {
      if (_prefs.logged) {
        like = !like;
        boatService.setUnsetFaouriteBoat(boatID, like);
      } else {
        print("like pressed, but user isnt logged");
        confirmAlertDialogWithIcon(context, "¿Esta embarcación es tu favorita?", () {
          Navigator.pushNamed(context, '/Login');
        }, Icons.favorite_outline_rounded);
      }
    });

  }

  final PageController _controller = PageController();
  static final _prefs = SharedPrefs();
  int currentIndex = 0;
  bool like = false;

  @override
  void initState() {
    super.initState();
  
    like = widget.list[0].favourite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: widget.list.isNotEmpty
          ? Stack(
              children: [
                InkWell(
                  onDoubleTap: () => _likePressed(widget.list[0].boatId),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: widget.list.toWidgets,
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (newIndex) {
                      currentIndex = newIndex;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                  visible: widget.list.length > 1,
                  child: Positioned(
                    child: Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.list
                            .map(
                              (Foto f) => _dot(
                                f == widget.list.elementAt(currentIndex),
                                widget.list.first == f,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    left: (MediaQuery.of(context).size.width / 2) - 100,
                    bottom: 24,
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 42.0,
                    height: 42.0,
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(42.0),
                    ),
                    child: InkWell(
                      child: BoatyIcon(
                        icon: like
                            ? BoatyIcons.favoritosfill
                            : BoatyIcons.favoritos,
                        color: like ? BoatyColors.red : Colors.black,
                      ),
                      onTap: () => _likePressed(widget.list[0].boatId),
                    ),
                  ),
                  right: 24,
                  top: 22,
                ),
              ],
            )
          : EmptyWidget(text: "No hay fotos de esta embarcacion"),
    );
  }
}

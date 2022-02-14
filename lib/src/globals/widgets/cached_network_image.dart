import 'package:boaty/src/globals/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetImage extends StatelessWidget {
  const CachedNetImage({required this.url, Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: "$url",
        fit: BoxFit.cover,
        placeholder: (context, url) => LoadingWidget(),
        errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.black),
    );
  }
}

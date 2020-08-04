import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershu/app/sq_color.dart';

class NovelCoverImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  NovelCoverImage(this.imageUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(border: Border.all(color: SQColor.paper)),
    );
  }
}

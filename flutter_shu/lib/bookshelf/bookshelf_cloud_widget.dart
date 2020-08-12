import 'package:flutter/material.dart';
import 'package:fluttershu/utility/screen.dart';

class BookshelfCloudWidget extends AnimatedWidget {
  final double width;

  BookshelfCloudWidget({Animation<double> animation, this.width})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    final Animation<double> animation = listenable;
    return Container(
      width: width,
      height: width * 0.73,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          Positioned(
            bottom: -30,
            child: Image.asset(
              'img/bookshelf_cloud_0.png',
              fit: BoxFit.cover,
              width: width,
            ),
          ),

        ],
      ),
    );
  }
}

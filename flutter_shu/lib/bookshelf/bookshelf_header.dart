import 'package:flutter/material.dart';
import 'package:fluttershu/app/app_navigator.dart';
import 'package:fluttershu/bookshelf/bookshelf_cloud_widget.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/utility/screen.dart';
import 'package:fluttershu/utility/styles.dart';
import 'package:fluttershu/widget/novel_cover_image.dart';

class BookshelfHeader extends StatefulWidget {
  final Novel novel;

  BookshelfHeader(this.novel);

  @override
  _BookshelfHeaderState createState() => _BookshelfHeaderState();
}

class _BookshelfHeaderState extends State<BookshelfHeader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(microseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var bgHeight = width / 0.9;
    var height = Screen.topSafeHeight + 250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: height - bgHeight,
            child: Image.asset(
              'img/bookshelf_bg.png',
              fit: BoxFit.cover,
              width: width,
              height: bgHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: BookshelfCloudWidget(
              animation: animation,
              width: width,
            ),
          ),
          buildContext(context),
        ],
      ),
    );
  }

  Widget buildContext(BuildContext context) {
    Novel novel = this.widget.novel;
    var width = Screen.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 54 + Screen.topSafeHeight, 10, 0),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          AppNavigator.pushNovelDetail(context, novel);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
                child: NovelCoverImage(
                  novel.imgUrl,
                  width: 120,
                  height: 120,
                ),
                decoration: BoxDecoration(boxShadow: Styles.borderShadow)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/novel_detail/novel_detail_scene.dart';





class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushNovelDetail(BuildContext context, Novel novel) {
    AppNavigator.push(context, NovelDetailScene(novel.id));
  }


}

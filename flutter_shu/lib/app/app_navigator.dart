import 'package:flutter/material.dart';
import 'package:fluttershu/me/login_scene.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/novel_detail/novel_detail_scene.dart';
import 'package:fluttershu/me/web_scene.dart';

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

  static pushLogin(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LoginScene();
    }));
  }

  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WebScene(url: url,title: title,);
    }));
  }
}

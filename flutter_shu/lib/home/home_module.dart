import 'package:flutter/material.dart';
import 'package:fluttershu/model/novel.dart';

class HomeModule {
  String id;
  String name;
  int style;
  List content;

  List<CarouselInfo> carousels;
  List<MenuInfo> menus;
  List<Novel> books;

  HomeModule.fromJson(Map data) {
    id = data['id'];
    name =data['m_s_name'];

  }
}

class MenuInfo {
  String title;
  String icon;

  MenuInfo.formJson(Map data) {
    title = data['toTitle'];
    icon = data['icon'];
  }
}

class CarouselInfo {
  String imageUrl;
  String link;

  CarouselInfo.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}

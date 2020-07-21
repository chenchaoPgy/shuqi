import 'package:flutter/material.dart';
import 'sq_color.dart';
import 'root_scene.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '牧子小说',
      navigatorObservers: [routeObserver],//路由观察器，当调用Navigator的相关方法时，会回调相关的操作
      theme: ThemeData(
          primaryColor: Colors.blue,
          dividerColor: Color(0xffeeeeee),
          scaffoldBackgroundColor: SQColor.paper,
          textTheme:TextTheme(body1: TextStyle(color: SQColor.darkGray)),
      ),
      home: RootScene(),
    );
  }
}

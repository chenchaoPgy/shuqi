import 'package:flutter/material.dart';
import 'package:fluttershu/app/sq_color.dart';

class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: TabBar(
                labelColor: SQColor.darkGray,
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                unselectedLabelColor: SQColor.gray,
                indicatorColor: SQColor.secondary,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                tabs: <Widget>[
                  Tab(
                    text: '精选',
                  ),
                  Tab(
                    text: '女生',
                  ),
                  Tab(
                    text: '男生',
                  ),
                  Tab(
                    text: '漫画',
                  ),
                ],
              ),
            ),
            backgroundColor: SQColor.white,
            elevation: 0,
          ),
          body: TabBarView(children: [

          ]),
        ));
  }
}

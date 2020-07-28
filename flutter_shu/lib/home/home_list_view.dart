import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:fluttershu/home/home_model.dart';
import 'package:fluttershu/utility/toast.dart';
import 'package:fluttershu/app/request.dart';

enum HomeListType {
  excellent,
  male,
  female,
  cartoon,
}

class HomeListView extends StatefulWidget {
  final HomeListType type;

  HomeListView(this.type);

  @override
  _HomeListViewState createState() => _HomeListViewState();
}

Widget buildModule(BuildContext context, HomeModule module) {}

class _HomeListViewState extends State<HomeListView> {
  List<CarouselInfo> carouselInfos = [];
  int pageIndex = 1;
  List<HomeModule> modules = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<Void> fetchData() async {
    try {
      var action;
      switch (this.widget.type) {
        case HomeListType.excellent:
          action = 'home_excellent';
          break;
        case HomeListType.female:
          action = 'home_female';
          break;
        case HomeListType.male:
          action = 'home_male';
          break;
        case HomeListType.cartoon:
          action = 'home_cartoon';
          break;
        default:
          break;
      }
      var responseJson = await Request.get(action: action);
      List moduleData = responseJson['module'];
      List<HomeModule> modules = [];
      moduleData.forEach((data) {
        modules.add(HomeModule.fromJson(data));
      });

      setState(() {
        this.modules = modules;
        this.carouselInfos = carouselInfos;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          child: ListView.builder(
              itemCount: modules.length,
              itemBuilder: (BuildContext context, int index) {
                return buildModule(context, modules[index]);
              }),
          onRefresh: null),
    );
  }
}

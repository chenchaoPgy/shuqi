import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttershu/app/request.dart';
import 'package:fluttershu/app/sq_color.dart';
import 'package:fluttershu/bookshelf/bookshelf_header.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/utility/screen.dart';
import 'package:fluttershu/utility/toast.dart';

class BookshelfScene extends StatefulWidget {
  @override
  _BookshelfSceneState createState() => _BookshelfSceneState();
}

class _BookshelfSceneState extends State<BookshelfScene> {
  List<Novel> favoriteNovels = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SQColor.white,
      body: AnnotatedRegion(
        value: navAlpha > 0.5
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            RefreshIndicator(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  controller: scrollController,
                  children: <Widget>[
                    favoriteNovels.length > 0
                        ? BookshelfHeader(favoriteNovels[0])
                        : Container(),
                  ],
                ),
                onRefresh: fetchData),
            buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      List<Novel> favoriteNovels = [];
      List<dynamic> favoriteResponse = await Request.get(action: 'bookshelf');
      favoriteResponse.forEach((data) {
        favoriteNovels.add(Novel.fromJson(data));
      });

      setState(() {
        this.favoriteNovels = favoriteNovels;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(SQColor.white),
          ),
        ),
      ],
    );
  }

  Widget buildActions(Color iconColor) {
    return Row(
      children: <Widget>[
        Container(
          height: kToolbarHeight,
          width: 44,
          child: Image.asset('img/actionbar_checkin.png', color: iconColor),
        ),
        Container(
          height: kToolbarHeight,
          width: 44,
          child: Image.asset('img/actionbar_search.png', color: iconColor),
        ),
        SizedBox(width: 15),
      ],
    );
  }
}

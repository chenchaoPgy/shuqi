import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttershu/app/request.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/model/novel_comment.dart';
import 'package:fluttershu/utility/toast.dart';
import 'package:fluttershu/novel_detail/novel_detail_header.dart';


class NovelDetailScene extends StatefulWidget {
  final String novelId;

  NovelDetailScene(this.novelId);

  @override
  _NovelDetailSceneState createState() => _NovelDetailSceneState();
}

class _NovelDetailSceneState extends State<NovelDetailScene> with RouteAware {
  Novel novel;
  List<Novel> recommendNovels = [];
  List<NovelComment> comments = [];
  ScrollController scrollController = new ScrollController();
  double navAlpha = 0;
  bool isSummaryUnfold = false;
  int commentCount = 0;
  int commentMemberCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  back() {
    Navigator.pop(context);
  }

  void fetchData() async {
    try {
      var novelId = this.widget.novelId;
      var novelResponse =
          await Request.post(action: 'novel_detail', params: {'id': novelId});

      var commentsResponse =
          await Request.post(action: 'novel_comment', params: {'id': novelId});
      List<NovelComment> comments = [];
      commentsResponse.forEach((data) {
        comments.add(NovelComment.fromJson(data));
      });
      var recommendResponse = await Request.post(
          action: 'novel_recommend', params: {'id': novelId});
      List<Novel> recommendNovels = [];
      recommendResponse.forEach((data) {
        recommendNovels.add(Novel.fromJson(data));
      });

      setState(() {
        this.novel = Novel.fromJson(novelResponse);
        this.comments = comments;
        this.recommendNovels = recommendNovels;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.novel == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
      );
    }

    return Scaffold(
      body: AnnotatedRegion(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      NovelDetailHeader(novel),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        value: navAlpha > 0.5
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      ),
    );
  }
}

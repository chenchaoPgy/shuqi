import 'package:flutter/material.dart';
import 'package:fluttershu/app/sq_color.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/utility/screen.dart';
import 'package:fluttershu/app/app_navigator.dart';
import 'package:fluttershu/widget/novel_cover_image.dart';

class HomeNovelCoverView extends StatelessWidget {
  final Novel novel;

  HomeNovelCoverView(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 3) / 4;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, novel);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NovelCoverImage(novel.imgUrl, width: width, height: width / 0.75),
            SizedBox(
              height: 5,
            ),
            Text(
              novel.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              novel.author,
              style: TextStyle(fontSize: 12, color: SQColor.gray),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttershu/app/app_navigator.dart';
import 'package:fluttershu/model/novel.dart';
import 'package:fluttershu/utility/screen.dart';
import 'package:fluttershu/widget/novel_cover_image.dart';
import 'package:fluttershu/app/sq_color.dart';

class NovelGridItem extends StatelessWidget {
  final Novel novel;

  NovelGridItem(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15) / 2;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, this.novel);
      },
      child: Container(
        width: width,
        child: Row(
          children: <Widget>[
            NovelCoverImage(
              novel.imgUrl,
              width: 50,
              height: 60,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    novel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    novel.recommendCountStr(),
                    style: TextStyle(fontSize: 12, color: SQColor.gray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttershu/home/novel_cell.dart';
import 'home_model.dart';
import 'home_section_view.dart';

class NovelNormalCard extends StatelessWidget {
  final HomeModule cardInfo;

  NovelNormalCard(this.cardInfo);

  @override
  Widget build(BuildContext context) {
    var novels = cardInfo.books;
    if (novels.length < 3) {
      return null;
    }
    List<Widget> children = [
      HomeSectionView(cardInfo.name),
    ];
    for (var i = 0; i < novels.length; i++) {
      var novel = novels[i];
      children.add(NovelCell(novel));
      children.add(Divider(
        height: 1,
      ));
    }
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

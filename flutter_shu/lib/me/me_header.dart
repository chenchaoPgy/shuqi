import 'package:flutter/material.dart';
import 'package:fluttershu/app/user_manager.dart';

class MeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = UserManager.currentUser;
    return GestureDetector(
      onTap: () {
        if (UserManager.instance.isLogin) {
          AppNavigator.pushWeb(
              context, 'https://github.com/huanxsd/flutter_shuqi', 'Github');
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                'img/placeholder_avatar.png',
              ),
              radius: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '登录',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '0.0',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '书豆余额',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

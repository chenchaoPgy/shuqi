import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershu/app/request.dart';
import 'package:fluttershu/app/sq_color.dart';
import 'package:fluttershu/app/user_manager.dart';
import 'package:fluttershu/utility/toast.dart';

class LoginScene extends StatefulWidget {
  @override
  _LoginSceneState createState() => _LoginSceneState();
}

class _LoginSceneState extends State<LoginScene> {
  TextEditingController phoneEditer = TextEditingController();
  TextEditingController codeEditer = TextEditingController();
  int coldDownSeconds = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('登录'),
        elevation: 0,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: SQColor.primary,
                    borderRadius: BorderRadius.circular(5)),
                height: 40,
                child: FlatButton(
                    onPressed: login,
                    child: Text('登录',
                        style: TextStyle(color: Colors.white, fontSize: 16))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: SQColor.paper, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: phoneEditer,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 14, color: SQColor.darkGray),
        decoration: InputDecoration(
            hintText: '请输入手机号',
            hintStyle: TextStyle(color: SQColor.gray),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: SQColor.paper, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: codeEditer,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 14, color: SQColor.gray),
        decoration: InputDecoration(
            hintText: '请输入验证码',
            hintStyle: TextStyle(color: SQColor.gray),
            border: InputBorder.none),
      ),
    );
  }

  login() async {
    var phone = phoneEditer.text;
    var code = codeEditer.text;
    try {
      var response = await Request.post(action: 'login', params: {
        'phone': phone,
        'code': code,
      });
      UserManager.instance.login(response);
      Navigator.pop(context);
    } catch (e) {
      Toast.show(e.toString());
    }
  }
}

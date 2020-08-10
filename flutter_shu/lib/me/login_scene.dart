import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershu/app/request.dart';
import 'package:fluttershu/app/sq_color.dart';
import 'package:fluttershu/app/user_manager.dart';
import 'package:fluttershu/me/code_button.dart';
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
              buildPhone(),
              SizedBox(
                height: 10,
              ),
              buildCode(),
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
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          color: SQColor.paper, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: codeEditer,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 14, color: SQColor.darkGray),
              decoration: InputDecoration(
                  hintText: '请输入验证码',
                  hintStyle: TextStyle(color: SQColor.gray),
                  border: InputBorder.none),
            ),
          ),
          Container(
            color: Color(0xffdae3f2),
            width: 1,
            height: 40,
          ),
          CodeButton(onPressed: fetchSmsCode, coldDownSeconds: coldDownSeconds)
        ],
      ),
    );
  }

  fetchSmsCode() async {
    if (phoneEditer.text.length == 0) {
      return;
    }
    try {
      await Request.post(
          action: 'sms', params: {'phone': phoneEditer.text, 'type': 'login'});
      setState(() {
        coldDownSeconds = 60;
      });
      coldDown();
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  coldDown() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        --coldDownSeconds;
      });
      coldDown();
    });
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

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}

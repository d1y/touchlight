// Author: d1y<chenhonzhou@gmial.com>
// 实验性项目

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(TouchApp());
}

class TouchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State {
  /// 闪光灯`flag`
  bool lightFlag = false;

  /// 闪光灯文案
  String get lightText {
    return !lightFlag ? "开启" : "关闭";
  }

  Color get buttonBg {
    return !lightFlag ? Colors.red : Colors.blue;
  }

  IconData get buttonIcon {
    return !lightFlag ? Icons.lightbulb_outline : Icons.lightbulb;
  }

  @override
  void initState() {
    // print("init start");
    fullScreen();
    screenLight(true);
    // print("init success");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void cccp() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var flag = !lightFlag;
      setState(() {
        lightFlag = flag;
      });
      handleLight(flag);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var ctx = MediaQuery.of(context).size;
    // print(ctx);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Builder(builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return Container(
          width: size.width,
          height: size.height,
          color: Colors.black,
          child: Center(
            child: RaisedButton.icon(
              color: buttonBg, // Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.only(
                top: 12,
                bottom: 12,
                left: 40,
                right: 40,
              ),
              icon: Icon(buttonIcon),
              label: Text(
                lightText,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              elevation: 0,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              onPressed: () {
                cccp();
                // var flag = !lightFlag;
                // setState(() {
                //   lightFlag = flag;
                // });
                // handleLight(flag);
              },
            ),
          ),
        );
      })),
    );
  }
}

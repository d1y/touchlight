// Author: d1y<chenhonzhou@gmial.com>
// 实验性项目

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cfg.dart';
import 'utils.dart';
import 'package:flutter/services.dart';

import 'package:about/about.dart';

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

  bool lightBoom = false;

  /// 闪光灯文案
  String get lightText {
    return !lightFlag ? "开启" : "关闭";
  }

  /// 按钮背景
  Color get buttonBg {
    return !lightFlag ? Colors.red : Colors.blue;
  }

  /// 按钮图标
  IconData get buttonIcon {
    return !lightFlag ? Icons.lightbulb_outline : Icons.lightbulb;
  }

  /// 滚动条值
  double rating = 1;

  /// 循环单次时间
  /// 最小一次 `1` 秒
  /// 最大一次 `10` 秒
  Duration get volume {
    var i = rating.toInt();
    print("i: $i");
    return Duration(seconds: i);
  }

  Timer intervalTouch;

  @override
  void initState() {
    fullScreen();
    screenLight(true);
    super.initState();
  }

  @override
  void dispose() {
    cleanLightLoop();
    super.dispose();
  }

  /// 启动循环
  void handleLightLoop() {
    cleanLightLoop();
    intervalTouch = Timer.periodic(volume, (timer) {
      var flag = !lightBoom;
      setState(() {
        lightBoom = flag;
      });
      handleLight(flag);
    });
  }

  /// 关闭
  void closeLight() {
    cleanLightLoop();
    handleLight(false);
  }

  /// 清除循环
  void cleanLightLoop() {
    if (intervalTouch != null && intervalTouch.isActive) {
      intervalTouch.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: !lightFlag ? Colors.black : Colors.white,
          persistentFooterButtons: [
            Builder(builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height * .1,
                child: Slider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() {
                      rating = newRating;
                      handleLightLoop();
                    });
                  },
                  min: 1,
                  max: 10,
                ),
              );
            }),
            Builder(builder: (BuildContext context) {
              return FlatButton(
                padding: EdgeInsets.all(4.2),
                color: Colors.blue[100],
                onPressed: () {
                  print("单击");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("帮助"),
                        content: Text("滑动的是间隔时间, 越大就越慢, 开启就会一直循环, 不需要了就直接关闭即可"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("我知道了"),
                            onPressed: () =>
                                Navigator.of(context).pop(), //关闭对话框
                          ),
                        ],
                      );
                    },
                  );
                },
                onLongPress: () {
                  showAboutPage(
                    context: context,
                    applicationLegalese: 'Copyright © d1y, {{ year }}',
                    applicationDescription: Text('TouchLight是一个轻量级的控制闪光灯的程序'),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text(GithubLink),
                        onTap: () {
                          crossOpenUrl(GithubLink);
                        },
                      )
                    ],
                    applicationIcon: SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset('design/logo.png'),
                      ),
                    ),
                  );
                },
                child: Text("使用帮助"),
              );
            })
          ],
          body: Builder(builder: (BuildContext context) {
            var size = MediaQuery.of(context).size;
            return Container(
              width: size.width,
              height: size.height,
              color: !lightFlag ? Colors.black : Colors.white,
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
                    var b = !lightFlag;
                    if (lightFlag) {
                      closeLight();
                    } else {
                      handleLightLoop();
                    }
                    setState(() {
                      lightFlag = b;
                    });
                  },
                ),
              ),
            );
          })),
    );
  }
}

// Author: d1y<chenhonzhou@gmial.com>
// 实验性项目

import 'package:lamp/lamp.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// open url by browser..
Future<bool> crossOpenUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
    return true;
  } else {
    return false;
  }
}

/// 进入全屏
/// 参考: https://stackoverflow.com/a/62513429
void fullScreen() {
  SystemChrome.setEnabledSystemUIOverlays([]);
}

/// 屏幕长亮
void screenLight(bool flag) {
  try {
    if (flag) {
      // The following line will enable the Android and iOS wakelock.
      Wakelock.enable();
    } else {
      // The next line disables the wakelock again.
      Wakelock.disable();
    }
  } catch (e) {
    print(e);
    throw new Exception(e);
  }
}

/// 控制闪光灯
void handleLight(bool flag) {
  try {
    if (flag) {
      Lamp.turnOn();
    } else {
      Lamp.turnOff();
    }
  } catch (e) {
    print(e);
    throw new Exception(e);
  }
}

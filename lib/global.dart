
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/userdefaults.dart';
import 'package:device_info_plus/device_info_plus.dart';

const keyMethodNative = 'method_native';
const keyRouteNative = 'Route_native';

const channel = MethodChannel('flutter.io');

late MyChars myChars;

late List<PinyinGroup> pyTable;

/*
* 拼读
* */
void spelling(String value) async {
  int voice = await getVoiceType();
  switch (voice) {
    case 0:
      channel.invokeMethod(keyMethodNative, ['spelling0', value]);
      break;
    case 1:
      channel.invokeMethod(keyMethodNative, ['spelling1', value]);
      break;
    default:
      break;
  }
}

/*
* APP 信息
* */

class AppInfo {
  static  final deviceInfoPlugin = DeviceInfoPlugin();
  static Future<String> version() async{
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    return deviceInfo.data['version.release'];
  }
}





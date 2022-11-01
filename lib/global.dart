
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/model/pinyin.dart';
import 'package:youknow/userdefaults.dart';
const keyMethodNative = 'method_native';
const keyRouteNative = 'Route_native';

const channel = MethodChannel('flutter.io');

late MyChars myChars;

late List<PinyinGroup> pyTable;

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



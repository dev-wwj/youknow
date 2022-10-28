
import 'package:flutter/services.dart';
import 'package:youknow/model/character.dart';
import 'package:youknow/model/pinyin.dart';

const keyMethodNative = 'method_native';
const keyRouteNative = 'Route_native';

const channel = MethodChannel('flutter.io');

late MyChars myChars;

late List<PinyinGroup> pyTable;
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

// 用户配置信息
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//自动播放开关
Future<bool> isAutoplay() async {
  final SharedPreferences prefs = await _prefs;
  final bool onOff = prefs.getBool('voice_autoplay') ?? true;
  return onOff;
}

void setAutoplay(bool value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setBool('voice_autoplay', value);
}

/*
* 声音类型
* 0 : 女声， 1 : 男声
* */
Future<int> getVoiceType() async {
  final SharedPreferences prefs = await _prefs;
  final int value = prefs.getInt('voice_type') ?? 0;
  return value;
}

void setVoiceType(int value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setInt('voice_type', value);
}

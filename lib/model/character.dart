// ignore_for_file: argument_type_not_assignable_to_error_handler, no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:youknow/extension/string_ex.dart';

class MyChars {
  final List<String> chars;
  MyChars(this.chars);

  final groupSize = 10;

  late int section = 0;

  late int index = 0;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'index': index,
    'chars': chars,
    'section': section,
    'groupSize':groupSize
  };

  List<String> charsAt(section) {
    if (section * groupSize + groupSize  < chars.length) {
      return chars.getRange(section * groupSize, section * groupSize + groupSize).toList();
    }else {
      return chars.getRange(section * groupSize, chars.length).toList();
    }
  }

  int numOfSection() {
    return (chars.length / groupSize).ceil();
  }

  int indexStart() {
    return section * groupSize;
  }

  int indexAt(section, index) {
    return index - section * groupSize;
  }

  int sectionWith(index){
    return (index / groupSize).truncate();
  }

  bool indexAtSectionLast(index) {
    return indexAt(section, index) == groupSize - 1;
  }

  bool switchSection(index) {
    var _section = sectionWith(index);
    if (_section != section) {
      section = _section;
      return true;
    }
    return false;
  }

  // 读取本地文件
  static Future<MyChars> locChars() async {
    Future<String> _locFile() async {
      var str = await MString.readStringFile('resources/character.string');
      return str;
    }

    return _locFile().then((value) {
      List<String> cs = [];
      for (var element in value.characters) {
        cs.add(element);
      }
      return MyChars(cs);
    }).catchError((Error error) => Null);
  }
}

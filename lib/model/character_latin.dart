import 'dart:ffi';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:youknow/global.dart';

class CharLatin {
  final String ch;
  late String? latin;
  CharLatin({ required this.ch, this.latin});
}

class WorkLink {
  final int index;
  final int matching;
  final Color color;
  WorkLink({required this.index, required this.color, required this.matching});
}

typedef OrderCallBack = void Function(bool);

class CharRandom {
  final List<String> _chars;
  final int _groupSize;

  OrderCallBack? orderBack;

  /*从每课中选择几个字练习*/
  CharRandom(this._chars, this._groupSize, this.orderBack);

  late List<String> randomChars;
  late List<CharLatin> orderChars;

  Future<bool> refreshGroup() async {
    randomChars = random();
    List tempChars = List.from(randomChars);
    var times = 0;
    do {
      do {
        var r = Random.secure().nextInt(tempChars.length);
        String value = tempChars.elementAt(r);
        tempChars.removeAt(r);
        tempChars.insert(0, value);
      } while (times++ <= tempChars.length);
      orderChars = List<CharLatin>.generate(
          tempChars.length, (index) => CharLatin(ch: tempChars[index]));
    } while (orderCorrect());
    await _queryTrans();
    return true;
  }

  /*转换成拉丁字母*/
  Future<void> _queryTrans() async {
    try {
      for (var element in orderChars) {
        String value = await channel
            .invokeMethod(keyMethodNative, ['applyingTransform', element.ch]);
        element.latin = value;
      }
    } on PlatformException {}
  }

  // 随机取出最多 groupSize 个字符
  List<String> random(){
    if (_chars.length < _groupSize) {
      return _chars.getRange(0, _chars.length - 1).toList();
    } else {
      List<String> temp = [];
      do {
        var r = Random.secure().nextInt(_chars.length - 1);
        String str = _chars[r];
        if (temp.contains(str) == false) {
          temp.add(str);
        }
      } while (temp.length < _groupSize);
      return temp;
    }
  }

  // 对 orderChars 重新排序
  void swithOrderItem(int oldIndex, int newIndex ) {
    CharLatin cl = orderChars[oldIndex];
    orderChars.removeAt(oldIndex);
    orderChars.insert(newIndex, cl);
    if (orderCorrect()) {
      orderBack!(true);
    }
  }

  // 判断排序后是否正确
  bool orderCorrect() {
    for (int i = 0; i < randomChars.length; i++) {
      if (randomChars[i] != orderChars[i].ch) {
        return false;
      }
    }
    return true;
  }
  // 判断连线是否正确

  void judgeLink(List<WorkLink> links) {
    if (isLinkCorrect(links)){
      orderBack!(true);
    }
  }

  bool isLinkCorrect(List<WorkLink> links) {
    if (links.isEmpty || links.length < randomChars.length) {
      return false;
    }
    for (var element in links) {
      var char = randomChars[element.index];
      var latinChar = orderChars[element.matching].ch;
      if (char != latinChar) {
        return false;
      }
    }
    return true;
  }


}


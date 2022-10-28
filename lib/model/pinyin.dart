// ignore_for_file: invalid_return_type_for_catch_error, no_leading_underscores_for_local_identifiers

import 'package:youknow/extension/list_ex.dart';
import 'package:youknow/extension/string_ex.dart';

class Pinyin {
  final String latin;
  final String sound;

  Pinyin({required this.latin, required this.sound});

  Pinyin.fromJson(Map<String, String> map)
      : latin = map['latin']!,
        sound = map['sound']!;

  static List<Pinyin> buildFromJson(List<dynamic> argv) {
    List<Pinyin> pys = [];
    argv.forEach((element) {
      Map<String, String> map = Map.from(element);
      Pinyin py = Pinyin.fromJson(map);
      pys.add(py);
    });
    return pys;
  }
}

class PinyinGroup {
  final String name;
  final List<Pinyin> items;

  PinyinGroup({required this.name, required this.items});

  static PinyinGroup fromJson(Map<String, dynamic> map) {
    var name = map.keys.first;
    dynamic dc = map.values.first;
    var pys = Pinyin.buildFromJson(dc);
    return PinyinGroup(name: name, items: pys);
  }

  // : name = map.keys.first,
  //   items = Pinyin.buildFromJson((map.values.first as List).cast<Map<String,String>>());
//cast<String>()
  static Future<List<PinyinGroup>> locTable() async {
    Future<Map> _locFile() async {
      var map = await MMap.readJsonFile('resources/pinyin.json');
      return map;
    }

    return _locFile().then((value) {
      List<PinyinGroup> groups = [];
      value.forEach((key, value) {
        groups.add(PinyinGroup.fromJson({key: value}));
      });
      return groups;
    }).catchError((error) async => []);
  }
}

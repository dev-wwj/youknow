// ignore_for_file: argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error, no_leading_underscores_for_local_identifiers

import 'package:youknow/extension/list_ex.dart';

class Lesson {
  final int index;
  final List<String> chars;

  Lesson(this.index, this.chars);

  Lesson.fromJson(Map<String, dynamic> map)
      : index = map['index'],
        chars = map['value'].cast<String>();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'index': index,
        'chars': chars,
      };

  static Future<List<Lesson>> lessons() async {
    // 读取本地文件
    Future<List> _lessonJsonFile() async {
      var json = await MList.readJsonFile('resources/lessons.json');
      return json;
    }

    return _lessonJsonFile().then((value) {
      List<Lesson> les = [];
      for (var element in value) {
        les.add(Lesson.fromJson(element));
      }
      return les;
    }).catchError((Error error) => []);
  }
}

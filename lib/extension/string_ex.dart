import 'package:flutter/services.dart';

extension MString on String {
  static Future<String> readStringFile(String path) async {
    final String string = await rootBundle.loadString(path);
    return string;
  }
}
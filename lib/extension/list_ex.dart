import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

extension MList on List {
  static Future<List> readJsonFile(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response);
    return data;
  }
}

extension MMap on Map {
  static Future<Map> readJsonFile(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response);
    return data;
  }
}

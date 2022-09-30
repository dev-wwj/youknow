import 'dart:convert';

import 'package:flutter/services.dart';

extension MList on List {
  static Future<List> readJsonFile(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response);
    return data;
  }
}
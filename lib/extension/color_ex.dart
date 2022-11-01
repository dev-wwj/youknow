import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

extension MyColor on Color {
  static Color random() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }

  static Color randomLight() {
    return Color.fromARGB(255, Random.secure().nextInt(127) + 128,
        Random.secure().nextInt(127) + 128, Random.secure().nextInt(127) + 128);
  }

  static Color randomLightish() {
    return Color.fromARGB(255, Random.secure().nextInt(30) + 225,
        Random.secure().nextInt(30) + 225, Random.secure().nextInt(30) + 225);
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch as Map<int, Color>);
  }
}


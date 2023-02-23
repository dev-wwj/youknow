import 'package:flutter/material.dart';
import 'package:youknow/extension/color_ex.dart';
import 'package:youknow/global.dart';

extension MyTextStyle on TextStyle {
  static TextStyle white(double fontSize) {
    return TextStyle(fontSize: fontSize, color: Colors.white);
  }

  static TextStyle black(double fontSize) {
    return TextStyle(fontSize: fontSize, color: Colors.black);
  }

  static TextStyle whiteLarger() {
    return white(30);
  }

  static TextStyle whiteMaximum() {
    return white(50);
  }
}

extension MyButtonStyle on ButtonStyle {
  static ButtonStyle randomBgFontLarger() {
    return ButtonStyle(
        textStyle: MaterialStateProperty.all(MyTextStyle.whiteLarger()),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => MyColor.randomLight()),
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => MyColor.randomLight()));
  }

  static ButtonStyle randomBgFontMaximum() {
    return ButtonStyle(
        textStyle: MaterialStateProperty.all(MyTextStyle.whiteMaximum()),
        foregroundColor: MaterialStateProperty.resolveWith(
                (states) => MyColor.randomLight()),
        backgroundColor: MaterialStateProperty.resolveWith(
                (states) => MyColor.randomLight()));
  }

}

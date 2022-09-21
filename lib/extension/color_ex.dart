import 'dart:math';
import 'dart:ui';

extension MyColor on Color {
  static Color random() {
    return Color.fromARGB(255, Random.secure().nextInt(255),
        Random.secure().nextInt(255), Random.secure().nextInt(255));
  }
}
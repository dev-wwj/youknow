import 'dart:math';
import 'dart:ui';

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
}